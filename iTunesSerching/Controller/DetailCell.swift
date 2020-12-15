//
//  TrackCell.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 13.12.2020.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var trackName: UILabel!
    
    func updateCell(track : Song) {
        trackName.text = track.trackName
    }
}
