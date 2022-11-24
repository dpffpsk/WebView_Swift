//
//  BaseViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        setupConstraints()
    }
    
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupLayout() {
        
    }
    
    func setupConstraints() {
        
    }
}
