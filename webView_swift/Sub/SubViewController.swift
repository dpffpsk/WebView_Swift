//
//  SubViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/19.
//

import UIKit

class SubViewController: UIViewController {

    let subView: SubView = SubView()
    let data = [["Basic", "Custom", "Expand"],["A", "B", "C"]]
    let header = ["TableView", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        subView.tableView.dataSource = self
        subView.tableView.delegate = self
        
        setupLayout()
        setupConstraints()
    }

    func setupLayout() {
        view.addSubview(subView)
    }
    
    func setupConstraints() {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        subView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        subView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        subView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension SubViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        cell.accessoryType = .disclosureIndicator
        
        // 달라진 방식(iOS 14.0 이상)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.data[indexPath.section][indexPath.row]
            cell.contentConfiguration = content
        } else {
        // 기존과 동일(iOS 14.0 까지만 지원)
            cell.textLabel?.text = self.data[indexPath.section][indexPath.row]
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    // tapped cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = UIViewController()

        switch indexPath.row {
        case 0:
            vc = BasicTableViewController()
        case 1:
            vc = CustomTableViewController()
        default:
            print("empty vc")
        }

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
