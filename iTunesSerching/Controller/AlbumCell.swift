//
//  AlbumCell.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 12.12.2020.
//

import UIKit

    class AlbumCell: UICollectionViewCell {
        
        @IBOutlet weak var albumImage: UIImageView!
        @IBOutlet weak var albumTitleLabel: UILabel!
        @IBOutlet weak var albumAuthorLabel: UILabel!

        
        func updateCell (album: Album) {
            let imageUrl = URL(string: album.artworkUrl100)
            
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl!) {
                    DispatchQueue.main.async {
                        self.albumImage.image = UIImage(data: imageData)
                    }
                }
            }
            albumTitleLabel.text = album.collectionName
            albumAuthorLabel.text = album.artistName
        }
        
    }
