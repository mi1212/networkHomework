//
//  NetworkManager.swift
//  networkHomework
//
//  Created by Mikhail Chuparnov on 21.02.2023.
//

import UIKit

class NetworkManager {
    
    let baseUrl = "https://api.punkapi.com/v2/beers"
    
    var page = 2
    
    func getBeerData(_ complitionHendler: @escaping ([Beer]) -> Void) {
        if let url = URL(string: baseUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let resultData = data {
                        do {
                            
                            let beers = try JSONDecoder().decode([Beer].self, from: resultData)
                            
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
    
    func getBeerDataNextPage(_ complitionHendler: @escaping ([Beer]) -> Void) {
        if let url = URL(string: baseUrl + "?page=\(page)") {
            print("page \(page)")
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let resultData = data {
                        do {
                            
                            let beers = try JSONDecoder().decode([Beer].self, from: resultData)
                            
                            if !beers.isEmpty {
                                self.page += 1
                            }
                            
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
    
    func getImage(from url: URL, completion: @escaping (_ imageData: Data) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, respond, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(data)
            }
        }).resume()
    }
}
