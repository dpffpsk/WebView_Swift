//
//  Gallery.swift
//  webView_swift
//
//  Created by wons on 2022/11/01.
//

import UIKit
import PhotosUI

// TODO: 사진첩 불러오기
class Gallery: NSObject, PHPickerViewControllerDelegate {
    
    var view: UIViewController?
    
    init(_ view: UIViewController) {
        super.init()
        self.view = view
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    if let vc = self.view as? GalleryViewController {
                        vc.galleryView.galleryImageView.image = image as? UIImage
                    }
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}
