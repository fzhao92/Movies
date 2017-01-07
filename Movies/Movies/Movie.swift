//
//  Movie.swift
//  Movies
//
//  Created by Forrest Zhao on 1/7/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

struct Movie {
    var title: String
    var year: Int
    var imageUrl: String
    
    init(title: String, year: Int, imageUrl: String) {
        self.title = title
        self.year = year
        self.imageUrl = imageUrl
    }
}
