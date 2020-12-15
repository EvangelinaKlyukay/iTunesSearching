//
//  NetworkManager.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 11.12.2020.
//

import Foundation


class NetworkManager {
    
    let itunesApiAlbum = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term="
    let itunesApiSongs = "https://itunes.apple.com/lookup?entity=song&id="

    static let instance = NetworkManager()
    
    func getAlbums (searchRequest: String, complition: @escaping ([Album])->()) {
        var albums = [Album]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(itunesApiAlbum)\(searchString)")
        let task = URLSession.shared
        task.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                    let album = try! JSONDecoder().decode(AlbumJSON.self, from: data)
                    
                    for albumInfo in album.results! {
                        
                        guard let artistName = albumInfo.artistName else {return}
                        guard let artworkUrl100 = albumInfo.artworkUrl100 else {return}
                        guard let collectionId = albumInfo.collectionId else {return}
                        guard let collectionName = albumInfo.collectionName else {return}
                        guard let country = albumInfo.country else {return}
                        guard let primaryGenreName = albumInfo.primaryGenreName else {return}
                        guard let releaseDate = albumInfo.releaseDate else {return}
                       
                            let releaseDateFormatted = releaseDate.prefix(4)

                            let albumInstance = Album(artistName: artistName, artworkUrl100: artworkUrl100, collectionId: collectionId, collectionName: collectionName, country: country, primaryGenreName: primaryGenreName, releaseDate: String(releaseDateFormatted))
                      
                            albums.append(albumInstance)
                    }
            complition(albums)
            }
        }.resume()
    }
    
    func getAlbumSongs (collectionId: Int, complition: @escaping ([Song]) -> ()) {
        var tracksList = [Song]()
        let url = URL(string: "\(itunesApiSongs)\(collectionId)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                    let tracks = try! JSONDecoder().decode(SongJSON.self, from: data)
                    for track in tracks.results {
                        if track.trackName != nil {
                            tracksList.append(Song(trackName: track.trackName!))
                        }
                    }
                    complition(tracksList)
            }
        }.resume()
    }
}
