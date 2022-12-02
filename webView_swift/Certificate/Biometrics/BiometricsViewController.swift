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
    
    enum AuthenticationState {
        case login, logout
    }
    
    // 현재 로그인 상태에 따른 UI 변화
    var state = AuthenticationState.logout {
        didSet {
            if state == .login {
                biometricsView.loginStateButton.setTitle("LOGOUT", for: .normal)
            } else {
                biometricsView.loginStateButton.setTitle("LOGIN", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAction()
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
    
    func buttonAction() {
        self.biometricsView.loginStateButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        if state == .login {
            state = .logout
        } else {
            let authContext = LAContext()
            print("authContext : \(authContext.biometryType.rawValue)")
            
            if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "인증하기") { success, error in
                    
                    if success {
                        DispatchQueue.main.async {
                            self.state = .login
                        }
                    } else {
                        
                    }
                    print("결과", success, error)
                }
            }
        }
    }
}
