//
//  BiometricsView.swift
//  webView_swift
//
//  Created by wons on 2022/11/28.
//

import UIKit

class BiometricsView: BaseView {

    lazy var loginStateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "asdfsadf"
        return label
    }()
    
    lazy var biometricsImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Face_ID_logo")
        return img
    }()
    
    override func setupLayout() {
        addSubview(loginStateLabel)
        addSubview(biometricsImageView)
    }

    // TODO: 사이즈 조정
    override func setupConstraints() {
        loginStateLabel.translatesAutoresizingMaskIntoConstraints = false
        loginStateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        loginStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        loginStateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        loginStateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginStateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        biometricsImageView.translatesAutoresizingMaskIntoConstraints = false
        biometricsImageView.topAnchor.constraint(equalTo: self.loginStateLabel.bottomAnchor, constant: 30).isActive = true
        biometricsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        biometricsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        biometricsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -300).isActive = true
        biometricsImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        biometricsImageView.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
}
