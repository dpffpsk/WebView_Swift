//
//  BaseView.swift
//  webView_swift
//
//  Created by wons on 2022/10/21.
//

import UIKit

class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
    }
    
    func setupConstraints() {
        
    }
}
