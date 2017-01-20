//
//  SavedMovieTableViewController.swift
//  Movies
//
//  Created by Forrest Zhao on 1/19/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

class SavedMovieTableViewController: UITableViewController {
    
    fileprivate let reuseIdentifier = "savedMovieCell"
    fileprivate let segueIdentifier = "showMovieDetailFromSaved"

    var savedMovieViewModel = SavedMovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        savedMovieViewModel.fetchData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMovieViewModel.savedMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = savedMovieViewModel.savedMovies[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            savedMovieViewModel.deleteMovieFromCoreData(index: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = savedMovieViewModel.savedMovies[indexPath.row].imdbID
        performSegue(withIdentifier: segueIdentifier, sender: movieID)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let destVC = segue.destination as! MovieDetailViewController
            destVC.movieID = sender as? String
        }
    }

}
