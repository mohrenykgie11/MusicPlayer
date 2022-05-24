//
//  ManageQueueView.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/23/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ManageQueueView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Binding var currentDuration: TimeInterval
    @State var value: CGFloat = 35
    var playlist: Playlist
    
    // MARK: - BODY
    var body: some View {
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
                        
                        Text("Manage Queue")
                            .foregroundColor(Color("AppColor"))
                            .fontWeight(.heavy)
                        
                        Spacer()
                    }
                }//: TOP NAV
                
                HStack(spacing: 15) {
                    HStack {
                        ZStack {
                            WebImage(url: URL(string: playlist.artwork))
                                .placeholder(Image(""))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(Color("AppColor"))
                        }
                        .background(BackgroundBlurView())
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text(playlist.artist_name)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            
                            Text("\(playlist.artist) / \(Utility.formatSecondsToHMS(currentDuration))")
                                .foregroundColor(.white)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        ControlButton(systemImageName: "heart") {
                            
                        }
                        
                        ControlButton(imageName: "menu") {
                            
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Next Up")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Image(systemName: "shuffle")
                            
                            Text("Shuffle")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                    }
                    .background(Color("ButtonColor"))
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                Divider()
                    .background(Color.white.opacity(0.80))
                    .padding(.horizontal, 20)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1...6, id: \.self) { index in
                            VStack {
                                HStack {
                                    Image(systemName: "xmark")
                                        
                                    VStack(spacing: 10) {
                                        Text("Rapid Fire")
                                            .font(.system(size: 14))
                                        
                                        Text("Santi | 5:00")
                                            .fontWeight(.light)
                                            .font(.system(size: 12))
                                    }
                                        
                                    Spacer()
                                    
                                    Image(uiImage: UIImage(named: "harmburger") ?? UIImage())
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 34, height: 34)
                                        .foregroundColor(.white)
                                }
                                .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Slider(value: $value, in: 0...50)
                        .accentColor(Color("AppColor"))
                    
                    HStack {
                        ControlButton(systemImageName: "backward.end.fill", fontSize: 24) {
                            
                        }
                        Spacer()
                        ControlButton(systemImageName: "play.fill", fontSize: 24) {
                            
                        }
                        Spacer()
                        ControlButton(systemImageName: "forward.end.fill", fontSize: 24) {
                            
                        }
                    }
                    .padding(.horizontal, 60)
                    .padding(.bottom, 10)
                    
                    Divider()
                        .background(Color.white.opacity(0.80))
                }
            }
            .border(.white.opacity(0.80), width: 0.8)
            .padding(.top, 40)
            .padding(.bottom, 20)
            .padding(.horizontal, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
}

struct ManageQueueView_Previews: PreviewProvider {
    static let playlist: [Playlist] = Bundle.main.decode("playlist.json")
    
    static var previews: some View {
        ManageQueueView(currentDuration: .constant(0), playlist: playlist[0])
    }
}
