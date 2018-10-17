//
//  WithdrawController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/31.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

protocol BankDelegate {
    func onBankSetting()
}

import UIKit
//取款界面
class WithdrawController: BaseController,UITextFieldDelegate,BankDelegate {
   
    @ IBOutlet weak var headerView:UIView!
    @ IBOutlet weak var headerImg:UIImageView!
    @ IBOutlet weak var accountNameUI:UILabel!
    @ IBOutlet weak var accountBalanceUI:UILabel!
    @ IBOutlet weak var bankUI:UILabel!
//    @ IBOutlet weak var unUseTipUI:UILabel!
//    @ IBOutlet weak var unUseTipHeightConstaint:NSLayoutConstraint!
    
    
    @ IBOutlet weak var inputArea:UIView!
    @ IBOutlet weak var inputMoneyUI:CustomFeildText!
    @ IBOutlet weak var inputPwdUI:CustomFeildText!
    @ IBOutlet weak var commitBtn:UIButton!
    
    @ IBOutlet weak var drawTipUI:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitBtn.addTarget(self, action: #selector(onCommitClick), for: UIControlEvents.touchUpInside)
        inputMoneyUI.delegate = self
        inputPwdUI.delegate = self
        commitBtn.layer.cornerRadius = 22.5
        
        self.navigationItem.title = "提款"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "提款记录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onWithdrawRecordClick))
        
        //        当键盘弹起的时候会向系统发出一个通知，
        //        这个时候需要注册一个监听器响应该通知
        popHeight = Int(kScreenHeight/5)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        headerView.isUserInteractionEnabled = true
        headerView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onHeaderClick)))
        
        checkAccountFromWeb()
    }
    
    @objc func onHeaderClick(){
        openUserCenter(controller: self)
    }
    
    func checkAccountFromWeb() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "正在检查帐号...",url:CHECK_PICK_MONEY_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if !isEmptyString(str: resultJson){
                            showToast(view: self.view, txt: resultJson)
                        }else{
                            showToast(view: self.view, txt: convertString(string: "检查提款帐户安全失败"))
                        }
                        return
                    }
                    if let result = CheckPickAccountWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            //银行帐户等信息检查通过后获取提款配置信息
                            if result.code == 121{
                                showToast(view: self.view, txt: result.msg)
                                //跳到设置提款密码界面
                                self.actionBankPwdSetting(delegate: self)
                                return
                            }
                            if result.code == 122 {
                                showToast(view: self.view, txt: result.msg)
                                //跳到设置银行相关信息界面，设置银行信息
                                if let value = result.content{
                                    let json = value.toJSONString()
                                    if let jsonValue = json{
                                        self.actionBankSetting(delegate: self,json:jsonValue)
                                    }
                                }
                                return
                            }
                            self.pickDataFromWeb()
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "检查提款帐户安全失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    @IBAction func onHeaderEmptyViewClick(){
        inputMoneyUI.resignFirstResponder()
        inputPwdUI.resignFirstResponder()
    }
    
    func pickDataFromWeb() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "获取提款配置中...",url:PICK_MONEY_DATA_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if !isEmptyString(str: resultJson){
                            showToast(view: self.view, txt: resultJson)
                        }else{
                            showToast(view: self.view, txt: convertString(string: "同步提款信息失败"))
                        }
                        return
                    }
                    if let result = PickMoneyDaraWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let content = result.content{
                                self.updateValues(data: content)
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "同步提款信息失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func updateValues(data:PickMoneyData) -> Void {
        accountNameUI.text = String.init(format: "用户名:%@", data.userName)
        accountBalanceUI.text = String.init(format: "帐户余额:%.2f元", data.accountBalance)
        bankUI.text = String.init(format: "银行帐号:%@(%@)", data.cardNo,data.bankName)
        var tipContent = ""
        tipContent = tipContent + "提示信息:\n\n"
//        tipContent = tipContent + String.init(format: "每天的提示处理时间为:%@至%@;", data.startTime,data.endTime)
        tipContent = tipContent + String.init(format: "每天的提款处理时间为:%@至%@;", data.startTime,data.endTime)
        tipContent = tipContent + "\n"
        tipContent = tipContent + "取款1-3分钟内到账。(如遇高峰期，可能需要延迟到5-10分钟内到帐);"
        tipContent = tipContent + "\n"
        tipContent = tipContent + String.init(format: "用户每日最小提现 %@元,最大提现 %@元", data.minPickMoney,data.maxPickMoney)
        tipContent = tipContent + "\n"
        tipContent = tipContent + String.init(format: "今日可取款%@次，已取款%d次", data.wnum == -1 ? "不限" : String(data.wnum),data.curWnum)
        tipContent = tipContent + "\n"
        tipContent = tipContent + String.init(format: "是否能提款：%@", data.enablePick ? "是" : "否")
        tipContent = tipContent + "\n\n"
        tipContent = tipContent + "消费比例:\n"
        tipContent = tipContent + String.init(format: "出款需达投注量:%@,有效投注金额%.2f元", data.checkBetNum == -1 ? "无限" : String(data.checkBetNum),data.validBetMoney)
        tipContent = tipContent + "\n"
        drawTipUI.text = tipContent
        
        //显示赋值是否可提款
        if !data.enablePick{
//            unUseTipUI.isHidden = false
//            unUseTipHeightConstaint.constant = 20
            if data.drawFlag != "是"{
//                unUseTipUI.text = data.drawFlag
                commitBtn.isEnabled = false
                commitBtn.backgroundColor = UIColor.lightGray
            }else{
//                unUseTipUI.text = ""
                commitBtn.isEnabled = true
                commitBtn.backgroundColor = UIColor.red
            }
        }else{
//            unUseTipUI.isHidden = true
//            unUseTipHeightConstaint.constant = 0
            commitBtn.isEnabled = true
            commitBtn.backgroundColor = UIColor.red
        }
    }
    
    //打开银行取款密码设置
    func actionBankPwdSetting(delegate:BankDelegate){
        openBankPwdSetting(controller: self,delegate:delegate)
    }
    
    //打开银行信息设置
    func actionBankSetting(delegate:BankDelegate,json:String){
        openBankSetting(controller: self,delegate:delegate,json:json)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func onWithdrawRecordClick() -> Void {
        openAccountMingxi(controller: self, whichPage: 1)
    }
    
    func onCommitClick() -> Void {
        let moneyStr = inputMoneyUI.text!
        let pwdStr = inputPwdUI.text!
        if isEmptyString(str: moneyStr){
            showToast(view: self.view, txt: "请输入取款金额")
            return
        }
        if isEmptyString(str: pwdStr){
            showToast(view: self.view, txt: "请输入取款密码")
            return
        }
        onPostPickMoney(money: moneyStr, pwd: pwdStr)
    }
    
    func onPostPickMoney(money:String,pwd:String) -> Void {
        request(frontDialog: true,method: .post, loadTextStr:"正在提交...",url: POST_PICK_MONEY_URL,params: ["money":money,"repPwd":pwd],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "提交失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = PostPickMoneyWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            showToast(view: self.view, txt: "提交成功，请等待订单处理完成")
                            self.inputMoneyUI.text = ""
                            self.inputPwdUI.text = ""
                            //提现请求成功后，关闭界面
//                            self.onBackClick()
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "提交失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    //银行取款密码设置，或出款银行设置完后
    func onBankSetting() {
        checkAccountFromWeb()
    }
    

}
