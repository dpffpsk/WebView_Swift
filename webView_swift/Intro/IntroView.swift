//
//  IntroView.swift
//  webView_swift
//
//  Created by wons on 2022/10/18.
//

import UIKit

class IntroView: UIView {
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "WELCOME"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var acornImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "acorn_image")?.withRenderingMode(.alwaysTemplate)
        img.sizeToFit()
        img.tintColor = .white
        return img
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBlue
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
//        addSubview(descriptionLabel)
        addSubview(acornImageView)
    }
    
    func setupConstraints() {
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
//        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
//        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
//        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        acornImageView.translatesAutoresizingMaskIntoConstraints = false
        acornImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        acornImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        acornImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        acornImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
