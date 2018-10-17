//
//  SubChargeController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class SubChargeController: BaseController {
    
    @IBOutlet weak var tableView:UITableView!
    var isFastPay = true
    var fastPay:FastPay?
    var bankPay:BankPay?
    
    var account = ""
    var balance = ""
    
    var nameUI:UILabel!
    var balanceUI:UILabel!
    var datas:[ChargPayBean] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "支付信息"
        
        //当键盘弹起的时候会向系统发出一个通知，
        //这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = headerView()
        tableView.tableFooterView = self.footView()
        if isFastPay{
            self.datas = getFakeModels(fast: fastPay)
        }else{
            self.datas = getFakeModels(bank: bankPay)
        }
        self.tableView.reloadData()
    }

    
    func getFakeModels(fast:FastPay?) -> [ChargPayBean]{
        var list:[ChargPayBean] = []
        if let pay = fast{
            let name = ChargPayBean()
            name.title = "收款姓名"
            name.content = pay.receiveName
            list.append(name)
            
            let account = ChargPayBean()
            account.title = "收款账号"
            account.content = pay.receiveAccount
            list.append(account)
            
            if !isEmptyString(str: pay.qrCodeImg){
                let qrcode = ChargPayBean()
                qrcode.imgUrl = pay.qrCodeImg
                list.append(qrcode)
            }
            
            let inputMoney = ChargPayBean()
            inputMoney.title = "充值金额"
            inputMoney.code = "money"
            inputMoney.input = true
            list.append(inputMoney)
            
            let label = ChargPayBean()
            label.title = String.init(format: "%@:", !isEmptyString(str: pay.frontLabel) ? pay.frontLabel : "我的账号:")
            label.input = true
            label.code = "depositor"
            list.append(label)
            
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    let c = config.content.remark_field_switch
                    if c == "on"{
                        let remark = ChargPayBean()
                        remark.title = "转账备注"
                        remark.code = "remark"
                        remark.input = true
                        list.append(remark)
                    }
                }
            }
        }
        return list
    }
    
    func getFakeModels(bank:BankPay?) -> [ChargPayBean]{
        var list:[ChargPayBean] = []
        if let pay = bank{
            let name = ChargPayBean()
            name.title = "充值银行"
            name.content = pay.payBankName
            list.append(name)
            
            let account = ChargPayBean()
            account.title = "收款姓名"
            account.content = pay.receiveName
            list.append(account)
            
            let accoutName = ChargPayBean()
            accoutName.title = "收款账号"
            accoutName.content = pay.bankCard
            list.append(accoutName)
            
            let bankAddress = ChargPayBean()
            bankAddress.title = "开户网点"
            bankAddress.content = pay.bankAddress
            list.append(bankAddress)
            
            let inputMoney = ChargPayBean()
            inputMoney.title = "充值金额"
            inputMoney.holderText = "请输入金额"
            inputMoney.code = "money"
            inputMoney.input = true
            list.append(inputMoney)
            
            let label = ChargPayBean()
            label.title = "存款人姓名"
            label.input = true
            label.holderText = "请填写真实姓名"
            label.code = "depositor"
            list.append(label)
            
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    let c = config.content.remark_field_switch
                    if c == "on"{
                        let remark = ChargPayBean()
                        remark.title = "转账备注"
                        remark.code = "remark"
                        remark.input = true
                        list.append(remark)
                    }
                }
            }
        }
        return list
    }
    
    func footView() -> UIView{
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 170))
        let tip = UITextView.init(frame: CGRect.init(x: 15, y: 0, width: kScreenWidth - 30, height: 100))
        var tipText = ""
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                if isFastPay{
                    if !isEmptyString(str: config.content.pay_tips_deposit_fast){
                        tipText = tipText + config.content.pay_tips_deposit_fast
                    }
                }else{
                    if !isEmptyString(str: config.content.pay_tips_deposit_general){
                        tipText = tipText + config.content.pay_tips_deposit_general
                    }
                }
            }
        }
        tip.text = tipText
//        tip.lineBreakMode = .byWordWrapping
        tip.textColor = UIColor.red
        tip.font = UIFont.systemFont(ofSize: 14)
//        tip.numberOfLines = 4
        footer.addSubview(tip)
        let confirmbtn = UIButton.init(frame: CGRect.init(x: 15, y: 110, width: kScreenWidth - 30, height: 40))
        confirmbtn.backgroundColor = UIColor.red
        confirmbtn.layer.cornerRadius = 5
        confirmbtn.setTitle("确认提交", for: .normal)
        confirmbtn.setTitleColor(UIColor.white, for: .normal)
        confirmbtn.addTarget(self, action: #selector(onCommitBtn(ui:)), for: .touchUpInside)
        footer.addSubview(confirmbtn)
        return footer
    }
    
    @objc func onCommitBtn(ui:UIButton){
        for item in self.datas{
            if item.input && isEmptyString(str: item.content){
                if item.code != "remark"{
                    showToast(view: self.view, txt: String.init(format: "请输入%@", item.title))
                    return
                }
            }
        }
        var money = ""
        var depositor = ""
        var remark = ""
        for item in self.datas{
            if item.input && !isEmptyString(str: item.content){
                if item.code == "money"{
                    money = item.content
                }else if item.code == "depositor"{
                    depositor = item.content
                }else if item.code == "remark"{
                    remark = item.content
                }
            }
        }
        actionSubmitPay(payType: isFastPay ? PAY_METHOD_FAST : PAY_METHOD_BANK,
                        money: money, depositor: depositor,remark: remark)
    }

    /**
     *
     * @param payType 充值方式
     * @param position 选择的充值方式位置
     * @param money 充值金额
     * @param depositor 充值人
     * @param account 充值附加信息如帐号
     */
    func actionSubmitPay(payType:Int,money:String,depositor:String,remark:String = "") -> Void {

        let url = SUBMIT_PAY_URL
        var params:Dictionary<String,AnyObject> = [:]
        params["payMethod"] = payType as AnyObject
        if payType == PAY_METHOD_FAST{
            params["money"] = money as AnyObject
            params["depositor"] = depositor as AnyObject
            params["account"] = self.account as AnyObject
            if let pay = self.fastPay{
                params["payId"] = pay.id as AnyObject
            }
        }else if payType == PAY_METHOD_BANK{
            params["money"] = money as AnyObject
            params["depositor"] = depositor as AnyObject
            if let pay = self.bankPay{
                params["bankId"] = pay.id as AnyObject
            }
        }
        params["remark"] = remark as AnyObject

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
                            self.navigationController?.popViewController(animated: true)
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

    
    func headerView() -> UIView{
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 100))
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 100))
        bg.image = UIImage.init(named: "member_page_header")
        header.addSubview(bg)
        
        let icon = UIImageView.init(frame: CGRect.init(x: 20, y: 20, width: 60, height: 60))
        icon.image = UIImage.init(named: "charge_default_header")
        header.addSubview(icon)
        let nameUI = UILabel.init(frame: CGRect.init(x: 90, y: 20, width: kScreenWidth - 110, height: 30))
        nameUI.font = UIFont.systemFont(ofSize: 14)
        nameUI.textColor = UIColor.white
        nameUI.text = self.account
        header.addSubview(nameUI)
        let balanceUI = UILabel.init(frame: CGRect.init(x: 90, y: 45, width: kScreenWidth - 110, height: 30))
        balanceUI.font = UIFont.systemFont(ofSize: 14)
        balanceUI.textColor = UIColor.white
        balanceUI.text = self.balance
        header.addSubview(balanceUI)
        let more = UIImageView.init(frame: CGRect.init(x: kScreenWidth - 40, y: 40, width: 20, height: 20))
        more.image = UIImage.init(named: "more")
        header.addSubview(more)
        header.isUserInteractionEnabled = true
        header.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onHeaderClick)))
        return header
    }
    
    @objc func onHeaderClick(){
        openUserCenter(controller: self)
    }
    
}

extension SubChargeController :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.datas[indexPath.row]
        if !isEmptyString(str: model.imgUrl){
            return 300
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.datas[indexPath.row]
        if !isEmptyString(str: model.imgUrl){
            let cell = tableView.dequeueReusableCell(withIdentifier: "imgeCell") as? SubChargeImageCell
            cell?.setupData(data: model,controller: self)
            cell?.selectionStyle = .none
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell") as? SubChargeCell
            cell?.inputUI.delegate = self
            cell?.inputUI.tag = indexPath.row
            cell?.copyBtn.tag = indexPath.row
            if indexPath.row == 2{
                cell?.inputUI.keyboardType = .numberPad
            }
            cell?.copyBtn.addTarget(self, action: #selector(onCopyBtn(ui:)), for: .touchUpInside)
            cell?.setupData(data: model)
            cell?.copyBtn.isHidden = false
            cell?.inputUI.addTarget(self, action: #selector(onInput(ui:)), for: .editingChanged)
            cell?.selectionStyle = .none
            return cell!
        }
    }
    
    @objc func onInput(ui:UITextField){
        let text = ui.text!
        self.datas[ui.tag].content = text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @objc func onCopyBtn(ui:UIButton){
        if self.datas.isEmpty{
            return
        }
        let data = self.datas[ui.tag]
        if !isEmptyString(str: data.content){
            UIPasteboard.general.string = data.content
            showToast(view: self.view, txt: "复制成功")
        }else{
            showToast(view: self.view, txt: "没有内容,无法复制")
        }
    }
    
    
}
