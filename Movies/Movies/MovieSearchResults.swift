//
//  Movie.swift
//  Movies
//
//  Created by Forrest Zhao on 1/7/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

struct SearchResults {
    var movies: [Movie] = []
    
    init(jsonDict: JSON) {
        let searchResultDictArr = jsonDict["Search"] as! [JSON]
        for dict in searchResultDictArr {
            movies.append(Movie(dict: dict))
        }
    }
}

struct Movie {
    var title: String
    var year: String
    var imageUrl: String
    
    init(dict: JSON) {
        guard let title = dict["title"] as? String,
        let year = dict["year"] as? String,
        let imageUrl = dict["Poster"] as? String
            else { fatalError("Could not create movie object from supplied dictionary") }
        self.title = title
        self.year = year
        self.imageUrl = imageUrl
    }
}
