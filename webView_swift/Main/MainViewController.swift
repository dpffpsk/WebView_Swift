//
//  ViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/14.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    let introView = IntroView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        setupConstraints()
        setIntro()
        buttonAction()
    }
    
    func setupLayout() {
        view.addSubview(mainView)
        view.addSubview(introView)
    }
    
    func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        
        introView.translatesAutoresizingMaskIntoConstraints = false
        introView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        introView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        introView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        introView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setIntro() {
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(introTimer), userInfo: nil, repeats: false)
    }
    
    @objc func introTimer() {
        view.subviews.forEach { view in
            if view == introView {
                view.removeFromSuperview()
            }
        }
    }
    
    func buttonAction() {
        self.mainView.nativeButton.addTarget(self, action: #selector(showNative), for: .touchUpInside)
    }
    
    @objc func showNative(_: UIButton) {
        let vc = SubViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
