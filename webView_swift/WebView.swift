//
//  WebView.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/19.
//

import UIKit
import WebKit

class WebView: WKWebView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }
    
    init() {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        let userScript = WKUserScript(source: "postMessage()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        configuration.userContentController = contentController
        configuration.preferences = preferences
        
        super.init(frame: .zero, configuration: configuration)
    }
}
