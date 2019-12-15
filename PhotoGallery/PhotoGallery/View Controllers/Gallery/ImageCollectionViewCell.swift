//
//  ImageCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet private weak var imageView: UIImageView!
    var image: Image? {
        didSet {
            setup()
        }
    }
    
    // MARK: - Private API
    private func setup() {
        guard let image = image else { return }
    }
    
}
