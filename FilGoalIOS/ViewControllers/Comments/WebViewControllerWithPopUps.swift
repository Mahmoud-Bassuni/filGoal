import UIKit
import WebKit

@objc class WebViewControllerWithPopUps: UIViewController {

    var webView: WKWebView!
    var popupWebView: WKWebView?
    @objc var urlPath: String = ""
    var containerHieght : NSLayoutConstraint? = NSLayoutConstraint()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebView()
    }
    
    //MARK: Setting up webView
    func setupWebView() {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self

        view.addSubview(webView)
    }

    func loadWebView() {
        if let url = URL(string: urlPath) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        self.webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
//            if complete != nil {
//                self.webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
//                    self.containerHeight.constant = height as! CGFloat
//                })
//            }
//
//            })
//    }
}

extension WebViewControllerWithPopUps: WKUIDelegate, WKNavigationDelegate {
    
    //MARK: Creating new webView for popup
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        popupWebView = WKWebView(frame: view.bounds, configuration: configuration)
        popupWebView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        popupWebView!.navigationDelegate = self
        popupWebView!.uiDelegate = self
        view.addSubview(popupWebView!)
        return popupWebView!
    }

    //MARK: To close popup
    func webViewDidClose(_ webView: WKWebView) {
        if webView == popupWebView {
            popupWebView?.removeFromSuperview()
            popupWebView = nil
        }
    }
}
