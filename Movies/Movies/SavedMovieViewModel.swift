
//
//  savedMovieViewModel.swift
//  Movies
//
//  Created by Forrest Zhao on 1/19/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation
import CoreData

class SavedMovieViewModel {
    
    var savedMovies: [SavedMovie] = [SavedMovie]()

    //MARK: - Core data functions

    func fetchData() {
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedMovie> = SavedMovie.fetchRequest()
        do {
            savedMovies = try managedContext.fetch(fetchRequest)
            print("Number of items in saved movies = \(savedMovies.count)")
        } catch {
            print("Error executing fetch request")
        }
    }
}
