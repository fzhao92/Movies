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
    
    static func getMovie(name: String, with completion: @escaping ([JSON]) -> Void) -> Void {
        let urlString = OMBDb.baseURL + "?s=\(name)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [JSON] {
                if let json = json {
                    print("********* Success! *********")
                    print(json)
                    completion(json)
                }
            }
        }.resume()
    }
}
