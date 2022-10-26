//
//  PermissionView.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/26.
//

import UIKit

class PermissionView: BaseView {
    
    lazy var cameraButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("카메라", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var photoButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("사진첩", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var locationButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("위치정보", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var contactsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("연락처", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 30
        return stack
    }()
    
    override func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(cameraButton)
        stackView.addArrangedSubview(photoButton)
        stackView.addArrangedSubview(locationButton)
        stackView.addArrangedSubview(contactsButton)
    }
    
    override func setupConstraints() {
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        cameraButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        cameraButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true

        photoButton.translatesAutoresizingMaskIntoConstraints = false
        photoButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        photoButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true

        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        contactsButton.translatesAutoresizingMaskIntoConstraints = false
        contactsButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        contactsButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        contactsButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -200).isActive = true
    }
}
