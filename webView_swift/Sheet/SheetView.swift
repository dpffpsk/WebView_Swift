//
//  TopSheetView.swift
//  webView_swift
//
//  Created by wons on 2022/12/14.
//

import UIKit

class SheetView: BaseView {

    lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        /// layerMinXMinYCorner : 좌측 상단
        /// layerMaxXMinYCorner : 우측 상단
        /// layerMaxXMaxYCorner : 우측 하단
        /// layerMinXMaxYCorner : 좌측 하단
        // view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner)
        return view
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "★Top Sheet★"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    lazy var showTopSheetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Top Sheet", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    override func setupLayout() {
        addSubview(backgroundView)
        backgroundView.addSubview(showTopSheetButton)
    }
    
    override func setupConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        showTopSheetButton.translatesAutoresizingMaskIntoConstraints = false
        showTopSheetButton.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor).isActive = true
        showTopSheetButton.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor).isActive = true
        showTopSheetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        showTopSheetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func show() {
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve) {
            self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.layoutIfNeeded()
        }
    }
    
    func hide() {
        
    }
}
