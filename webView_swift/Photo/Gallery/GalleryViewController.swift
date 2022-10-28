//
//  GalleryViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/28.
//

import UIKit
import Photos
import PhotosUI

class GalleryViewController: BaseViewController {

    let galleryView = GalleryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonAction()
    }

    override func setupLayout() {
        view.addSubview(galleryView)
    }
    
    override func setupConstraints() {
        galleryView.translatesAutoresizingMaskIntoConstraints = false
        galleryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        galleryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        galleryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        galleryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // Select 버튼
    private func buttonAction() {
        self.galleryView.selectButton.addTarget(self, action: #selector(selected(_:)), for: .touchUpInside)
    }
    
    @objc func selected(_: UIButton) {
        // 사진첩 권한
        PHPhotoLibrary.requestAuthorization( { [weak self] status in
            if status == .authorized {
                self?.openGallery()
            } else {

            }
        })
    }
    
    func openGallery() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        DispatchQueue.main.async {
            let picker = PHPickerViewController(configuration: configuration) // must be used from main thread only
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
}

extension GalleryViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) // 1
        let itemProvider = results.first?.itemProvider // 2
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    self.galleryView.galleryImageView.image = image as? UIImage
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}
