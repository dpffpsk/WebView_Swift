//
//  DataBaseViewCell.swift
//  webView_swift
//
//  Created by wons on 2022/11/17.
//

import Foundation
import UIKit

class DataBaseViewCell: UITableViewCell {
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     cell이 재사용될 때도 호출됩니다.
     tableView가 가지고 있는 selected indexPath와
     cell이 표시될 indexPath를 비교하고 선택상태롤 자동으로 설정하기 때문에
     재사용 여부와 관계없이 항상 정확한 상태를 표시합니다.
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        /*
         selected 파라미터로 조건문을 걸어
         didSelected 혹은 didDeseleted되었을 때
         실행될 코드를 작성할 수 있습니다.
         */
        super.setSelected(selected, animated: animated)
    }
    
    private func setupLayout() {
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(idLabel)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(ageLabel)
    }
    
    private func setupConstraints() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}
