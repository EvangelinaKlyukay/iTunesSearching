//
//  DetailViewController.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 11.12.2020.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var album : Album!
    var albmImage : UIImage!
    var tracks = [Song]()
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yearLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        updateLabels()
        loadTracks()
    }
    
    func updateLabels () {
        albumNameLabel.text = album.collectionName
        authorNameLabel.text = album.artistName
        genreLabel.text = album.primaryGenreName
        countryNameLabel.text = album.country
        albumImage.image = albmImage
        yearLabel.text = album.releaseDate
    }
    
    func loadTracks() {
        print(album.collectionId)
        NetworkManager.instance.getAlbumSongs(collectionId: album.collectionId) { (requestedTracks) in
            self.tracks = requestedTracks
            print(requestedTracks)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailCell {
            cell.updateCell(track: tracks[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
