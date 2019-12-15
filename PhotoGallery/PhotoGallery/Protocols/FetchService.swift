//
//  FetchService.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

protocol FetchService {
	func getImages(_ completion: @escaping (Result<[Image], Error>) -> Void)
}
