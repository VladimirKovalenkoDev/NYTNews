//
//  DetailController.swift
//  NYTNews
//
//  Created by Владимир Коваленко on 27.02.2021.
//

import UIKit
import WebKit
class DetailController: UIViewController {
    var url = ""
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView.uiDelegate = self
        loadWeb()
        setUpWeb()
    }
    private func setUpWeb(){
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
                NSLayoutConstraint.activate([
                    webView.topAnchor
                        .constraint(equalTo: self.view.topAnchor, constant: 88),
                    webView.leftAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                    webView.bottomAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                    webView.rightAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
                ])
    }
    private func loadWeb(){
        if let myURL = URL(string: url){
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
    }
}
extension DetailController: WKUIDelegate {}
