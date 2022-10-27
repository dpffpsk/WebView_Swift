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

    var locationManager: CLLocationManager!
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
    
    func buttonAction() {
        self.permissionView.cameraButton.addTarget(self, action: #selector(cameraPermission), for: .touchUpInside)
        self.permissionView.photoButton.addTarget(self, action: #selector(photoPermission), for: .touchUpInside)
        self.permissionView.locationButton.addTarget(self, action: #selector(locationPermission), for: .touchUpInside)
        self.permissionView.contactsButton.addTarget(self, action: #selector(contactsPermission), for: .touchUpInside)
    }
    
    // 카메라 권한
    @objc func cameraPermission(_: UIButton) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("")
                print("===============================")
                print("카메라 : 권한 허용")
                print("===============================")
                print("")
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "카메라를 사용할 수 없습니다.\n설정 > 개인정보 보호 > 카메라 > APP 을 ON으로 설정해주세요.", preferredStyle: .alert)
                    
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
                print("카메라 : 권한 거부")
                print("===============================")
                print("")
            }
        })
    }
    
    // 사진첩 권한 //todo error
    @objc func photoPermission(_: UIButton) {
        PHPhotoLibrary.requestAuthorization( { status in
            if status == .authorized {
                print("")
                print("===============================")
                print("사진첩 : 권한 허용")
                print("===============================")
                print("")
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "사진첩을 사용할 수 없습니다.\n설정 > 개인정보 보호 > 사진 > APP 을 ON으로 설정해주세요.", preferredStyle: .alert)
                    
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
                print("사진첩 : 권한 거부")
                print("===============================")
                print("")
            }
        })
    }
    
    // 위치 권한
    @objc func locationPermission(_: UIButton) {
        if #available(iOS 14.0, *) {
            let accuracyState = CLLocationManager().accuracyAuthorization
            print("accuracyState : \(accuracyState)")
            
            if accuracyState == .fullAccuracy {
                print("")
                print("===============================")
                print("위치 : 권한 허용")
                print("===============================")
                print("")
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "위치를 사용할 수 없습니다.\n설정 > 개인정보 보호 > 위치 서비스 > APP 을 ON으로 설정해주세요.", preferredStyle: .alert)
                    
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
                print("위치 : 권한 거부")
                print("===============================")
                print("")
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                print("GPS: 권한 있음")
            case .restricted, .notDetermined:
                print("GPS: 아직 선택하지 않음")
            case .denied:
                print("GPS: 권한 없음")
            default:
                print("GPS: Default")
            }
        }
    }
    
    // 전화번호부 권한
    @objc func contactsPermission(_: UIButton) {
        
        CNContactStore().requestAccess(for: .contacts) { (granted, error) in
            guard granted // 권한 부여
            else { // 권한 거부
                print("")
                print("===============================")
                print("전화번호부 : 권한 거부")
                print("===============================")
                print("")
                
                // [메인 큐에서 비동기 방식 실행 : UI 동작 실시]
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "연락처를 사용할 수 없습니다.\n설정 > 개인정보 보호 > 연락처 > APP 을 ON으로 설정해주세요.", preferredStyle: .alert)
                    
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
                return
            }
            print("")
            print("===============================")
            print("전화번호부 : 권한 허용")
            print("===============================")
            print("")
        }
    }
}
