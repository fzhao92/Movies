//
//  ViewController.swift
//  Movies
//
//  Created by Forrest Zhao on 1/6/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    fileprivate let reuseIdentifier = "FlickrCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SearchViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.getMoviesByTitle(title: searchBar.text!) {
            print("search completed")
            self.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("movies count= \(searchViewModel.movies.count)")
        return searchViewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! SearchCollectionViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: SearchCollectionViewCell, indexPath: IndexPath) {
        cell.showActivityIndicator()
        let movie = searchViewModel.movies[indexPath.row]
        cell.title.text = movie.title
        movie.loadImage { (movie, error) in
            if error == nil {
                cell.moviePosterImage.image = movie.image
                cell.hideActivityIndicator()
            } else {
                print("Error loading image!!!!")
                print(error)
                return
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
