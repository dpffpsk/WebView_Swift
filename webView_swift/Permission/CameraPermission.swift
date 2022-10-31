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
        
        switch authorizationStatus {
        case .authorized: // The user has previously granted access to the camera.
            print("authorized")
        case .notDetermined: // The user has not yet been asked for camera access.
            print("notDetermined")
        case .denied: // The user has previously denied access.
            print("denied")
        case .restricted: // The user can't grant access due to restrictions.
            print("restricted")
        @unknown default:
            print("unknown default")
        }
    }
}
