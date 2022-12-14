//
//  CustomTableViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/21.
//

import UIKit

class CustomTableViewController: BaseViewController {

    let customTableview = CustomTableView()
    let data = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTableview.tableView.dataSource = self
        customTableview.tableView.delegate = self
    }
    
    override func setupLayout() {
        view.addSubview(customTableview)
    }
    
    override func setupConstraints() {
        customTableview.translatesAutoresizingMaskIntoConstraints = false
        customTableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        customTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        customTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        customTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor
                                                , constant: 0).isActive = true
    }
}
extension CustomTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: CustomTableViewCell, reuseIdentifier: String(describing: UITableViewCell.self))
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

