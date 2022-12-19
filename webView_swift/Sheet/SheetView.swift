//
//  TopSheetView.swift
//  webView_swift
//
//  Created by wons on 2022/12/14.
//

import UIKit

enum Gubun{
    case top
    case bottom
}

class SheetView: UIView {
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var gubun: Gubun!
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var contentView: UIView = {
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

    init(gubun: Gubun? = .top) {
        super.init(frame: .zero)
        
        self.gubun = gubun
        self.backgroundColor = .clear
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGestureRecognizer)
        setupLayout()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(backgroundView)
        addSubview(contentView)
        contentView.addSubview(topLabel)
    }
    
    private func setupConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        if gubun == .top {
            topConstraint = contentView.topAnchor.constraint(equalTo: self.topAnchor)
            bottomConstraint = contentView.bottomAnchor.constraint(equalTo: self.topAnchor)
        } else {
            topConstraint = contentView.topAnchor.constraint(equalTo: self.bottomAnchor)
            bottomConstraint = contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        }
        
        leadingConstraint = contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        trailingConstraint = contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        
        topConstraint?.isActive = true
        bottomConstraint?.isActive = true
        leadingConstraint?.isActive = true
        trailingConstraint?.isActive = true
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        topLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    func showTopSheet() {
        topConstraint?.isActive = false
        bottomConstraint?.isActive = false
        
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve) {
            self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.layoutIfNeeded()
        }
    }
    
    private func hideSheet() {
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
    
    @objc private func didTapView(_: UITapGestureRecognizer) {
        topConstraint?.isActive = false
        bottomConstraint?.isActive = false
        
        if gubun == .top {
            contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        } else {
            contentView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        
        hideSheet()
    }
    
    func showBottomSheet() {
        topConstraint?.isActive = false
        bottomConstraint?.isActive = false
        
        contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.layoutIfNeeded()
        }
    }
}
