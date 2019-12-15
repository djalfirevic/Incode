//
//  GalleryViewViewModel.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

class GalleryViewViewModel {
    
    // MARK: - Properties
    private var images = [Image]()
    var numberOfImages: Int {
        return images.count
    }
    
    // MARK: - Public API
    func imageAt(_ indexPath: IndexPath) -> Image? {
        return images[indexPath.item]
    }
    
    // MARK: - Private API
    
}
