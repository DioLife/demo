//
//  MenuHeader.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/25.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

//侧边个人中心头部区
class MemberPageHeader: UIView {
    
//    var punchButton: UIButton = UIButton()
    var app_icon:UIImageView!
    var bgImg:UIImageView!
//    var qr_icon:UIImageView!
    //    var sign_icon:UIImageView!
    var accountLabel:UILabel!
    
    var levelLable: UILabel!
    var levelImg: UIImageView!
    
    var signBtn:UIButton!
    var balanceLabel:UILabel!
    
    var btnView:UIView!
    var charge:UIView?
    var pickView:UIView?
    
    var controller:BaseController!
    var meminfo:Meminfo?
    
    var setupButton = UIButton()
    var loginButton = UIButton()
    var registerButton = UIButton()
    
    var setupButtonClick:(() -> Void)?
    var loginButtonClick:(() -> Void)?
    var registerButtonClick:(() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(icon:UIImage?,account:String?,balance:Float?,levelName:String?,levelIcon:String?,slideMenu:Bool,controller:BaseController) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: slideMenu ? kScreenWidth/2 : kScreenWidth, height: 250))
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeHadChange), name: Notification.Name(rawValue: ThemeUpdateNotification), object: nil)
        
        self.controller = controller
        bgImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 50))
        updateHeaderBgLogo()
        self.addSubview(bgImg)
        
        app_icon = UIImageView.init(frame: CGRect.init(x: self.bounds.width*0.5-40, y: self.bounds.height*0.5-60-35, width: 80, height: 80))
        app_icon.image = icon
        app_icon.tag = 10
        app_icon.layer.cornerRadius = 40.0
        app_icon.layer.masksToBounds = true
        app_icon.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(app_icon)

//        if let sys = getSystemConfigFromJson() {
//            if sys.content != nil{
//                let signSwitch = sys.content.switch_sign_in
//                if !isEmptyString(str: signSwitch) && signSwitch == "on"{
//                    self.addSubview(punchButton)
//                    punchButton.whc_Left(15).whc_Top(30).whc_Width(70).whc_Height(32)
//                    punchButton.imageView?.contentMode = .scaleAspectFit
//                    punchButton.setImage(UIImage(named: "personalNotPunch"), for: .normal)
//                    punchButton.setImage(UIImage(named: "personalPunched"), for: .selected)
//                    punchButton.addTarget(self, action: #selector(punchAction), for: .touchUpInside)
//                    refreshPunchState()
//                }
//            }
//        }
        updateAppLogo()
//        qr_icon = UIImageView.init(frame: CGRect.init(x: self.bounds.width-40, y: 10, width: 30, height: 30))
//        qr_icon.image = UIImage.init(named: "qr")
//        qr_icon.layer.borderColor = UIColor.white.cgColor
//        qr_icon.layer.borderWidth = 3
//        qr_icon.tag = 11
//        self.addSubview(qr_icon)
        
//        accountLabel = UILabel.init(frame: CGRect.init(x: self.bounds.width/4, y: self.bounds.height*0.5+20, width: self.bounds.width/2, height: 25))
        accountLabel = UILabel.init()
        accountLabel.text = account
        accountLabel.textColor = UIColor.white
        accountLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        accountLabel.textAlignment = NSTextAlignment.center
        self.addSubview(accountLabel)
        
        levelImg = UIImageView.init()
        levelImg.contentMode = UIViewContentMode.scaleAspectFit
        self.addSubview(levelImg)
        
        levelLable = UILabel.init()
        levelLable.text = levelName
        levelLable.textColor = UIColor.white
        levelLable.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        levelLable.textAlignment = NSTextAlignment.center
        self.addSubview(levelLable)
        
        signBtn = UIButton.init(frame: CGRect.init(x: self.bounds.width/2 + 5, y: self.bounds.height-110, width: 60, height: 22))
        signBtn.setImage(UIImage.init(named: "sign_btn"), for: .normal)
        signBtn.addTarget(self, action: #selector(onSignClick), for: .touchUpInside)
//        self.addSubview(signBtn)
        
//        balanceLabel = UILabel.init(frame: CGRect.init(x: 0, y: self.bounds.height-85, width: self.bounds.width, height: 25))
        balanceLabel = UILabel.init()
        balanceLabel.text = String.init(format: "余额:%.2f元", balance!)
        balanceLabel.textColor = UIColor.white
        balanceLabel.textAlignment = NSTextAlignment.center
        balanceLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        self.addSubview(balanceLabel)
        
        updateAccountLabels()
        
        toggleBtns()
        bindEvent()
        setupSettinglogAndRegButtons()
    }
    
    
    private func setupSettinglogAndRegButtons() {
        buttonFactory(button: setupButton, title: "设置")
        setupButton.addTarget(self, action: #selector(rightItemClickHandle), for: .touchUpInside)
        setupButton.whc_Right(15).whc_Top(20)
        
        buttonFactory(button: loginButton, title: "登录")
        loginButton.addTarget(self, action: #selector(loginClickHandle), for: .touchUpInside)
        loginButton.whc_Right(15).whc_Top(20)
        
        if allowRegisterSwitch() {
            buttonFactory(button: registerButton, title: "注册")
            registerButton.addTarget(self, action: #selector(registerClickHandle), for: .touchUpInside)
            registerButton.whc_Right(10, toView: loginButton).whc_CenterYEqual(loginButton)
        }
    }
    
    private func allowRegisterSwitch() -> Bool{
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
    
    @objc private func rightItemClickHandle() {
        setupButtonClick?()
    }
    
    @objc private func loginClickHandle() {
        loginButtonClick?()
    }
    
    @objc private func registerClickHandle() {
        registerButtonClick?()
    }
    
    private func buttonFactory(button: UIButton,title: String) {
        button.isHidden = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        self.addSubview(button)
        self.bringSubview(toFront: button)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: 设置头像、头像背景
    @objc private func themeHadChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateHeaderBgLogo()
            self.updateAppLogo()
        }
    }
    
    func updateHeaderBgLogo() -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        let logoImg = sys.content.member_page_bg_url
        if !isEmptyString(str: logoImg){
            
            let urlString = handleImageURL(urlString: logoImg)
            
            let themeName = YiboPreference.getCurrentThmeByName()
            var bgImageName = ""
            if themeName == "Red" {
                bgImageName = "personalHeaderBg_red"
            }else if themeName == "Blue" {
                bgImageName = "personalHeaderBg_blue"
            }else if themeName == "Green" {
                bgImageName = "personalHeaderBg_green"
            }else if themeName == "FrostedOrange" {
                bgImageName = "personalHeaderBg_glassOrange"
            }
            
            if let url = URL.init(string: urlString) {
                self.bgImg.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: bgImageName), options: nil, progressBlock: nil, completionHandler: nil)
            }else {
                self.bgImg.theme_image = "General.personalHeaderBg"
            }
            
        }else{
            self.bgImg.theme_image = "General.personalHeaderBg"
        }
    }
    
    private func updateLevelIcon(icon: String) -> Void {
        var logoImg = icon
        if !isEmptyString(str: logoImg){
            //这里的logo地址有可能是相对地址
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
            
            if let imageURL = URL(string: logoImg) {
                levelImg.kf.setImage(with: ImageResource(downloadURL: imageURL))
            }
            
        }else{
            levelImg.whc_Height(0)
        }

    }
    
    func updateAppLogo() -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        let logoImg = sys.content.member_page_logo_url
        if !isEmptyString(str: logoImg){
            
            let urlString = handleImageURL(urlString: logoImg)
            
            let themeName = YiboPreference.getCurrentThmeByName()
            var bgImageName = ""
            if themeName == "Red" {
                bgImageName = "placeHeader_red"
            }else if themeName == "Blue" {
                bgImageName = "placeHeader_blue"
            }else if themeName == "Green" {
                bgImageName = "placeHeader_green"
            }else if themeName == "FrostedOrange" {
                bgImageName = "placeHeader_glassOrange"
            }
            
            if let url = URL.init(string: urlString) {
                self.app_icon.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: bgImageName), options: nil, progressBlock: nil, completionHandler: nil)
            }else {
                self.app_icon.theme_image = "General.personalHeaderBg"
            }
            
        }else{
            self.app_icon.theme_image = "General.personalHeaderBg"
        }
    }
    
    func createbtn(title:String,imageName:String,index:Int,attachView:UIView) ->  UIView{
        let view = UIView.init()
        
        
        
        if index == 0 {
            view.frame = CGRect.init(x:self.bounds.width/2*CGFloat(index), y: attachView.bounds.height - 50, width: self.bounds.width/2 - 0.5, height: 50)
        }else if index == 1 {
            view.frame = CGRect.init(x:self.bounds.width/2*CGFloat(index) + 0.5, y: attachView.bounds.height - 50, width: self.bounds.width/2 - 0.5, height: 50)
        }
        
        setupNoPictureAlphaBgView(view: view)
        
        let img = UIImageView.init(frame: CGRect.init(x: view.bounds.width/2-10-25, y: view.bounds.height/2-10, width: 20, height: 20))
        img.theme_image = ThemeImagePicker.init(keyPath: imageName)
        view.addSubview(img)
        let txt = UILabel.init(frame: CGRect.init(x: view.bounds.width/2-25+3, y: view.bounds.height/2-10, width: 100, height: 20))
        txt.text = title
        txt.textAlignment = NSTextAlignment.center
        txt.theme_textColor = "FrostedGlass.normalDarkTextColor"
        txt.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(txt)

        return view
    }
    
    func bindEvent() -> Void {
        //给界面上各按钮添加手势事件
        app_icon.isUserInteractionEnabled = true
//        qr_icon.isUserInteractionEnabled = true
        if charge != nil{
            charge?.isUserInteractionEnabled = true
        }
        if pickView != nil{
            pickView?.isUserInteractionEnabled = true
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
//        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
        let tap5 = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
        
//        app_icon.addGestureRecognizer(tap)
//        qr_icon.addGestureRecognizer(tap2)
        if charge != nil{
            charge?.addGestureRecognizer(tap4)
        }
        if pickView != nil{
            pickView?.addGestureRecognizer(tap5)
        }
        
    }
    
    //用户中心
    func openUserCenter() -> Void {
        if controller.navigationController != nil{
            gameplay.openUserCenter(controller: controller)
        }else{
            let loginVC = UIStoryboard(name: "user_center", bundle: nil).instantiateViewController(withIdentifier: "userCenter")
            let recordPage = loginVC as! UserCenterController
            controller.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            controller.present(nav, animated: true, completion: nil)
        }
    }
    
    func actionQrcodePage(){
        if controller.navigationController != nil{
            openQRCodePage(controller: controller)
        }else{
            let loginVC = UIStoryboard(name: "qrcode_page", bundle: nil).instantiateViewController(withIdentifier: "qrcodeController")
            let recordPage = loginVC as! QrcodeViewController
            controller.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            controller.present(nav, animated: true, completion: nil)
        }
    }
    
    func actionConvertMoney(){
        if controller.navigationController != nil{
            openConvertMoneyPage(controller: controller)
        }else{
            let loginVC = UIStoryboard(name: "fee_convert", bundle: nil).instantiateViewController(withIdentifier: "feeConvert")
            let recordPage = loginVC as! FeeConvertController
            controller.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            controller.present(nav, animated: true, completion: nil)
        }
    }
    
    func actionChargeMoney(meminfo:Meminfo?){
        
        if YiboPreference.getAccountMode() == GUEST_TYPE{
            showToast(view: controller.view, txt: "试玩账号不能进行此操作")
            return
        }
        
        if controller.navigationController != nil{
            openChargeMoney(controller: controller,meminfo:meminfo)
        }else{
            let loginVC = UIStoryboard(name: "new_charge_money_page", bundle: nil).instantiateViewController(withIdentifier: "new_charge")
            let recordPage = loginVC as! NewChargeMoneyController
            recordPage.meminfo = meminfo
            controller.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            controller.present(nav, animated: true, completion: nil)
        }
    }
    
    func actionPickMoney(meminfo:Meminfo?){
        
        if YiboPreference.getAccountMode() == GUEST_TYPE{
            showToast(view: controller.view, txt: "试玩账号不能进行此操作")
            return
        }
        
        if controller.navigationController != nil{
            openPickMoney(controller: controller,meminfo:meminfo)
        }else{
            let loginVC = UIStoryboard(name: "withdraw_page", bundle: nil).instantiateViewController(withIdentifier: "withDraw")
            let recordPage = loginVC as! WithdrawController
            recordPage.meminfo = meminfo
            controller.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            controller.present(nav, animated: true, completion: nil)
        }
    }
    
    func syncDatas() -> Void {
        accountWeb()
        
        if YiboPreference.getLoginStatus() {
            setupButton.isHidden = false
            loginButton.isHidden = true
            registerButton.isHidden = true
        }else {
            setupButton.isHidden = true
            loginButton.isHidden = false
            registerButton.isHidden = false
        }
    }
    
    @objc func tapClickEvent(_ recongnizer: UIPanGestureRecognizer) {
        let tag = recongnizer.view!.tag
        print("tag === ",tag)
        switch tag {
        case 10://cilck header img
            openUserCenter()
            break;
        case 11://click qrcode
            actionQrcodePage()
            break;
        case 12://click charge btn
            actionChargeMoney(meminfo:self.meminfo)
            break;
        case 13://click withdraw btn
            actionPickMoney(meminfo:self.meminfo)
            break;
        case 14:
            onSignClick()
            break;
        default:
            break;
        }
    }
    
    @objc private func punchAction() {
        onSignClick()
    }
    
    private func refreshPunchState() {
//        let currentdate = Date()
//        let dateformatter = DateFormatter()
////        dateformatter.timeZone =
//        //待：使用系统时区
//        dateformatter.dateFormat = "YYYY-MM-dd"
//        let dateString = dateformatter.string(from: currentdate)
        
//        let date = Date()
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
//        let year =  components.year
//        let month = components.month
//        let day = components.day
//        let dateString = String.init(format: "%d%d%d", year!,month!,day!)
//
//        let lastSignDateStr = YiboPreference.getSignDate()
//
//        let userName = YiboPreference.getUserName()
//        let baseUrl = getDomainUrl()
//        let signKey = dateString + userName + baseUrl
////        punchButton.isSelected = lastSignDateStr == signKey
//        punchButton.isSelected = lastSignDateStr.contains(signKey)
    }
    
    private func getMemInfo() -> Meminfo?{
        return self.meminfo
    }
    
    func accountWeb() -> Void {
        //帐户相关信息
        controller.request(frontDialog: false, url:MEMINFO_URL,
                           callback: {(resultJson:String,resultStatus:Bool)->Void in
                            if !resultStatus {
                                return
                            }
                            if let result = MemInfoWraper.deserialize(from: resultJson){
                                if result.success{
                                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                                    if let memInfo = result.content{
                                        //更新帐户名，余额等信息
                                        self.meminfo = memInfo
                                        self.updateAccount(memInfo:memInfo);
                                    }
                                }
                            }
        })
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var accountNameStr = ""
        if !isEmptyString(str: memInfo.account){
            accountNameStr = memInfo.account
        }else{
            accountNameStr = "暂无名称"
        }
        accountLabel.text = accountNameStr
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = "\(memInfo.balance)"
        }else{
            leftMoneyName = "0"
        }
        
        balanceLabel.text = String.init(format: "余额:%@元",  leftMoneyName)
        if !isEmptyString(str: memInfo.level) {
            levelLable.text = memInfo.level
        }
        
        if !isEmptyString(str: memInfo.level_icon) {
            updateLevelIcon(icon: memInfo.level_icon)
            levelImg.whc_Height(20)
        }else {
            levelImg.whc_Height(0)
        }
        
        if isEmptyString(str: memInfo.level) && isEmptyString(str: memInfo.level_icon) {
            levelLable.whc_Height(0)
        }else {
            levelLable.whc_Height(25)
        }
        
        if let sys = getSystemConfigFromJson() {
            if sys.content != nil{
                let switch_level_show = sys.content.switch_level_show
                if !(!isEmptyString(str: switch_level_show) && switch_level_show == "on"){
                   levelLable.whc_Height(0)
                   levelLable.whc_Height(0)
                }
            }
        }
        
    }
    
    private func updateAccountLabels() {
        accountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(app_icon.centerX)
            make.top.equalTo(app_icon.bottom)
        }
        
        levelLable.whc_Top(1, toView: accountLabel)
        levelLable.whc_CenterX(0, toView: accountLabel)
        
        levelImg.whc_Right(2, toView: levelLable)
        levelImg.whc_CenterYEqual(levelLable)
        levelImg.whc_Height(20)
        levelImg.whc_Width(20)
        
        ////////////////////////
//        levelImg.whc_CenterX(-12, toView: accountLabel)
//        levelLable.whc_left
        ////////////////////////
        
        balanceLabel.whc_CenterXEqual(accountLabel)
        balanceLabel.whc_Top(1, toView: levelLable)
    }
    
    func toggleBtns() -> Void {
//        if YiboPreference.getAccountMode() == GUEST_TYPE{
//            charge?.removeFromSuperview()
//            pickView?.removeFromSuperview()
//        }else{
//            if charge != nil{
//                charge?.removeFromSuperview()
//            }
//            if pickView != nil{
//                pickView?.removeFromSuperview()
//            }
        charge = createbtn(title: "我的充值", imageName:"HomePage.homeDeposit", index: 0,attachView: self)
        pickView = createbtn(title: "我的提现", imageName:"HomePage.withdrawal", index: 1,attachView: self)
            charge?.tag = 12
            pickView?.tag = 13
            self.addSubview(charge!)
            self.addSubview(pickView!)
//        }
        
//        let line = UIView()
//        line.theme_backgroundColor = "Global.themeColor"
//        self.addSubview(line)
//        line.whc_CenterX(0).whc_Width(1).whc_Bottom(0).whc_HeightEqual(charge)
    }
    
    func showSignDialog(content:String) -> Void {
        let alertController = UIAlertController(title: "签到成功",
                                                message: content, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    @objc func onSignClick() -> Void {
//        controller.request(frontDialog: true,method: .post, loadTextStr:"签到中.", url:NEWSIGN_URL,
//                           callback: {(resultJson:String,resultStatus:Bool)->Void in
//                            if !resultStatus {
//                                if resultJson.isEmpty {
//                                    showToast(view: self.controller.view, txt: convertString(string: "签到失败"))
//                                }else{
//                                    showToast(view: self.controller.view, txt: resultJson)
//                                }
//                                return
//                            }
//                            if let result = SignResultWraper.deserialize(from: resultJson){
//                                if result.success{
//                                    // 处理签到成功后的操作
////                                    let currentdate = Date()
////                                    let dateformatter = DateFormatter()
////                                    dateformatter.dateFormat = "YYYY-MM-dd"
//
//                                    let date = Date()
//                                    let calendar = Calendar.current
//                                    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
//                                    let year =  components.year
//                                    let month = components.month
//                                    let day = components.day
//                                    let dateString = String.init(format: "%d%d%d", year!,month!,day!)
//
//                                    let userName = YiboPreference.getUserName()
//                                    let baseUrl = getDomainUrl()
//                                    let signKey = dateString + userName + baseUrl
//
//                                    let ignDateStr = YiboPreference.getSignDate()
//                                    if !ignDateStr.contains(signKey) {
//                                        YiboPreference.save_signDate(value: "\(signKey),\(ignDateStr)" as AnyObject)
//                                    }
//
//                                    self.refreshPunchState()
//
//                                }else{
//                                    if !isEmptyString(str: result.msg){
//                                        showToast(view: self.controller.view, txt: result.msg)
//                                    }else{
//                                        showToast(view: self.controller.view, txt: convertString(string: "签到失败"))
//                                    }
//                                    if result.code == 0{
//                                        loginWhenSessionInvalid(controller: self.controller)
//                                    }
//                                }
//                            }
//        })
    }
    
}
