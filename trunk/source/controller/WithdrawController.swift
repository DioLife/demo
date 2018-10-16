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
   
    

    @IBAction func editPersonalInfo() {
        self.navigationController?.pushViewController(UserInfoController(), animated: true)
    }
    @IBOutlet weak var remainWithdrawTimes: UILabel!
    @IBOutlet weak var lowerLimit: UILabel!
    @IBOutlet weak var upperLimit: UILabel!
    @IBOutlet weak var needBettingAmount: UILabel!
    @IBOutlet weak var currentCodeAmount: UILabel!
    @ IBOutlet weak var headerImg:UIImageView!
    @IBOutlet weak var headerBgImage: UIImageView!
    @ IBOutlet weak var accountNameUI:UILabel!
    @ IBOutlet weak var accountBalanceUI:UILabel!
    @ IBOutlet weak var bankUI:UILabel!
    @ IBOutlet weak var unUseTipUI:UILabel!
//    @ IBOutlet weak var unUseTipHeightConstaint:NSLayoutConstraint!
    
    @ IBOutlet weak var inputArea:UIView!
    @ IBOutlet weak var inputMoneyUI:CustomFeildText!
    @ IBOutlet weak var inputPwdUI:CustomFeildText!
    @ IBOutlet weak var commitBtn:UIButton!
    
    @IBOutlet weak var withdrawTimeLable: UILabel!
    
//    @ IBOutlet weak var drawTipUI:UITextView!
    
    var meminfo:Meminfo?
    var firstBankInfo:BankList?
    var pickBankAccount:PickBankAccount?

    @IBAction func viewAcountChange() { self.navigationController?.pushViewController(AccountChangeController(), animated: true)
    }
    
    @objc private func getBankListModelNoti(noti: Notification) {
        if let model = noti.object as? BankCardListContent {
            let num = model.cardNo
            bankUI.text = num
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountNameUI.text = "没有名称"
        if let meminfo = self.meminfo{
            accountBalanceUI.text = "帐户余额:\(meminfo.balance)"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(getBankListModelNoti), name: NSNotification.Name(rawValue: "getBankListModelNoti"), object: nil)
        headerBgImage.theme_image = "General.personalHeaderBg"
        headerImg.theme_image = "General.placeHeader"
        commitBtn.addTarget(self, action: #selector(onCommitClick), for: UIControlEvents.touchUpInside)
        inputMoneyUI.delegate = self
        inputPwdUI.delegate = self
        commitBtn.layer.cornerRadius = 3.0
        commitBtn.theme_backgroundColor = "Global.themeColor"
        commitBtn.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapBankLabel))
        bankUI.isUserInteractionEnabled = true
        bankUI.addGestureRecognizer(tapGesture)
        
        self.navigationItem.title = "提款"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "提款记录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onWithdrawRecordClick))
        
        checkAccountFromWeb()
    }
    
    private func getTimesToWithDraw() -> Int{
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                if let timesToWithDraw = config.content.withdraw_time_one_day {
                    return timesToWithDraw
                }
            }
        }
        
        return 1
    }
    
   @objc private func tapBankLabel() {
        showSelectedView()
    }
    
    private func showSelectedView() {
        
//        if let array = pickBankAccount?.bankList {
//
//            if let pwd = pickBankAccount?.receiptPwd {
//                if isEmptyString(str: pwd){
//                    //跳到设置提款密码界面
//                    self.actionBankPwdSetting(delegate: self)
//                    return
//                }
//            }
//
//            if array.isEmpty{
//                if let value = pickBankAccount {
//                    let json = value.toJSONString()
//                    if let jsonValue = json{
//                        self.actionBankSetting(delegate: self,json:jsonValue)
//                    }
//                }
//                return
//            }
        
        if let model  = pickBankAccount {
            if !setupByBankRequest(content: model) {
                return
            }
        }
        
        if let array = pickBankAccount?.bankList {
            var namesArray = [String]()
            for index in 0..<array.count {
                let noSc = String.init(format: "%@(%@)", array[index].cardNoSc ,array[index].bankName)
                namesArray.append(noSc)
            }

            let selectedView = LennySelectView(dataSource: namesArray, viewTitle: "银行卡列表")
            selectedView.didSelected = { [weak self, selectedView] (index, content) in
                self?.bankUI.text = String.init(format: "%@(%@)", array[index].cardNoSc ,array[index].bankName)
            }
            view.window?.addSubview(selectedView)
            selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        }
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
                            
                            if let content = result.content{
                                if self.setupByBankRequest(content: content) {}
                            }
                            
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
    
    
    private func setupByBankRequest(content: PickBankAccount) -> Bool{
            self.pickBankAccount = content
            self.updateValues(data: content)
            //银行帐户等信息检查通过后获取提款配置信息
            if let pwd = content.receiptPwd{
                if isEmptyString(str: pwd){
                    //跳到设置提款密码界面
                    self.actionBankPwdSetting(delegate: self)
                    return false
                }
            }
            if let banklist = content.bankList{
                if banklist.isEmpty{
                        let json = content.toJSONString()
                        if let jsonValue = json{
                            self.actionBankSetting(delegate: self,json:jsonValue)
                            return false
                        }
                    return false
                }else{
                    self.firstBankInfo = banklist[0]
                }
            }
        
        return true
    }
    
    @IBAction func onHeaderEmptyViewClick(){
        inputMoneyUI.resignFirstResponder()
        inputPwdUI.resignFirstResponder()
    }
    
    func updateValues(data:PickBankAccount) -> Void {
        if let meminfo = self.meminfo{
            accountBalanceUI.text = String.init(format: "帐户余额:%@元", meminfo.balance)
        }
        
        if let bank = data.bankList{
            if !bank.isEmpty{
                bankUI.text = String.init(format: "%@(%@)", bank[0].cardNoSc ,bank[0].bankName)
                accountNameUI.text = String.init(format: "%@",bank[0].realName)
            }
        }
        
        if let everydayDrawTimes = Int((data.everydayDrawTimes)!) {
            if getTimesToWithDraw() <= 0 {
                remainWithdrawTimes.text = "每日无限次提现次数"
            }else {
                let remainTimes = everydayDrawTimes - data.dayTimes
                remainWithdrawTimes.text = "每日提现次数剩余:\(remainTimes)次"
            }
        }else {
            remainWithdrawTimes.text = "每日提现次数剩余: 次"
        }
        
//        var tipContent = ""
//        tipContent = tipContent + "提示信息:\n\n"
////        tipContent = tipContent + String.init(format: "每天的提示处理时间为:%@至%@;", data.startTime,data.endTime)
//        tipContent = tipContent + String.init(format: "每天的提示处理时间为:%@至%@;", data.minDrawTime!,data.maxDrawTime!)
//        tipContent = tipContent + "\n"
//        tipContent = tipContent + "取款1-3分钟内到账。(如遇高峰期，可能需要延迟到5-10分钟内到帐);"
//        tipContent = tipContent + String.init(format: "用户每日最小提现 %@元,最大提现 %@元", data.minDrawMoney!,data.maxDrawMoney!)
        if let maxDrawMoney = data.maxDrawMoney {
            upperLimit.text = maxDrawMoney
        }
        if let minDrawMoney = data.minDrawMoney {
            lowerLimit.text = minDrawMoney
        }
        if let needBettingAmountStr = data.bet?.drawNeed {
            needBettingAmount.text = "\(needBettingAmountStr)"
        }
        if let currentBettingNum = data.bet?.betNum {
            currentCodeAmount.text = "\(currentBettingNum)"
        }
        
        var withdrawTime = ""
        if let withdrawMinTime  = data.minDrawTime {
            withdrawTime += withdrawMinTime
            if let withdrawMaxTime = data.maxDrawTime {
                withdrawTime += "--" + withdrawMaxTime
            }
        }
        
        withdrawTimeLable.text = withdrawTime
        
        
        /////////////////
       
//        if  (data.bet?.betNum)! >= (data.bet?.drawNeed)! {
//            commitBtn.backgroundColor = .red
//            commitBtn.isUserInteractionEnabled = true
//        }else {
//            commitBtn.backgroundColor = .gray
//            commitBtn.isUserInteractionEnabled = false
//            showToast(view: self.view, txt: "未达到提现要求")
//        }
        

//        tipContent = tipContent + "\n"
//        tipContent = tipContent + String.init(format: "今日可取款%@次，已取款%d次", data.everydayDrawTimes! == "0" ? "无限" : data.everydayDrawTimes!,data.dayTimes)
//        tipContent = tipContent + "\n"
//
//        if let bet = data.bet{
//            tipContent = tipContent + "消费比例:\n\n"
//            tipContent = tipContent + String.init(format: "出款需达投注量:%d", bet.drawNeed)
//            tipContent = tipContent + "\n"
//        }
        
//        drawTipUI.text = tipContent
        
        //显示赋值是否可提款
//        if !data.enablePick{
//            unUseTipUI.isHidden = false
//            unUseTipHeightConstaint.constant = 20
//            if data.drawFlag != "是"{
//                unUseTipUI.text = data.drawFlag
//                commitBtn.isEnabled = false
//                commitBtn.backgroundColor = UIColor.lightGray
//            }else{
//                unUseTipUI.text = ""
//                commitBtn.isEnabled = true
//                commitBtn.backgroundColor = UIColor.red
//            }
//        }else{
//            unUseTipUI.isHidden = true
//            unUseTipHeightConstaint.constant = 0
//            commitBtn.isEnabled = true
//            commitBtn.backgroundColor = UIColor.red
//        }
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
    
    @objc func onWithdrawRecordClick() -> Void {
//        openAccountMingxi(controller: self, whichPage: 1)
        let vc = TopupAndWithdrawRecords()
        vc.current_index = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onCommitClick() -> Void {
        
        if self.firstBankInfo == nil{
            showToast(view: self.view, txt: "未获取到银行卡信息,请先绑定银行卡")
            return
        }
        
        
        if let data = pickBankAccount {
            if let everydayDrawTimes = Int((data.everydayDrawTimes)!) {
                
                let remainTimes = everydayDrawTimes - data.dayTimes
                if remainTimes <= 0 && getTimesToWithDraw() > 0{
                    showToast(view: self.view, txt: "剩余提现次数为 0")
                    return
                }
            }
            
            let timeMin = data.minDrawTime
            let timeMax = data.maxDrawTime
            let timeNow = getTimeWithDate(date: Date(),dateFormat: "HH:mm")
            
            if timeNow.compare(timeMin!).rawValue < 0 || timeNow.compare(timeMax!).rawValue > 0 {
                showToast(view: self.view, txt: "不在提款时间段内，无法提款！")
                return
            }

            let moneyStr = inputMoneyUI.text!
            
            if let moneyNum = Float(moneyStr) {
                if let maxDrawMoney = Float((pickBankAccount?.maxDrawMoney)!) {
                    if moneyNum > maxDrawMoney {
                        showToast(view: self.view, txt: "提现金额不得大于: \(maxDrawMoney)")
                        return
                    }
                }
                
                if let minDrawMoney = Float((pickBankAccount?.minDrawMoney)!) {
                    if moneyNum < minDrawMoney {
                        showToast(view: self.view, txt: "提现金额不得小于: \(minDrawMoney)")
                        return
                    }
                }
            }
            
            let pwdStr = inputPwdUI.text!
            if isEmptyString(str: moneyStr){
                showToast(view: self.view, txt: "请输入取款金额")
                return
            }
            if isEmptyString(str: pwdStr){
                showToast(view: self.view, txt: "请输入取款密码")
                return
            }
            onPostPickMoney(money: moneyStr, bankid: (self.firstBankInfo?.id)!, pwd: pwdStr)
            
        }
    }
    
    func onPostPickMoney(money:String,bankid:String,pwd:String) -> Void {
        request(frontDialog: true,method: .post, loadTextStr:"正在提交...",url: POST_PICK_MONEY_URL,params: ["amount":money,"bankId":bankid,"pwd":pwd],
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
