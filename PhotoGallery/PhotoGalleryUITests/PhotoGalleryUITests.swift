//
//  PhotoGalleryUITests.swift
//  PhotoGalleryUITests
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import XCTest

class PhotoGalleryUITests: XCTestCase {
    
    // MARK: - Properties
    var application: XCUIApplication!
    
    // MARK: - Setup
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launchArguments = [Tests.arguments.rawValue]
        application.launch()
        XCUIDevice.shared.orientation = .portrait
        
        UIView.setAnimationsEnabled(false)
    }
    
    // MARK: - Tests
    func test_galleryCollectionViewExists() {
        let galleryCollectionView = application.collectionViews[Tests.galleryCollectionViewIdentifier.rawValue]
        XCTAssertTrue(galleryCollectionView.exists, "The gallery collection view should exist.")
    }
    
}
