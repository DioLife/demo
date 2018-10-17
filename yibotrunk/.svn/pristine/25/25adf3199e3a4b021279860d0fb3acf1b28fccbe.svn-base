//
//  ScoreExchangeController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//积分兑换
class ScoreExchangeController: BaseController ,UITextFieldDelegate{
    
    @ IBOutlet weak var headerImg:UIImageView!
    @ IBOutlet weak var accountNameUI:UILabel!
    @ IBOutlet weak var accountBalanceUI:UILabel!
    @ IBOutlet weak var scoreUI:UILabel!
    @ IBOutlet weak var currentExchangeUI:UILabel!
    @ IBOutlet weak var changeMethodBtn:UIButton!
    @ IBOutlet weak var inputMoneyView:UIView!
    @ IBOutlet weak var inputMoneyTipUI:UILabel!
    @ IBOutlet weak var inputMoneyUI:CustomFeildText!
    @ IBOutlet weak var commitBtn:UIButton!
    @ IBOutlet weak var currentExchangeMethodUIHeightConstaint:NSLayoutConstraint!
    
    var configs:[ExchangeConfig] = []
    var typeid = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeMethodBtn.addTarget(self, action: #selector(onMethodChange), for: UIControlEvents.touchUpInside)
        commitBtn.addTarget(self, action: #selector(onCommitClick), for: UIControlEvents.touchUpInside)
        inputMoneyUI.delegate = self
        commitBtn.layer.cornerRadius = 22.5
        
        self.navigationItem.title = "积分兑换"
        self.title = "积分兑换"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        //        当键盘弹起的时候会向系统发出一个通知，
        //        这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        syncAccount()
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
                                self.syncExchangeMethod()
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
    
    func syncExchangeMethod() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "获取配置中...",url:EXCHANGE_CONFIG_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if !isEmptyString(str: resultJson){
                            showToast(view: self.view, txt: resultJson)
                        }else{
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }
                        return
                    }
                    if let result = ExchangeConfigResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let content = result.content{
                                self.scoreUI.text = String.init(format: "当前积分:%.1f", content.score)
                                if !content.configs.isEmpty{
                                    self.configs.removeAll()
                                    self.configs = self.configs + content.configs
                                    if self.typeid == 0{
                                        self.updateExchangeInfoView(config: content.configs[0])
                                    }else{
                                        if !self.configs.isEmpty{
                                            for config in self.configs{
                                                if config.id == self.typeid{
                                                    self.updateExchangeInfoView(config: config)
                                                    break
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    self.currentExchangeUI.text = "兑换类型：暂无兑换类型"
//                                    self.changeMethodBtn.isHidden = true
                                    showToast(view: self.view, txt: "没有兑换类型，请在后台配置兑换类型后重试！")
                                }
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func updateExchangeInfoView(config:ExchangeConfig) -> Void {
        let type = config.type
        if type == 1{
             inputMoneyTipUI.text = String.init(format: "兑换额度(%.2f现金可兑换%.2f积分)", config.numerator,config.denominator)
            currentExchangeUI.text = "兑换类型：现金兑换积分"
        }else{
            inputMoneyTipUI.text = String.init(format: "兑换额度(%.2f积分可兑换%.2f现金)", config.numerator,config.denominator)
            currentExchangeUI.text = "兑换类型：积分兑换现金"
        }
        self.typeid = config.id
//        self.changeMethodBtn.isHidden = false
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var accountNameStr = ""
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.account){
            accountNameStr = memInfo.account
        }else{
            accountNameStr = "暂无名称"
        }
        accountNameUI.text = accountNameStr
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = String.init(format: "当前余额:%.2f", Double(memInfo.balance)!)
        }else{
            leftMoneyName = "0"
        }
        accountBalanceUI.text = String.init(format: "%@元",  leftMoneyName)
    }
    
    //更换exchange方式事件
    func onMethodChange() -> Void {
        showExchangeDialog()
    }
    
    func performExchange(position:Int,type:Int) -> Void {
        if self.configs.isEmpty{
            return
        }
        for index in 0...self.configs.count-1{
            let config = self.configs[index]
            if config.type == type{
                self.updateExchangeInfoView(config: configs[index])
                break
            }
        }
    }
    
    func showExchangeDialog() -> Void {
        let alert = UIAlertController.init(title: "兑换", message: nil, preferredStyle: .actionSheet)
        if !self.configs.isEmpty{
            for config in configs{
                let type = config.type
                if type == 1{
                    let action = UIAlertAction.init(title: "现金兑换积分", style: .default, handler: {(action:UIAlertAction) in
                        self.performExchange(position: 0,type:type)
                    })
                    alert.addAction(action)
                }else{
                    let action = UIAlertAction.init(title: "积分兑换现金", style: .default, handler: {(action:UIAlertAction) in
                        self.performExchange(position: 0,type:type)
                    })
                    alert.addAction(action)
                }
            }
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    //确定提交订单
    func onCommitClick() -> Void {
        let moneyValue = inputMoneyUI.text!
        if isEmptyString(str: moneyValue){
            showToast(view: self.view, txt: "请输入金额或积分")
            return
        }
        if !isPurnInt(string: moneyValue){
            showToast(view: self.view, txt: "金额须为整数")
            return
        }
        postExchange(typeid: self.typeid, amount: moneyValue)
    }
    
    func postExchange(typeid:Int,amount:String) -> Void {
        request(frontDialog: true,method: .post,loadTextStr: "兑换中...",url:EXCHANGE_URL,
                params: ["typeId":self.typeid,"amount":amount],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if !isEmptyString(str: resultJson){
                            showToast(view: self.view, txt: resultJson)
                        }else{
                            showToast(view: self.view, txt: convertString(string: "兑换失败"))
                        }
                        return
                    }
                    if let result = ExchangeWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            showToast(view: self.view, txt: "兑换成功")
                            self.syncAccount()
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "兑换失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
}
