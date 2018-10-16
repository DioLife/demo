//
//  ActiveDetailController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/2.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//优惠活动详情
class ActiveDetailController: BaseController,UIWebViewDelegate {

    var htmlContent = ""
    var titleStr = "优惠活动详情"
    @IBOutlet weak var webView:UIWebView!
    var foreignUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        
        webView.scalesPageToFit = true
        if isEmptyString(str: foreignUrl){
            webView.loadHTMLString(htmlContent, baseURL: URL.init(string: BASE_URL))
        }else{
            webView.loadRequest(URLRequest.init(url: URL.init(string: foreignUrl)!))
        }
//        self.navigationItem.title = titleStr
//        self.title = titleStr
    }
}

extension ActiveDetailController{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        showDialog(view: self.view, loadText: "正在载入...")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideDialog()
    }
    
}
