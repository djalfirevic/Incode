//
//  AsyncImageView.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

let cache = NSCache<AnyObject, AnyObject>()
class AsyncImageView: UIImageView {

    // MARK: - Properties
    private var imageUrl: String?
    
    // MARK: - Public API
    func loadImage(from imageUrl: String, forID id: String) {
        self.imageUrl = imageUrl
        
        if let image = cache.object(forKey: id as AnyObject) as? UIImage {
            self.image = image
            return
        }
        
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        if let url = URL(string: imageUrl) {
            DispatchQueue.global(qos: .userInitiated).async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async { [weak self] in
                    if let data = data, let imageUrl = self?.imageUrl, url.absoluteString == imageUrl {
                        if let image = UIImage(data: data) {
                            self?.image = image
                            cache.setObject(image, forKey: id as AnyObject)
                            
                            activityIndicatorView.stopAnimating()
                            activityIndicatorView.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
}
