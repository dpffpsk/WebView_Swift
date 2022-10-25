//
//  BasicTableViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/21.
//

import UIKit

class BasicTableViewController: BaseViewController {

    let basicTableView = BasicTableView()
    let data = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicTableView.tableView.dataSource = self
    }

    override func setupLayout() {
        view.addSubview(basicTableView)
    }
    
    override func setupConstraints() {
        basicTableView.translatesAutoresizingMaskIntoConstraints = false
        basicTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        basicTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        basicTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        basicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension BasicTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        
        // 달라진 방식(iOS 14.0 이상)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.data[indexPath.row]
            cell.contentConfiguration = content
        } else {
        // 기존과 동일(iOS 14.0 까지만 지원)
            cell.textLabel?.text = self.data[indexPath.row]
        }
        
        return cell
    }
}
