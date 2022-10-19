//
//  SubViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/19.
//

import UIKit

class SubViewController: UIViewController {

    let subView: SubView = SubView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
