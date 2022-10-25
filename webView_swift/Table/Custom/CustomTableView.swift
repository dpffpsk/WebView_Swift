//
//  CustomTableView.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/21.
//

import UIKit

class CustomTableView: BaseView {

    // tableView 생성
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
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
        label.textColor = .blue
        label.text = "content"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "face.smiling.fill")
        return img
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    override func setupLayout() {
        
        /*
         addSubview(titleLabel)
         addSubview(listCollectionView)
         addSubview(buttonStackView)
         buttonStackView.addArrangedSubview(registerButton)
         buttonStackView.addArrangedSubview(importButton)
         */
    
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentsLabel)
        
        
    }
    
    override func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        /*
         buttonStackView.snp.makeConstraints {
             $0.top.equalTo(listCollectionView.snp.bottom).offset(50)
             $0.leading.equalToSuperview().offset(leading)
             $0.trailing.equalToSuperview().offset(-trailing)
             $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-bottom)
             $0.height.equalTo(60)
         }
         */
    }
    
    func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}
