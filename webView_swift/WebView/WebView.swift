//
//  WebView.swift
//  webView_swift
//
//  Created by wons on 2022/10/19.
//

import UIKit
import WebKit

class WebView: WKWebView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: .zero, configuration: configuration)
    }


    
    /*
     override init(frame: CGRect, configuration: WKWebViewConfiguration) {
         super.init(frame: frame, configuration: configuration)
     }
     
     init() {
         let configuration = WKWebViewConfiguration()
         super.init(frame: .zero, configuration: configuration)
     }
     */
}
