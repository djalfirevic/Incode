//
//  DataManager.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

class DataManager {
	
	// MARK: - Properties
	private let service: FetchService
	
	// MARK: - Initializers
	init() {
		self.service = NetworkFetchService()
	}
	
	init(service: FetchService) {
		self.service = service
	}
	
	// MARK: - Public API
    func getImages(_ completion: @escaping (Result<[Image], Error>) -> Void) {
        service.getImages(completion)
	}
	
}
