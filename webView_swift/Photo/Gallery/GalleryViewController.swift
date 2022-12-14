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
    
    // gallery 버튼
    private func buttonAction() {
        self.galleryView.galleryButton.addTarget(self, action: #selector(tappedGallery(_:)), for: .touchUpInside)
    }
    
    // 사진첩 권한 요청
    @objc func tappedGallery(_: UIButton) {
        GalleryPermission().requestAuthorization { [weak self] _ in
            self?.openGallery()
        }
    }
    
    // 사진첩 열기
    private func openGallery() {
        if #available(iOS 14.0, *) {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 0
            configuration.filter = .any(of: [.images, .videos])

            DispatchQueue.main.async {
                let picker = PHPickerViewController(configuration: configuration) // must be used from main thread only
                picker.delegate = self

                self.present(picker, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true)
            }
        }
    }
}

// available(iOS 14.0, *)
extension GalleryViewController: PHPickerViewControllerDelegate {
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.galleryView.galleryImageView.image = image as? UIImage
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}

// deprecated(iOS 14.0)
extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            galleryView.galleryImageView.contentMode = .scaleToFill
            galleryView.galleryImageView.image = pickedImage //4
        }
        dismiss(animated: true, completion: nil)
    }
     
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


