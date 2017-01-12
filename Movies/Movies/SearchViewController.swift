//
//  ViewController.swift
//  Movies
//
//  Created by Forrest Zhao on 1/6/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController {

    let shared = SearchResultsDataStore.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        shared.getMoviesByTitle(title: "Gladiator") {
            print("Number of movies found  \(self.shared.movies.count)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

