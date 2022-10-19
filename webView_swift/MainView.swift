//
//  MainView.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/19.
//

import UIKit

class MainView: UIView {

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Main"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .green
        addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }

}
