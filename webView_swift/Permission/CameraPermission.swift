//
//  CameraPermission.swift
//  webView_swift
//
//  Created by wons on 2022/10/31.
//

import Foundation
import AVFoundation

class CameraPermission {
    // 권한 요청
    func requestAuthorization() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                PermissionAlert().grantedPermission("카메라")
            } else {
                PermissionAlert().deniedPermission("카메라", "카메라")
            }
        })
    }
    
    // 권한 체크
    func authorizationStatus() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        print("[CameraPermission.authorizationStatus() : \(authorizationStatus)]")
    }
}

