//
//  AlbumViewController.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 10.12.2020.
//

import UIKit

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    private var albums = [Album]()
    private var tracks = [Song]()
    
    private let itemsPerRow: CGFloat = 2
    private let minimumItemSpacing: CGFloat = 10
    let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 20.0, right: 16.0)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailViewController" {
            if let destinationVC = segue.destination as? DetailViewController {
                if let album = sender as? Album {
                    destinationVC.album = album
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumCell {
            let album = albums[indexPath.item]
            cell.album = album
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
            NetworkManager.instance.getAlbums(searchRequest: searchBar.text!, offset: 0) { (requestedAlbums) in
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
                DispatchQueue.main.async {
                    self.albumCollectionView.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}
