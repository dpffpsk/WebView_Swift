//
//  ViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/14.
//

import UIKit
import WebKit

/*
 (Sub가 아닌)MainViewController 을 첫 화면으로 사용
 - LaunchScreen 밑에 webView 로딩하는 기능
 - 주석 처리 제거 및 SceneDelegate rootViewController 변경
 */
class MainViewController: UIViewController {
    
    let mainView = MainView()
//    let introView = IntroView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        setupConstraints()
//        setIntro()
//        buttonAction()
    }
    
    func setupLayout() {
        view.addSubview(mainView)
//        view.addSubview(introView)
    }
    
    func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        introView.translatesAutoresizingMaskIntoConstraints = false
//        introView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        introView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        introView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        introView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
//    func setIntro() {
//        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(introTimer), userInfo: nil, repeats: false)
//    }
    
//    @objc func introTimer() {
//        view.subviews.forEach { view in
//            if view == introView {
//                view.removeFromSuperview()
//            }
//        }
//    }
    
//    func buttonAction() {
//        self.mainView.nativeButton.addTarget(self, action: #selector(showNative), for: .touchUpInside)
//    }
//
//    @objc func showNative(_: UIButton) {
//        let vc = SubViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
