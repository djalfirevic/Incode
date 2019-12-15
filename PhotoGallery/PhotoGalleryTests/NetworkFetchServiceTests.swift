//
//  NetworkFetchServiceTests.swift
//  PhotoGalleryTests
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import XCTest
@testable import PhotoGallery

class NetworkFetchServiceTests: XCTestCase {

    // MARK: - Properties
    private let dataManager = DataManager(service: NetworkFetchService())
    
    // MARK: - Tests
    func test_getImages() {
        let requestExpectation = expectation(description: "Request Expectation")
        
        dataManager.getImages() { result in
            requestExpectation.fulfill()
            
            switch result {
            case .success(let images):
                XCTAssertNotNil(images, "There should be some images.")
            case .failure(let error):
                XCTFail("There should be some images.")
            }
        }
        
        waitForExpectations(timeout: 5, handler: { (error) in
            if error != nil {
                XCTFail("Request timed out")
            }
        })
    }

}
