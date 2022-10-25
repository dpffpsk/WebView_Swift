//
//  CustomTableViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/21.
//

import UIKit

class CustomTableViewController: BaseViewController {

    let customTableview = CustomTableView()
    let data = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTableview.tableView.dataSource = self
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
extension CustomTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: CustomTableViewCell, reuseIdentifier: String(describing: UITableViewCell.self))
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        return cell
    }
}

