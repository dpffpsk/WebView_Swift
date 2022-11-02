//
//  LocationPermission.swift
//  webView_swift
//
//  Created by wons on 2022/11/01.
//

import Foundation
import CoreLocation

class LocationPermission {
    // 권한 요청 // request authorization
    func requestAuthorization() {

        var authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authorizationStatus = CLLocationManager().authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            PermissionAlert().grantedPermission("위치")
        case .notDetermined:
            CLLocationManager().requestWhenInUseAuthorization()
        case .denied:
            PermissionAlert().deniedPermission("위치", "위치 서비스")
        default:
            print("[LocationPermission.requestAuthorization().authorizationStatus : \(authorizationStatus)]")
        }
        
        if #available(iOS 14.0, *) {
            let accuracyState = CLLocationManager().accuracyAuthorization
            
            print("[LocationPermission.requestAuthorization().accuracyState : \(accuracyState)]")
        }
    }
    
    // 권한 체크
    func authorizationStatus() {
        var authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = CLLocationManager().authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        print("[LocationPermission.authorizationStatus() : \(authorizationStatus)]")
    }
}
