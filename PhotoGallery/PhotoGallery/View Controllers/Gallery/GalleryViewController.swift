//
//  GalleryViewController.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView!
    private let viewModel = GalleryViewViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FETCH podataka...
    }
    
    // MARK: - Private API
    private func showImage(_ image: Image) {
        let storyboard = UIStoryboard(name: Storyboards.main.rawValue, bundle: Bundle.main)
        if let imageViewController = storyboard.instantiateViewController(identifier: ImageViewController.identifier) as? ImageViewController {
            imageViewController.image = image
            navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
    
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Unable to instantiate ImageCollectionViewCell")
        }
        
        cell.image = viewModel.imageAt(indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
}
