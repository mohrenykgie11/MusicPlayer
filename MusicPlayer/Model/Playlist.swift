//
//  Playlist.swift
//  MusicPlayer
//
//  Created by Morenikeji on 5/22/22.
//

import Foundation
import SwiftUI

struct Playlist: Codable, Identifiable {
    var id: Int
    var artist_name: String
    var artist: String
    var _id: String
    var name: String
    var artwork: String
    var source: String
    var preview: String
}

struct Option: Codable, Identifiable {
    var id: Int
    var name: String
    var image: String
}
