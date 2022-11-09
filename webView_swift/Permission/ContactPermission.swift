//
//  ContactPermission.swift
//  webView_swift
//
//  Created by wons on 2022/11/01.
//

import Foundation
import Contacts

class ContactPermission {
    func requestAuthorization() {
        CNContactStore().requestAccess(for: .contacts) { (granted, error) in
            guard granted // 권한 부여
            else { // 권한 거부
                PermissionAlert().deniedPermission("연락처", "연락처")
                return
            }
            PermissionAlert().grantedPermission("연락처")
        }
    }
}
