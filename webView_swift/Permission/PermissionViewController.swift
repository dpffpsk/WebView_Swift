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
        CameraPermission().requestAuthorization { _ in
            PermissionAlert().grantedPermission("카메라")
        }
    }
    
    // 사진첩 권한
    @objc func photoPermission(_: UIButton) {
        GalleryPermission().requestAuthorization { _ in
            PermissionAlert().grantedPermission("사진")
        }
    }
    
    // 위치 권한
    @objc func locationPermission(_: UIButton) {
        LocationPermission().requestAuthorization()
    }
    
    // 전화번호부 권한
    @objc func contactsPermission(_: UIButton) {
        ContactPermission().requestAuthorization()
    }
}
