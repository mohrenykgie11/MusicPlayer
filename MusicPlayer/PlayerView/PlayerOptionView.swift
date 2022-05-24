//
//  PlayerOptionView.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/23/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlayerOptionView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Binding var currentDuration: TimeInterval
    @State var queue: Bool = false
    @State var optionList: [Option] = [Option(id: 1, name: "Play Next", image: "queue"), Option(id: 2, name: "Add to Play Queue", image: "queue"), Option(id: 3, name: "Add to Playlist", image: "plus"), Option(id: 4, name: "Add to Liked Songs", image: "heart"), Option(id: 5, name: "Share", image: "share"), Option(id: 6, name: "Go to Song Radio", image: "radio"), Option(id: 7, name: "Go to Album", image: "album"), Option(id: 8, name: "Go to Artist", image: "star")]
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
                        
                        VStack(spacing: 5) {
                            Text(playlist.artist_name)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                            
                            Text(playlist.artist)
                                .foregroundColor(.white)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                        }
                        
                        Spacer()
                    }
                }
                
                VStack(spacing: 15) {
                    WebImage(url: URL(string: playlist.artwork))
                        .placeholder(Image(""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170, height: 170)
                    
                    // MARK: Control buttons
                    HStack {
                        // MARK: Shuffle
                        Button(action: {
                            //
                        }) {
                            VStack(spacing: 5) {
                                Image(systemName: "shuffle")
                                    .foregroundColor(.white)
                                
                                Text("Shuffle")
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                            }
                        }
                        
                        Spacer()
                        
                        // MARK: Repeat
                        Button(action: {
                            //
                        }) {
                            VStack(spacing: 5) {
                                Image(systemName: "repeat")
                                    .foregroundColor(.white)
                                
                                Text("Repeat")
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                            }
                        }
                        
                        Spacer()
                        
                        // MARK: Queue
                        Button(action: {
                            queue = true
                        }) {
                            VStack(spacing: 5) {
                                Image(systemName: "shuffle")
                                    .foregroundColor(.white)
                                
                                Text("Go to queue")
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                            }
                            
                        }
                        .fullScreenCover(isPresented: $queue){
                            ZStack{
                                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                                ManageQueueView(currentDuration: $currentDuration, playlist: playlist)
                            }
                            .background(BackgroundBlurView())
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                Divider()
                    .background(Color.white.opacity(0.80))
                    .padding(.horizontal, 20)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(optionList.indices, id: \.self) { index in
                            VStack {
                                HStack(spacing: 20) {
                                    if optionList[index].id == 3 || optionList[index].id == 4 {
                                        Image(systemName: optionList[index].image)
                                    } else {
                                        Image(uiImage: UIImage(named: optionList[index].image) ?? UIImage())
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    
                                    Text(optionList[index].name)
                                        .font(.system(size: 16))
                                       
                                    Spacer()
                                }
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 15)
                }//: SCROLL VIEW
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color("AppColor"))
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                }
            }//:CONTENT VSTACK
            .border(.white.opacity(0.80), width: 0.5)
            .padding(.top, 40)
            .padding(.bottom, 20)
            .padding(.horizontal, 10)
        }//:PARENT VSTACK
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct PlayerOptionView_Previews: PreviewProvider {
    static let playlist: [Playlist] = Bundle.main.decode("playlist.json")
    
    static var previews: some View {
        PlayerOptionView(currentDuration: .constant(0), playlist: playlist[0])
    }
}
