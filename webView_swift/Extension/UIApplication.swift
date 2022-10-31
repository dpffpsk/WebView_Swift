//
//  UIApplication.swift
//  webView_swift
//
//  Created by wons on 2022/10/31.
//

import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {

        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
//        let window = windowScene?.windows.first
        
//        'windows' was deprecated in iOS 15.0: Use UIWindowScene.windows on a relevant window scene instead
//        if let keyWindow = UIApplication.shared.windows.last {
        if let keyWindow = windowScene?.windows.first {
            if var viewController = keyWindow.rootViewController {
                while viewController.presentedViewController != nil {
                    viewController = viewController.presentedViewController!
                }
                
                return viewController
            }
        }
        return nil
    }
}
