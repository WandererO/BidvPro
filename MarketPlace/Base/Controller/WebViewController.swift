//
//  WebViewController.swift
//  
//
//  Created by AMYZ0345 on 2021/11/17.
//

import UIKit
import WebKit
import SafariServices
import RxSwift

class WebViewController: BaseHiddenNaviController, WKScriptMessageHandler, WKUIDelegate {
    
    

    @objc lazy var wkWebView : WKWebView = {
        
        let config = WKWebViewConfiguration()
        
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "back")
        
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        config.userContentController.add(self, name: "back")
        
        let y = (ignoreTitle ?0 : 48) + STATUSBAR_HIGH
        let frame = CGRect(x: 0, y: y, width: self.view.width, height: self.view.height-y)
        let webView = WKWebView(frame: frame , configuration: config)
        
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return webView
    }()
    /* 忽略标题 */
    var ignoreTitle : Bool = true
    ///进度条
    lazy var progressView : UIProgressView = {
        let view = UIProgressView()
        view.frame = CGRect(x: 0, y: STATUSBAR_HIGH-1, width: SCREEN_WIDTH, height: 1)
        view.backgroundColor =  .hexColor("FCD283")
        return view
    }()
    ///返回按钮
    lazy var backButton : UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(backButtonClick))

        return btn
    }()
    
    var urlStr : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kMainBackgroundColor
        setUI()
        self.wkWebView.load(URLRequest(url: URL(string: urlStr) ?? URL(fileURLWithPath: "")))
    }
}
// MARK: - WKNavigationDelegate
extension WebViewController : WKNavigationDelegate{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.navigationItem.leftBarButtonItem = self.backButton
    }
    //（获取页面返回的cookie，然后设置更新）
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let token =  Archive.getToken()
        
        let postStr = "sendToken('\(token)')"
        
        webView.evaluateJavaScript(postStr) { result, error in
            
            if error != nil {
                
                print(result as Any)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        let url = webView.url?.absoluteString
        
            decisionHandler(.allow)
            return
    }
    
    func openApp(url:String , schemes : String){
        
        let openUrlStr = schemes + url
        let openUrl = URL(string: openUrlStr)
        if UIApplication.shared.canOpenURL(openUrl!) {
            UIApplication.shared.open(openUrl!)
        }else{
            let vc = SFSafariViewController(url: URL(string: url)!)
            present(vc, animated: true)
        }
        self.progressView.isHidden = true
    }
}

extension WebViewController{
    func setUI(){
        
        
        
        self.view.addSubview(self.wkWebView)
        self.wkWebView.navigationDelegate = self
        self.wkWebView.uiDelegate = self
        self.configartionRxKVO()
        self.view.addSubview(self.progressView)
    }
    @objc func backButtonClick(){
    }
}

// MARK: - rx
extension WebViewController {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "back" {///返回
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func configartionRxKVO() {
        
        self.wkWebView.rx.observe(\WKWebView.estimatedProgress).subscribe { [weak self] progress in
            
            if progress == 1 {
                self?.progressView.isHidden = true
                self?.progressView.setProgress(0, animated: false)
            }else{
                self?.progressView.isHidden = false
                self?.progressView.setProgress(Float(progress), animated: true)
            }
        } onError: { [weak self] error in
            self?.progressView.isHidden = true
        } onCompleted: { [weak self] in
            self?.progressView.isHidden = true
        }.disposed(by: disposeBag)
        
        self.wkWebView.rx.observe(\WKWebView.title).subscribe (onNext: { [weak self] webTitle in
            
            if let newTitle = webTitle {
                if self?.ignoreTitle ?? false {
                    return
                }
                if newTitle.count > 0 {
                    self?.title = newTitle
                }
            }
        }).disposed(by: disposeBag)
    
    }
}
