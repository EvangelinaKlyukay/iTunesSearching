//
//  NetworkManager.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 11.12.2020.
//

import Foundation


class NetworkManager {
    
    func makeAlbumsUrl(q: String, offset: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "entity", value: "album"),
            URLQueryItem(name: "attribute", value: "albumTerm"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "50"),
            URLQueryItem(name: "term", value: q.replacingOccurrences(of: " ", with: "+"))
        ]
        return components.url
    }
    
    func makeSongsUrl(collectionId: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/lookup"
        components.queryItems = [
            URLQueryItem(name: "entity", value: "song"),
            URLQueryItem(name: "id", value: String(collectionId))
        ]
        return components.url
    }
    
    static let instance = NetworkManager()
    
    func getAlbums (searchRequest: String, offset: Int, complition: @escaping ([Album])->()) {
        let url = makeAlbumsUrl(q: searchRequest, offset: offset)
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                let album = try! JSONDecoder().decode(AlbumRespons.self, from: data)
                
                complition(album.results!)
            }
        }.resume()
    }
    
    func getAlbumSongs (collectionId: Int, complition: @escaping ([Song]) -> ()) {
        var tracksList = [Song]()
        let url = makeSongsUrl(collectionId: collectionId)
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                let tracks = try! JSONDecoder().decode(SongRespons.self, from: data)
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
