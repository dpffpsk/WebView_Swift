//
//  ExpandableViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/25.
//

import UIKit

class ExpandableViewController: BaseViewController {

    let expandableTableview = ExpandableTableView()
    var expandableCellData = [ExpandableCellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expandableTableview.tableView.dataSource = self
        expandableTableview.tableView.delegate = self
        
        expandableCellData = [ExpandableCellData(opened: false,
                                                 title: "Section1",
                                                 sectionData: ["    Data1-1",
                                                               "    Data1-2",
                                                               "    Data1-3"]),
                              ExpandableCellData(opened: false,
                                                 title: "Section2",
                                                 sectionData: ["    Data2-1",
                                                               "    Data2-2",
                                                               "    Data2-3"]),
                              ExpandableCellData(opened: false,
                                                 title: "Section3",
                                                 sectionData: ["    Data3-1",
                                                               "    Data3-2",
                                                               "    Data3-3"])]

    }
    
    override func setupLayout() {
        view.addSubview(expandableTableview)
    }
    
    override func setupConstraints() {
        expandableTableview.translatesAutoresizingMaskIntoConstraints = false
        expandableTableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        expandableTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        expandableTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        expandableTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ExpandableViewController: UITableViewDataSource, UITableViewDelegate{
    // section??? ??????
    func numberOfSections(in tableView: UITableView) -> Int {
        return expandableCellData.count
    }
    
    // row??? ??????
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if expandableCellData[section].opened == true {
            // tableView Section??? ??????????????? Section Cell ????????? sectionData ???????????? ??????????????? ???
            return expandableCellData[section].sectionData.count + 1
        } else {
            // tableView Section??? ???????????? ???????????? Section Cell ????????? ???????????? ???
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // section ?????? ??????
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath)
                       as? ExpandableTableViewCell else { return UITableViewCell() }
            
            print("::::::::::::::: \(expandableCellData[indexPath.section].title)")
            cell.titleLabel.text = expandableCellData[indexPath.section].title
           
            return cell
               
        // sectionData ?????? ??????
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath)
                       as? ExpandableTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = expandableCellData[indexPath.section].sectionData[indexPath.row - 1]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ??? ?????? ??? ???????????? ?????? ????????? ????????? ???
        tableView.deselectRow(at: indexPath, animated: true)
        
        // section ?????? ???????????? ????????? ??????
        if indexPath.row == 0 {
            // section??? ??????????????? ?????? ?????? ??? ?????? ????????? ??????
            expandableCellData[indexPath.section].opened = !expandableCellData[indexPath.section].opened
            
            // ?????? ???????????? ?????????????????? ?????? ?????? ???????????? ?????? ????????? ????????????
            tableView.reloadSections([indexPath.section], with: .none)
        
        // sectionData ????????? ???????????? ?????? ???????????? ?????? ??????
        } else {
            print("?????? sectionData ????????? ??????")
        }
        
        print([indexPath.section], [indexPath.row])
    }
}
