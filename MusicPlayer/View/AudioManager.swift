//
//  AudioManager.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/24/22.
//

import SwiftUI
import AVFoundation
import Combine

struct AudioPlayerControlsView: View {
    private enum PlaybackState: Int {
        case waitingForSelection
        case buffering
        case playing
        case pause
    }
    
    let player: AVPlayer
    let timeObserver: PlayerTimeObserver
    let durationObserver: PlayerDurationObserver
    let itemObserver: PlayerItemObserver
    //@State private var currentTime: TimeInterval = 0
    @Binding var currentDuration: TimeInterval
    @Binding var currentTime: TimeInterval
    @State private var state = PlaybackState.waitingForSelection
    
    var body: some View {
        VStack {
            Slider(value: $currentTime,
                   in: 0...currentDuration,
                   onEditingChanged: sliderEditingChanged) {
            }
            .disabled(state != .playing)
            
            HStack {
                Text("\(Utility.formatSecondsToHMS(currentTime))")
                    .foregroundColor(Color.white)

                Spacer()

                Text("\(Utility.formatSecondsToHMS(currentDuration))")
                    .foregroundColor(Color.white)
            }
        }
        
        // Listen out for the time observer publishing changes to the player's time
        .onReceive(timeObserver.publisher) { time in
            // Update the local var
            print("time", time)
            self.currentTime = time
            // And flag that we've started playback
            if time > 0 {
                self.state = .playing
            } else if time == currentDuration {
                self.currentTime = 0
            }
        }
        // Listen out for the duration observer publishing changes to the player's item duration
        .onReceive(durationObserver.publisher) { duration in
            // Update the local var
            print("duration", duration)
            self.currentDuration = duration
        }
        // Listen out for the item observer publishing a change to whether the player has an item
        .onReceive(itemObserver.publisher) { hasItem in
            if self.state == .pause {
                //
            } else {
                self.state = hasItem ? .buffering : .waitingForSelection
                self.currentTime = 0
                self.currentDuration = 0
            }
        }
    }
    
    // MARK: Private functions
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            // Tell the PlayerTimeObserver to stop publishing updates while the user is interacting
            // with the slider (otherwise it would keep jumping from where they've moved it to, back
            // to where the player is currently at)
            if self.state == .pause {
                timeObserver.pause(false)
            } else {
                timeObserver.pause(true)
            }
            
            //self.state = .pause
        }
        else {
            // Editing finished, start the seek
            state = .buffering
            let targetTime = CMTime(seconds: currentTime,
                                    preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                // Now the (async) seek is completed, resume normal operation
                self.timeObserver.pause(false)
                self.state = .playing
            }
        }
    }
}

class PlayerTimeObserver {
    let publisher = PassthroughSubject<TimeInterval, Never>()
    private weak var player: AVPlayer?
    private var timeObservation: Any?
    private var paused = false
    
    init(player: AVPlayer) {
        self.player = player
        
        // Periodically observe the player's current time, whilst playing
        //if
        timeObservation = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { [weak self] time in
            guard let self = self else { return }
            // If we've not been told to pause our updates
            guard !self.paused else { return }
            // Publish the new player time
            self.publisher.send(time.seconds)
        }
    }
    
    deinit {
        if let player = player,
            let observer = timeObservation {
            player.removeTimeObserver(observer)
        }
    }
    
    func pause(_ pause: Bool) {
        paused = pause
    }
}

class PlayerItemObserver {
    let publisher = PassthroughSubject<Bool, Never>()
    private var itemObservation: NSKeyValueObservation?
    
    init(player: AVPlayer) {
        // Observe the current item changing
        itemObservation = player.observe(\.currentItem) { [weak self] player, change in
            guard let self = self else { return }
            // Publish whether the player has an item or not
            self.publisher.send(player.currentItem != nil)
        }
    }
    
    deinit {
        if let observer = itemObservation {
            observer.invalidate()
        }
    }
}

class PlayerDurationObserver {
    let publisher = PassthroughSubject<TimeInterval, Never>()
    private var cancellable: AnyCancellable?
    
    init(player: AVPlayer) {
        let durationKeyPath: KeyPath<AVPlayer, CMTime?> = \.currentItem?.duration
        cancellable = player.publisher(for: durationKeyPath).sink { duration in
            guard let duration = duration else { return }
            guard duration.isNumeric else { return }
            self.publisher.send(duration.seconds)
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
