//
//  CameraView.swift
//  webView_swift
//
//  Created by wons on 2022/10/27.
//

import UIKit

class CameraView: BaseView {

    lazy var retakeButton: UIButton = {
        let btn = UIButton()
        btn.configuration = .filled()
        btn.setTitle("Retake", for: .normal)
        return btn
    }()
    
    override func setupLayout() {
        addSubview(retakeButton)
    }
    
    override func setupConstraints() {
        retakeButton.translatesAutoresizingMaskIntoConstraints = false
        retakeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        retakeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        retakeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        retakeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
