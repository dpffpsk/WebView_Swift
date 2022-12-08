//
//  PatternLockView.swift
//  webView_swift
//
//  Created by wons on 2022/12/06.
//

import UIKit

class PatternLockView: BaseView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pattern"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()

    override func setupLayout() {
        self.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
