//
//  MenuHeader.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/25.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//侧边个人中心头部区
class MenuHeader: UIView {
    
    var app_icon:UIImageView!
    var qr_icon:UIImageView!
//    var sign_icon:UIImageView!
    var accountLabel:UILabel!
    var signBtn:UIButton!
    var balanceLabel:UILabel!
    
    var btnView:UIView!
    var charge:UIView?
    var pickView:UIView?
    
    var controller:BaseController!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(icon:UIImage?,account:String?,balance:Float?,slideMenu:Bool,controller:BaseController) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: slideMenu ? kScreenWidth/2 : kScreenWidth, height: 250))
        
        self.controller = controller
        let bgImg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        bgImg.backgroundColor = UIColor(hex: 0xEC2829)
//        bgImg.image = UIImage.init(named: "header_bg")
        self.addSubview(bgImg)
        
        app_icon = UIImageView.init(frame: CGRect.init(x: self.bounds.width*0.5-40, y: self.bounds.height*0.5-40-25, width: 60, height: 60))
        app_icon.image = UIImage.init(named: "member_page_default_header")
        app_icon.image = icon
        app_icon.tag = 10
        app_icon.contentMode = UIViewContentMode.scaleAspectFill
//        app_icon.clipsToBounds = true
        self.addSubview(app_icon)
        updateAppLogo()
        
        qr_icon = UIImageView.init(frame: CGRect.init(x: self.bounds.width-40, y: 10, width: 30, height: 30))
        qr_icon.image = UIImage.init(named: "qr")
        qr_icon.layer.borderColor = UIColor.white.cgColor
        qr_icon.layer.borderWidth = 3
        qr_icon.tag = 11
        self.addSubview(qr_icon)
        
//        sign_icon = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 80, height: 44.5))
//        sign_icon.image = UIImage.init(named: "sign")
//        sign_icon.tag = 14
//        self.addSubview(sign_icon)
        
        accountLabel = UILabel.init(frame: CGRect.init(x: 0, y: self.bounds.height-112, width: self.bounds.width/2, height: 25))
        accountLabel.text = account
        accountLabel.textColor = UIColor.white
        accountLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        accountLabel.textAlignment = NSTextAlignment.right
        self.addSubview(accountLabel)
        
        signBtn = UIButton.init(frame: CGRect.init(x: self.bounds.width/2 + 5, y: self.bounds.height-110, width: 60, height: 22))
        signBtn.setImage(UIImage.init(named: "sign_btn"), for: .normal)
        signBtn.addTarget(self, action: #selector(onSignClick), for: .touchUpInside)
        self.addSubview(signBtn)
        
        balanceLabel = UILabel.init(frame: CGRect.init(x: 0, y: self.bounds.height-85, width: self.bounds.width, height: 25))
        balanceLabel.text = String.init(format: "余额:%.2f元", balance!)
        balanceLabel.textColor = UIColor.white
        balanceLabel.textAlignment = NSTextAlignment.center
        balanceLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        self.addSubview(balanceLabel)
        toggleBtns()
        bindEvent()
    }
    
    func updateAppLogo() -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        var logoImg = sys.content.lottery_page_logo_url
        if !isEmptyString(str: logoImg){
            //这里的logo地址有可能是相对地址
            print("the logo url = ",logoImg)
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
            downloadImage(url: URL.init(string: logoImg)!, imageUI: self.app_icon)
        }else{
            self.app_icon.image = UIImage.init(named: "member_page_default_header")
        }
    }
    
    func createbtn(title:String,image:UIImage,index:Int,attachView:UIView) ->  UIView{
        let view = UIView.init(frame: CGRect.init(x:self.bounds.width/2*CGFloat(index), y: attachView.bounds.height - 50, width: self.bounds.width/2 - 0.5, height: 50))
        view.backgroundColor = UIColor.white
        let img = UIImageView.init(frame: CGRect.init(x: view.bounds.width/2-10-15, y: view.bounds.height/2-10, width: 20, height: 20))
        img.image = image
        view.addSubview(img)
        let txt = UILabel.init(frame: CGRect.init(x: view.bounds.width/2-15+3, y: view.bounds.height/2-10, width: 50, height: 20))
        txt.text = title
        txt.textAlignment = NSTextAlignment.center
        txt.textColor = UIColor.lightGray
        txt.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(txt)
        return view
    }
    
    func bindEvent() -> Void {
        //给界面上各按钮添加手势事件
        app_icon.isUserInteractionEnabled = true
        qr_icon.isUserInteractionEnabled = true
        if charge != nil{
            charge?.isUserInteractionEnabled = true
        }
        if pickView != nil{
            pickView?.isUserInteractionEnabled = true
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
        let tap5 = UITapGestureRecognizer.init(target: self, action: #selector(tapClickEvent(_:)))
        
        app_icon.addGestureRecognizer(tap)
        qr_icon.addGestureRecognizer(tap2)
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
    
    func actionChargeMoney(){
        if controller.navigationController != nil{
            openChargeMoney(controller: controller)
        }else{
            let loginVC = UIStoryboard(name: "charge_money", bundle: nil).instantiateViewController(withIdentifier: "chargeMoney")
            let recordPage = loginVC as! ChargeMoneyController
            controller.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            controller.present(nav, animated: true, completion: nil)
        }
    }
    
    func actionPickMoney(){
        if controller.navigationController != nil{
            openPickMoney(controller: controller)
        }else{
            let loginVC = UIStoryboard(name: "withdraw_page", bundle: nil).instantiateViewController(withIdentifier: "withDraw")
            let recordPage = loginVC as! WithdrawController
            controller.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            controller.present(nav, animated: true, completion: nil)
        }
    }
    
    func syncDatas() -> Void {
        accountWeb()
//        toggleBtns()
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
            actionChargeMoney()
            break;
        case 13://click withdraw btn
            actionPickMoney()
            break;
        case 14:
            onSignClick()
            break;
        default:
            break;
        }
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
            leftMoneyName = String.init(format: "%.2f", Float(memInfo.balance)!)
        }else{
            leftMoneyName = "0"
        }
        balanceLabel.text = String.init(format: "余额:%@元",  leftMoneyName)
    }
    
    func toggleBtns() -> Void {
        if YiboPreference.getAccountMode() == GUEST_TYPE{
            charge?.removeFromSuperview()
            pickView?.removeFromSuperview()
        }else{
            if charge != nil{
                charge?.removeFromSuperview()
            }
            if pickView != nil{
                pickView?.removeFromSuperview()
            }
            charge = createbtn(title: "存款", image: UIImage.init(named: "recharge_icon")!, index: 0,attachView: self)
            pickView = createbtn(title: "取款", image: UIImage.init(named: "withdraw_icon")!, index: 1,attachView: self)
            charge?.tag = 12
            pickView?.tag = 13
            self.addSubview(charge!)
            self.addSubview(pickView!)
        }
    }
    
    func showSignDialog(content:String) -> Void {
        let alertController = UIAlertController(title: "签到成功",
                                                message: content, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    @objc func onSignClick() -> Void {
        controller.request(frontDialog: true,method: .post, loadTextStr:"签到中.", url:SIGN_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.controller.view, txt: convertString(string: "签到失败"))
                        }else{
                            showToast(view: self.controller.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SignResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if let content = result.content{
                                if content.score == 0{
                                    showToast(view: self.controller.view, txt: "签到成功")
                                    return
                                }else{
                                    let days = content.days
                                    if days > 0{
                                        let content = String.init(format: "恭喜您已连续签到%d天，获得积分%d", days,content.score)
                                        self.showSignDialog(content: content)
                                    }else{
                                        showToast(view: self.controller.view, txt: "签到成功")
                                        return
                                    }
                                }
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.controller.view, txt: result.msg)
                            }else{
                                showToast(view: self.controller.view, txt: convertString(string: "签到失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self.controller)
                            }
                        }
                    }
        })
    }
    
    
    
    
    
    

}
