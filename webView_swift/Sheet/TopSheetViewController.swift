//
//  TopSheetViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/23.
//

import UIKit

class TopSheetViewController: UIViewController {

//    lazy var movingView: UIView = {
//        let view = UIView()
//        return view
//    }()
//
//    lazy var viewIndicator: UIView = {
//       let view = UIView()
//        return view
//    }()
//
//    lazy var movingViewHeight: NSLayoutConstraint = {
//        let constraint = NSLayoutConstraint()
//        return constraint
//    }()
//
//    var isMonth = true
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        movingView.layer.cornerRadius = 40
//        viewIndicator.layer.cornerRadius = viewIndicator.frame.height / 2
//
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(scrollVertical))
//        movingView.addGestureRecognizer(panGesture)
//    }
//
//    @objc func scrollVertical(sender: UIPanGestureRecognizer) {
//        let dragPosition = sender.translation(in: self.view)
//
//        switch sender.state {
//        case .changed:
//            if isMonth {
//                movingViewHeight.constant = 453 + dragPosition.y
//            } else {
//                movingViewHeight.constant = 200 + dragPosition.y
//            }
//        case .ended:
//            if movingViewHeight.constant < 300{
//                self.movingViewHeight.constant = 200
//                isMonth = false
//            } else {
//                self.movingViewHeight.constant = 453
//                isMonth = true
//            }
//
//        default:
//            break
//        }
//    }
    
}
