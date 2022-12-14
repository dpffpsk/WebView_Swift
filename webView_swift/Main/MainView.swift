//
//  MainView.swift
//  webView_swift
//
//  Created by wons on 2022/10/19.
//

import UIKit

class MainView: UIView {

    lazy var webView: WebView = WebView()

    var nativeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Native", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()

    init() {
        super.init(frame: .zero)
        
        setupLayout()
        setupConstraints()
        loadWebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(webView)
//        addSubview(nativeButton)
    }
    
    func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
//        nativeButton.translatesAutoresizingMaskIntoConstraints = false
//        nativeButton.topAnchor.constraint(equalTo: self.webView.bottomAnchor, constant: 15).isActive = true
//        nativeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        nativeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        nativeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        nativeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func loadWebView() {
        let myURL = URL(string:"https://www.naver.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
