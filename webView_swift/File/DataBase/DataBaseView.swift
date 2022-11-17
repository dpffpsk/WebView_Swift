//
//  DataBaseView.swift
//  webView_swift
//
//  Created by wons on 2022/11/16.
//

import UIKit

class DataBaseView: BaseView {
    
    lazy var createTableButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Create", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    lazy var insertDataButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Insert", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    lazy var updateDataButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Update", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    lazy var deleteDataButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Delete", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    lazy var dropTableButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Drop", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    lazy var dataTableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override init() {
        super.init()
        
        self.dataTableView.rowHeight = 50
        setTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        addSubview(dataTableView)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(createTableButton)
        buttonStackView.addArrangedSubview(insertDataButton)
        buttonStackView.addArrangedSubview(updateDataButton)
        buttonStackView.addArrangedSubview(deleteDataButton)
        buttonStackView.addArrangedSubview(dropTableButton)
    }
    
    override func setupConstraints() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  10).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -10).isActive = true
        
        dataTableView.translatesAutoresizingMaskIntoConstraints = false
        dataTableView.topAnchor.constraint(equalTo: self.buttonStackView.bottomAnchor, constant: 20).isActive = true
        dataTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dataTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        dataTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setTableView() {
        dataTableView.register(DataBaseViewCell.self, forCellReuseIdentifier: "dataBaseViewCell")
    }
}
