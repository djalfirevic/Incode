//
//  GalleryViewViewModel.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation

final class GalleryViewViewModel {
    
    // MARK: - Properties
    private var images = [Image]()
    var numberOfImages: Int {
        return images.count
    }
    var fetchCompleted: (() -> Void)?
    
    // MARK: - Public API
    func imageAt(_ indexPath: IndexPath) -> Image? {
        return images[indexPath.item]
    }
    
    func fetchImages() {
        DataManager().getImages { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let images):
                self.images = images
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self.fetchCompleted?()
        }
    }
    
    func insertImage(_ image: Image) {
        images.append(image)
    }
    
}
