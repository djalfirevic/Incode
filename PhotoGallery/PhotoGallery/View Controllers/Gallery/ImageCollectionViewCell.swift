//
//  ImageCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet private weak var imageView: AsyncImageView!
    var image: Image? {
        didSet {
            setup()
        }
    }
    
    // MARK: - Cell Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Private API
    private func setup() {
        guard let image = image else { return }
        
        imageView.loadImage(from: image.picture, forID: image.id)
    }
    
}
