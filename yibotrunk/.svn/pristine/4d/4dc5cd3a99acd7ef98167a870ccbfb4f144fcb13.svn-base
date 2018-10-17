//
//  BaseTableViewController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class BaseTableViewController: UITableViewController {

    var loadingDialog:MBProgressHUD?
    func showDialog(view:UIView,loadText:String) -> Void {
        loadingDialog = showLoadingDialog(view: view, loadingTxt: loadText)
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

}
