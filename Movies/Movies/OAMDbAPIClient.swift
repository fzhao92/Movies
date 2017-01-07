//
//  OAMDbAPIClient.swift
//  Movies
//
//  Created by Forrest Zhao on 1/7/17.
//  Copyright © 2017 Forrest Zhao. All rights reserved.
//

import Foundation

class OAMDbAPIClient {
    typealias JSON = [String: Any]
    
    static func getMovie(name: String, with completion: @escaping (JSON) -> Void) -> Void {
        let urlString = OMBDb.baseURL + "/?s=\(name)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    completion(jsonObject as! JSON)
                }
                catch let error {
                    print("Error creating json object: \(error)")
                }
            }
        }
        task.resume()
    }
}
