//
//  WKWebViewConfiguration.swift
//  webView_swift
//
//  Created by wons on 2022/10/20.
//

import UIKit
import WebKit

extension WKWebViewConfiguration {
    /// 웹뷰 쿠키 설정
    static func cookiesIncluded(completion: @escaping (WKWebViewConfiguration?) -> Void) {
        let config = WKWebViewConfiguration()
        guard let cookies = HTTPCookieStorage.shared.cookies else {
            completion(config)
            return
        }
        
        let dataStore = WKWebsiteDataStore.default()
        // 저장 유무 nonPersistent() or default()
        
        let waitGroup = DispatchGroup()
        for cookie in cookies {
            waitGroup.enter()
            dataStore.httpCookieStore.setCookie(cookie) { waitGroup.leave() }
        }
        waitGroup.notify(queue: DispatchQueue.main) {
            config.websiteDataStore = dataStore
            completion(config)
        }
    }
}


/*
 let task = URLSession.shared.dataTask(with: request){(data, response, error) in
     guard let data = data, error == nil else {
         print("error=\(error)")
         return
     }
     
     if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
         // 쿠키 저장하기
         let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: response!.url!)
         HTTPCookieStorage.shared.setCookies(cookies, for: response!.url!, mainDocumentURL: nil)
     }
 }
 task.resume()
 */
