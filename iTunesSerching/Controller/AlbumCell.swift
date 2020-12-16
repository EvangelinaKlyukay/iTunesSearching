//
//  AlbumCell.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 12.12.2020.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: WebImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumAuthorLabel: UILabel!
   
    var album: Album? {
        didSet {
            albumTitleLabel.text = album?.collectionName
            albumAuthorLabel.text = album?.artistName
            albumImage.load(url: album!.artworkUrl100)
        }
    }
}
