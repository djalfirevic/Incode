//
//  FileFetchService.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

class FileFetchService {
	
	// MARK: - Properties
	private var images = [Image]()
	
	// MARK: - Initializer
	init() {
		do {
			try configureData()
		} catch {
			Logger.log(message: "\(error)", type: .error)
		}
	}
	
	// MARK: - Private API
	private func configureData() throws {
		guard let path = Bundle.main.path(forResource: "images", ofType: "json") else { return }
		
		let url = URL(fileURLWithPath: path)
		let decoder = JSONDecoder()
		
		do {
			let data = try Data(contentsOf: url)
			
			images = try decoder.decode([Image].self, from: data)
			
            Logger.log(message: "Parsing successful: \(images.count) element(s) parsed.", type:  .success)
		} catch {
			Logger.log(message: "Parsing error: \(error.localizedDescription)", type:  .error)
			Logger.log(message: "Parsing error: \(error)", type:  .error)
			
			throw error
		}
	}
	
}

extension FileFetchService: FetchService {
	
	// MARK: - FetchService
    func getImages(_ completion: @escaping (Result<[Image], Error>) -> Void) {
        completion(.success(images))
    }
	
}
