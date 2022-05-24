//
//  TabBar.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/22/22.
//

import SwiftUI

struct TabBar: View {
    //MARK: - PROPERTIES
    //Selected tab index: default is 0, which is home
    @State var current = 0
    
    //MARK: - BODY
    var body: some View {
        TabView(selection: $current) {
            HomeView()
                .tag(0)
                .tabItem {
                    Image(systemName: "house.fill")
                    
                    Text("Home")
                }
            
            Text("Search")
                .tag(1)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    
                    Text("Search")
                }
            
            Text("Your Library")
                .tag(2)
                .tabItem {
                    Image(systemName: "music.note.list")
                        .resizable()
                    
                    Text("Your Library")
                }
        }
        .edgesIgnoringSafeArea(.top)
        .accentColor(.orange)
    }
}

//MARK: - PREVIEW
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
