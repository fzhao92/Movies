//
//  Movie.swift
//  Movies
//
//  Created by Forrest Zhao on 1/7/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

struct Movie {
    var title: String
    var year: String
    var imageUrl: String
    
    init(dict: JSON) {
        guard let title = dict["Title"] as? String,
        let year = dict["Year"] as? String,
        let imageUrl = dict["Poster"] as? String
            else { fatalError("Could not create movie object from supplied dictionary") }
        self.title = title
        self.year = year
        self.imageUrl = imageUrl
    }
}
