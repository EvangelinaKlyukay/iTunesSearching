//
//  WebImageView.swift
//  iTunesSerching
//
//  Created by Евангелина Клюкай on 16.12.2020.
//

import UIKit

class WebImageView: UIImageView {
    func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, respons, error) in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
