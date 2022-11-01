//
//  PermissionViewController.swift
//  webView_swift
//
//  Created by wons on 2022/10/26.
//

import UIKit
import AVFoundation
import Photos
import CoreLocation
import Contacts

class PermissionViewController: BaseViewController {

    let permissionView = PermissionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(permissionView)
    }
    
    override func setupConstraints() {
        permissionView.translatesAutoresizingMaskIntoConstraints = false
        permissionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        permissionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        permissionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        permissionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // 버튼 클릭시 이벤트
    private func buttonAction() {
        self.permissionView.cameraButton.addTarget(self, action: #selector(cameraPermission), for: .touchUpInside)
        self.permissionView.photoButton.addTarget(self, action: #selector(photoPermission), for: .touchUpInside)
        self.permissionView.locationButton.addTarget(self, action: #selector(locationPermission), for: .touchUpInside)
        self.permissionView.contactsButton.addTarget(self, action: #selector(contactsPermission), for: .touchUpInside)
    }
    
    // 카메라 권한
    @objc func cameraPermission(_: UIButton) {
        CameraPermission().requestAuthorization()
    }
    
    // 사진첩 권한
    @objc func photoPermission(_: UIButton) {
        GalleryPermission().requestAuthorization()
    }
    
    // 위치 권한
    @objc func locationPermission(_: UIButton) {
        CLLocationManager().requestWhenInUseAuthorization() // 위치 권한 요청
        
        var authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authorizationStatus = CLLocationManager().authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        print("authorizationStatus : \(authorizationStatus)")
        
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            PermissionAlert().grantedPermission("위치")
        case .restricted, .notDetermined:
            print("")
            print("===============================")
            print("[위치 : 아직 선택하지 않음]")
            print("===============================")
            print("")
        case .denied:
            PermissionAlert().deniedPermission("위치", "위치 서비스")
        default:
            print("위치 : Default")
        }
        
        if #available(iOS 14.0, *) {
            let accuracyState = CLLocationManager().accuracyAuthorization
            print("accuracyState : \(accuracyState)")
            
            switch accuracyState {
            case .fullAccuracy: // 정확한 위치 데이터에 접근
                print("full")
            case .reducedAccuracy: // 대략적 위치 데이터에 접근
                print("reduce")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    // 전화번호부 권한
    @objc func contactsPermission(_: UIButton) {
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
