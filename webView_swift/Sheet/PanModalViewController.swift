//
//  PanModalViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/20.
//

import UIKit
import PanModal

class PanModalViewController: BaseViewController {
    
    let panModalView = PanModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panModalView.tableView.dataSource = self
    }
    
    override func setupLayout() {
        view.addSubview(panModalView)
    }
    
    override func setupConstraints() {
        panModalView.translatesAutoresizingMaskIntoConstraints = false
        panModalView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        panModalView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        panModalView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        panModalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension PanModalViewController: PanModalPresentable, UITableViewDataSource {
    
    // tableView나 colletionView 사용할 경우 return에 해당 뷰 출력
//    var panScrollable: UIScrollView? {
//        return tableView
//    }
    var panScrollable: UIScrollView? {
        return nil
    }
    
    // 접혔을 때 높이
    var shortFormHeight: PanModalHeight {
        return .contentHeight(280)
    }
    
    // 펼쳤을 때 top에서부터 거리
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    
    // true : 화면 최상단까지 스크롤 불가
    var anchorModalToLongForm: Bool {
        return true
    }
    
    // 드래그로 내려도 화면 사라지지 않음
//    var allowsDragToDismiss: Bool {
//        return false
//    }
    
    // 호출시 백그라운드 색상
//    var panModalBackgroundColor: UIColor {
//        return UIColor.cyan.withAlphaComponent(0.3)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        cell.backgroundColor = .systemOrange

        // 달라진 방식(iOS 14.0 이상)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = "sample"
            content.textProperties.color = .white
            content.textProperties.font = UIFont.boldSystemFont(ofSize: 20)
            cell.contentConfiguration = content
        }
        
        return cell
    }
}

