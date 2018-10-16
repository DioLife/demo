//
//  LoginController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class LoginController: BaseController,UITextFieldDelegate,LoginAndRegisterDelegate {
    
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backBtnTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var inputAccount:CustomFeildText!
    @IBOutlet weak var inputPwd:CustomFeildText!
    @IBOutlet weak var savePwd:UISwitch!
    @IBOutlet weak var registerNow:UILabel!
    @IBOutlet weak var loginBtn:UIButton!
    @IBOutlet weak var freePlay:UILabel!
    @IBOutlet weak var logoUI:UIImageView!
    @IBOutlet weak var pcButton:UIButton!
    
    
    //    @IBOutlet weak var forgetPwd:UILabel!
    @IBOutlet weak var onlineService:UILabel!
    @IBOutlet weak var deleteAccount:UIButton!
    @IBOutlet weak var deletePwd:UIButton!
    var openFromOtherPage = false
    var canBack = true;//是否显示返回按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view)
        
        self.navigationItem.title = "登录"
        setupUI()
        inputAccount.addTarget(self, action: #selector(onAcountInput(view:)), for: UIControlEvents.editingChanged)
        inputPwd.addTarget(self, action: #selector(onAcountInput(view:)), for: UIControlEvents.editingChanged)
        setupNoPictureAlphaBgView(view: inputAccount)
        setupNoPictureAlphaBgView(view: inputPwd)
        
        deleteAccount.addTarget(self, action: #selector(onDeleteClick(btn:)),for: .touchUpInside)
        deletePwd.addTarget(self, action: #selector(onDeleteClick(btn:)),for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(onLoginClick(btn:)),for: .touchUpInside)
        self.savePwd.addTarget(self, action: #selector(rememberPwdAction(view:)), for: UIControlEvents.valueChanged)
        savePwd.addTarget(self, action: #selector(onSavePwdSwitch(ui:)), for: UIControlEvents.valueChanged)
        savePwd.isOn = YiboPreference.getPwdState()
        
        loginBtn.layer.cornerRadius = 3.0
        
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
        pcButton.addTarget(self, action: #selector(goPCButton), for: .touchUpInside)
        
        let str = NSMutableAttributedString.init(string: "没有账号?现在注册")
        str.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: str.length))
        registerNow.attributedText = str
        
        //在线客服
        let str1 = NSMutableAttributedString.init(string: "在线客服")
        str1.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: str1.length))
        onlineService.attributedText = str1
        //免费试玩
        let str2 = NSMutableAttributedString.init(string: "免费试玩")
        str2.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: str2.length))
        freePlay.attributedText = str2
//        if canBack{
//            backButton.isHidden = false
//        }else{
//            backButton.isHidden = true
//        }
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
                onlineService.isHidden = false
            }
            //            print("datas?.onoff_mobile_app_reg ==== \(datas?.onoff_mobile_app_reg)")
            if let appReg = datas?.onoff_register{
                if !isEmptyString(str:appReg) && appReg == "on"{
                    registerNow.isHidden = false
                }else{
                    registerNow.isHidden = true
                }
            }else{
                registerNow.isHidden = false
            }
        }
        
        updateAppLogo(logo: self.logoUI)
    }
    
    @objc func goPCButton(){
        let url = String.init(format: "%@/?toPC=1", BASE_URL)
        openBrower(urlString: url)
    }
    
    func updateAppLogo(logo:UIImageView) -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        
        var newLogoImg = sys.content.login_page_logo_url
        
        if !isEmptyString(str: newLogoImg) {
            
            newLogoImg = handleImageURL(logoImgP: newLogoImg)
            
            let imageURL = URL(string: newLogoImg)
            logo.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
        }else {
            var logoImg = sys.content.lottery_page_logo_url
            if !isEmptyString(str: logoImg){
                logoImg = handleImageURL(logoImgP: logoImg)
                
                let imageURL = URL(string: logoImg)
                logo.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }else{
                logo.image = nil
            }

        }
    }
    
    //MARK: 地址可能是相对地址的处理
    private func handleImageURL(logoImgP: String) -> String{
        var logoImg = logoImgP
        if logoImg.contains("\t"){
            let strs = logoImg.components(separatedBy: "\t")
            if strs.count >= 2{
                logoImg = strs[1]
            }
        }
        logoImg = logoImg.trimmingCharacters(in: .whitespaces)
        if !logoImg.hasPrefix("https://") && !logoImg.hasPrefix("http://"){
            logoImg = String.init(format: "%@/%@", BASE_URL,logoImg)
        }
        
        return logoImg
    }
    
    @objc func onSavePwdSwitch(ui:UISwitch) -> Void {
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
            onBackClick()
//            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @objc func tapEvent(recongnizer: UIPanGestureRecognizer) {
        let label = recongnizer.view as! UILabel
        switch label.tag {
        case 10:
            print("acton register now-----")
            let loginVC = UIStoryboard(name: "register_page", bundle: nil).instantiateViewController(withIdentifier: "registerController")
            let recordPage = loginVC as! RegisterController
            recordPage.loginAndRegDelegate = self
//            self.navigationController?.pushViewController(recordPage, animated: true)
            self.present(recordPage, animated: true) {
                
            }
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
    
    
    
    @objc func rememberPwdAction(view:UISwitch) -> Void{
        YiboPreference.savePwdState(value: view.isOn as AnyObject)
    }
    
    @objc func onDeleteClick(btn:UIButton) -> Void {
        if btn.tag == 0{
            inputAccount.text = ""
            deleteAccount.isHidden = true
        }else{
            inputPwd.text = ""
            deletePwd.isHidden = true
        }
    }
    
    @objc func onLoginClick(btn:UIButton) -> Void {
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
                                if !isEmptyString(str: content.account){
                                    YiboPreference.saveUserName(value:content.account as AnyObject)
                                }else{
                                    YiboPreference.saveUserName(value:self.inputPwd.text! as AnyObject)
                                }
                                self.onBackClick()
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
    
    @objc func onAcountInput(view:UITextField) -> Void {
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
    
    @IBAction func rememberAction(_ sender: UIButton) {
        rememberBtn.isSelected = !sender.isSelected
        YiboPreference.savePwdState(value: rememberBtn.isSelected as AnyObject)
    }
    
    private func setupUI() {
        
        if glt_iphoneX {
            backBtnTopConstraint.constant = 54
        }else {
            backBtnTopConstraint.constant = 30
        }
//        YiboPreference.savePwdState(value: rememberBtn.isSelected as AnyObject)
        let shouldSave = YiboPreference.getPwdState()
        rememberBtn.isSelected = shouldSave
        
        rememberBtn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        rememberBtn.theme_setImage("Global.Login_Register.rememberCheckboxNormal", forState: .normal)
        rememberBtn.theme_setImage("Global.Login_Register.rememberCheckboxSelected", forState: .selected)
        
        backgroundImg.isHidden = false
        backgroundImg.theme_image = "Global.Login_Register.background"
        setTextFiledLeftView(img:"Global.Login_Register.fieldAccountImg", textField: inputAccount)
        setTextFiledLeftView(img: "Global.Login_Register.fieldPwdImg", textField: inputPwd)
        inputAccount.background = UIImage(named: "")
        inputPwd.background = UIImage(named: "")
    }
    
    private func setTextFiledLeftView(img: String,textField: UITextField) {
        let imgView = UIImageView.init(frame:  CGRect(x: 10, y: 10, width: textField.height - 10 * 2, height: textField.height - 10 * 2))
        imgView.theme_image = ThemeImagePicker(keyPath: img)
        textField.leftView = imgView
        textField.leftViewMode = UITextFieldViewMode.always
    }
    
    
    @IBAction func backAction() {
        self.dismiss(animated: true) {
            
        }
    }
    
}
