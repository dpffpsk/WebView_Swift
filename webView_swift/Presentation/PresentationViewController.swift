//
//  PresentationViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/23.
//

import UIKit

class PresentationViewController: BaseViewController {

    let presentationView = PresentationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(presentationView)
    }
    
    override func setupConstraints() {
        presentationView.translatesAutoresizingMaskIntoConstraints = false
        presentationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        presentationView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        presentationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        presentationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func buttonAction() {
        self.presentationView.pushButton.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        self.presentationView.presentButton.addTarget(self, action: #selector(presentAction), for: .touchUpInside)
    }
    
    @objc func pushAction(_: UIButton) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade

        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(NextViewController(), animated: false)
    }
    
    @objc func presentAction(_: UIButton) {
        /*
         * UIModalTransitionStyle
         * - coverVertical : 아래에서 위
         * - crossDcissolve : 화면 교차
         * - flipHorizontal : 카드 뒤집히는 효과
         * - partialCurl : 종이 넘김 효과
         */
        
        /*
         * UIModalPresentationStyle
         * - currentContext
         * - fullScreen
         * - overCurrentContext
         * - overFullScreen
         * - formSheet
         * - pageSheet
         * - popover
         */
        
        let nextVC = NextViewController()
        nextVC.modalTransitionStyle = .flipHorizontal
        nextVC.modalPresentationStyle = .popover
        self.present(nextVC, animated: true)
    }
}

