//
//  GalleryView.swift
//  webView_swift
//
//  Created by wons on 2022/10/28.
//

import UIKit

class GalleryView: BaseView {

    lazy var selectButton: UIButton = {
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
        addSubview(selectButton)
        addSubview(galleryImageView)
    }
    
    override func setupConstraints() {
        galleryImageView.translatesAutoresizingMaskIntoConstraints = false
        galleryImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        galleryImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        galleryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        galleryImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        galleryImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.topAnchor.constraint(equalTo: self.galleryImageView.bottomAnchor, constant: 20).isActive = true
        selectButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        selectButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
