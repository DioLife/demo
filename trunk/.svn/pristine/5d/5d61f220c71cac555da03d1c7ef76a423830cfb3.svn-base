//
//  RegisterManagerContrller.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/28.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
//注册管理
class RegisterManagerContrller: BaseController {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var confirmBtn:UIButton!
    
    var isSelect = false
    
    var gameDatas = [[FakeBankBean]]()
    var userTypes:[String] = ["代理","会员"]
    var selectedUserTypeIndex = 0
    
    var lotteryRebate = "";//选中的返点
    var sportRebate = "";//选中的体育返点
    var shabaRebate = "";//选中的沙巴体育返点
    var realRebate = "";//选中的真人返点
    var eqameRebate = "";//选中的电子返点
    var userName = ""
    var passWord = ""
    var againPassword = ""
    
    var ratebackData:AllRateBack!
    
    var isProxy = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        self.title = "注册管理"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backPageAction))
        tableView.delegate = self
        tableView.dataSource = self
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.addTarget(self, action: #selector(actionRegister), for: .touchUpInside)
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        loadRatebackDatas(showDialog: true)
    }


    @objc func actionRegister(){
        
        if isEmptyString(str: userName){
            showToast(view: self.view, txt: "请输入用户名")
            return
        }
        if isEmptyString(str: passWord){
            showToast(view: self.view, txt: "请输入密码")
            return
        }
        if isEmptyString(str: againPassword){
            showToast(view: self.view, txt: "请再次输入密码")
            return
        }
        
        if passWord != againPassword{
            showToast(view: self.view, txt: "两次密码不一致")
            return
        }
        let userType = selectedUserTypeIndex == 0 ? "2" : "1"
        var params:Dictionary<String,String> = ["username":userName,"password":againPassword,"accountType":userType]
        
        
        if !isEmptyString(str: lotteryRebate){
            params["kickback"] = lotteryRebate
        }
        if !isEmptyString(str: realRebate){
            params["realRebate"] = realRebate
        }
        if !isEmptyString(str: sportRebate){
            params["sportRebate"] = sportRebate
        }
        if !isEmptyString(str: eqameRebate){
            params["egameRebate"] = eqameRebate
        }
        if !isEmptyString(str: shabaRebate){
            params["shabaRebate"] = shabaRebate
        }
        request(frontDialog: true, method:.post, loadTextStr:"提交中...", url:API_REGISTER_SAVE,params: params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "提交失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = RatebackWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            showToast(view: self.view, txt: "注册成功")
                            self.onBackClick()
                        }else{
                            if !isEmptyString(str: result.msg){
                                self.print_error_msg(msg: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "提交失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
                    
        })
    }
    
     @objc func backPageAction(){
        if self.navigationController != nil{
            let count = self.navigationController?.viewControllers.count
            if count! > 1{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }

    func getFakeModels(bank:AllRateBack?){
        
        var data1:[FakeBankBean] = []
        
        let item1 = FakeBankBean()
        item1.text = "用户类型"
       
        item1.value = self.isProxy ? userTypes[0] : userTypes[1]
        data1.append(item1)
        
        let item2 = FakeBankBean()
        item2.text = "登录账户"
        item2.value = ""
        item2.placeholder = "账号只能是数字和字母"
        data1.append(item2)
        
        let item3 = FakeBankBean()
        item3.text = "登录密码"
        item3.value = ""
        item3.placeholder = "请输入密码"
        data1.append(item3)
        
        let item4 = FakeBankBean()
        item4.text = "重复密码"
        item4.value = ""
        item4.placeholder = "请再次输入密码"
        data1.append(item4)
        self.gameDatas.append(data1)
        
        //...........................
        var data2:[FakeBankBean] = []
        
        let item21 = FakeBankBean()
        item21.text = "设置奖金:"
        item21.value = "选择其他奖金组"
        item21.code = "cpfs"
        data2.append(item21)
        
        let system = getSystemConfigFromJson()
        let sport = system?.content.onoff_sport_switch
        let sbsport = system?.content.onoff_sb_switch
        let zhenren = system?.content.onoff_zhen_ren_yu_le
        let game = system?.content.onoff_dian_zi_you_yi
        
        if !isEmptyString(str: sport!) && sport == "on" && self.isProxy{
            let item22 = FakeBankBean()
            item22.text = "设置体育返点:"
            item22.value = "选择其他返点比例"
            item22.code = "tyfs"
            data2.append(item22)
        }
        
        if !isEmptyString(str: sbsport!) && sbsport == "on" && self.isProxy{
            let item23 = FakeBankBean()
            item23.text = "设置沙巴体育返点:"
            item23.value = "选择其他返点比例"
            item23.code = "sbfs"
            data2.append(item23)
        }
        
        if !isEmptyString(str: zhenren!) && zhenren == "on" && self.isProxy{
            let item24 = FakeBankBean()
            item24.text = "设置真人返点:"
            item24.value = "选择其他返点比例"
            item24.code = "zrfs"
            data2.append(item24)
        }
        
        if !isEmptyString(str: game!) && game == "on" && self.isProxy{
            let item25 = FakeBankBean()
            item25.text = "设置电子返点:"
            item25.value = "选择其他返点比例"
            item25.code = "dzfs"
            data2.append(item25)
        }
        self.gameDatas.append(data2)
        
    }
    
    func loadRatebackDatas(showDialog:Bool) -> Void {
        
        gameDatas = [[FakeBankBean]]()
        
        request(frontDialog: showDialog, method:.get, loadTextStr:"获取数据中...", url:API_REGISTER_RATEBACK,
                callback: {(resultJson:String,resultStatus:Bool)->Void in

                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }

                    if let result = RatebackWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            self.ratebackData = result.content
                            self.getFakeModels(bank: result.content)
                            self.tableView.reloadData()
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
    
}

extension RegisterManagerContrller :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameDatas[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.gameDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        setThemeViewNoTransparentDefaultGlassBlackOtherGray(view: header)
        
        let label = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: tableView.bounds.width - 40, height: 40))
        setThemeLabelTextColorGlassWhiteOtherBlack(label: label)
        if section == 0{
            label.text = "信息填写"
        }else{
            label.text = "奖金组设定"
        }
        label.font = UIFont.systemFont(ofSize: 14)
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "add_bank_cell") as? AddBankTableCell  else {
            fatalError("The dequeued cell is not an instance of AddBankTableCell.")
        }
        let model = self.gameDatas[indexPath.section][indexPath.row]
        if indexPath.section == 0{
            if indexPath.row == 0{
                cell.accessoryType = .disclosureIndicator
                cell.inputTV.isHidden = true
                cell.valueTV.isHidden = false
            }else{
                if indexPath.row == 2 || indexPath.row == 3{
                    cell.inputTV.isSecureTextEntry = true
                }
                cell.accessoryType = .none
                cell.inputTV.isHidden = false
                cell.valueTV.isHidden = true
                cell.inputTV.delegate = self
                cell.inputTV.tag = indexPath.row
                cell.inputTV.addTarget(self, action: #selector(onInput(ui:)), for: .editingChanged)
            }
        }else{
            let model = self.gameDatas[indexPath.section][indexPath.row]
            cell.setModel(model: model,row: indexPath.row)
            cell.inputTV.isHidden = true
            cell.valueTV.isHidden = false
            cell.accessoryType = .disclosureIndicator
        }
        cell.inputTV.placeholder = !isEmptyString(str: model.placeholder) ? model.placeholder : String.init(format: "请输入%@", model.value)
        cell.valueTV.text = model.value
        cell.textTV.text = model.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 0{
                
                if (isSelect == false) {
                    isSelect = true
                    self.showUserTypeListDialog()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isSelect = false
                    }
                }
            }
        }else{
            
            if (isSelect == false) {
                isSelect = true
                
                if self.ratebackData == nil{
                    return
                }
                let data = self.gameDatas[indexPath.section][indexPath.row]
                if data.code == "cpfs"{
                    let array = self.ratebackData.lotteryArray
                    showRateBackListDialog(row: indexPath.row, code: data.code, sources: array)
                }else if data.code == "tyfs"{
                    let array = self.ratebackData.sportArray
                    showRateBackListDialog(row: indexPath.row,code: data.code, sources: array)
                }else if data.code == "sbfs"{
                    let array = self.ratebackData.shabaArray
                    showRateBackListDialog(row: indexPath.row,code: data.code, sources: array)
                }else if data.code == "zrfs"{
                    let array = self.ratebackData.realArray
                    showRateBackListDialog(row: indexPath.row,code: data.code, sources: array)
                }else if data.code == "dzfs"{
                    let array = self.ratebackData.egameArray
                    showRateBackListDialog(row: indexPath.row,code: data.code, sources: array)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isSelect = false
                }
            }
            
        }
    }
    
    @objc func onInput(ui:UITextField){
        let text = ui.text!
        let tag = ui.tag
        if tag == 1{
            userName = text
        }else if tag == 2{
            passWord = text
        }else if tag == 3{
            againPassword = text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    private func showUserTypeListDialog(){
        let selectedView = LennySelectView(dataSource: self.userTypes, viewTitle: "请选择用户类型")
        selectedView.selectedIndex = self.selectedUserTypeIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.gameDatas[0][0].value = selectedView.kLenny_InsideDataSource[index]
            self?.isProxy =  self?.gameDatas[0][0].value == "代理"
            self?.selectedUserTypeIndex = index
            self?.loadRatebackDatas(showDialog: true)
//            self?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .middle)
            
            // 选择会员或代理后，刷新奖金组设定的section
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
    
    private func showRateBackListDialog(row:Int,code:String,sources:[RebateBean]){
        if sources.isEmpty{
            showToast(view: self.view, txt: "没有返点数据，无法选择，请联系客服")
            return
        }
        var dataNames:[String] = []
        var selectedIndex = 0
        for index in 0...sources.count-1{
            let item = sources[index]
            if code == "cpfs"{
                if item.value == lotteryRebate{
                    selectedIndex = index
                }
            }else if code == "tyfs"{
                if item.value == sportRebate{
                    selectedIndex = index
                }
            }else if code == "sbfs"{
                if item.value == shabaRebate{
                    selectedIndex = index
                }
            }else if code == "zrfs"{
                if item.value == realRebate{
                    selectedIndex = index
                }
            }else if code == "dzfs"{
                if item.value == eqameRebate{
                    selectedIndex = index
                }
            }
            dataNames.append(String.init(format: "%@", item.label))
        }
        let selectedView = LennySelectView(dataSource: dataNames, viewTitle: "请选择奖金组")
        selectedView.selectedIndex = selectedIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.gameDatas[1][row].value = selectedView.kLenny_InsideDataSource[index]
            self?.tableView.reloadData()
            if code == "cpfs"{
                self?.lotteryRebate = sources[index].value
            }else if code == "tyfs"{
                self?.sportRebate = sources[index].value
            }else if code == "sbfs"{
                self?.shabaRebate = sources[index].value
            }else if code == "zrfs"{
                self?.realRebate = sources[index].value
            }else if code == "dzfs"{
                self?.eqameRebate = sources[index].value
            }
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

