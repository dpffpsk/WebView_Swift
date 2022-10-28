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
    
    // 권한 허용 alert
    private func grantedPermission(_ str: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "\(str) 권한 허용 상태입니다.", message: "", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        print("")
        print("===============================")
        print("\(str) : 권한 허용")
        print("===============================")
        print("")
    }
    
    // 권한 거부 alert
    private func deniedPermission(_ str1: String, _ str2: String) {
        DispatchQueue.main.async {
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
            
            self.present(alert, animated: true, completion: nil)
        }
        
        print("")
        print("===============================")
        print("\(str1) : 권한 거부")
        print("===============================")
        print("")
    }
    
    // 카메라 권한
    @objc func cameraPermission(_: UIButton) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) in
            if granted {
                self?.grantedPermission("카메라")
            } else {
                self?.deniedPermission("카메라", "카메라")
            }
        })
    }
    
    // 사진첩 권한 //todo error
    @objc func photoPermission(_: UIButton) {
        PHPhotoLibrary.requestAuthorization( { [weak self] status in
            if status == .authorized {
                self?.grantedPermission("사진")
            } else {
                self?.deniedPermission("사진첩", "사진")
            }
        })
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
            self.grantedPermission("위치")
        case .restricted, .notDetermined:
            print("")
            print("===============================")
            print("위치 : 아직 선택하지 않음")
            print("===============================")
            print("")
        case .denied:
            self.deniedPermission("위치", "위치 서비스")
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
        CNContactStore().requestAccess(for: .contacts) { [weak self] (granted, error) in
            guard granted // 권한 부여
            else { // 권한 거부
                self?.deniedPermission("연락처", "연락처")
                return
            }
            self?.grantedPermission("연락처")
        }
    }
}
