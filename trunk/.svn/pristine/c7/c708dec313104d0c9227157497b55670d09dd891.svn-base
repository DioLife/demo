//
//  AppSettingController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class AppSettingController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var isSelect = false
    
    let datas = [["自动登录","摇一摇投注","下注声音","公告提示"],["切换主题"],["建议反馈","清理缓存","清除支付浏览器"],["版本检测","关于我们"],["退出登录"]]

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        self.navigationItem.title = "设置"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
//        setupthemeBgView(view: self.view)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            switchTheme()
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0{
                openFeedback(controller: self)
            }else if indexPath.row == 1{
                ////图片异步加载框架清理内存缓存
                KingfisherManager.shared.cache.clearMemoryCache()
                // 清理硬盘缓存，这是一个异步的操作
                KingfisherManager.shared.cache.clearDiskCache()
                // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
                KingfisherManager.shared.cache.cleanExpiredDiskCache()
                URLCache.shared.removeAllCachedResponses()
                showToast(view: self.view, txt: "清理成功")
            }else if indexPath.row == 2 {
                YiboPreference.setDefault_brower_type(value: "-1")
                tableView.reloadRows(at: [IndexPath.init(row: 2, section: 2)], with: .fade)
                showToast(view: self.view, txt: "清除默认支付浏览器成功")
            }
            
        }else if indexPath.section == 3{
            if indexPath.row == 0{
                checkVersion(showDialog: true, showText: "正在检测新版本...")
            }else if indexPath.row == 1{
                print("about us")
                openAboutus(controller: self)
            }
        }else if indexPath.section == 4{
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
            let attrStr = try NSAttributedString.init(data: msg.description.data(using: String.Encoding.unicode)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
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
                            YiboPreference.saveLoginStatus(value: false as AnyObject)
                            //试玩站号推出时清除账号
                            if YiboPreference.getAccountMode() == GUEST_TYPE{
                                YiboPreference.saveUserName(value: "" as AnyObject)
                                YiboPreference.savePwd(value: "" as AnyObject)
                                YiboPreference.setAccountMode(value: 0 as AnyObject)
                            }
                            loginWhenSessionInvalid(controller: self)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "signOutToFirstTabNoti"), object: nil)
                            self.navigationController?.popViewController(animated: false)
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowBrowsersChooseView() {
            return datas[section].count
        }else {
            if section == 2 {
                return datas[section].count - 1
            }else {
                return datas[section].count
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            }else if indexPath.row == 3{
                cell.toggle.tag = 3
                cell.toggle.isOn = YiboPreference.isShouldAlert_isAll() == "on"
            }
            cell.toggle.addTarget(cell, action: #selector(cell.onSwitchAction(view:)), for: UIControlEvents.valueChanged)
        }else{
            cell.toggle.isHidden = true
            cell.moreImg.isHidden = false
        }
        
        if indexPath.section == 4{
            cell.exitlogin.isHidden = false
            cell.toggle.isHidden = true
            cell.moreImg.isHidden = true
            cell.txt.isHidden = true
        }else if indexPath.section == 2 && indexPath.row == 2{
            let tipsLable = UILabel()
            cell.contentView.addSubview(tipsLable)
            tipsLable.text = getDefaultName()
            tipsLable.textColor = UIColor.darkGray
            tipsLable.font = UIFont.systemFont(ofSize: 14.0)
            tipsLable.whc_Right(40).whc_CenterY(0)
        }
        
        return cell
    }
    
    private func getDefaultName() -> String {
        let nameType = YiboPreference.getDefault_brower_type()
        var name = ""
        if nameType == -1{
            return name
        }
        if nameType == BROWER_TYPE_SAFARI {
            name = "Safari浏览器"
        }else if nameType == BROWER_TYPE_QQ{
            name = "QQ浏览器"
        }else if nameType == BROWER_TYPE_GOOGLE{
            name = "谷歌浏览器"
        }else if nameType == BROWER_TYPE_UC{
            name = "UC浏览器"
        }else if nameType == BROWER_TYPE_FIREFOX{
            name = "火狐浏览器"
        }
        return name
    }
    
    private func switchTheme() {
        
        if (isSelect == false) {
            isSelect = true
            onItemClick(dataSource: themes,viewTitle: "主题风格切换")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
        
    }
    
    
    private func onItemClick(dataSource: [String], viewTitle: String){
        
        let currentThmeIndex = YiboPreference.getCurrentThme()
        
        let selectedView = LennySelectView(dataSource: dataSource, viewTitle: viewTitle)
        selectedView.selectedIndex = currentThmeIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            
            let themeStr: String
            switch index {
            case 0:
                themeStr = "Red"
            case 1:
                themeStr = "Blue"
            case 2:
                themeStr = "Green"
            case 3:
                themeStr = "FrostedOrange"
            case 4:
                themeStr = "FrostedBlue"
            case 5:
                themeStr = "FrostedPurple"
            case 6:
                themeStr = "FrostedBeautyOne"
            default:
                themeStr = "Red"
            }
            
            ThemeManager.setTheme(plistName: themeStr, path: .mainBundle)
            YiboPreference.setCurrentThemeByName(value: themeStr as AnyObject)
            YiboPreference.setCurrentTheme(value: index as AnyObject)
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in

        }
    }

}
