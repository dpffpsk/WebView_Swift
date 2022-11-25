//
//  LocalizationView.swift
//  webView_swift
//
//  Created by wons on 2022/11/24.
//

import UIKit

class LocalizationView: BaseView {
    
    lazy var textLabel1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var textLabel2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var textLabel3: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    lazy var koreanButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("한국어", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return btn
    }()
    
    lazy var englishButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("영어", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return btn
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    override func setupLayout() {
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(textLabel1)
        labelStackView.addArrangedSubview(textLabel2)
        labelStackView.addArrangedSubview(textLabel3)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(koreanButton)
        buttonStackView.addArrangedSubview(englishButton)
    }
    
    override func setupConstraints() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 30).isActive = true
        labelStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        labelStackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: self.labelStackView.bottomAnchor, constant: 50).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 30).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonStackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}

