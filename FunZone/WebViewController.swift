//
//  WebViewController.swift
//  FunZone
//
//  Created by admin on 6/1/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let webKitView = WKWebView()
            let newUrl = URL(string: "https://www.google.com")!
            webKitView.load(URLRequest(url: newUrl))
            view = webKitView
        }

    }
