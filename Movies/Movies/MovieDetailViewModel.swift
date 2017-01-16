//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Forrest Zhao on 1/12/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    let title: String
    let year: String
    let rated: String
    let released: String
    let genre: String
    let director: String
    let actors: String
    let plot: String
    var containsLeo = false
    
    init(movieDetail: MovieDetail) {
        self.title = movieDetail.title
        self.year = "Year: \(movieDetail.year)"
        self.rated = "Rated: \(movieDetail.rated)"
        self.released = "Released: \(movieDetail.released)"
        self.genre = "Genre: \(movieDetail.genre)"
        self.director = "Director: \(movieDetail.director)"
        self.actors = "Actors: \(movieDetail.actors)"
        self.plot = movieDetail.plot
        hasLeo(movieDetail: movieDetail)
    }
    
    func hasLeo(movieDetail: MovieDetail) {
        if movieDetail.actors.lowercased().contains("leonardo dicaprio") {
            containsLeo = true
        }
    }
    
}
