//
//  ImageViewController.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
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
        
    }
    
    // MARK: - Private API
    private func setup() {
        guard let image = image else { return }
        
        textLabel.text = image.comment
    }
    
}
