//
//  MovieDetail.swift
//  Movies
//
//  Created by Forrest Zhao on 1/12/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

class MovieDetail {
    
    var title: String
    var year: String
    var rated: String
    var released: String
    var genre: String
    var director: String
    var actors: String
    var plot: String

    init(movieID: String) {
        self.title = ""
        self.year = ""
        self.rated = ""
        self.released = ""
        self.genre = ""
        self.director = ""
        self.actors = ""
        self.plot = ""
        getDetailsObject(id: movieID) { (dict) in
            if dict["Response"] as! String == "True" {
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
    }
    
    func getDetailsObject(id: String, completion: @escaping (JSON) -> ()) {
        OAMDbAPIClient.getMovieByImdbID(id: id) { (detailJSON) in
            completion(detailJSON)
        }
    }
    
}
