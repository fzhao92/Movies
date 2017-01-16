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
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "movieCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
//        collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension SearchViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchViewModel.getMoviesByTitle(title: searchBar.text!) { (hasResults) in
            self.activityIndicator.stopAnimating()
            if hasResults {
                print("search completed")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            else {
                print("No results found for query")
                //show no results ui error notification
            }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
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
                print("Error loading image!!!!")
                cell.moviePosterImage.image = UIImage(named: "no-image-placeholder")
                if let error = error {
                    print(error)
                }
                return
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size for item at called!")

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        print("available width is \(availableWidth)")
        print("width for item is \(widthPerItem)")

        return CGSize(width: widthPerItem, height: widthPerItem * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

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
