//
//  MainViewController+WKUIDelegate.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/17.
//

import UIKit
import WebKit

extension MainViewController: WKUIDelegate {
    
    // alert(js에서 호출하는 alert)
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            completionHandler()
        })
        
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    

    // confirm(js에서 호출하는 confirm)
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            completionHandler(false)
        }
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler(true)
        }
            
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
            
        self.present(alertController, animated: true)
    }
}
