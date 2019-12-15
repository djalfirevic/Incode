//
//  NetworkFetchService.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

let ENDPOINT = "http://www.json-generator.com/api/json/get/cftPFNNHsi"

class NetworkFetchService {}

extension NetworkFetchService: FetchService {
    
    // MARK: - FetchService
    func getImages(_ completion: @escaping (Result<[Image], Error>) -> Void) {
        if let url = URL(string: ENDPOINT) {
            DispatchQueue.global(qos: .userInitiated).async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if let data = data {
                        let decoder = JSONDecoder()
                        
                        do {
                            let images = try decoder.decode([Image].self, from: data)
                            
                            completion(.success(images))
                            Logger.log(message: "Parsing successful: \(images.count) element(s) parsed.", type:  .success)
                        } catch {
                            Logger.log(message: "Parsing error: \(error.localizedDescription)", type:  .error)
                            Logger.log(message: "Parsing error: \(error)", type:  .error)
                            
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
    }
    
}
