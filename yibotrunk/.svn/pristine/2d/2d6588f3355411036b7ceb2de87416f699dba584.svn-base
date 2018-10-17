//
//  ChargeMoneyController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/29.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON
import Kingfisher

//充值页面
class ChargeMoneyController: BaseController,PayMethodDelegate,UITextFieldDelegate {
    
    @ IBOutlet weak var headerImg:UIImageView!
    @ IBOutlet weak var accountNameUI:UILabel!
    @ IBOutlet weak var accountBalanceUI:UILabel!
    @ IBOutlet weak var receiverUI:UILabel!
    @ IBOutlet weak var copyAccountNumUI:UIButton!
    @ IBOutlet weak var bankAddressUI:UILabel!
    @ IBOutlet weak var currentPayMethodUI:UILabel!
    @ IBOutlet weak var currentPayMethodImg:UIImageView!
    @ IBOutlet weak var changeMethodBtn:UIButton!
    @ IBOutlet weak var inputMoneyView:UIView!
    @ IBOutlet weak var inputMoneyTipUI:UILabel!
    @ IBOutlet weak var fastTipUI:UILabel!
    @ IBOutlet weak var inputMoneyUI:CustomFeildText!
    @ IBOutlet weak var secondInputUI:CustomFeildText!
    @ IBOutlet weak var commitBtn:UIButton!
    @ IBOutlet weak var qrcodeArea:UIView!
    @ IBOutlet weak var qrcodeAreaImg:UIImageView!
    
    @ IBOutlet weak var qrCodeAreaHeightConstaint:NSLayoutConstraint!
    @ IBOutlet weak var secondInputUIHeightConstaint:NSLayoutConstraint!
    @ IBOutlet weak var receiverUIHeightConstaint:NSLayoutConstraint!
    

    var globalAccountName = ""
    
    var payMethodResult:PayMethodResult!
    var selectPayType = PAY_METHOD_ONLINE;//已选择的支付方式
    var selectPosition = 0;//对应支付方式下的支付列表中已选择的位置
    
    var payMethodWindow:PayMethodWindow!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        changeMethodBtn.addTarget(self, action: #selector(onPayMethodChange), for: UIControlEvents.touchUpInside)
        commitBtn.addTarget(self, action: #selector(onCommitClick), for: UIControlEvents.touchUpInside)
        
        copyAccountNumUI.addTarget(self, action: #selector(onCopyAccountNumber), for: UIControlEvents.touchUpInside)
        
        inputMoneyUI.delegate = self
        secondInputUI.delegate = self
        
        qrcodeArea.layer.cornerRadius = 5
        qrcodeArea.layer.borderWidth = 1
        qrcodeArea.layer.borderColor = UIColor.lightGray.cgColor
        
        commitBtn.layer.cornerRadius = 22.5
        
        self.navigationItem.title = "充值"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "充值记录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onChargeRecordClick))
        
        addLongPressGestureRecognizer()
        
//        当键盘弹起的时候会向系统发出一个通知，
////        这个时候需要注册一个监听器响应该通知
        popHeight = Int(kScreenHeight/4)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        syncAccount()
    }
    
    func addLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressClick))
        self.qrcodeAreaImg.isUserInteractionEnabled = true
        self.qrcodeAreaImg.contentMode = UIViewContentMode.scaleAspectFit
        self.qrcodeAreaImg.addGestureRecognizer(longPress)
    }
    
    func longPressClick(){
        let alert = UIAlertController(title: "请选择", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction.init(title: "保存到相册", style: .default, handler: {(action:UIAlertAction) in
            UIImageWriteToSavedPhotosAlbum(self.qrcodeAreaImg.image!, self, #selector(self.save_image(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let action2 = UIAlertAction.init(title: "识别二维码图片", style: .default, handler: {(action:UIAlertAction) in
            if self.qrcodeAreaImg.image == nil{
                return
            }
            UIImageWriteToSavedPhotosAlbum(self.qrcodeAreaImg.image!, self, #selector(self.readQRcode(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func readQRcode(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer){
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let imageCI = CIImage.init(image: self.qrcodeAreaImg.image!)
        let features = detector?.features(in: imageCI!)
        guard (features?.count)! > 0 else { return }
        let feature = features?.first as? CIQRCodeFeature
        let qrMessage = feature?.messageString
        
        guard var code = qrMessage else{
            showToast(view: self.view, txt: "请确认二维码图片是否正确")
            return
        }
        if !isEmptyString(str: code){
            var appname = ""
            code = code.lowercased()
            if code.starts(with:"wxp"){
                appname = "微信"
            }else if code.contains("alipay"){
                appname = "支付宝"
            }else{
                showToast(view: self.view, txt: "请确认二维码图片是否正确的收款二维码")
            }
            if error == nil {
                let ac = UIAlertController.init(title: "保存成功",
                                                message: String.init(format: "您可以打开%@,从相册选取并识别此二维码", appname), preferredStyle: .alert)
                ac.addAction(UIAlertAction(title:"去扫码",style: .default,handler: {(action:UIAlertAction) in
                    // 跳转扫一扫
                    if appname == "微信"{
                        if UIApplication.shared.canOpenURL(URL.init(string: "weixin://")!){
                            openBrower(urlString: "weixin://")
                        }else{
                            showToast(view: self.view, txt: "您未安装微信，无法打开扫描")
                        }
                    }else if appname == "支付宝"{
                        if UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!){
                            openBrower(urlString: "alipay://")
                        }else{
                            showToast(view: self.view, txt: "您未安装支付宝，无法打开扫描")
                        }
                    }
                }))
                self.present(ac, animated: true, completion: nil)
            } else {
                let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
        }else{
            showToast(view: self.view, txt: "请确认二维码图片是否正确的收款二维码")
            return
        }
    }
    
    //保存二维码
    @objc func save_image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error == nil {
//            let ac = UIAlertController(title: "保存成功", message: "请打开微信识别二维码", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
//            self.present(ac, animated: true, completion: nil)
            showToast(view: self.view, txt: "保存图片成功")
        } else {
            let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func viewClick(_ sender: Any) {
        inputMoneyUI.resignFirstResponder()
        secondInputUI.resignFirstResponder()
    }
    
    @IBAction func viewClick2(_ sender: Any) {
        inputMoneyUI.resignFirstResponder()
        secondInputUI.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func onChargeRecordClick() -> Void {
        openAccountMingxi(controller: self, whichPage: 0)
    }
    
    func syncPayMethod() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "获取充值方式中...",url:GET_PAY_METHODS_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    if let result = PayMethodWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let payMethods = result.content{
                                //更新充值方式
                                self.payMethodResult = payMethods
                                print("the pay count = ",self.payMethodResult.online.count)
                                if !self.payMethodResult.online.isEmpty{
                                    self.selectPayType = PAY_METHOD_ONLINE
                                } else if !self.payMethodResult.fast.isEmpty{
                                    self.selectPayType = PAY_METHOD_FAST
                                } else if !self.payMethodResult.bank.isEmpty{
                                    self.selectPayType = PAY_METHOD_BANK
                                }
                                self.updatePayInfo(type: self.selectPayType)
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取充值方式失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func fixPayIconWithPayType(payType:String) -> String {
        if isEmptyString(str: payType){
            return ""
        }
        switch payType {
        case "3":
            return "/native/resources/images/weixin.jpg"
        case "4":
            return "/native/resources/images/zhifubao.jpg"
        case "5":
            return "/native/resources/images/qqpay.png"
        case "6":
            return "/native/resources/images/jdpay.jpg"
        case "7":
            return "/native/resources/images/baidu.jpg"
        case "8":
            return "/native/resources/images/union.jpg"
        default:
            return ""
        }
    }
    
    func updateCurrentPayImage(url:String,img:UIImageView,payType:String="") -> Void {
        img.contentMode = UIViewContentMode.scaleAspectFit
        if !isEmptyString(str: url){
            let murl = url.trimmingCharacters(in: .whitespaces)
            let imageURL = URL(string: murl)!
            img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            let icon = fixPayIconWithPayType(payType: payType)
            if isEmptyString(str: icon){
                img.image = UIImage.init(named: "default_pay_icon")
            }else{
                let fixurl = String.init(format: "%@%@%@", BASE_URL,PORT,icon)
                let imageURL = URL(string: fixurl)!
                img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    //更新界面上对应支付方式的支付信息
    func updatePayInfo(type:Int) -> Void {
        
        var showWindow = true
        if self.payMethodResult.fast.isEmpty && self.payMethodResult.online.isEmpty &&
            self.payMethodResult.bank.isEmpty{
            showWindow = false
        }
        //若没有配置任何支付方式，则隐藏扫码区
        if !showWindow{
            qrcodeArea.isHidden = true
            qrCodeAreaHeightConstaint.constant = 0
        }
        
        var json = ""
        if type == PAY_METHOD_ONLINE{
            if self.payMethodResult.online.isEmpty{
                return
            }
            let onlinePay = self.payMethodResult.online[self.selectPosition]
            json = onlinePay.toJSONString()!
            self.selectPayType = PAY_METHOD_ONLINE;
        }else if type == PAY_METHOD_FAST{
            if self.payMethodResult.fast.isEmpty{
                return
            }
            let fastPay = self.payMethodResult.fast[self.selectPosition]
            json = fastPay.toJSONString()!
            self.selectPayType = PAY_METHOD_FAST;
        }else if type == PAY_METHOD_BANK{
            if self.payMethodResult.bank.isEmpty{
                return
            }
            let bankPay = self.payMethodResult.bank[self.selectPosition]
            json = bankPay.toJSONString()!
            self.selectPayType = PAY_METHOD_BANK;
        }
        
        if isEmptyString(str: json){
            return
        }
        if type == PAY_METHOD_ONLINE{
            let onlinePay = JSONDeserializer<OnlinePay>.deserializeFrom(json: json)
            if let value = onlinePay{
                inputMoneyTipUI.text = String.init(format: "充值金额(最低充值金额%d元)", value.minFee)
                secondInputUI.placeholder = "添加备注(50字以内)"
                //更新确认支付按钮下方的支付方式文字
//                currentPayMethodUI.text = String.init(format: "当前支付方式: %@", value.payName)
                //bankPayTip.setVisibility(View.GONE);
                updateCurrentPayImage(url: value.icon, img: currentPayMethodImg,payType: value.payType)
                
                receiverUI.isHidden = true
                copyAccountNumUI.isHidden = true
                bankAddressUI.isHidden = true
//                receiverUIHeightConstaint.constant = 0
                
                qrcodeArea.isHidden = true
                qrCodeAreaHeightConstaint.constant = 0
            }
        }else if type == PAY_METHOD_FAST{
            let fastPay = JSONDeserializer<FastPay>.deserializeFrom(json: json)
            if let value = fastPay{
                
                inputMoneyTipUI.text = String.init(format: "充值金额(最低充值金额%d元)", value.minFee)
                var ph = ""
                if !isEmptyString(str: value.frontLabel){
                    ph = String.init(format: "(请输入正确的%@，否则无法到帐)",value.frontLabel)
                }
                secondInputUI.placeholder = ph
                //更新确认支付按钮下方的支付方式文字
//                currentPayMethodUI.text = String.init(format: "当前支付方式: %@", value.payName)
                updateCurrentPayImage(url: value.icon, img: currentPayMethodImg)
                
                //bankPayTip.setVisibility(View.GONE);
                receiverUI.isHidden = false
                copyAccountNumUI.isHidden = false
                bankAddressUI.isHidden = true
//                receiverUIHeightConstaint.constant = 21
                
                receiverUI.text = String.init(format: "收款人:%@(%@)", !isEmptyString(str: value.receiveName) ? value.receiveName : "暂无姓名",!isEmptyString(str: value.receiveAccount) ? value.receiveAccount : "暂无帐号")
                qrcodeArea.isHidden = false
                qrCodeAreaHeightConstaint.constant = 150
                //下载扫码二维码图片
                if !isEmptyString(str: value.qrCodeImg){
                    self.fillImage(url: value.qrCodeImg)
                }
            }
        }else if type == PAY_METHOD_BANK{
            let bankPay = JSONDeserializer<BankPay>.deserializeFrom(json: json)
            if let value = bankPay{
                inputMoneyTipUI.text = String.init(format: "充值金额(最低充值金额%d元)", value.minFee)
                secondInputUI.placeholder = "请输入存款人姓名"
                //更新确认支付按钮下方的支付方式文字
//                currentPayMethodUI.text = String.init(format: "当前支付方式: %@", value.payName)
                updateCurrentPayImage(url: value.icon, img: currentPayMethodImg)
                
                //bankPayTip.setVisibility(View.VISIBLE);
                receiverUI.isHidden = false
                copyAccountNumUI.isHidden = false
                bankAddressUI.isHidden = false
//                receiverUIHeightConstaint.constant = 21
                
                bankAddressUI.text = String.init(format: "开户行:%@", !isEmptyString(str: value.bankAddress) ? value.bankAddress : "暂无开户行信息")
                
                receiverUI.text = String.init(format: "收款人:%@(%@)", !isEmptyString(str: value.receiveName) ? value.receiveName : "暂无姓名",!isEmptyString(str: value.bankCard) ? value.bankCard : "暂无帐号")
                qrcodeArea.isHidden = true
                qrCodeAreaHeightConstaint.constant = 0
            }
        }
        
        if selectPayType == PAY_METHOD_ONLINE{
            secondInputUI.isHidden = true
            secondInputUIHeightConstaint.constant = 0
        }else{
            secondInputUI.isHidden = false
            secondInputUIHeightConstaint.constant = 40
        }
    }
    
    func fillImage(url:String) -> Void {
        let imageURL = URL(string: url)
        if let url = imageURL{
            downloadImage(url: url, imageUI: self.qrcodeAreaImg)
        }
    }
    
    func syncAccount() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "同步帐号信息...",url:MEMINFO_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    if let result = MemInfoWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let memInfo = result.content{
                                //赋值帐户名及余额
                                self.updateAccount(memInfo: memInfo)
                                self.syncPayMethod()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "同步帐户信息失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var accountNameStr = ""
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.account){
            accountNameStr = memInfo.account
        }else{
            accountNameStr = "暂无名称"
        }
        globalAccountName = accountNameStr
        accountNameUI.text = accountNameStr
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = String.init(format: "当前余额:%.2f", Double(memInfo.balance)!)
        }else{
            leftMoneyName = "0"
        }
        accountBalanceUI.text = String.init(format: "%@元",  leftMoneyName)
    }
    
    //确定提交订单
    func onCommitClick() -> Void {
        let summary = secondInputUI.text
        let moneyValue = inputMoneyUI.text
        if selectPayType == PAY_METHOD_ONLINE{
//            actionSubmitPay(payType: selectPayType, position: selectPosition, money: moneyValue!, depositor: "", account: "")
            
            let orderNo = ""
            let accountName = self.globalAccountName
            let chargeMoney = self.inputMoneyUI.text!
            
            self.inputMoneyUI.text = ""
            self.secondInputUI.text = ""
            
            let onlinePay = self.payMethodResult.online[self.selectPosition]
            let payMethodName = onlinePay.payName
            let payJson = onlinePay.toJSONString()
            //跳到订单支付确认页
            openConfirmPayController(orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: "", receiveAccount: "", dipositor: "", dipositorAccount: "", qrcodeUrl: "", payType: self.selectPayType, payJson: payJson!)
            
        }else if selectPayType == PAY_METHOD_FAST{
            actionSubmitPay(payType: selectPayType, position: selectPosition, money: moneyValue!, depositor: "", account: summary!)
        }else if selectPayType == PAY_METHOD_BANK{
            actionSubmitPay(payType: selectPayType, position: selectPosition, money: moneyValue!, depositor: summary!, account: "")
        }
    }
    
    
    /**
     *
     * @param payType 充值方式
     * @param position 选择的充值方式位置
     * @param money 充值金额
     * @param depositor 充值人
     * @param account 充值附加信息如帐号
     */
    func actionSubmitPay(payType:Int,position:Int,money:String,depositor:String,account:String) -> Void {
        
        let url = SUBMIT_PAY_URL
        var params:Dictionary<String,AnyObject> = [:]
        params["payMethod"] = payType as AnyObject
        if payType == PAY_METHOD_ONLINE{
            let online = payMethodResult.online
            if !online.isEmpty{
                if online.count > position{
                    let onlinePay = online[position]
                    params["money"] = money as AnyObject
                    params["payId"] = onlinePay.id as AnyObject
                }
            }
        }else if payType == PAY_METHOD_FAST{
            let fast = payMethodResult.fast
            if !fast.isEmpty{
                if fast.count > position{
                    let fastPay = fast[position]
                    params["money"] = money as AnyObject
                    params["account"] = account as AnyObject
                    params["payId"] = fastPay.id as AnyObject
                    params["depositor"] = depositor as AnyObject
                }
            }
        }else if payType == PAY_METHOD_BANK{
            let bank = payMethodResult.bank
            if !bank.isEmpty{
                if bank.count > position{
                    let bankPay = bank[position]
                    params["money"] = money as AnyObject
                    params["depositor"] = depositor as AnyObject
                    params["bankId"] = bankPay.id as AnyObject
                }
            }
        }
        
        request(frontDialog: true,method: .post,loadTextStr: "提交中...",url:url,params: params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "提交失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SubmitPayResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            showToast(view: self.view, txt: "订单提交成功")
                            if let content = result.content{
                                let orderNo = content
                                let accountName = self.globalAccountName
                                let chargeMoney = self.inputMoneyUI.text!
                                
                                self.inputMoneyUI.text = ""
                                self.secondInputUI.text = ""
                                
                                if self.selectPayType == PAY_METHOD_ONLINE{
                                    let onlinePay = self.payMethodResult.online[self.selectPosition]
                                    let payMethodName = onlinePay.payName
                                    let payJson = onlinePay.toJSONString()
                                    //跳到订单支付确认页
                                    self.openConfirmPayController(orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: "", receiveAccount: "", dipositor: "", dipositorAccount: "", qrcodeUrl: "", payType: self.selectPayType, payJson: payJson!)
                                    
                                }else if self.selectPayType == PAY_METHOD_FAST{
                                    let fastPay = self.payMethodResult.fast[self.selectPosition]
                                    let payMethodName = fastPay.payName
                                    let dipositorAccount = self.secondInputUI.text!
                                    //跳到订单支付确认页
                                    self.openConfirmPayController(orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: "", receiveAccount: "", dipositor: "", dipositorAccount: dipositorAccount, qrcodeUrl: fastPay.qrCodeImg, payType: self.selectPayType, payJson: "")
                                }else if self.selectPayType == PAY_METHOD_BANK{
                                    let bankPay = self.payMethodResult.bank[self.selectPosition]
                                    let payMethodName = bankPay.payName
                                    let receiveName = bankPay.receiveName
                                    let receiveAccount = bankPay.bankCard
                                    let dipositor = self.secondInputUI.text!
                                    //跳到订单支付确认页
                                    self.openConfirmPayController(orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: receiveName, receiveAccount: receiveAccount, dipositor: dipositor, dipositorAccount: "", qrcodeUrl: "", payType: self.selectPayType, payJson: "")
                                }
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "提交失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func openConfirmPayController(orderNo:String,accountName:String,chargeMoney:String,
                                  payMethodName:String, receiveName:String,receiveAccount:String,dipositor:String,dipositorAccount:String,qrcodeUrl:String,payType:Int,payJson:String) -> Void {
        if self.navigationController != nil{
            openConfirmPay(controller: self, orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: receiveName, receiveAccount: receiveAccount, dipositor: dipositor, dipositorAccount: dipositorAccount, qrcodeUrl: qrcodeUrl, payType: payType, payJson: payJson)
        }
    }
    
    //更换支付方式事件
    func onPayMethodChange() -> Void {
        var showWindow = true
        if self.payMethodResult != nil{
            if self.payMethodResult.fast.isEmpty && self.payMethodResult.online.isEmpty &&
                self.payMethodResult.bank.isEmpty{
                showWindow = false
            }
            if !showWindow{
                showToast(view: self.view, txt: "没有可以选择的支付方式，请联系客服")
                return
            }
        }
        showPayMethodWindow()
    }
    
    func onCopyAccountNumber() -> Void {
        var json = ""
        if selectPayType == PAY_METHOD_FAST{
        if self.payMethodResult.fast.isEmpty{
                return
            }
            let fastPay = self.payMethodResult.fast[self.selectPosition]
            json = fastPay.toJSONString()!
            self.selectPayType = PAY_METHOD_FAST
        }else if selectPayType == PAY_METHOD_BANK{
            if self.payMethodResult.bank.isEmpty{
                return
            }
            let bankPay = self.payMethodResult.bank[self.selectPosition]
            json = bankPay.toJSONString()!
            self.selectPayType = PAY_METHOD_BANK;
        }
        
        if isEmptyString(str: json){
            return
        }
        if selectPayType == PAY_METHOD_FAST{
            let fastPay = JSONDeserializer<FastPay>.deserializeFrom(json: json)
            if let value = fastPay{
                if !isEmptyString(str: value.receiveAccount){
                    UIPasteboard.general.string = value.receiveAccount
                    showToast(view: self.view, txt: "复制帐号成功")
                }else{
                    showToast(view: self.view, txt: "没有帐号 无法复制")
                }
            }
        }else if selectPayType == PAY_METHOD_BANK{
            let bankPay = JSONDeserializer<BankPay>.deserializeFrom(json: json)
            if let value = bankPay{
                if !isEmptyString(str: value.bankCard){
                    UIPasteboard.general.string = value.bankCard
                    showToast(view: self.view, txt: "复制帐号成功")
                }else{
                    showToast(view: self.view, txt: "没有帐号 无法复制")
                }
            }
        }
    }
    
    func showPayMethodWindow() -> Void {
        if payMethodWindow == nil{
            payMethodWindow = Bundle.main.loadNibNamed("pay_method_window", owner: nil, options: nil)?.first as! PayMethodWindow
            payMethodWindow.delegate = self
        }
        if payMethodResult != nil{
            payMethodWindow.setData(order: payMethodResult, selectPay: selectPayType, selectPosition: selectPosition)
            payMethodWindow.show()
        }
    }
    
    func onPayMethod(selectPay: Int, selectPos: Int) {
        selectPayType = selectPay
        selectPosition = selectPos
        updatePayInfo(type: selectPayType)
    }
    
    
}
