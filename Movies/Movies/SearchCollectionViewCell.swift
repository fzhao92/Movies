//
//  SearchCollectionViewCell.swift
//  Movies
//
//  Created by Forrest Zhao on 1/11/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movie: Movie! {
        didSet {
            showActivityIndicator()
            title.text = movie.title
            movie.loadImage({ (movie, error) in
                if error == nil {
                    self.moviePosterImage.image = movie.image
                } else {
                    self.moviePosterImage.image = UIImage(named: "no-image-placeholder")
                    if let error = error {
                        print(error)
                    }
                }
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
            })
        }
    }
    
    func showActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
}
