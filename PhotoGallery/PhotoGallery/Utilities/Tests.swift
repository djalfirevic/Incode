//
//  Tests.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

enum Tests: String {
	static let isTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil || ProcessInfo.processInfo.arguments.contains(Tests.arguments.rawValue)
	
	case arguments = "UITests"
	case galleryCollectionViewIdentifier = "tests--galleryCollectionView"
}
