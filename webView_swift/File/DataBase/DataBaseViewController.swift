//
//  DataBaseViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/16.
//

import UIKit

class DataBaseViewController: BaseViewController {
    
    let dataBaseView = DataBaseView()
    var dataModel: [DataModel] = []
    let dbHelper = DBHelper.shared
    let tableName: String = "testTable"

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAction()
        dataBaseView.dataTableView.dataSource = self
        dataBaseView.dataTableView.delegate = self
    }
    
    override func setupLayout() {
        view.addSubview(dataBaseView)
    }
    
    override func setupConstraints() {
        dataBaseView.translatesAutoresizingMaskIntoConstraints = false
        dataBaseView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        dataBaseView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        dataBaseView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        dataBaseView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func buttonAction() {
        dataBaseView.createTableButton.addTarget(self, action: #selector(createTable), for: .touchUpInside)
        dataBaseView.insertDataButton.addTarget(self, action: #selector(insertData), for: .touchUpInside)
        dataBaseView.updateDataButton.addTarget(self, action: #selector(updateData), for: .touchUpInside)
        dataBaseView.deleteDataButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        dataBaseView.dropTableButton.addTarget(self, action: #selector(dropTable), for: .touchUpInside)
    }
    
    @objc func createTable(_: UIButton) {
        dbHelper.createTable(tableName: tableName)
        self.dataModel = dbHelper.readData(tableName: tableName)
        self.dataBaseView.dataTableView.reloadData()
    }
    
    @objc func insertData(_: UIButton) {
        dbHelper.insertData(tableName: tableName, name: "파오리", age: 10)
        dbHelper.insertData(tableName: tableName, name: "팬텀", age: 5)
        self.dataModel = dbHelper.readData(tableName: tableName)
        self.dataBaseView.dataTableView.reloadData()
    }
    
    @objc func updateData(_: UIButton) {
        dbHelper.updateData(tableName: tableName, id: 1, name: "피카츄", age: 50)
        self.dataModel = dbHelper.readData(tableName: tableName)
        self.dataBaseView.dataTableView.reloadData()
    }
    
    @objc func deleteData(_: UIButton) {
        dbHelper.deleteData(tableName: tableName, id: 1)
        self.dataModel = dbHelper.readData(tableName: tableName)
        self.dataBaseView.dataTableView.reloadData()
    }
    
    @objc func dropTable(_: UIButton) {
        dbHelper.dropTable(tableName: tableName)
        self.dataModel = dbHelper.readData(tableName: tableName)
        self.dataBaseView.dataTableView.reloadData()
    }
}

extension DataBaseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dataBaseViewCell") as? DataBaseViewCell else { return UITableViewCell() }

        cell.idLabel.text = String(dataModel[indexPath.row].id)
        cell.nameLabel.text = String(dataModel[indexPath.row].name)
        
        if let age = dataModel[indexPath.row].age {
            cell.ageLabel.text = String(age)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





        
