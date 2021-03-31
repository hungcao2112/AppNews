//
//  DetailViewController.swift
//  AppNews
//
//  Created by Hung Cao on 31/03/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        guard let article = article,
              let sourceURL = URL(string: article.sourceUrl ?? "") else {
            return
        }
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.load(URLRequest(url: sourceURL))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.progress = Float(webView.estimatedProgress)
            progressView.isHidden = progressView.progress >= 1.0
        }
    }
}
