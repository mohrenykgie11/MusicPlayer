//
//  AddToPlaylistView.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/22/22.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct AddToPlaylistView: View {
    // MARK: - PROPERTIES
    @Binding var modal: Bool
    @Binding var currentDuration: TimeInterval
    @State var sort: Bool = false
    @State var search: String = ""
    var playlist: Playlist
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                modal = false
                            }) {
                                Image(systemName: "arrow.backward.circle")
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("AppColor"))
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text("Add to Playlist")
                                .foregroundColor(Color("AppColor"))
                                .fontWeight(.heavy)
                            
                            Spacer()
                        }
                    }//: TOP NAV
                    
                    // MARK: Playlist info
                    HStack(alignment: .top, spacing: 15) {
                        WebImage(url: URL(string: playlist.artwork))
                            .placeholder(Image(""))//Default image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(playlist.artist_name)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                
                            Text(playlist.artist)
                                .foregroundColor(.white)
                                .fontWeight(.light)
                                .font(.system(size: 12))
           
                            Text("\(Utility.formatSecondsToHMS(currentDuration))")
                                .foregroundColor(.white)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                            
                            Button(action: {
                               //create new playlist
                            }) {
                                VStack {
                                    Text("Create New Playlist")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                        .padding(.all, 7)
                                }
                                .background(Color("ButtonColor"))
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Divider()
                        .background(Color.white.opacity(0.80))
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                    
                    // MARK: - Search and Sort
                    HStack(spacing: 20) {
                        VStack {
                            HStack(spacing: 20) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color("AppColor"))
                                
                                TextField("Find Playlist", text: $search)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        }
                        .frame(height: 40)
                        .border(.white.opacity(0.80), width: 0.5)
                        
                        VStack {
                            Text("Sort")
                                .foregroundColor(.white)
                                .fontWeight(.light)
                                .font(.system(size: 12))
                        }
                        .frame(width: 70, height: 40)
                        .border(.white.opacity(0.80), width: 0.5)
                        .onTapGesture {
                            sort.toggle()
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - Playlist folders with songs
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(1...10, id: \.self) { index in
                                VStack {
                                    HStack {
                                        ZStack {
                                            WebImage(url: URL(string: playlist.artwork))
                                                .placeholder(Image(""))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .blur(radius: 0.8)
                                            
                                            ControlButton(systemImageName: "plus") {
                                                
                                            }
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text("Folder Name")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14))
                                            
                                            Text("by Morenikeji | 10 songs")
                                                .foregroundColor(.white)
                                                .fontWeight(.light)
                                                .font(.system(size: 12))
                                        }
                                        
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                    }
                    Spacer()
                }
                .border(.white.opacity(0.80), width: 0.5)
                .padding(.top, 40)
                .padding(.bottom, 20)
                .padding(.horizontal, 10)
            }//:PARENT VSTACK
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
                
            if sort {
                Color.black.opacity(0.85).edgesIgnoringSafeArea(.all)
                SortModal(modal: $sort)
                   .offset(y: self.sort ? 0 : UIScreen.main.bounds.height)
                   .animation(.spring())
            }
            
        }//:ZSTACK
    }
}

// MARK: - PREVIEW
struct AddToPlaylistView_Previews: PreviewProvider {
    static let playlist: [Playlist] = Bundle.main.decode("playlist.json")
    
    static var previews: some View {
        AddToPlaylistView(modal: .constant(false), currentDuration: .constant(0), playlist: playlist[0])
    }
}
