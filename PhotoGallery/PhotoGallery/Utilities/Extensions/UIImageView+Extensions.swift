//
//  UIImageView+Extensions.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import Foundation
import UIKit

let cache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    func loadImage(from imageUrl: String, forID id: String) {
        if let image = cache.object(forKey: id as AnyObject) as? UIImage {
            self.image = image
            return
        }
		
		let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
		activityIndicatorView.hidesWhenStopped = true
		activityIndicatorView.startAnimating()
		activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(activityIndicatorView)
		NSLayoutConstraint.activate([
			activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
        
        if let url = URL(string: imageUrl), imageUrl.isValidURL {
            DispatchQueue.global(qos: .userInitiated).async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async { [weak self] in
                    if let data = data, url.absoluteString == imageUrl {
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
