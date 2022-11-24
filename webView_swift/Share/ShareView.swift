//
//  ShareView.swift
//  webView_swift
//
//  Created by wons on 2022/11/24.
//

import UIKit

class ShareView: BaseView {

    lazy var shareTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 3
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.8)
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    lazy var shareButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("공유하기", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    override func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(shareTextField)
        stackView.addArrangedSubview(shareButton)
    }
    
    override func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
}
