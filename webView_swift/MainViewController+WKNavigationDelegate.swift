//
//  MainViewController+WKNavigationDelegate.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/17.
//

import UIKit
import WebKit

extension MainViewController: WKNavigationDelegate {
    
    // 해당 웹 페이지를 로드할지 말지 결정
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if let host = navigationAction.request.url?.host,
//                if host == "www.apple.com" {
//                    decisionHandler(.allow) // 해당 웹 페이지 로드
//                    return
//                }
//        }
//        decisionHandler(.cancel) 해당 웹 페이지 로드하지 않음
    }
    
    // 웹뷰가 컨텐츠를 로딩을 준비할 때
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 웹뷰가 컨텐츠를 받기 시작할 때
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // URL이 유효하지 않을 때 호출되지 않음
        // 로딩 상태를 표시해주는 액티비티 인디케이터 뷰를 사용할 때 해당 메서드 호출
    }
    
    // 웹뷰가 컨텐츠 받기를 완료했을 때
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    // 웹뷰가 컨텐츠 받기를 실패했을 때
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // 네트워크에 문제가 있거나 URL이 잘못 되었을 때 호출
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            
    }
}
