//
//  PlaylistView2.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/24/22.
//

import SwiftUI
import Combine
import AVKit
import SDWebImageSwiftUI
import AVFoundation

struct PlaylistView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State var addToPlaylist: Bool = false
    @State var showOption: Bool = false
    @State var addToFavorite: Bool = false
    @State var isPlaying: Bool = false
    @State var currentDuration: TimeInterval = 0
    @State var currentTime: TimeInterval = 0
    var playlist: Playlist
    let player = AVPlayer()
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.backward.circle")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("AppColor"))
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            VStack(alignment: .center, spacing: 5) {
                                Text("Playlist")
                                    .foregroundColor(.white)
                                
                                Text(playlist.name)
                                    .foregroundColor(Color("AppColor"))
                            }
                            
                            Spacer()
                        }
                    }//: TOP NAV
                    .padding(.top, 10)
                    
                    VStack(alignment: .center, spacing: 10) {
                        WebImage(url: URL(string: playlist.artwork))
                            .placeholder(Image(""))//default image
                            .resizable()
                            .padding(.top, 20)
                            .padding(.horizontal, 15)
                        
                        VStack(spacing: 4) {
                            Text(playlist.artist_name)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            
                            Text(playlist.artist)
                                .foregroundColor(.white)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                        }
                        
                        //MARK: Option buttons
                        //MARK: Add to playlist
                        HStack {
                            ControlButton(systemImageName: "plus") {
                                addToPlaylist = true
                            }
                            .fullScreenCover(isPresented: $addToPlaylist){
                                ZStack{
                                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                                    AddToPlaylistView(modal: $addToPlaylist, currentDuration: $currentDuration, playlist: playlist)
                                }
                                .background(BackgroundBlurView())
                            }
                            
                            Spacer()
                            
                            //MARK: Add to favorite
                            ControlButton(systemImageName: addToFavorite ? "heart.fill" : "heart") {
                                addToFavorite.toggle()
                            }
                            
                            Spacer()
                            
                            //MARK: Options
                            ControlButton(imageName: "menu") {
                                showOption = true
                            }
                            .fullScreenCover(isPresented: $showOption){
                                ZStack{
                                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                                    PlayerOptionView(currentDuration: $currentDuration, playlist: playlist)
                                }
                                .background(BackgroundBlurView())
                            }
                        }
                        .padding(.horizontal, 50)
                        
                        //MARK: Slider
                        VStack {
                            AudioPlayerControlsView(player: player,
                                                    timeObserver: PlayerTimeObserver(player: player),
                                                    durationObserver: PlayerDurationObserver(player: player),
                                                    itemObserver: PlayerItemObserver(player: player), currentDuration: $currentDuration, currentTime: $currentTime)
                        }
                        .padding(.horizontal, 15)
                    
                        //MARK: Control Buttons
                        HStack {
                            //MARK: Shuffle
                            ControlButton(systemImageName: "shuffle") {

                            }

                            Spacer()

                            //MARK: Previous track
                            ControlButton(systemImageName: "backward.end.fill", fontSize: 24) {

                            }

                            Spacer()

                            //MARK: Play/Pause Button
                            ControlButton(systemImageName: isPlaying ? "pause.fill" : "play.fill") {
                                isPlaying.toggle()
                                print("isPlaying ", isPlaying)
                                if isPlaying {
                                    print("repeat...", Int(currentTime), Int(currentDuration))
                                    if (Int(currentTime) + 1) == Int(currentDuration) {
                                        guard let url = URL(string: playlist.source) else {
                                            return
                                        }
                                        
                                        print("repeat2...", Int(currentTime), Int(currentDuration))
                                        let playerItem = AVPlayerItem(url: url)
                                        self.player.replaceCurrentItem(with: playerItem)
                                        self.player.play()
                                    } else {
                                        self.player.play()
                                    }
                                } else {
                                    self.player.pause()
                                }
                            }

                            Spacer()

                            //MARK: Next track
                            ControlButton(systemImageName: "forward.end.fill", fontSize: 24) {

                            }

                            Spacer()

                            //MARK: Next track
                            ControlButton(systemImageName: "repeat", fontSize: 24) {

                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 20)
                    }
                    .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 1.4)
                    .border(.white.opacity(0.80), width: 0.5)

                    Spacer()
                }//: CONTENT VSTACK
                .padding(.bottom, 20)
            }//:PARENT VSTACK
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .onAppear() {
                initializeUrl()
            }
            .onDisappear {
                // When this View isn't being shown anymore stop the player
                self.player.replaceCurrentItem(with: nil)
            }
        }
    }
    
    // MARK: - Private functions
    func initializeUrl() {
        guard let url = URL(string: playlist.source) else {
            return
        }
        
        print("initializing...")
        let playerItem = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: playerItem)
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static let playlist: [Playlist] = Bundle.main.decode("playlist.json")

    static var previews: some View {
        PlaylistView(playlist: playlist[0])
    }
}
