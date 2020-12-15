//
//  Song.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 12.12.2020.
//

import Foundation

struct SongJSON : Codable {
    var resultsCount : Int?
    var results : [SongInfo]
}

struct SongInfo : Codable {
    var trackName : String?
}

class Song {
    var trackName: String

    init(trackName: String) {
        self.trackName = trackName
    }
}

