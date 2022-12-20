//
//  PanModalView.swift
//  webView_swift
//
//  Created by wons on 2022/12/20.
//

import UIKit
import PanModal

class PanModalView: BaseView {
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override init() {
        super.init()
        
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
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setTableView() {
        tableView.backgroundColor = .systemOrange
        tableView.contentInset.top = 10
        tableView.separatorInset.right = 15
        tableView.separatorColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}
