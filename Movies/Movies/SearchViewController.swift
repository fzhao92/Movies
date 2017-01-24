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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noSearchResultsLabel: UILabel!
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "movieCell"
    fileprivate let segueIdentifier = "showMovieDetail"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        noSearchResultsLabel.isHidden = true
        activityIndicator.hidesWhenStopped = true
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
    }
    
}

extension SearchViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchViewModel.getMoviesByTitle(title: searchBar.text!) { (hasResults) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if hasResults {
                    self.collectionView.isHidden = false
                    self.noSearchResultsLabel.isHidden = true
                    self.collectionView.reloadData()
                }
                else {
                    self.collectionView.isHidden = true
                    self.noSearchResultsLabel.isHidden = false
                }
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieID = searchViewModel.movies[indexPath.row].imdbID
        performSegue(withIdentifier: segueIdentifier, sender: movieID)
    }

}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let destVC = segue.destination as! MovieDetailViewController
            destVC.movieID = sender as? String
        }
    }
}

//MARK: - Helpers

extension SearchViewController {
    
    func configureCell(cell: SearchCollectionViewCell, indexPath: IndexPath) {
        cell.showActivityIndicator()
        let movie = searchViewModel.movies[indexPath.row]
        cell.title.text = movie.title
        cell.backgroundColor = UIColor.red
        movie.loadImage { (movie, error) in
            cell.hideActivityIndicator()
            if error == nil {
                cell.moviePosterImage.image = movie.image
            } else {
                cell.moviePosterImage.image = UIImage(named: "no-image-placeholder")
                if let error = error {
                    print(error)
                }
                return
            }
        }
    }
    
}

//TODO: - Impl for custom collectionview layout

//extension SearchViewController: SearchLayoutDelegate {
//    
//    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat {
//
//    }
//    
//    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat {
//
//    }
//}
