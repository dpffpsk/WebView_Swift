//
//  PDFViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/12.
//

import UIKit
import PDFKit

class PDFViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupConstraints() {
        let pdfView = PDFView(frame: self.view.bounds)
        
        view.addSubview(pdfView)
        
//        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        
//        let fileURL = Bundle.main.url(forResource: "파일명", withExtension: "pdf")
        let urlString = "https://www.africau.edu/images/default/sample.pdf"
        
        if let url = URL(string: urlString) {
            pdfView.document = PDFDocument(url: url)
        }
    }
}
