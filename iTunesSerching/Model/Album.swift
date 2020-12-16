//
//  Album.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 11.12.2020.
//

import Foundation

struct AlbumRespons: Codable {
    var resultsCount: Int?
    var results: [Album]?
}

struct Album: Codable {
    var artistId: Int
    var artistName: String
    var artistViewUrl: String?
    var artworkUrl100: URL
    var country: String
    var primaryGenreName: String
    var releaseDate: String
    var collectionId: Int
    var collectionName: String
}
