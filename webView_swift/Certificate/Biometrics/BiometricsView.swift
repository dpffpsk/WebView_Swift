//
//  BiometricsView.swift
//  webView_swift
//
//  Created by wons on 2022/11/28.
//

import UIKit

class BiometricsView: BaseView {

    lazy var loginStateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOGIN", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return btn
    }()

    lazy var biometricsImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Face_ID_logo")
        return img
    }()
    
    override func setupLayout() {
        addSubview(loginStateButton)
        addSubview(biometricsImageView)
    }

    override func setupConstraints() {
        loginStateButton.translatesAutoresizingMaskIntoConstraints = false
        loginStateButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        loginStateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        loginStateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        loginStateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        biometricsImageView.translatesAutoresizingMaskIntoConstraints = false
        biometricsImageView.topAnchor.constraint(equalTo: self.loginStateButton.bottomAnchor, constant: 30).isActive = true
        biometricsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100).isActive = true
        biometricsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
        biometricsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -400).isActive = true
    }
}
