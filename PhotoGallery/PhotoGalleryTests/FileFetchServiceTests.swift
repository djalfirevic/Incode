//
//  FileFetchServiceTests.swift
//  PhotoGalleryTests
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import XCTest
@testable import PhotoGallery

class FileFetchServiceTests: XCTestCase {
	
	// MARK: - Properties
	private let dataManager = DataManager(service: FileFetchService())
	
	// MARK: - Tests
	func test_getImages() {
		dataManager.getImages() { result in
            switch result {
            case .success(let images):
                XCTAssertNotNil(images, "There should be at least 2 images.")
            case .failure(let error):
                XCTFail("There should be at least 2 images.")
            }
		}
	}
	
}
