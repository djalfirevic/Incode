//
//  ImageViewController.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

final class ImageViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    var image: Image?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Actions
    @IBAction private func shareButtonTapped() {
        guard let image = image else { return }
        
        if let image = cache.object(forKey: image.id as AnyObject) as? UIImage {
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityViewController, animated: true)
        }
    }
    
    // MARK: - Private API
    private func setup() {
        guard let image = image else { return }
        
        textLabel.text = image.comment
        imageView.loadImage(from: image.picture, forID: image.id)
    }
    
}
