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
    var error: NSError?
    
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
        
        setup()
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

    private func setup() {
        self.biometricsView.loginStateButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        let authContext = LAContext()
        canEvaluatePolicy(authContext: authContext)
        print("BiometryType : \(authContext.biometryType)")
        
        var imageName = ""
        switch authContext.biometryType {
        case .faceID:
            imageName = "Face_ID_logo"
        case .touchID:
            imageName = "Touch_ID_logo"
        default:
            print("BiometryType : none")
        }
        
        biometricsView.biometricsImageView.image = UIImage(named: imageName)
    }
    
    @objc func loginTapped() {
        // state login -> logout 변경(login 상태)
        if state == .login {
            state = .logout
        } else { // state logout -> login 변경(logout 상태)
            let authContext = LAContext()
            canEvaluatePolicy(authContext: authContext)
            
            let domainState = authContext.evaluatedPolicyDomainState

            if UserDefaults.standard.data(forKey: "domainState") != nil && domainState != UserDefaults.standard.data(forKey: "domainState") {
                print("domainState : \(String(describing: domainState))")
                
                Alert().show(message: "생체인증정보가 변경되어 재등록을 진행합니다.") {
                    self.evaluatePolicy(authContext: authContext, domainState: domainState)
                    return
                }
            } else {
                evaluatePolicy(authContext: authContext, domainState: domainState)
            }
        }
    }
    
    private func canEvaluatePolicy(authContext: LAContext = .init()) {
        guard authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            Alert().show(message: "Error : \(error?.localizedDescription ?? "Failed to authenticate")")
            return
        }
    }
    
    private func evaluatePolicy(authContext: LAContext = .init(), domainState: Data?) {
        if let domainState = domainState {
            UserDefaults.standard.set(domainState, forKey: "domainState")
        }
        
        authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "생체인증") { success, error in
            if success {
                DispatchQueue.main.async {
                    self.state = .login
                }
            } else {
                Alert().show(message: "Error : \(error?.localizedDescription ?? "Failed to authenticate")")
            }
        }
    }
}
