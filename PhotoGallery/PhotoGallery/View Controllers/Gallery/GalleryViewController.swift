//
//  GalleryViewController.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    // MARK: - Private API
    private func showImage(_ image: Image) {
        let storyboard = UIStoryboard(name: Storyboards.main.rawValue, bundle: Bundle.main)
        if let imageViewController = storyboard.instantiateViewController(identifier: ImageViewController.identifier) as? ImageViewController {
            imageViewController.image = image
            navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
    
}
