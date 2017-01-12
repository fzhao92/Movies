//
//  ViewController.swift
//  Movies
//
//  Created by Forrest Zhao on 1/6/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        shared.getMoviesByTitle(title: "Gladiator") {
//            print("Number of movies found  \(self.shared.movies.count)")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.getMoviesByTitle(title: searchBar.text!) {
            print("search completed")
        }
    }
}

