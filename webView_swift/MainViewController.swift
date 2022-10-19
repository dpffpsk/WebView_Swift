//
//  ViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/14.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    
//    var webView: WKWebView!
//
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let myURL = URL(string:"https://www.naver.com")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
//    }
    
    let mainView = MainView()
    let introView = IntroView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(introTimer), userInfo: nil, repeats: false)
    }
    
    @objc func introTimer() {
        print("===Intro===")
        
        view.subviews.forEach { view in
            if view == introView {
                view.removeFromSuperview()
            }
        }
    }
    
    func setupConstraints() {
       // mainView.constraintsFromSuperView(superView: view, isTopSuperView: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("===viewWillAppear===")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("===viewDidAppear===")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("===viewWillDisappear===")
    }
    
    private func setupView() {
        view.addSubview(mainView)
        view.addSubview(introView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        introView.translatesAutoresizingMaskIntoConstraints = false
        introView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        introView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        introView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        introView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
