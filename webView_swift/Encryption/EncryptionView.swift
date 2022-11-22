//
//  EncryptionView.swift
//  webView_swift
//
//  Created by wons on 2022/11/22.
//

import UIKit

class EncryptionView: BaseView {
    
    lazy var encryptTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.8)
        textField.font = UIFont.systemFont(ofSize: 30)

        return textField
    }()
    
    lazy var encryptButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("암호화", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return btn
    }()
    
    lazy var encryptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    lazy var encryptStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    lazy var decryptTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.8)
        textField.font = UIFont.systemFont(ofSize: 30)

        return textField
    }()
    
    lazy var decryptButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("복호화", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return btn
    }()
    
    lazy var decryptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    lazy var decryptStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    lazy var allStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 30
        return stack
    }()

    override func setupLayout() {
        addSubview(allStackView)
        allStackView.addArrangedSubview(encryptStackView)
        allStackView.addArrangedSubview(decryptStackView)
        encryptStackView.addArrangedSubview(encryptTextField)
        encryptStackView.addArrangedSubview(encryptButton)
        encryptStackView.addArrangedSubview(encryptLabel)
        decryptStackView.addArrangedSubview(decryptTextField)
        decryptStackView.addArrangedSubview(decryptButton)
        decryptStackView.addArrangedSubview(decryptLabel)
    }
    
    override func setupConstraints() {
        allStackView.translatesAutoresizingMaskIntoConstraints = false
        allStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        allStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        allStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        allStackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}
