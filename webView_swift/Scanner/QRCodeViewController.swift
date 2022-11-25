//
//  QRCodeViewController.swift
//  webView_swift
//
//  Created by wons on 2022/11/25.
//

import UIKit

class QRCodeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect(origin: .zero, size: view.frame.size)
        let qrcode = QRCodeView(frame: frame)

        qrcode.generateCode("https://wwww.naver.com")

        view.addSubview(qrcode)
    }
}
