//
//  WebViewController.swift
//  webView_swift
//
//  Created by jiweon.lee on 2022/10/17.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate  {
    
    var webView: WKWebView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadWebView()
        
        webView = initJavascriptBridge();
        self.webView!.uiDelegate = self

    }
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        view = webView
//    }

    
//    func loadWebView() {
//        if let url = URL(string: "https://m.naver.com/") {
//            let request = URLRequest(url: url)
//            print("=================================")
//            webView.load(request)
//            print("=================================")
//        }
//    }
    
    func initJavascriptBridge() -> WKWebView{
            let contentController = WKUserContentController();
            // 웹에서 불러쓸수 있는 native함수를 정의한다.
            let config = WKWebViewConfiguration();
            config.userContentController = contentController;
            let webView:WKWebView = WKWebView(frame:self.view.frame, configuration:config);
            let url = NSURL(string: "https://m.naver.com/");
            let request = NSURLRequest(url:url! as URL);
            
            webView.load(request as URLRequest);
            self.view.addSubview(webView);
            
            return webView;
     }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("=========didCommit")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("=========didStart")
    }
}


/*
 class ViewController: UIViewController, WKUIDelegate {
     
     var webView: WKWebView!
     
     override func loadView() {
         let webConfiguration = WKWebViewConfiguration()
         webView = WKWebView(frame: .zero, configuration: webConfiguration)
         webView.uiDelegate = self
         view = webView
     }
     override func viewDidLoad() {
         super.viewDidLoad()
         
         let myURL = URL(string:"https://www.apple.com")
         let myRequest = URLRequest(url: myURL!)
         webView.load(myRequest)
     }}
 */

/*
 class ViewController: UIViewController, WKUIDelegate,WKNavigationDelegate {

     @IBOutlet weak var webView: WKWebView!
     
     override func loadView() {
         super.loadView()
         
         webView = WKWebView(frame: self.view.frame)
         webView.uiDelegate = self
         webView.navigationDelegate = self
         
         self.view = self.webView
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         let url = URL(string: "http://work6.kr")
         let request = URLRequest(url: url!)
         webView.load(request)
         
         
         // Do any additional setup after loading the view, typically from a nib.
     }
 */
