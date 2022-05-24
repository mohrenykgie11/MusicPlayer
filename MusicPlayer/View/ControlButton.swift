//
//  ControlButton.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/22/22.
//

import SwiftUI

struct ControlButton: View {
    var imageName: String = ""
    var systemImageName: String = ""
    var fontSize: CGFloat = 24
    var color: Color = .white
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            if systemImageName == "" {
                Image(uiImage: UIImage(named: imageName) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .foregroundColor(color)
            } else {
                Image(systemName: systemImageName)
                    .font(.system(size: fontSize))
                    .foregroundColor(color)
            }
            
        }
    }
}

struct ControlButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlButton(action: {})
            .preferredColorScheme(.dark)
    }
}
