//
//  AudioListTableViewCell.swift
//  PlayerApp
//
//  Created by Abhishek Chatterjee on 23/02/18.
//  Copyright © 2018 Abhishek Chatterjee. All rights reserved.
//

import UIKit

var asyncImagesCashArray = NSCache<NSString, UIImage>()

class AyncImageView: UIImageView {

    //MARK: - Variables
    private var currentURL: NSString?

    //MARK: - Public Methods

    func loadAsyncFrom(url: String, placeholder: UIImage?) {
        let imageURL = url as NSString
        if let cashedImage = asyncImagesCashArray.object(forKey: imageURL) {
            image = cashedImage
            return
        }
        image = placeholder
        currentURL = imageURL
        guard let requestURL = URL(string: url) else { image = placeholder; return }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                if error == nil {
                    if let imageData = data {
                        if self?.currentURL == imageURL {
                            if let imageToPresent = UIImage(data: imageData) {
                                asyncImagesCashArray.setObject(imageToPresent, forKey: imageURL)
                                self?.image = imageToPresent
                            } else {
                                self?.image = placeholder
                            }
                        }
                    } else {
                        self?.image = placeholder
                    }
                } else {
                    self?.image = placeholder
                }
            }
            }.resume()
    }
}

class AudioListTableViewCell: UITableViewCell {

    @IBOutlet var songBackgroundView: AyncImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var songNameLabel: UILabel!

    var urlString: String? {
        didSet {
            if let url = urlString {
                songBackgroundView.loadAsyncFrom(url: url, placeholder: nil)
            }
        }
    }
}
