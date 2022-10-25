//
//  IntroView.swift
//  webView_swift
//
//  Created by wons on 2022/10/18.
//

import UIKit

class IntroView: UIView {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Intro"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
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
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
