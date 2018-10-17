//
//  AppSettingController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class AppSettingController: BaseTableViewController {
    
    let datas = [["自动登录","摇一摇投注","下注声音"],["建议反馈","清理缓存","清除支付浏览器"],["版本检测","关于我们"],["退出登录"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if indexPath.row == 0{
                openFeedback(controller: self)
            }else if indexPath.row == 1{
                ////图片异步加载框架清理内存缓存
                KingfisherManager.shared.cache.clearMemoryCache()
                // 清理硬盘缓存，这是一个异步的操作
                KingfisherManager.shared.cache.clearDiskCache()
                // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
                KingfisherManager.shared.cache.cleanExpiredDiskCache()
                showToast(view: self.view, txt: "清理成功")
            }else if indexPath.row == 2{
                YiboPreference.setDefault_brower_type(value: -1 as AnyObject)
                showToast(view: self.view, txt: "清除支付浏览器成功")
                self.tableView.reloadData()
            }
        }else if indexPath.section == 2{
            if indexPath.row == 0{
                checkVersion(showDialog: true, showText: "正在检测新版本...")
            }else if indexPath.row == 1{
                print("about us")
                openAboutus(controller: self)
            }
        }else if indexPath.section == 3{
            print("click exit login")
            showConfirmExitDialog()
        }
    }
    
    
    
    func checkVersion(showDialog:Bool,showText:String){
        
        request(frontDialog: showDialog, method: .post, loadTextStr: showText, url:CHECK_UPDATE_URL,params:["curVersion":getVerionName(),"appID":getAPPID(),"platform":"ios"],
                           callback: {(resultJson:String,resultStatus:Bool)->Void in
                            if !resultStatus {
                                if resultJson.isEmpty {
                                    showToast(view: self.view, txt: convertString(string: "检测升级失败"))
                                }else{
                                    showToast(view: self.view, txt: resultJson)
                                }
                                return
                            }
                            if let result = CheckUpdateWraper.deserialize(from: resultJson){
                                if result.success{
                                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                                    if let content = result.content{
                                        if isEmptyString(str: content.url){
                                            return
                                        }
                                        self.showUpdateDialog(version: content.version, content: content.content, url: content.url)
                                    }
                                }else{
                                    if !isEmptyString(str: result.msg){
                                        showToast(view: self.view, txt: result.msg)
                                    }else{
                                        showToast(view: self.view, txt: convertString(string: "检测升级失败"))
                                    }
                                }
                            }
        })
    }
    
    func showUpdateDialog(version:String,content:String,url:String) ->Void{
        let alertController = UIAlertController(title: "发现新版本",
                                                message: content, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "去更新", style: .default, handler: {
            action in
            openBrower(urlString: url)
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        do{
            var msg = getAppName() + " " + version + "\n\n"
            if !isEmptyString(str: content){
                let split = content.components(separatedBy: ";")
                if !split.isEmpty{
                    for item in split{
                        msg = msg + item + "\n"
                    }
                }else{
                    msg = msg + content
                }
            }
            msg = msg + "\n"
            let attrStr = try NSAttributedString.init(data: msg.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
            alertController.setValue(attrStr, forKey: "attributedMessage")
        }catch{
            print(error)
        }
        self.present(alertController, animated: true, completion: nil)
    }

    
    func showConfirmExitDialog() -> Void {
        let message = "确定要退出吗？"
        let alertController = UIAlertController(title: "温馨提示",
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.postExitLogin()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func postExitLogin() -> Void {
        request(frontDialog: true, loadTextStr:"退出登录中...",url:LOGIN_OUT_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "退出失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LoginOutWrapper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if result.content{
                                self.navigationController?.popViewController(animated: true)
                                loginWhenSessionInvalid(controller: self)
                            }else{
                                showToast(view: self.view, txt: "退出登录失败")
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "退出失败,请重试"))
                            }
                        }
                    }
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "appSetting") as? AppSettingCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        cell.txt.text = datas[indexPath.section][indexPath.row]
        if indexPath.section == 0{
            cell.toggle.isHidden = false
            cell.moreImg.isHidden = true
            if indexPath.row == 0{
                cell.toggle.tag = 0
                cell.toggle.isOn = YiboPreference.getAutoLoginStatus()
            }else if indexPath.row == 1{
                cell.toggle.tag = 1
                cell.toggle.isOn = YiboPreference.getShakeTouzhuStatus()
            }else if indexPath.row == 2{
                cell.toggle.tag = 2
                cell.toggle.isOn = YiboPreference.isPlayTouzhuVolume()
            }
            cell.toggle.addTarget(cell, action: #selector(cell.onSwitchAction(view:)), for: UIControlEvents.valueChanged)
        }else{
            cell.toggle.isHidden = true
            cell.moreImg.isHidden = false
            if indexPath.row == 2{
                let type = YiboPreference.getDefault_brower_type()
                if type == -1{
                    cell.defaultName.text = ""
                }else{
                    if type == BROWER_TYPE_SAFARI{
                        cell.defaultName.text = "safari浏览器"
                    }else if type == BROWER_TYPE_UC{
                        cell.defaultName.text = "UI浏览器"
                    }else if type == BROWER_TYPE_QQ{
                        cell.defaultName.text = "QQ浏览器"
                    }else if type == BROWER_TYPE_GOOGLE{
                        cell.defaultName.text = "谷歌浏览器"
                    }else if type == BROWER_TYPE_FIREFOX{
                        cell.defaultName.text = "火狐浏览器"
                    }
                }
                
            }
        }
        if indexPath.section == 3{
            cell.exitlogin.isHidden = false
            cell.toggle.isHidden = true
            cell.moreImg.isHidden = true
            cell.txt.isHidden = true
        }
        return cell
    }

}
