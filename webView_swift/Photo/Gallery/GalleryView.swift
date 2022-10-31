//
//  GalleryView.swift
//  webView_swift
//
//  Created by wons on 2022/10/28.
//

import UIKit

class GalleryView: BaseView {

    lazy var galleryButton: UIButton = {
        let btn = UIButton()
        btn.configuration = .filled()
        btn.setTitle("Gallery", for: .normal)
        return btn
    }()
    
    lazy var galleryImageView: UIImageView = {
        let img = UIImageView()
        img.sizeToFit()
        img.backgroundColor = .lightGray
        return img
    }()
    
    override func setupLayout() {
        addSubview(galleryButton)
        addSubview(galleryImageView)
    }
    
    override func setupConstraints() {
        galleryImageView.translatesAutoresizingMaskIntoConstraints = false
        galleryImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        galleryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        galleryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        galleryImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        galleryImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        galleryButton.topAnchor.constraint(equalTo: self.galleryImageView.bottomAnchor, constant: 20).isActive = true
        galleryButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        galleryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        galleryButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        galleryButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        galleryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
