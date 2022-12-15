//
//  TopSheetView.swift
//  webView_swift
//
//  Created by wons on 2022/12/14.
//

import UIKit

class SheetView: BaseView {
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
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
        label.text = "★Ta-Da!★"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    override init() {
        super.init()
        
        self.backgroundColor = .clear
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        addSubview(backgroundView)
        addSubview(contentView)
        contentView.addSubview(topLabel)
    }
    
    override func setupConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = contentView.topAnchor.constraint(equalTo: self.topAnchor)
        topConstraint?.isActive = true
        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: self.topAnchor)
        bottomConstraint?.isActive = true
        leadingConstraint = contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        leadingConstraint?.isActive = true
        trailingConstraint = contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        trailingConstraint?.isActive = true
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    func show() {
        topConstraint?.isActive = false
        bottomConstraint?.isActive = false
        
        contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            self.layoutIfNeeded()
        }
    }
    
    func hide() {
        topConstraint?.isActive = false
        bottomConstraint?.isActive = false
        
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                            self.backgroundView.backgroundColor = .clear
                            self.layoutIfNeeded()
                       },
                       completion: { _ in
                            self.removeFromSuperview()
            }
        )
    }
    
    @objc func didTapView(_: UITapGestureRecognizer) {
        hide()
    }
}
