//
//  VideosViewController.swift
//  FilGoalIOS
//
//  Created by Abdelrahman Elabd on 11/28/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import UIKit
import WebKit

@objc class VideoViewController : ParentViewController,WKUIDelegate{
    
    
    var webView: WKWebView!
    @objc var urlString : String!
    @objc var embed : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebView()
    }
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
        if  embed != ""{
        webView.loadHTMLString(embed, baseURL: nil)
        }
            /*
        if let url = URL(string: htmlString) {
           // let urlRequest = URLRequest(url: url)
            webView.loadHTMLString(htmlString, baseURL: URL(string: "https://seapi.filgoal.com/"))
        }*/
    }

}
