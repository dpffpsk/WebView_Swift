//
//  PermissionViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/26.
//

import UIKit
import AVFoundation

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
    
    func buttonAction() {
        self.permissionView.cameraButton.addTarget(self, action: #selector(showNative), for: .touchUpInside)
    }
    
    @objc func showNative(_: UIButton) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                DispatchQueue.main.async {
                    //UIAlertController
                    let alert = UIAlertController(title: "", message: "카메라를 사용할 수 없습니다.\n설정 > 개인정보 보호 > 카메라 > APP 을 ON으로 설정해주세요.", preferredStyle: .alert)
                    
                    // Button
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
                    
                    print("Camera: 권한 거부")
                }
            }
        })
    }
}
