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
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAction()
    }
    
    override func setupLayout() {
        view.addSubview(showTopSheetButton)
    }
    
    override func setupConstraints() {
        showTopSheetButton.translatesAutoresizingMaskIntoConstraints = false
        showTopSheetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        showTopSheetButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        showTopSheetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        showTopSheetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
  
    private func setAction() {
        self.showTopSheetButton.addTarget(self, action: #selector(didTapTopSheetButton), for: .touchUpInside)
    }
    
    @objc func didTapTopSheetButton(_: UIButton) {
        let sheetView = SheetView()
        view.addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        sheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.view.layoutIfNeeded()
        
        self.navigationController?.navigationBar.isHidden = true
        sheetView.show()
    }
}
