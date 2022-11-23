//
//  PresentationView.swift
//  webView_swift
//
//  Created by wony on 2022/11/23.
//

import UIKit

class PresentationView: BaseView {

    lazy var pushButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("PUSH", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return btn
    }()
    
    lazy var presentButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("PRESENT", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return btn
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 50
        return stack
    }()
    
    override func setupLayout() {
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(pushButton)
        buttonStackView.addArrangedSubview(presentButton)
    }
    
    override func setupConstraints() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonStackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
