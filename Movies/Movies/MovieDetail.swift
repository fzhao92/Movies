//
//  MovieDetail.swift
//  Movies
//
//  Created by Forrest Zhao on 1/12/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

struct MovieDetail {
    var title: String
    var year: String
    var rated: String
    var released: String
    var genre: String
    var director: String
    var actors: String {
        didSet {
            if actors.lowercased().contains("leonardo dicaprio"){
                containsLeo = true
            }
        }
    }
    var plot: String
    var containsLeo: Bool = false
    
    init(dict: JSON) {
        self.title = dict["Title"] as! String
        self.year = dict["Year"] as! String
        self.rated = dict["Rated"] as! String
        self.released = dict["Released"] as! String
        self.genre = dict["Genre"] as! String
        self.director = dict["Director"] as! String
        self.actors = dict["Actors"] as! String
        self.plot = dict["Plot"] as! String
    }
}
