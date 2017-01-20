
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
    let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext

    //MARK: - Core data functions

    func fetchData() {
        let fetchRequest: NSFetchRequest<SavedMovie> = SavedMovie.fetchRequest()
        do {
            savedMovies = try managedContext.fetch(fetchRequest)
        } catch {
            print("Error executing fetch request")
        }
    }
    
    func deleteMovieFromCoreData(index: Int) {
        let movieToDelete = savedMovies[index]
        managedContext.delete(movieToDelete)
        do {
            try managedContext.save()
        } catch {
            print("Error trying to save context after delete")
            return
        }
        savedMovies.remove(at: index)
    }
}
