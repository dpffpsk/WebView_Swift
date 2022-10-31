//
//  GalleryPermission.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/31.
//

import Foundation
import Photos

class GalleryPermission {
    
    // 권한 요청
    func requestAuthorization() {
        let requiredAccessLevel: PHAccessLevel = .readWrite
        
//        PHPhotoLibrary.requestAuthorization { authorizationStatus in // will be deprecated(ios 14)
        PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
            switch authorizationStatus {
            case .limited:
                PermissionAlert().deniedPermission("사진첩", "사진")
            case .authorized:
                PermissionAlert().grantedPermission("사진")
            default:
                print("authorizationStatus : default")
            }
        }
    }
    
    
    // 권한 체크
    func authorizationStatus() -> PHAuthorizationStatus {
        let accessLevel: PHAccessLevel = .readWrite
        
//        let authorizationStatus = PHPhotoLibrary.authorizationStatus() // will be deprecated(ios 14)
        let authorizationStatus = PHPhotoLibrary.authorizationStatus(for: accessLevel)

        switch authorizationStatus {
        case .notDetermined:
            print("User has not yet made a choice with regards to this application")
        case .restricted:
            print("This application is not authorized to access photo data.")
        case .denied:
            print("dfdf")
        case .authorized:
            print("dddff")
        case .limited:
            print("limited authorization granted")
        default:
            print("Not implemented")
        }
        
        print("========== : \(authorizationStatus)")
        
        /*
         @available(iOS 8, *)
         case notDetermined = 0 // User has not yet made a choice with regards to this application

         @available(iOS 8, *)
         case restricted = 1 // This application is not authorized to access photo data.

         // The user cannot change this application’s status, possibly due to active restrictions
         //   such as parental controls being in place.
         @available(iOS 8, *)
         case denied = 2 // User has explicitly denied this application access to photos data.

         @available(iOS 8, *)
         case authorized = 3 // User has authorized this application to access photos data.

         @available(iOS 14, *)
         case limited = 4 // User has authorized this application for limited photo library access. Add PHPhotoLibraryPreventAutomaticLimitedAccessAlert = YES to the application's Info.plist to prevent the automatic alert to update the users limited library selection. Use -[PHPhotoLibrary(PhotosUISupport) presentLimitedLibraryPickerFromViewController:] from PhotosUI/PHPhotoLibrary+PhotosUISupport.h to manually present the limited library picker.
         */
        return authorizationStatus
    }
}
