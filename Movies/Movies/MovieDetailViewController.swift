//
//  ViewController.swift
//  Movies
//
//  Created by Forrest Zhao on 1/16/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var plotLabel: UILabel!
    
    var movieID: String?
    var movieDetailViewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDetailViewModel(movieID: movieID!) { (movieDetailViewModel) in
            self.titleLabel.text = movieDetailViewModel.title
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: - Helpers

extension MovieDetailViewController {
    
    func createDetailViewModel(movieID: String, completion: @escaping (MovieDetailViewModel) -> ()) {
        var movieDetail: MovieDetail?
        OAMDbAPIClient.getMovieByImdbID(id: movieID) { (jsonDict) in
            if jsonDict["Response"] as! String == "True" {
                movieDetail = MovieDetail(dict: jsonDict)
            }
            if let movieDetail = movieDetail {
                completion(MovieDetailViewModel(movieDetail: movieDetail))
            }
        }
    }
}
