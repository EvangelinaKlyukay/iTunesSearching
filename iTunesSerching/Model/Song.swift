//
//  Song.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 12.12.2020.
//

import Foundation

struct SongRespons : Codable {
    var resultsCount : Int?
    var results : [Song]
}

struct Song : Codable {
    var trackName : String?
}
