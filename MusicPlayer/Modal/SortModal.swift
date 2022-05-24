//
//  SortModal.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/23/22.
//

import SwiftUI

struct SortModal: View {
    //MARK: - PROPERTIES
    @Binding var modal : Bool
    @State var recentlyAdded: Bool = false
    @State var recentlyPlayed: Bool = false
    @State var alphabetical: Bool = false
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            
            //MARK: Spacer to bottom screen
            VStack {
                HStack {
                    Text("Sort by")
                        .foregroundColor(Color("AppColor"))
                    
                    Spacer()
                }
                .padding(.all, 30)
                
                VStack(alignment: .leading, spacing: 20) {
                    Button {
                        recentlyAdded.toggle()
                        recentlyPlayed = false
                        alphabetical = false
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(named: "descending one")!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Recently Added")
                                
                            Spacer()
                        }
                        .foregroundColor(recentlyAdded ? Color("AppColor") : .white)
                    }
                    
                    Button {
                        recentlyAdded = false
                        recentlyPlayed.toggle()
                        alphabetical = false
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(named: "descending two") ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                
                            Text("Recently Played")
                               
                            Spacer()
                        }
                        .foregroundColor(recentlyPlayed ? Color("AppColor") : .white)
                    }
                    
                    Button {
                        recentlyAdded = false
                        recentlyPlayed = false
                        alphabetical.toggle()
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(named: "descending one")!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                
                            Text("Alphabetical")
                                
                            Spacer()
                        }
                        .foregroundColor(alphabetical ? Color("AppColor") : .white)
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        modal = false
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color("AppColor"))
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                }
            }//: VSTACK
            .frame(width: UIScreen.main.bounds.width - 15, height: 300, alignment: .bottom)
            .background(Color.black)
            .edgesIgnoringSafeArea(.top)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.white.opacity(0.80), lineWidth: 0.5)
            )
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .ignoresSafeArea()
    }
}

//MARK: - PREVIEW
struct SortModal_Previews: PreviewProvider {
    static var previews: some View {
        SortModal(modal: .constant(false))
    }
}
