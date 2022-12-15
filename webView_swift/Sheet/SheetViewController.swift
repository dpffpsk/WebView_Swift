//
//  TopSheetViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/12/14.
//

import UIKit

class SheetViewController: BaseViewController {

    let sheetView = SheetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(sheetView)
    }
    
    override func setupConstraints() {
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sheetView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        sheetView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sheetView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.view.layoutIfNeeded()
    }
  
    func buttonAction() {
        self.sheetView.showTopSheetButton.addTarget(self, action: #selector(didTapTopSheetButton), for: .touchUpInside)
    }
    
    @objc func didTapTopSheetButton(_: UIButton) {
        print("dsfsdf")
        
        self.navigationController?.navigationBar.isHidden = true
        sheetView.show()
        self.sheetView.showTopSheetButton.isEnabled = false
    }
    
}
