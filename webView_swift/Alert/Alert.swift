//
//  Alert.swift
//  webView_swift
//
//  Created by wons on 2022/11/22.
//

import UIKit

class Alert {
    func show(isCanceled: Bool = false, title: String? = nil, message: String? = nil, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            handler?()
        }
        
        if isCanceled {
            let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            alert.addAction(cancel)
        }
        
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
    }
}
