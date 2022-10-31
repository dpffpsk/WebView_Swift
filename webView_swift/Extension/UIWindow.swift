//
//  UIWindow.swift
//  webView_swift
//
//  Created by wons on 2022/10/31.
//

import UIKit

extension UIWindow {
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    static private var firstRootViewController: UIViewController? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .first(where: { $0.isKeyWindow })?.rootViewController
    }

    /**
     - Author :
     - Date:
     - Parameters:
        - vc: rootViewController 혹은 UITapViewController
     - Returns: UIViewController?
     - Note: vc내에서 가장 최상위에 있는 뷰컨트롤러 반환
    */
//    'keyWindow' was deprecated in iOS 13.0: Should not be used for applications that support multiple scenes as it returns a key window across all connected scenes
//    public func visibleViewControllerFrom(vc:UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    
//    'windows' was deprecated in iOS 15.0: Use UIWindowScene.windows on a relevant window scene instead
//    public func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController ) -> UIViewController? {
    private func visibleViewControllerFrom(vc: UIViewController? = firstRootViewController ) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }

//    UIApplication.shared.connectedScenes
//        .compactMap { $0 as? UIWindowScene }
//        .flatMap { $0.windows }
//        .first { $0.isKeyWindow }
//
    
//    UIApplication.shared.connectedScenes
//        .filter { $0.activationState == .foregroundActive }
//        .map({ $0 as? UIWindowScene })
//        .compactMap({$0})
//        .first?.windows
//        .first({$0.isKeyWindow}).first
//
//
//    UIApplication.shared.connectedScenes
//                .filter { $0.activationState == .foregroundActive }
//                .first(where: { $0 is UIWindowScene })
//                .flatMap({ $0 as? UIWindowScene })?.windows
//                .first(where: \.isKeyWindow)
//
}
