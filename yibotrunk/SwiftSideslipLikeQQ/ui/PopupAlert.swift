//
//  PopupAlert.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

protocol UrlJumpDelegate {
    func urlJump(url:String)
}

class PopupAlert: UIView ,UIWebViewDelegate,WKNavigationDelegate {

    var titleUI:UILabel!
    var contenUI:UIWebView!
//    var contenUI:WKWebView!
    var cancelBtn:UIButton!
    var sureBtn:UIButton!
    
    
    var alert:UIView!
    typealias clickAlertClosure = (_ index: Int) -> Void //声明闭包，点击按钮传值
    
    var urlDelegate:UrlJumpDelegate?
    
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    //为闭包设置调用函数
    func clickIndexClosure(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    let Bgtap = UITapGestureRecognizer()
    
    init(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        createAlertView()
        self.titleUI.text = title
        self.titleUI.textColor = UIColor.black
        if let msg = message{
//            print(msg)
            let myAppend = "<style>"
            let myAppend2 = "img{width: 100%;height: 100%;}"
            let myAppend3 = "body{margin:0px 0px 0px 0px;padding:0px 0px 0px 0px;}"
            let myAppendend = "</style>"
            let msgNew = msg + myAppend + myAppend2 + myAppend3 + myAppendend
//            print(msgNew)
            contenUI.loadHTMLString(msgNew, baseURL: URL.init(string: BASE_URL))
        }
        self.sureBtn.setTitle(sureButtonTitle, for: UIControlState())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAlertView() {
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        Bgtap.addTarget(self, action: #selector(dismiss))
        self.addGestureRecognizer(Bgtap)
        
        alert = UIView.init(frame: CGRect.init(x: kScreenWidth/8, y: kScreenHeight/4,
                                                   width: kScreenWidth*0.75, height: kScreenHeight/4+100))
        alert.backgroundColor = UIColor.white
        alert.layer.cornerRadius = 10
        self.addSubview(alert)
        
        titleUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: alert.bounds.width, height: 50))
        titleUI.backgroundColor = UIColor.lightGray
        titleUI.textColor = UIColor.white
        titleUI.clipsToBounds = true
        titleUI.textAlignment = NSTextAlignment.center
        let tpath = UIBezierPath(roundedRect: titleUI.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let tlayer = CAShapeLayer()
        tlayer.frame = titleUI.bounds
        tlayer.path = tpath.cgPath
        titleUI.layer.mask = tlayer
        alert.addSubview(titleUI)
        
        contenUI = UIWebView.init()
        contenUI.delegate = self;
//        let webConfiguration = WKWebViewConfiguration()
//        contenUI = WKWebView.init(frame: CGRect.init(x: alert.bounds.origin.x, y: alert.bounds.origin.y+50,width: kScreenWidth/2, height: CGFloat(kScreenHeight/2)), configuration: webConfiguration)
//        contenUI.navigationDelegate = self
//        contenUI = UIWebView.init(frame: CGRect.init(x: alert.bounds.origin.x, y: alert.bounds.origin.y+50,width: kScreenWidth/2, height: CGFloat(kScreenHeight/2)))
        //内容
//        contenUI.scalesPageToFit = true
        contenUI.sizeThatFits(contenUI.frame.size)
//        contenUI.numberOfLines = 0
//        contenUI.textColor = UIColor.black
//        contenUI.textAlignment = NSTextAlignment.natural
//        contenUI.font = UIFont.systemFont(ofSize: 17)
        contenUI.backgroundColor = alert.backgroundColor
        alert.addSubview(contenUI)
        contenUI.snp.makeConstraints { (make) in
            make.top.equalTo(alert).offset(50)
            make.left.equalTo(alert).offset(0)
            make.right.equalTo(alert).offset(0)
            make.bottom.equalTo(alert).offset(-50)
        }
        
        //确认按钮
        sureBtn = UIButton.init(frame: CGRect(x: 0 , y: kScreenHeight/4+50,
                                              width: kScreenWidth*0.75, height: 50))
        sureBtn.backgroundColor = UIColor.red
        sureBtn.setTitleColor(UIColor.white, for: UIControlState())
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        sureBtn.clipsToBounds = true
        sureBtn.tag = 2
        let spath = UIBezierPath(roundedRect: sureBtn.bounds, byRoundingCorners: [UIRectCorner.bottomRight, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        let slayer = CAShapeLayer()
        slayer.frame = titleUI.bounds
        slayer.path = spath.cgPath
        sureBtn.layer.mask = slayer
        sureBtn.addTarget(self, action: #selector(clickBtnAction(ui:)), for: .touchUpInside)
        alert.addSubview(sureBtn)
    }
    
    func clickBtnAction(ui:UIButton) -> Void {
        if (clickClosure != nil) {
            clickClosure!(ui.tag)
        }
        dismiss()
    }
    
    //MARK:消失
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    func calcWebviewHeight(webview:UIWebView){
//        var htmlHeight:Float = Float(webview.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")!)!
//        let htmlWidth:Float = Float(webview.stringByEvaluatingJavaScript(from: "document.body.scrollWidth")!)!
////        contenUI.frame = CGRect.init(x: alert.bounds.origin.x, y: alert.bounds.origin.y+50,
////                                     width: kScreenWidth/2, height: CGFloat(htmlHeight))
////        webview.backgroundColor = UIColor.red
//
//        let rate:CGFloat = CGFloat(htmlWidth/htmlHeight)
//        htmlHeight = Float((kScreenWidth*0.75)/rate)
//        print("real webview height = ",htmlHeight)
//        alert.frame = CGRect.init(x: kScreenWidth/8, y: kScreenHeight/4,
//                                  width: kScreenWidth*0.75, height: CGFloat(htmlHeight-200))
//        let yyy = alert.bounds.origin.y + 50 + CGFloat(htmlHeight)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let url = webView.request?.url?.absoluteString{
            print("url ===== ",url)
            if !isEmptyString(str: url) && url != (BASE_URL+"/"){
                print("jump urlllllll =",url)
                if let delegate = urlDelegate{
                    dismiss()
                    delegate.urlJump(url: url)
                }
            }
//            calcWebviewHeight(webview: webView)
        }
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
//        print("页面加载完成")
        if let url = webView.url?.absoluteString {
            print("url ===== ",url)
            if !isEmptyString(str: url) && url != (BASE_URL+"/"){
                print("jump urlllllll =",url)
                if let delegate = urlDelegate{
                    dismiss()
                    delegate.urlJump(url: url)
                }
            }
            //            calcWebviewHeight(webview: webView)
        }
    }
}
