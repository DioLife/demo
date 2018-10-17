//
//  BaseController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/3.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class BaseController: UIViewController{
    
    var loadingDialog:MBProgressHUD?
    var keyBoardNeedLayout: Bool = true
    var popHeight:Int = 0
    var menuDelegate:MenuDelegate?
    
    func showDialog(view:UIView,loadText:String) -> Void {
//        if loadingDialog == nil {
            loadingDialog = showLoadingDialog(view: view, loadingTxt: loadText)
//        }
    }
    
    func hideDialog() -> Void {
        if loadingDialog != nil {
            hideLoadingDialog(hud: loadingDialog!)
        }
    }
    
    func onBackClick(){
        if self.navigationController != nil{
            let count = self.navigationController?.viewControllers.count
            if count! > 1{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func request(frontDialog:Bool,method:HTTPMethod = .get, loadTextStr:String="正在加载中...",url:String,params:Parameters=[:],
                 callback:@escaping (_ resultJson:String,_ returnStatus:Bool)->()) -> Void {
        
        if !NetwordUtil.isNetworkValid(){
            showToast(view: self.view, txt: "网络连接不可用，请检测")
            return
        }
        
        let beforeClosure:beforeRequestClosure = {(showDialog:Bool,showText:String)->Void in
            if frontDialog {
                self.showDialog(view: self.view, loadText: loadTextStr)
            }
        }
        let afterClosure:afterRequestClosure = {(returnStatus:Bool,resultJson:String)->Void in
            self.hideDialog()
            callback(resultJson, returnStatus)
        }
        let baseUrl = BASE_URL + PORT
        requestData(curl: baseUrl + url, cm: method, parameters:params,before: beforeClosure, after: afterClosure)
    }
    
    //键盘弹起响应
    func keyboardWillShow(notification: NSNotification) {
        print("show")
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            var deltaY = intersection.height-21-44
            if popHeight == 0{
                deltaY = intersection.height-21-44
            }else{
                deltaY = CGFloat(popHeight)
            }
            if keyBoardNeedLayout {
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: { _ in
                                self.view.frame = CGRect.init(x:0,y:-deltaY,width:self.view.bounds.width,height:self.view.bounds.height)
                                self.keyBoardNeedLayout = false
                                self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    //键盘隐藏响应
    func keyboardWillHide(notification: NSNotification) {
        print("hide")
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            var deltaY = intersection.height+21+44
            if popHeight == 0{
                deltaY = intersection.height+21+44
            }else{
                deltaY = 21+44
            }
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: { _ in
                            self.view.frame = CGRect.init(x:0,y:deltaY,width:self.view.bounds.width,height:self.view.bounds.height)
                            self.keyBoardNeedLayout = true
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}
