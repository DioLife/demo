//
//  BaseMainController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/20.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import MBProgressHUD
import HandyJSON

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kScrollRect = CGRect(x: 0, y: 0, width: 600, height: kScreenHeight*0.3)
let kIphone4sScrollRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight*0.5)

class BaseMainController: BaseController {
    
    var titleOfOtherPages = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adjustRightBtn()
    }
    
    func adjustRightBtn() -> Void {
        if !YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let loginBtn = UIBarButtonItem.init(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseMainController.actionLogin))
            self.navigationItem.rightBarButtonItems = [loginBtn]
            if allowRegisterSwitch(){
                self.navigationItem.rightBarButtonItems?.removeAll()
                let regBtn = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action:#selector(actionReg))
                if let config = getSystemConfigFromJson(){
                    if config.content != nil{
                        let regpos = config.content.register_btn_pos_sort
                        if regpos == "front" || isEmptyString(str: regpos){
                            self.navigationItem.rightBarButtonItems = [loginBtn,regBtn]
                        }else if regpos == "back"{
                            self.navigationItem.rightBarButtonItems = [regBtn,loginBtn]
                        }
                    }
                }
            }
        }
    }
    
    
    func allowRegisterSwitch() -> Bool{
        let system = getSystemConfigFromJson()
        if let value = system{
            let datas = value.content
            if let appReg = datas?.onoff_register{
                return !isEmptyString(str:appReg) && appReg == "on"
            }else{
                return false
            }
        }
        return false
    }
    
    func actionQRCode() -> Void {
        print("click qrcode")
        let link = getSystemConfigFromJson()?.content.app_qr_code_link_ios
        let qrAlert = QRCodeView.init(link: link)
        qrAlert.show()
    }
    
    func actionMenu(){
        if let delegate = menuDelegate{
            delegate.menuEvent(isRight: true)
        }
    }
    
    func actionSetting() -> Void {
        let firstView = self.navigationController?.viewControllers.first
        openSetting(controller: firstView!)
    }
    
    func actionLoginReg() -> Void {
        let firstView = self.navigationController?.viewControllers.first
        loginWhenSessionInvalid(controller: firstView!)
    }
    
    func actionLogin() -> Void {
        let firstView = self.navigationController?.viewControllers.first
        openLoginPage(controller: firstView!)
    }
    
    func actionReg() -> Void {
        let firstView = self.navigationController?.viewControllers.first
        openRegisterPage(controller: firstView!)
    }
    
}
    

extension BaseMainController: WRCycleScrollViewDelegate{
    /// 点击图片事件
    func cycleScrollViewDidSelect(at index:Int, cycleScrollView:WRCycleScrollView){
        //        print("点击了第\(index+1)个图片")
    }
    /// 图片滚动事件
    func cycleScrollViewDidScroll(to index:Int, cycleScrollView:WRCycleScrollView){
        //        print("滚动到了第\(index+1)个图片")
    }
}

