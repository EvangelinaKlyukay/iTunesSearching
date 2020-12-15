//
//  Track.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 12.12.2020.
//

import Foundation

struct TrackJSON : Codable {
    var resultsCount : Int?
    var results : [TrackInfo]
}

struct TrackInfo : Codable {
    var trackName : String?
}

class Track {
    var trackName: String

    init(trackName: String) {
        self.trackName = trackName
    }
}
