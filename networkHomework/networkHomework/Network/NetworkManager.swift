//
//  NetworkManager.swift
//  networkHomework
//
//  Created by Mikhail Chuparnov on 21.02.2023.
//

import Foundation

class NetworkManager {
    
    let baseUrl = "https://api.punkapi.com/v2/beers"
    
    func getBeerData(_ complitionHendler: @escaping ([Beer]) -> Void) {
        if let url = URL(string: baseUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let resultData = data {
                        do {
                            let decoder = JSONDecoder()
                            guard let beers = try? decoder.decode([Beer].self, from: resultData) else {return}
                            
                            DispatchQueue.main.async {
                                complitionHendler(beers)
                            }
                        } catch let jsonError {
                            print("Failed to decode JSON", jsonError)
                        }
                        
                    }
                }
            }.resume()
        }
        
        
    }
    
    func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
