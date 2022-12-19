//
//  TopSheetViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/14.
//

import UIKit

class SheetViewController: BaseViewController {

    lazy var showTopSheetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Top Sheet", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.backgroundColor = .systemBlue
        btn.sizeToFit()
        return btn
    }()
    
    lazy var showBottomSheetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Bottom Sheet", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.backgroundColor = .systemBlue
        btn.sizeToFit()
        return btn
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAction()
    }
    
    override func setupLayout() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(showTopSheetButton)
        buttonStackView.addArrangedSubview(showBottomSheetButton)
    }
    
    override func setupConstraints() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        buttonStackView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        buttonStackView.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
  
    private func setAction() {
        self.showTopSheetButton.addTarget(self, action: #selector(didTapTopSheetButton), for: .touchUpInside)
        self.showBottomSheetButton.addTarget(self, action: #selector(didTapBottomSheetButton), for: .touchUpInside)
    }
    
    @objc func didTapTopSheetButton(_: UIButton) {
        let sheetView = SheetView()
        
        UIApplication.topViewController()?.view.addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        sheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        UIApplication.topViewController()?.view.layoutIfNeeded()
        
        sheetView.showTopSheet()
    }
    
    @objc func didTapBottomSheetButton(_: UIButton) {
        let sheetView = SheetView(gubun: .bottom)
        
        UIApplication.topViewController()?.view.addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        sheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        UIApplication.topViewController()?.view.layoutIfNeeded()
        
        sheetView.showBottomSheet()
    }
}
