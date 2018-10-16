//
//  ChatViewController.swift
//  gameplay
//
//  Created by William on 2018/8/28.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import WebKit

class ChatViewController: BaseController,WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "聊天室"
        
        getData()
    }
    
    func getData() {
        request(frontDialog: true, method: .post, loadTextStr: "正在加载...", url: CHATROOM_LINK) { (resultJson:String, resultStatus:Bool) in
            
            if !resultStatus {
                if resultJson.isEmpty {
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }else{
                    showToast(view: self.view, txt: resultJson)
                }
                return
            }
//            print(resultJson)
            if let result = ChatModel.deserialize(from: resultJson) {
                if result.success{
                    self.setUpWKwebView(str:result.content)
                }else{
                    if !isEmptyString(str: result.msg){
                        showToast(view: self.view, txt: result.msg)
                    }else{
                        showToast(view: self.view, txt: "获取失败")
                    }
                }
            }
        }
    }
    

    func setUpWKwebView(str:String) {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        let myURL = URL(string: str)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view.addSubview(webView)

        webView.navigationDelegate = self //WKNavigationDelegate
    }
    
    //WKNavigationDelegate 提供了可用来追踪加载过程的代理方法
    //页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        print("页面开始加载")
        showToast(view:webView, txt: "正在加载....")
    }
    //当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        print("内容开始返回")
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        print("页面加载完成")
        hideDialog()
    }
    //页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        print("页面加载失败")
        hideDialog()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
