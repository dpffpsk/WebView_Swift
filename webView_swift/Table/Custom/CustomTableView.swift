//
//  CustomTableView.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/21.
//

import UIKit

class CustomTableView: BaseView {

    // tableView 생성
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override init() {
        super.init()
        
        self.tableView.rowHeight = 100
        setTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant:  10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    func setTableView() {
     tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    }
}
