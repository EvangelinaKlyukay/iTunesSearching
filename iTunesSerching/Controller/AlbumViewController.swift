//
//  AlbumViewController.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 10.12.2020.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var albums = [Album]()
    var tracks = [Song]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var albumCollectionView: UICollectionView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailViewController" {
            if let destinationVC = segue.destination as? DetailViewController {
                if let album = sender as? Album {
                    destinationVC.album = album
                    let index = albums.firstIndex(where: {$0 === album})
                    let indexPath = IndexPath(row: index!, section: 0)
                    if let cell = albumCollectionView.cellForItem(at: indexPath) as? AlbumCell {
                        destinationVC.albmImage = cell.albumImage.image
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumCell {
            cell.updateCell(album: albums[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "ShowDetailViewController", sender: album)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil || searchBar.text != "" {
            NetworkManager.instance.getAlbums(searchRequest: searchBar.text!) { (requestedAlbums) in
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
                DispatchQueue.main.async {
                    self.albumCollectionView.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}
