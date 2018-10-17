//
//  BankSettingController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import  HandyJSON

//出款银行信息设置
class BankSettingController: BaseController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableViewUI:UITableView!
    @IBOutlet weak var btnUI:UIButton!
    
    var datas:[Dictionary<String,String>] = []
    var dataJson = ""
    var delegate:BankDelegate?
    
    let USERNAME_ROW_INDEX = 0
    let BANKNAME_ROW_INDEX = 1
    let BANKADDRESS_ROW_INDEX = 2
    let BANKCARDNO_ROW_INDEX = 3
    let REPPWD_ROW_INDEX = 4
    
    var postPickPwd = false
    var isUsernameCanModify = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnUI.addTarget(self, action: #selector(onCommitClick), for: UIControlEvents.touchUpInside)
        tableViewUI.delegate = self
        tableViewUI.dataSource = self
        self.navigationItem.title = "银行设置"
        
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                isUsernameCanModify = config.content.draw_money_user_name_modify == "on"
            }
        }
        
        let bankObj = JSONDeserializer<PickBankAccount>.deserializeFrom(json: dataJson)
        if let bank = bankObj{
            let item1 = ["key":"持卡人姓名","value":bank.userName,"holder":"请输入持卡人姓名"]
            let item2 = ["key":"出款银行名称","value":bank.bankName,"holder":"请输入出款银行名称"]
            let item3 = ["key":"开户行网点","value":bank.bankAddress,"holder":"请输入开户行网点"]
            let item4 = ["key":"出款银行帐号","value":bank.cardNo,"holder":"请输入出款银行帐号"]
            datas.append(item1)
            datas.append(item2)
            datas.append(item3)
            datas.append(item4)
            if isEmptyString(str: bank.repPwd){
                postPickPwd = true
                let item5 = ["key":"取款密码","value":bank.repPwd]
                datas.append(item5)
            }
            self.tableViewUI.reloadData()
        }
        
        
    }
    
    @objc func onCommitClick() -> Void {
        postBank()
    }
    
    func postBank() -> Void {
        
        let usernameCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: USERNAME_ROW_INDEX, section: 0)) as! BankSettingCell
        let username = usernameCell.inputUI.text
        
        let bankNameCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: BANKNAME_ROW_INDEX, section: 0)) as! BankSettingCell
        let bankName = bankNameCell.inputUI.text
        
        let bankAddressCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: BANKADDRESS_ROW_INDEX, section: 0)) as! BankSettingCell
        let bankAddress = bankAddressCell.inputUI.text
        
        let bankCardNoCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: BANKCARDNO_ROW_INDEX, section: 0)) as! BankSettingCell
        let bankCardNo = bankCardNoCell.inputUI.text
        
        if isEmptyString(str: bankName!){
            showToast(view: self.view, txt: "请提供银行名称")
            return
        }
        if isEmptyString(str: bankCardNo!){
            showToast(view: self.view, txt: "请提供银行帐号")
            return
        }
        
        var params:Dictionary<String,String> = ["userName":username!,"bankName":bankName!,"bankAddress":bankAddress!,"cardNo":bankCardNo!]
        
        if postPickPwd{
            let bankPwdCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: REPPWD_ROW_INDEX, section: 0)) as! BankSettingCell
            let bankPwd = bankPwdCell.inputUI.text
            if isEmptyString(str: bankPwd!){
                showToast(view: self.view, txt: "请输入提款密码")
                return
            }
            params["repPwd"] = bankPwd!
        }
        
        request(frontDialog: true,method: .get,loadTextStr: "正在提交...",url:POST_BANK_DATA_URL,params: params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if !isEmptyString(str: resultJson){
                            showToast(view: self.view, txt: resultJson)
                        }else{
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }
                        return
                    }
                    if let result = PostBankWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            showToast(view: self.view, txt: "设置银行信息成功")
                            if let delegate = self.delegate{
                                delegate.onBankSetting()
                            }
                            self.navigationController?.popViewController(animated: true)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bankSettingCell") as? BankSettingCell  else {
            fatalError("The dequeued cell is not an instance of BankSettingCell.")
        }
        let item = datas[indexPath.row]
        if item["key"] == "持卡人姓名" && !self.isUsernameCanModify{
            cell.inputUI.isEnabled = false
        }else{
            cell.inputUI.isEnabled = true
        }
        cell.tagUI.text = item["key"]
        cell.inputUI.text = item["value"]
        cell.inputUI.placeholder = item["holder"]
        return cell
    }

}
