//
//  WebViewController.swift
//  noteapp
//
//  Created by student24 on 2018. 6. 14..
//  Copyright © 2018년 student24. All rights reserved.
//
import UIKit
import WebKit




class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView  = WKWebView()
        let myBlog = "https://www.apple.com"
        let url = URL(string: myBlog)
        let Request = URLRequest(url: url!)
        webView.load(Request)
    }
}
