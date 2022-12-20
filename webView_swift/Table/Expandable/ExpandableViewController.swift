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
    // section의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return expandableCellData.count
    }
    
    // row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if expandableCellData[section].opened == true {
            // tableView Section이 열려있으면 Section Cell 하나에 sectionData 개수만큼 추가해줘야 함
            return expandableCellData[section].sectionData.count + 1
        } else {
            // tableView Section이 닫혀있을 경우에는 Section Cell 하나만 보여주면 됨
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // section 부분 코드
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath)
                       as? ExpandableTableViewCell else { return UITableViewCell() }
            
            print("::::::::::::::: \(expandableCellData[indexPath.section].title)")
            cell.titleLabel.text = expandableCellData[indexPath.section].title
           
            return cell
               
        // sectionData 부분 코드
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath)
                       as? ExpandableTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = expandableCellData[indexPath.section].sectionData[indexPath.row - 1]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
        
        // section 부분 선택하면 열리게 설정
        if indexPath.row == 0 {
            // section이 열려있다면 다시 닫힐 수 있게 해주는 코드
            expandableCellData[indexPath.section].opened = !expandableCellData[indexPath.section].opened
            
            // 모든 데이터를 새로고침하는 것이 아닌 해당하는 섹션 부분만 새로고침
            tableView.reloadSections([indexPath.section], with: .none)
        
        // sectionData 부분을 선택하면 아무 작동하지 않게 설정
        } else {
            print("이건 sectionData 선택한 거야")
        }
        
        print([indexPath.section], [indexPath.row])
    }
}
