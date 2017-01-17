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
    
    var movieDetailViewModel: MovieDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieDetailViewModel = movieDetailViewModel {
            print("movie title is \(movieDetailViewModel.title)")
            titleLabel.text = movieDetailViewModel.title
        } else {
            print("movie detail view model is nil")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
