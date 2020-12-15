//
//  Album.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 11.12.2020.
//

import Foundation

struct AlbumJSON : Codable {
    var resultsCount : Int?
    var results : [AlbumInfo]?
}

struct AlbumInfo : Codable {
    var artistId : Int
    var artistName : String?
    var artistViewUrl : String?
    var artworkUrl100 : String?
    var country : String?
    var primaryGenreName : String?
    var releaseDate : String?
    var collectionId : Int?
    var collectionName : String?
}

class Album {
    let artistName: String
    var artworkUrl100: String
    let collectionId: Int
    let collectionName: String
    let country: String
    let primaryGenreName: String
    let releaseDate: String
    
    init(artistName: String, artworkUrl100: String, collectionId: Int, collectionName: String, country: String, primaryGenreName: String, releaseDate: String) {
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.collectionId = collectionId
        self.collectionName = collectionName
        self.country = country
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
    }
}
