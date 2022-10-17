//
//  ViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/14.
//

import UIKit

class MainViewController: UIViewController {
    
    var webViewButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("webView", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupConstraints()
        setupAttributes()
    }
    
    func setupLayout() {
        view.addSubview(webViewButton)
    }
    
    func setupConstraints() {
        webViewButton.translatesAutoresizingMaskIntoConstraints = false
        webViewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        webViewButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        webViewButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        webViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAttributes() {
        self.view.backgroundColor = .white
    }
}


/*
 class ViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate {
 var webView: WKWebView?;
 var host = "모바일웹주소(http://m.naver.com/)";

 override func viewDidLoad() {
         super.viewDidLoad()
         // 화면이 load되면 webview를 initialize한다.
         webView = initJavascriptBridge();
         self.webView!.uiDelegate = self
  }

 func initJavascriptBridge()->WKWebView{
         let contentController = WKUserContentController();
         // 웹에서 불러쓸수 있는 native함수를 정의한다.
         contentController.add(
             self,
             name: "ios"
         );
         
         let config = WKWebViewConfiguration();
         config.userContentController = contentController;
         let webView:WKWebView = WKWebView(frame:self.view.frame, configuration:config);
         let url = NSURL(string:host);
         let request = NSURLRequest(url:url! as URL);
         
         webView.load(request as URLRequest);
         self.view.addSubview(webView);
         
         return webView;
  }

 // 웹뷰에서 alert나 confirm을 사용할 수 있게 해 주는 impleament
 func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
         print("alert called");
         
         let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
         
         alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
             completionHandler()
         }))
         
         self.present(alertController, animated: true, completion: nil)
 }
 */
