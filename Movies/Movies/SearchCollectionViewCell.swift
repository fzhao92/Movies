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
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.autoresizingMask.insert(.flexibleHeight)
        contentView.autoresizingMask.insert(.flexibleWidth)
    }

}
