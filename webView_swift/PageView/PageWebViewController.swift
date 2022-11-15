//
//  PageWebViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/15.
//

import Foundation
import UIKit

class PageWebViewController: BaseViewController {
    
    var url: String?
    let webView: WebView = WebView()

    init(url: String? = nil){
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView(url: url ?? "https://www.naver.com")
    }
    
    override func setupLayout() {
        view.addSubview(webView)
    }
    
    override func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func loadWebView(url: String) {
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
