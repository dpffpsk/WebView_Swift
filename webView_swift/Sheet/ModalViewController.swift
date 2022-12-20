//
//  ModalViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/20.
//

import UIKit
import PanModal

// PanModal 라이브러리 사용
class ModalViewController: BaseViewController {
    
    let panModalViewController = PanModalViewController()

    lazy var modalButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("show", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemOrange
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(modalButton)
    }
    
    override func setupConstraints() {
        modalButton.translatesAutoresizingMaskIntoConstraints = false
        modalButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        modalButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        modalButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        modalButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func buttonAction() {
        self.modalButton.addTarget(self, action: #selector(showPanModal), for: .touchUpInside)
    }
    
    @objc private func showPanModal(_: UIButton) {
        self.presentPanModal(panModalViewController)
    }
}
