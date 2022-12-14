//
//  PDFViewController.swift
//  webView_swift
//
//  Created by wons on 2022/12/12.
//

import UIKit
import PDFKit

class PDFViewController: BaseViewController {

    let pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
    
        // main bundle : project 내 디렉토리에 있는 파일
        // guard let fileURL = Bundle.main.url(forResource: "파일명", withExtension: "pdf") else { return }
        guard let url = URL(string: "https://www.africau.edu/images/default/sample.pdf") else { return }
        
        guard let document = PDFDocument(url: url) else { return }
        pdfView.document = document
        
        // create document
        // var newDocument = PDFDocument()
        // guard let page = PDFPage(image: UIImage(systemName: "")!) else { return }
        // newDocument.insert(page, at: 1)
        // pdfView.document = newDocument
    }
    
    override func setupLayout() {
        view.addSubview(pdfView)
    }
    
    override func setupConstraints() {
        pdfView.frame = view.bounds
    }
}
