//
//  Movie.swift
//  Movies
//
//  Created by Forrest Zhao on 1/7/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]

class Movie {
    var title: String
    var year: String
    var imageUrl: String
    var imdbID: String
    var image: UIImage?
    
    init(dict: JSON) {
        guard let title = dict["Title"] as? String,
        let year = dict["Year"] as? String,
        let imdbID = dict["imdbID"] as? String,
        let imageUrl = dict["Poster"] as? String
            else { fatalError("Could not create movie object from supplied dictionary") }
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.imageUrl = imageUrl
    }
    
    func loadImage(_ completion: @escaping (_ Movie: Movie, _ error: NSError?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            print("Image url fucked")
            completion(self, nil)
            return
        }
        let loadRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: loadRequest, completionHandler: { (data, response, error) in
            if let error = error {
                print("error downloading image!!!")
                DispatchQueue.main.async {
                    completion(self, error as NSError?)
                }
                return
            }
            
            guard let data = data else {
                print("image data is nil!!!")
                DispatchQueue.main.async {
                    completion(self, nil)
                }
                return
            }
            
            let returnedImage = UIImage(data: data)
            self.image = returnedImage
            print("Image success!!!")
            DispatchQueue.main.async {
                completion(self, nil)
            }
        }).resume()
    }
}
