//
//  ShareViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/24.
//

import UIKit

class ShareViewController: BaseViewController {

    let shareView = ShareView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAction()
    }
    
    override func setupLayout() {
        view.addSubview(shareView)
    }
    
    override func setupConstraints() {
        shareView.translatesAutoresizingMaskIntoConstraints = false
        shareView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        shareView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        shareView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        shareView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func buttonAction() {
        self.shareView.shareButton.addTarget(self, action: #selector(doShare), for: .touchUpInside)
    }
    
    @objc func doShare() {
        // 키보드 닫기
        view.endEditing(true)
        
        let shareText: String = self.shareView.shareTextField.text ?? ""
        var shareObject = [Any]() // text, url, file 등 배열에 담기
        shareObject.append(shareText)
        let activityViewController = UIActivityViewController(activityItems : shareObject, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        // 제외할 activity 항목
//        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop,
//                                                        UIActivity.ActivityType.postToFacebook,
//                                                        UIActivity.ActivityType.postToTwitter,
//                                                        UIActivity.ActivityType.mail]
        
        // 공유하기 동작 후 처리(성공, 실패)
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.showToast(message: "share success")
            } else {
                self.showToast(message: "share cancel")
            }
            if let shareError = error {
                self.showToast(message: "\(shareError.localizedDescription)")
            }
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    // Toast Message : iOS는 직접 만들어서 사용(안드로이드에서는 자체 라이브러리가 제공됨)
    private func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
