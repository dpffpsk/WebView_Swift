//
//  LocalizationViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/24.
//

import UIKit

class LocalizationViewController: BaseViewController {

    let localizationView = LocalizationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        view.addSubview(localizationView)
    }
    
    override func setupConstraints() {
        localizationView.translatesAutoresizingMaskIntoConstraints = false
        localizationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        localizationView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        localizationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        localizationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

