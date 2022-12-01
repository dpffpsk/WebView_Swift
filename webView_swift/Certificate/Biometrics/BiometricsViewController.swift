//
//  BiometricsViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/28.
//

import UIKit
import LocalAuthentication

class BiometricsViewController: BaseViewController {

    let biometricsView = BiometricsView()
    let authContext = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("authContext : \(authContext.biometryType.rawValue)")
        authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "인증하기") { success, error in
            print("결과", success, error)
        }
    }
 
    override func setupLayout() {
        view.addSubview(biometricsView)
    }
    
    override func setupConstraints() {
        biometricsView.translatesAutoresizingMaskIntoConstraints = false
        biometricsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        biometricsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        biometricsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        biometricsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
