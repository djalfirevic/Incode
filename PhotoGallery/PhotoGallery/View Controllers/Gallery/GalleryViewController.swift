//
//  GalleryViewController.swift
//  PhotoGallery
//
//  Created by Djuro Alfirevic on 12/15/19.
//  Copyright © 2019 Incode Technologies. All rights reserved.
//

import UIKit

internal enum Constants: CGFloat {
    case cellSize = 80.0
}

final class GalleryViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView!
    private let viewModel = GalleryViewViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Actions
    @IBAction private func uploadPhotoButtonTapped() {
        let alertController = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            let imagePicker = self?.configureImagePicker(for: .photoLibrary)
            self?.present(imagePicker!, animated: true)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                let imagePicker = self?.configureImagePicker(for: .camera)
                self?.present(imagePicker!, animated: true)
            }
            
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Private API
    private func setup() {
        setupForTests()
        setupViewModel()
    }
    
    private func showImage(_ image: Image) {
        let storyboard = UIStoryboard(name: Storyboards.main.rawValue, bundle: Bundle.main)
        
        if #available(iOS 13.0, *) {
            if let imageViewController = storyboard.instantiateViewController(identifier: ImageViewController.identifier) as? ImageViewController {
                imageViewController.image = image
                navigationController?.pushViewController(imageViewController, animated: true)
            }
        } else {
            if let imageViewController = storyboard.instantiateViewController(withIdentifier: ImageViewController.identifier) as? ImageViewController {
                imageViewController.image = image
                navigationController?.pushViewController(imageViewController, animated: true)
            }
        }
    }
    
    private func setupViewModel() {
        viewModel.fetchCompleted = { [weak self] in
            guard let self = self else { return }
            
            self.collectionView.reloadData()
        }
        viewModel.fetchImages()
    }
    
    private func configureImagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        
        return imagePicker
    }
    
    private func saveImage(with image: UIImage) {
        let id = UUID().uuidString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let publishedAt = dateFormatter.string(from: Date())
        
        var storedPath = ""
        if let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imagePath = documentDirectoryPath.appendingPathComponent("\(id).jpg")

            do {
                try image.jpegData(compressionQuality: 1)?.write(to: imagePath, options: .atomic)
                storedPath = imagePath.absoluteString
            } catch {
                print(error.localizedDescription)
            }
        }
        
        let createdImage = Image(comment: "", picture: storedPath, id: id, publishedAt: publishedAt, title: "")
        viewModel.insertImage(createdImage)
        
        let indexPath = IndexPath(item: viewModel.numberOfImages - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
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
        if let image = viewModel.imageAt(indexPath) {
            showImage(image)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.cellSize.rawValue, height: Constants.cellSize.rawValue)
    }
    
}

extension GalleryViewController: Testable {
    
    func setupForTests() {
        guard Tests.isTesting else { return }
        
        collectionView.accessibilityIdentifier = Tests.galleryCollectionViewIdentifier.rawValue
    }
    
}

extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            saveImage(with: editedImage)
        } else {
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                saveImage(with: originalImage)
            }
        }
        
        picker.dismiss(animated:true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:true)
    }
    
}
