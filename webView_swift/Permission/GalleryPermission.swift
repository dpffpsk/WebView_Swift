//
//  GalleryPermission.swift
//  webView_swift
//
//  Created by wons on 2022/10/31.
//

import Foundation
import Photos
import UIKit

class GalleryPermission {
    // 권한 요청
    func requestAuthorization(success: ((PHAuthorizationStatus) -> Void)? = nil) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { authorizationStatus in
                switch authorizationStatus {
                case .denied:
                    PermissionAlert().deniedPermission("사진첩", "사진")
                case .authorized, .limited:
                    success?(.authorized)
                default:
                    print("[GalleryPermission.requestAuthorization() : \(authorizationStatus)]")
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization { authorizationStatus in
                switch authorizationStatus {
                case .denied:
                    PermissionAlert().deniedPermission("사진첩", "사진")
                case .authorized:
                    success?(.authorized)
                default:
                    print("[GalleryPermission.requestAuthorization() : \(authorizationStatus)]")
                }
            }
        }
    }
    
    // 권한 체크
    func authorizationStatus() {
        var authorizationStatus: PHAuthorizationStatus
        
        if #available(iOS 14, *) {
            authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            authorizationStatus = PHPhotoLibrary.authorizationStatus()
        }
        
        print("[GalleryPermission.authorizationStatus() : \(authorizationStatus)]")
    }
}
