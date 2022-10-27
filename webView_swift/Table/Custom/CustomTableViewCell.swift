//
//  CustomTableViewCell.swift
//  webView_swift
//
//  Created by wons on 2022/10/25.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    lazy var iConImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "face.smiling.fill")
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "content"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var submitButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("submit", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {

        addSubview(iConImageView)
        addSubview(stackView)
        addSubview(submitButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentsLabel)
    }
    
    func setupConstraints() {
        // imageView
        iConImageView.translatesAutoresizingMaskIntoConstraints = false
        iConImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        iConImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        iConImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        iConImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        // stackView(Label+Label)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.iConImageView.trailingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
       
        // button
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 10).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        submitButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
