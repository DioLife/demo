//
//  AddBankRealController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class AddBankRealController: BaseController{
    
//    @IBOutlet weak var lastBankViewHeightConstrait:NSLayoutConstraint!
    @IBOutlet weak var lastBankView:UIView!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var bankNameTV:UILabel!
    @IBOutlet weak var bankAddressTV:UILabel!
    @IBOutlet weak var bankCardNoTV:UILabel!
    @IBOutlet weak var tablview:UITableView!

    var isSelect = false
    var lastBankInfo:LastBankContent!
    var allBanks:[AllBankContent]!
    var allBankNames:[String] = []
    var gameDatas = [FakeBankBean]()
    var selectedIndex:Int = 0//银行列表选择的行索引
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "添加银行卡"
        
        tablview.delegate = self
        tablview.dataSource = self
        tablview.showsVerticalScrollIndicator = false
        tablview.tableFooterView = self.footView()
//        self.tablview.reloadData()
        self.loadLastBankDatas(showDialog: true)
    }
    
    func getFakeModels(bank:AllBankContent){
        let item1 = FakeBankBean()
        item1.text = "开户银行"
        item1.value = bank.payName
        gameDatas.append(item1)
        let item2 = FakeBankBean()
        item2.text = "开户姓名"
        item2.value = ""
        gameDatas.append(item2)
        let item3 = FakeBankBean()
        item3.text = "银行地址"
        item3.value = ""
        gameDatas.append(item3)
        let item4 = FakeBankBean()
        item4.text = "银行卡号"
        item4.value = ""
        gameDatas.append(item4)
        let item5 = FakeBankBean()
        item5.text = "确认卡号"
        item5.value = ""
        gameDatas.append(item5)
    }
    
    //
    func loadLastBankDatas(showDialog:Bool) -> Void {
        
        request(frontDialog: showDialog, method:.get, loadTextStr:"获取记录中", url:API_LAST_BANK_INFO,
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
                                self.updateLastBankView(info: result.content)
                            }else{
//                                self.lastBankViewHeightConstrait.constant = -120
//                                self.lastBankView.isHidden = true
                            }
                            if self.allBanks == nil{
                                self.loadAllBankDatas(showDialog: true)
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
    
    func updateLastBankView(info:LastBankContent?){
        if info == nil{
//            lastBankViewHeightConstrait.constant = -120
//            lastBankView.isHidden = true
            return
        }
//        lastBankViewHeightConstrait.constant = 0
//        lastBankView.isHidden = false
        icon.image = UIImage.init(named: "topup_icbcicon")
        bankNameTV.text = String.init(format: "%@", !isEmptyString(str: (info?.bankName)!) ? (info?.bankName)! : "暂无银行")
        bankAddressTV.text = String.init(format: "%@", !isEmptyString(str: (info?.bankAddress)!) ? (info?.bankAddress)! : "暂无地址")
        bankCardNoTV.text = String.init(format: "%@", !isEmptyString(str: (info?.cardNo)!) ? (info?.cardNo)! : "暂无卡号")
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
                                    self.self.getFakeModels(bank:self.allBanks[0])
                                    self.tablview.reloadData()
                                }
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
    
    @objc func onCommitBtn(ui:UIButton){
        
        let bankCode = self.allBanks[self.selectedIndex].code
        let bankName = self.allBanks[self.selectedIndex].payName
        let bankUserName = self.gameDatas[1].value
        let bankAddress = self.gameDatas[2].value
        let bankCardNo = self.gameDatas[3].value
        let bankAgainCardNo = self.gameDatas[4].value
        let lastBankCardNo = self.lastBankInfo != nil ? self.lastBankInfo.cardNo : ""
        let lastRealName = self.lastBankInfo != nil ? self.lastBankInfo.realName : ""
        
        if isEmptyString(str: bankUserName){
            showToast(view: self.view, txt: "请输入开户姓名")
            return
        }
        if isEmptyString(str: bankAddress){
            showToast(view: self.view, txt: "请输入开户银行地址")
            return
        }
        if isEmptyString(str: bankCardNo){
            showToast(view: self.view, txt: "请输入银行卡号")
            return
        }
        if isEmptyString(str: bankAgainCardNo){
            showToast(view: self.view, txt: "请输入确认银行卡号")
            return
        }
        
        if bankCardNo != bankAgainCardNo{
            showToast(view: self.view, txt: "两次输入银行卡号不一致")
            return
        }
        
        
        let parameter = ["realName": bankUserName,"bankName":bankName,"bankAddress":bankAddress,"cardNo":bankCardNo,
                         "code":bankCode,"lastCardNo":lastBankCardNo,"lastRealName":lastRealName]
//        print("parameter === ",parameter)
        self.request(frontDialog: true, method:.post, loadTextStr:"添加中...", url:API_ADD_BANKCARD,params: parameter,
                     callback: {(resultJson:String,resultStatus:Bool)->Void in
                        
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "添加失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        
                        if let result = AddBankWrapper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                showToast(view: self.view, txt: "添加成功")
                                self.navigationController?.popViewController(animated: true)
                            }else{
                                if !isEmptyString(str: result.msg){
                                    self.print_error_msg(msg: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "添加失败"))
                                }
                                if (result.code == 0) {
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }
                        }
                        
        })
    }
    
}

extension AddBankRealController{
    func footView() -> UIView{
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 50))
        let confirmbtn = UIButton.init(frame: CGRect.init(x: 20, y: 0, width: kScreenWidth - 40, height: 50))
        confirmbtn.backgroundColor = UIColor.red
        confirmbtn.layer.cornerRadius = 5
        confirmbtn.setTitle("确认", for: .normal)
        confirmbtn.setTitleColor(UIColor.white, for: .normal)
        confirmbtn.addTarget(self, action: #selector(onCommitBtn(ui:)), for: .touchUpInside)
        footer.addSubview(confirmbtn)
        return footer
    }
}

extension AddBankRealController :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "add_bank_cell") as? AddBankTableCell  else {
            fatalError("The dequeued cell is not an instance of AddBankTableCell.")
        }
        let model = self.gameDatas[indexPath.row]
        cell.inputTV.delegate = self
        cell.inputTV.tag = indexPath.row
        cell.setModel(model: model,row: indexPath.row)
        cell.inputTV.addTarget(self, action: #selector(onInput(ui:)), for: .editingChanged)
        return cell
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
    
    @objc func onInput(ui:UITextField){
        let text = ui.text!
        self.gameDatas[ui.tag].value = text
//        self.tablview.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    private func showBankListDialog(){
        let selectedView = LennySelectView(dataSource: self.allBankNames, viewTitle: "请选择开户银行")
        selectedView.selectedIndex = self.selectedIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.gameDatas[0].value = selectedView.kLenny_InsideDataSource[index]
            self?.selectedIndex = index
            self?.tablview.reloadData()
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
    
}

