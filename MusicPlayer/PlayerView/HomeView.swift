//
//  HomeView.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/22/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    //MARK: - PROPERTIES
    @State private var playlist: [Playlist] = Bundle.main.decode("playlist.json")
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                //MARK: Title header
                VStack {
                    HStack {
                        Text("Playlist")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("AppColor"))

                        Spacer(minLength: 0)
                    }
                }
                .padding(.top, 30)
                
                //MARK: Playlist collection
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(playlist.indices, id: \.self) { row in
                                NavigationLink(destination: PlaylistView(playlist: playlist[row])) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        WebImage(url: URL(string: playlist[row].artwork))
                                            .placeholder(Image(""))//default image
                                            .resizable()
                                            .frame(width: (UIScreen.main.bounds.width - 60) / 2, height: 150)
                                            .cornerRadius(4)
                                        
                                        Text(playlist[row].name)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                            .lineLimit(1)
                                        
                                        Text(playlist[row].artist_name)
                                            .foregroundColor(.white)
                                            .fontWeight(.light)
                                            .font(.system(size: 12))
                                    }
                                }//:NAVIGATION LINK
                            }//:FOREACH
                        }//:LAZYVGRID
                    }//:VSTACK
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 60)
                }//:SCROLLVIEW
            }//:PARENT VSTACK
            .background(Color.black)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }//:NAVIGATION VIEW
    }
}

//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
