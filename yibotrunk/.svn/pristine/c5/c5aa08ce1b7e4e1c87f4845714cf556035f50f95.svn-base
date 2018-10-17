//
//  LoginController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class LoginController: BaseController,UITextFieldDelegate,LoginAndRegisterDelegate {
    
    
    @IBOutlet weak var logoImageView:UIImageView!
    @IBOutlet weak var logoImageViewHeight:NSLayoutConstraint!
    @IBOutlet weak var inputAccount:CustomFeildText!
    @IBOutlet weak var inputPwd:CustomFeildText!
    @IBOutlet weak var savePwd:UISwitch!
    @IBOutlet weak var registerNow:UILabel!
    @IBOutlet weak var loginBtn:UIButton!
    @IBOutlet weak var freePlay:UILabel!
//    @IBOutlet weak var forgetPwd:UILabel!
    @IBOutlet weak var onlineService:UILabel!
    @IBOutlet weak var deleteAccount:UIButton!
    @IBOutlet weak var deletePwd:UIButton!
    
    var globalDelagate:GlobalDelegate!
    var openFromOtherPage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        
        inputAccount.addTarget(self, action: #selector(onAcountInput(view:)), for: UIControlEvents.editingChanged)
        inputPwd.addTarget(self, action: #selector(onAcountInput(view:)), for: UIControlEvents.editingChanged)
        
        deleteAccount.addTarget(self, action: #selector(onDeleteClick(btn:)),for: .touchUpInside)
        deletePwd.addTarget(self, action: #selector(onDeleteClick(btn:)),for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(onLoginClick(btn:)),for: .touchUpInside)
        self.savePwd.addTarget(self, action: #selector(rememberPwdAction(view:)), for: UIControlEvents.valueChanged)
        savePwd.addTarget(self, action: #selector(onSavePwdSwitch(ui:)), for: UIControlEvents.valueChanged)
        savePwd.isOn = YiboPreference.getPwdState()
        
        loginBtn.layer.cornerRadius = 20
        
        registerClickEvents()
        //将存储的用户名密码置入输入框
        inputAccount.text = YiboPreference.getUserName()
        inputPwd.text = YiboPreference.getPwd()
        if !isEmptyString(str: YiboPreference.getUserName()){
            deleteAccount.isHidden = false
        }
        if !isEmptyString(str: YiboPreference.getPwd()){
            deletePwd.isHidden = false
        }
        
        inputAccount.delegate = self
        inputPwd.delegate = self
        
//        //当键盘弹起的时候会向系统发出一个通知，
//        //这个时候需要注册一个监听器响应该通知
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//        //当键盘收起的时候会向系统发出一个通知，
//        //这个时候需要注册另外一个监听器响应该通知
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        let system = getSystemConfigFromJson()
        if let value = system{
            let datas = value.content
            if !isEmptyString(str: (datas?.onoff_mobile_guest_register)!) && datas?.onoff_mobile_guest_register == "on"{
                freePlay.isHidden = false
            }else{
                freePlay.isHidden = true
            }
            if !isEmptyString(str: (datas?.online_customer_showphone)!) && datas?.online_customer_showphone == "on"{
                onlineService.isHidden = false
            }else{
                onlineService.isHidden = true
            }
//            print("datas?.onoff_mobile_app_reg ==== \(datas?.onoff_mobile_app_reg)")
            if let appReg = datas?.onoff_register{
                if !isEmptyString(str:appReg) && appReg == "on"{
                    registerNow.isHidden = false
                }else{
                    registerNow.isHidden = true
                }
            }else{
                registerNow.isHidden = true
            }
            
            //update web logo image
            updateWebLogo()
            
        }
        
    }
    
    func updateWebLogo() -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        var logoImg = sys.content.logo_for_login
        if !isEmptyString(str: logoImg){
            self.logoImageViewHeight.constant = 100
            self.logoImageView.isHidden = false
            if logoImg.contains("\t"){
                let strs = logoImg.components(separatedBy: "\t")
                if strs.count >= 2{
                    logoImg = strs[1]
                }
            }
            logoImg = logoImg.trimmingCharacters(in: .whitespaces)
            if let url = URL.init(string: logoImg){
                downloadImage(url: url, imageUI: self.logoImageView)
            }
        }else{
            self.logoImageViewHeight.constant = 0
            self.logoImageView.isHidden = true
        }
    }
    
    func onSavePwdSwitch(ui:UISwitch) -> Void {
        YiboPreference.savePwdState(value: ui.isOn as AnyObject)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func registerClickEvents() -> Void {
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
//        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        registerNow.addGestureRecognizer(tap1)
        freePlay.addGestureRecognizer(tap2)
//        forgetPwd.addGestureRecognizer(tap3)
        onlineService.addGestureRecognizer(tap4)
    }
    
    func fromRegToLogin() {
        if openFromOtherPage{
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func tapEvent(recongnizer: UIPanGestureRecognizer) {
        let label = recongnizer.view as! UILabel
        switch label.tag {
        case 10:
            print("acton register now-----")
            let loginVC = UIStoryboard(name: "register_page", bundle: nil).instantiateViewController(withIdentifier: "registerController")
            let recordPage = loginVC as! RegisterController
            recordPage.loginAndRegDelegate = self
            self.navigationController?.pushViewController(recordPage, animated: true)
        case 11:
            print("acton free play -----")
            freeRegister(controller: self, showDialog: true, showText: "试玩注册中...", delegate: nil)
        case 12:
            print("acton forget pwd now-----")
            
        case 13:
            openContactUs(controller: self)
        default:
            break
        }
    }
    
    
    
    func rememberPwdAction(view:UISwitch) -> Void{
        YiboPreference.savePwdState(value: view.isOn as AnyObject)
    }
    
    func onDeleteClick(btn:UIButton) -> Void {
        if btn.tag == 0{
            inputAccount.text = ""
            deleteAccount.isHidden = true
        }else{
            inputPwd.text = ""
            deletePwd.isHidden = true
        }
    }
    
    func onLoginClick(btn:UIButton) -> Void {
        let name = inputAccount.text
        let pwd = inputPwd.text
        
        if isEmptyString(str: name!){
            showToast(view: self.view, txt: "请输入用户名")
            return
        }
        if isEmptyString(str: pwd!){
            showToast(view: self.view, txt: "请输入密码")
            return
        }
        request(frontDialog: true, method: .post, loadTextStr: "正在登录中...", url:LOGIN_URL,params:["username":name!,"password":pwd!],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "登录失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = LoginResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.saveLoginStatus(value: true as AnyObject)
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            //记住密码
                            if (YiboPreference.getPwdState()) {
                                YiboPreference.savePwd(value: self.inputPwd.text as AnyObject)
                            }else{
                                YiboPreference.savePwd(value: "" as AnyObject)
                            }
                            if let content = result.content{
                                let accountType = content.accountType
                                YiboPreference.setAccountMode(value:accountType as AnyObject)
                                //自动登录的情况下，要记住帐号
//                                if YiboPreference.isAutoLogin(){
                                    if !isEmptyString(str: content.account){
                                        YiboPreference.saveUserName(value:content.account as AnyObject)
                                    }else{
                                        YiboPreference.saveUserName(value:self.inputPwd.text! as AnyObject)
                                    }
//                                }
                            }
//                            if self.navigationController != nil{
//                                self.navigationController?.popViewController(animated: true)
//                            }else{
//                                self.dismiss(animated: true, completion: nil)
//                            }
                            self.onBackClick()
                            if self.globalDelagate != nil{
                                self.globalDelagate.onLoginFinish(isLogin: true)
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "登录失败"))
                            }
                        }
                    }
        })
        
    }

    func onAcountInput(view:UITextField) -> Void {
        let txt = view.text
        if let txtValue = txt{
            if isEmptyString(str: txtValue){
                if view.tag == 0{
                    deleteAccount.isHidden = true
                }else{
                    deletePwd.isHidden = true
                }
            }else{
                if view.tag == 0{
                    deleteAccount.isHidden = false
                }else{
                    deletePwd.isHidden = false
                }
            }
        }
    }

}
