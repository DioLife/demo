//
//  ChargeClassicPageController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class ChargeClassicPageController: BaseController {
    
    @IBOutlet weak var tableView:UITableView!
    var onlines:[OnlinePay] = []
    var fastPays:[FastPay] = []
    var offlines:[BankPay] = []
    
    var nameUI:UILabel!
    var balanceUI:UILabel!
    var accountName = ""
    var accountBalance = ""
    
    var payWindow:OnlinePayInputWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "充值"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.tableHeaderView = headerView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "充值记录", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onChargeRecordClick))
        syncAccount()
    }
    
    func onChargeRecordClick() -> Void {
        openAccountMingxi(controller: self, whichPage: 0)
    }

}


extension ChargeClassicPageController{
    
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
                                self.updateSources(result: payMethods)
                                self.tableView.reloadData()
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
    
    func updateSources(result:PayMethodResult?){
        if let pay = result{
            self.onlines = pay.online
            self.fastPays = pay.fast
            self.offlines = pay.bank
        }
    }
    
    func paySection() -> Int{
        var section = 0
        if !self.onlines.isEmpty{
            section = section + 1
        }
        if !self.fastPays.isEmpty{
            section = section + 1
        }
        if !self.offlines.isEmpty{
            section = section + 1
        }
        return section
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var accountNameStr = ""
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.account){
            accountNameStr = memInfo.account
        }else{
            accountNameStr = "暂无名称"
        }
        accountName = accountNameStr
        nameUI.text = accountNameStr
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = String.init(format: "当前余额:%.2f元", Double(memInfo.balance)!)
        }else{
            leftMoneyName = "0元"
        }
        self.accountBalance = leftMoneyName
        balanceUI.text = String.init(format: "%@",  leftMoneyName)
    }
    
    func headerView() -> UIView{
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 100))
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 100))
        bg.image = UIImage.init(named: "member_page_header")
        header.addSubview(bg)
        
        let icon = UIImageView.init(frame: CGRect.init(x: 20, y: 10, width: 60, height: 60))
        icon.image = UIImage.init(named: "charge_default_header")
        header.addSubview(icon)
        nameUI = UILabel.init(frame: CGRect.init(x: 90, y: 20, width: kScreenWidth - 110, height: 30))
        nameUI.font = UIFont.systemFont(ofSize: 14)
        nameUI.textColor = UIColor.white
        header.addSubview(nameUI)
        
        balanceUI = UILabel.init(frame: CGRect.init(x: 90, y: 45, width: kScreenWidth - 110, height: 30))
        balanceUI.font = UIFont.systemFont(ofSize: 14)
        balanceUI.textColor = UIColor.white
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
    
    func showOnlineWindow(online:OnlinePay){
        if payWindow == nil{
            payWindow = Bundle.main.loadNibNamed("charge_money_input", owner: nil, options: nil)?.first as! OnlinePayInputWindow
        }
        payWindow.delegate = self
        payWindow.controller = self
        payWindow.setData(online: online)
        payWindow.show()
    }
    
    func gotoNextPage(fast:FastPay){
        let loginVC = UIStoryboard(name: "offline_charge_subpage", bundle: nil).instantiateViewController(withIdentifier: "subcharge")
        let recordPage = loginVC as! SubChargeController
        recordPage.fastPay = fast
        recordPage.isFastPay = true
        recordPage.account = self.accountName
        recordPage.balance = self.accountBalance
        self.navigationController?.pushViewController(recordPage, animated: true)
    }
    
    func gotoNextPage(bank:BankPay){
        let loginVC = UIStoryboard(name: "offline_charge_subpage", bundle: nil).instantiateViewController(withIdentifier: "subcharge")
        let recordPage = loginVC as! SubChargeController
        recordPage.bankPay = bank
        recordPage.isFastPay = false
        recordPage.account = self.accountName
        recordPage.balance = self.accountBalance
        self.navigationController?.pushViewController(recordPage, animated: true)
    }
    
    func openConfirmPayController(orderNo:String,accountName:String,chargeMoney:String,
                                  payMethodName:String, receiveName:String,receiveAccount:String,dipositor:String,dipositorAccount:String,qrcodeUrl:String,payType:Int,payJson:String) -> Void {
        if self.navigationController != nil{
            openConfirmPay(controller: self, orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: receiveName, receiveAccount: receiveAccount, dipositor: dipositor, dipositorAccount: dipositorAccount, qrcodeUrl: qrcodeUrl, payType: payType, payJson: payJson)
        }
    }
    
}

extension ChargeClassicPageController: OnlinePayDelegate{

    func onPayClick(money:String,online:OnlinePay) {
        if isEmptyString(str: money){
            return
        }
        let payMethodName = online.payName
        let payJson = online.toJSONString()
        //跳到订单支付确认页
        openConfirmPayController(orderNo: "", accountName: self.accountName, chargeMoney: money, payMethodName: payMethodName, receiveName: "", receiveAccount: "", dipositor: "", dipositorAccount: "", qrcodeUrl: "", payType: PAY_METHOD_ONLINE, payJson: payJson!)
    }
}

extension ChargeClassicPageController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return paySection()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let total = paySection()
        let section = indexPath.section
        if total == 1{
            if !self.onlines.isEmpty && section == 0{
                self.showOnlineWindow(online: self.onlines[indexPath.row])
            }else if !self.fastPays.isEmpty && section == 0{
                gotoNextPage(fast: self.fastPays[indexPath.row])
            }else if !self.offlines.isEmpty && section == 0{
                gotoNextPage(bank: self.offlines[indexPath.row])
            }
        }else if total == 2{
            if !self.onlines.isEmpty && !self.fastPays.isEmpty{
                if section == 0{
                    showOnlineWindow(online: self.onlines[indexPath.row])
                }else if section == 1{
                    gotoNextPage(fast: self.fastPays[indexPath.row])
                }
            }else if !self.onlines.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    showOnlineWindow(online: self.onlines[indexPath.row])
                }else if section == 1{
                    gotoNextPage(bank: self.offlines[indexPath.row])
                }
            }else if !self.fastPays.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    gotoNextPage(fast: self.fastPays[indexPath.row])
                }else if section == 1{
                    gotoNextPage(bank: self.offlines[indexPath.row])
                }
            }
        }else if total == 3{
            if section == 0{
                showOnlineWindow(online: self.onlines[indexPath.row])
            }else if section == 1{
                gotoNextPage(fast: self.fastPays[indexPath.row])
            }else if section == 2{
                gotoNextPage(bank: self.offlines[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //如果数组中包含当前的section则返回数据源中当前section的数组大小，否则返回零
        let total = paySection()
        if total == 1{
            if !self.onlines.isEmpty && section == 0{
                return self.onlines.count
            }else if !self.fastPays.isEmpty && section == 0{
                return self.fastPays.count
            }else if !self.offlines.isEmpty && section == 0{
                return self.offlines.count
            }
        }else if total == 2{
            if !self.onlines.isEmpty && !self.fastPays.isEmpty{
                if section == 0{
                    return self.onlines.count
                }else if section == 1{
                    return self.fastPays.count
                }
            }else if !self.onlines.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    return self.onlines.count
                }else if section == 1{
                    return self.offlines.count
                }
            }else if !self.fastPays.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    return self.fastPays.count
                }else if section == 1{
                    return self.offlines.count
                }
            }
        }else if total == 3{
            if section == 0{
                return self.onlines.count
            }else if section == 1{
                return self.fastPays.count
            }else if section == 2{
                return self.offlines.count
            }
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "classicCell") as? ClassicPayCell  else {
            fatalError("The dequeued cell is not an instance of classicCell.")
        }
        let total = paySection()
        let section = indexPath.section
        if total == 1{
            if !self.onlines.isEmpty && section == 0{
                cell.setData(online: self.onlines[indexPath.row])
            }else if !self.fastPays.isEmpty && section == 0{
                cell.setData(fast: self.fastPays[indexPath.row])
            }else if !self.offlines.isEmpty && section == 0{
                cell.setData(bank: self.offlines[indexPath.row])
            }
        }else if total == 2{
            if !self.onlines.isEmpty && !self.fastPays.isEmpty{
                if section == 0{
                    cell.setData(online: self.onlines[indexPath.row])
                }else if section == 1{
                    cell.setData(fast: self.fastPays[indexPath.row])
                }
            }else if !self.onlines.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    cell.setData(online: self.onlines[indexPath.row])
                }else if section == 1{
                    cell.setData(bank: self.offlines[indexPath.row])
                }
            }else if !self.fastPays.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    cell.setData(fast: self.fastPays[indexPath.row])
                }else if section == 1{
                    cell.setData(bank: self.offlines[indexPath.row])
                }
            }
        }else if total == 3{
            if section == 0{
                cell.setData(online: self.onlines[indexPath.row])
            }else if section == 1{
                cell.setData(fast: self.fastPays[indexPath.row])
            }else if section == 2{
                cell.setData(bank: self.offlines[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 40))
        let text = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: kScreenWidth, height: 20))
        header.addSubview(text)
        let total = paySection()
        if total == 1{
            if !self.onlines.isEmpty && section == 0{
                text.text = "线上充值"
            }else if !self.fastPays.isEmpty && section == 0{
                text.text = "快速充值"
            }else if !self.offlines.isEmpty && section == 0{
                text.text = "线下充值"
            }
        }else if total == 2{
            if !self.onlines.isEmpty && !self.fastPays.isEmpty{
                if section == 0{
                    text.text = "线上充值"
                }else if section == 1{
                    text.text = "快速充值"
                }
            }else if !self.onlines.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    text.text = "线上充值"
                }else if section == 1{
                    text.text = "线下充值"
                }
            }else if !self.fastPays.isEmpty && !self.offlines.isEmpty{
                if section == 0{
                    text.text = "快速充值"
                }else if section == 1{
                    text.text = "线下充值"
                }
            }
        }else if total == 3{
            if section == 0{
                text.text = "线上充值"
            }else if section == 1{
                text.text = "快速充值"
            }else if section == 2{
                text.text = "线下充值"
            }
        }
        header.backgroundColor = UIColor.init(hex: 0xF5F5F5)
        return header
    }
    
}
