//
//  SheetPresentationViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/20.
//

import UIKit

// @available(iOS 15.0, *)
class SheetPresentationViewController: BaseViewController {
    
    lazy var showSheetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("TaDa", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.textColor = .white
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(showSheetButton)
    }
    
    override func setupConstraints() {
        showSheetButton.translatesAutoresizingMaskIntoConstraints = false
        showSheetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        showSheetButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
        showSheetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        showSheetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func buttonAction() {
        self.showSheetButton.addTarget(self, action: #selector(showSheetPresentationController), for: .touchUpInside)
    }
    
    @objc private func showSheetPresentationController() {
        let viewControllerToPresent = BottomSheetViewController()
        
        if let sheet = viewControllerToPresent.sheetPresentationController {
            // 드래그를 멈추면 그 위치에 멈추는 지점
            if #available(iOS 16.0, *) {
                sheet.detents = [.large(), .medium(), .custom(resolver: { context in
                    0.1*context.maximumDetentValue
                })]
            } else {
                sheet.detents = [.large(), .medium()]
            }
            // 초기화 드래그 위치
            sheet.selectedDetentIdentifier = .medium
            // sheet 상단의 막대기 표시 여부
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30.0
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
}
