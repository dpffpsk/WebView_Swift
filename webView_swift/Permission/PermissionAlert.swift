//
//  PermissionAlert.swift
//  webView_swift
//
//  Created by wons on 2022/10/31.
//

import UIKit

class PermissionAlert {
    
    // 권한 허용 alert
    func grantedPermission(_ str: String) {
        let alert = UIAlertController(title: "\(str) 권한 허용 상태입니다.", message: "", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
        print("[\(str) : 권한 허용]")
    }
    
    // 권한 거부 alert
    func deniedPermission(_ str1: String, _ str2: String) {
        let alert = UIAlertController(title: "", message: "\(str1)을 사용할 수 없습니다.\n설정 > 개인정보 보호 > \(str2) > APP 을 ON으로 설정해주세요.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "설정", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
        
        print("[\(str1) : 권한 거부]")
    }
}
