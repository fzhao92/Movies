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
    @IBOutlet weak var saveMovieButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDetailLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveMovieButtonPressed(_ sender: UIButton) {
        
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
    
    func populateDetailLabels() {
        startActivityIndicator()
        createDetailViewModel(movieID: movieID!) { (movieDetailViewModel) in
            DispatchQueue.main.async {
                self.stopActivityIndicator()
                self.titleLabel.text = movieDetailViewModel.title
                (self.detailStackView.arrangedSubviews[0] as! UILabel).text = movieDetailViewModel.year
                (self.detailStackView.arrangedSubviews[1] as! UILabel).text = movieDetailViewModel.rated
                (self.detailStackView.arrangedSubviews[2] as! UILabel).text = movieDetailViewModel.released
                (self.detailStackView.arrangedSubviews[3] as! UILabel).text = movieDetailViewModel.genre
                (self.detailStackView.arrangedSubviews[4] as! UILabel).text = movieDetailViewModel.director
                (self.detailStackView.arrangedSubviews[5] as! UILabel).text = movieDetailViewModel.actors
                self.plotLabel.text = movieDetailViewModel.plot
            }
        }
    }
    
    func startActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        saveMovieButton.isEnabled = false
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        saveMovieButton.isEnabled = true
    }
}
