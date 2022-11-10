//
//  CoreDataView.swift
//  webView_swift
//
//  Created by wons on 2022/11/09.
//

import UIKit

class CoreDataView: BaseView {
    
    lazy var selectImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("이미지 선택", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    lazy var getImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("이미지 불러오기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    lazy var getImageView: UIImageView = {
        let img = UIImageView()
        img.sizeToFit()
        img.backgroundColor = .lightGray
        return img
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 30
        return stack
    }()
    
    override func setupLayout() {
        addSubview(getImageView)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(selectImageButton)
        buttonStackView.addArrangedSubview(getImageButton)
    }
    
    override func setupConstraints() {
        getImageView.translatesAutoresizingMaskIntoConstraints = false
        getImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        getImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        getImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: self.getImageView.bottomAnchor, constant: 30).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
