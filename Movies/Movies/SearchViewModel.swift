//
//  SearchViewModel.swift
//  Movies
//
//  Created by Forrest Zhao on 1/12/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    
    var movies: [Movie] = []
    
    func getMoviesByTitle(title: String, _ completion: @escaping () -> ()) {
        OAMDbAPIClient.getMovie(name: title) { (moviesJSON) in
            self.movies.removeAll()
            let moviesDict = moviesJSON["Search"] as! [JSON]
            for dict in moviesDict {
                let movie = Movie(dict: dict)
                self.movies.append(movie)
            }
            completion()
        }
    }
    
}
