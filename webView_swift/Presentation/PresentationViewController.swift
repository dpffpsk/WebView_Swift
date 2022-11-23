//
//  PresentationViewController.swift
//  webView_swift
//
//  Created by wony on 2022/11/23.
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
//        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "nextVC") else {return}
//
//        nextVC.modalPresentationStyle = presentSet[present]
//        nextVC.modalTransitionStyle = transSet[trans]
//
//        nextVC.view.alpha = 0.5
//
//        self.present(nextVC, animated: true)
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let main = storyboard.instantiateViewController(withIdentifier: "MainStoryBoard") as! UINavigationController
        main.modalPresentationStyle = .fullScreen
        present(main, animated: true, completion: nil)
    }
}

