//
//  IntroViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/18.
//

import UIKit

class IntroViewController: UIViewController {

    let introView = IntroView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    
    
    private func setupView() {
        view.addSubview(introView)
        
        introView.translatesAutoresizingMaskIntoConstraints = false
        
        
        introView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        introView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        introView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        introView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
