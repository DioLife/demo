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

    var isSelect = false
    @IBOutlet weak var tableViewUI:UITableView!
    @IBOutlet weak var btnUI:UIButton!
    
    var datas:[Dictionary<String,String>] = []
    var dataJson = ""
    var delegate:BankDelegate?
    
    let KAIHU_YINHU_ROW_INDEX = 0
    let USERNAME_ROW_INDEX = 1
    let BANKADDRESS_ROW_INDEX = 2
    let BANKCARDNO_ROW_INDEX = 3
    let BANKCARDNO_AGAIN_ROW_INDEX = 4
    let REPPWD_ROW_INDEX = 5
    
    var postPickPwd = false
    var lastBankInfo:LastBankContent?
    
    var allBanks:[AllBankContent]!
    var allBankNames:[String] = []
    var selectedBankIndex = 0
    let placeholders = ["","请输入持卡人姓名","请输入银行地址","请输入银行卡号","请确认卡号"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        btnUI.addTarget(self, action: #selector(onCommitClick), for: UIControlEvents.touchUpInside)
        tableViewUI.delegate = self
        tableViewUI.dataSource = self
        setViewBackgroundColorTransparent(view: tableViewUI)
        tableViewUI.tableFooterView = UIView.init(frame: CGRect.zero)
        btnUI.layer.cornerRadius = 5
        btnUI.theme_backgroundColor = "Global.themeColor"
        self.navigationItem.title = "银行设置"
        let bankObj = JSONDeserializer<PickBankAccount>.deserializeFrom(json: dataJson)
        if let bank = bankObj{
            let item1 = ["key":"开户银行","value":"选择开户银行"]
            let item2 = ["key":"开户姓名","value":""]
            let item3 = ["key":"银行地址","value":""]
            let item4 = ["key":"银行卡号","value":""]
            let item5 = ["key":"确认卡号","value":""]
            datas.append(item1)
            datas.append(item2)
            datas.append(item3)
            datas.append(item4)
            datas.append(item5)
            
            if isEmptyString(str: bank.receiptPwd!){
                postPickPwd = true
                let item6 = ["key":"取款密码","value":bank.receiptPwd]
                datas.append(item6 as! [String : String])
            }
            self.tableViewUI.reloadData()
        }
        
        loadAllBankDatas(showDialog: true)//获取银行列表
    }
    
    @objc func onCommitClick() -> Void {
        postBank()
    }
    
    func postBank() -> Void {
        
        
        
        let khyhCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: KAIHU_YINHU_ROW_INDEX, section: 0)) as! BankSettingCell
        let khyh = khyhCell.valueUI.text
        
        let usernameCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: USERNAME_ROW_INDEX, section: 0)) as! BankSettingCell
        let userName = usernameCell.inputUI.text
        
        let bankAddressCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: BANKADDRESS_ROW_INDEX, section: 0)) as! BankSettingCell
        let bankAddress = bankAddressCell.inputUI.text
        
        let bankCardNoCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: BANKCARDNO_ROW_INDEX, section: 0)) as! BankSettingCell
        let bankCardNo = bankCardNoCell.inputUI.text
        
        let bankCardNoAgainCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: BANKCARDNO_AGAIN_ROW_INDEX, section: 0)) as! BankSettingCell
        let bankCardNoAgain = bankCardNoAgainCell.inputUI.text
        
        if isEmptyString(str: khyh!) || khyh == "选择开户银行" {
            showToast(view: self.view, txt: "请选择开户银行")
            return
        }
        
        if isEmptyString(str: userName!){
            showToast(view: self.view, txt: "请输入开户姓名")
            return
        }
        
        if isEmptyString(str: bankAddress!){
            showToast(view: self.view, txt: "请输入开户银行地址")
            return
        }
//        if isEmptyString(str: bankName!){
//            showToast(view: self.view, txt: "请提供银行名称")
//            return
//        }
        if isEmptyString(str: bankCardNo!){
            showToast(view: self.view, txt: "请提供银行帐号")
            return
        }
        
        if isEmptyString(str: bankCardNoAgain!){
            showToast(view: self.view, txt: "请再次提供银行帐号")
            return
        }
        
        if bankCardNo != bankCardNoAgain{
            showToast(view: self.view, txt: "两次卡号不一致")
            return
        }
        
        
        let user = userName?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let bankNameTV = khyh?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let bankAddressTV = bankAddress?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let bankCardNoTV = bankCardNo?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let bankCode = !self.allBanks.isEmpty ? self.allBanks[self.selectedBankIndex].code : ""
        
        var params:Dictionary<String,String> = ["realName":userName!,"bankName":khyh!,
                                                "bankAddress":bankAddress!,"cardNo":bankCardNo!,
                                                "code":bankCode]
        
//        if postPickPwd{
//            let bankPwdCell = self.tableViewUI.cellForRow(at: IndexPath.init(row: REPPWD_ROW_INDEX, section: 0)) as! BankSettingCell
//            let bankPwd = bankPwdCell.inputUI.text
//            if isEmptyString(str: bankPwd!){
//                showToast(view: self.view, txt: "请输入提款密码")
//                return
//            }
//            params["repPwd"] = bankPwd!
//        }
        
        if let lastBank = self.lastBankInfo{
            params["lastCardNo"] = lastBank.cardNo
            params["lastRealName"] = lastBank.realName
        }
        
        request(frontDialog: true,method: .post,loadTextStr: "正在提交...",url:POST_BANK_DATA_URL,params: params,
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
    
    func loadAllBankDatas(showDialog:Bool) -> Void {
        
        request(frontDialog: showDialog, method:.get, loadTextStr:"获取银行列表中", url:API_GET_BANKS,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = AllBankWrapper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if result.content != nil{
                                self.allBanks = result.content
                                if !self.allBanks.isEmpty{
                                    for bank in self.allBanks{
                                        self.allBankNames.append(bank.payName)
                                    }
                                }
                                self.getLastBankData()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                self.print_error_msg(msg: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取银行列表失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
                    
        })
    }
    
    private func showBankListDialog(){
        
        if self.allBankNames.isEmpty{
            return
        }
        
        let selectedView = LennySelectView(dataSource: self.allBankNames, viewTitle: "请选择开户银行")
        selectedView.selectedIndex = self.selectedBankIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.datas[0] = ["key":"开户银行","value":self?.allBankNames[index]] as! [String : String]
            self?.selectedBankIndex = index
            self?.tableViewUI.reloadData()
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            //            self.setSelected(false, animated: true)
        }
    }
    
    
    func getLastBankData(){
        request(frontDialog: true, method:.get, loadTextStr:"获取中", url:API_LAST_BANK_INFO,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = LastBankWrapper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if result.content != nil{
                                self.lastBankInfo = result.content
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                self.print_error_msg(msg: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if (result.code == 0) {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if (isSelect == false) {
                isSelect = true
                self.showBankListDialog()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isSelect = false
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bankSettingCell") as? BankSettingCell  else {
            fatalError("The dequeued cell is not an instance of BankSettingCell.")
        }
        let item = datas[indexPath.row]
        if indexPath.row == 0{
            cell.inputUI.isHidden = true
            cell.valueUI.isHidden = false
            cell.valueUI.text = item["value"]
            cell.accessoryType = .disclosureIndicator
        }else{
            cell.inputUI.isHidden = false
            cell.valueUI.isHidden = true
            cell.inputUI.text = item["value"]
            cell.accessoryType = .none
        }
        
        //定位crash
        cell.inputUI.placeholder = placeholders[indexPath.row]
        cell.tagUI.text = item["key"]
        return cell
    }

}
