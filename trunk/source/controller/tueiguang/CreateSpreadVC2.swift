//
//  CreateSpreadVC2.swift
//  gameplay
//
//  Created by William on 2018/8/9.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class CreateSpreadVC2: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    var isSelect = false
    
    var gameDatas = [[FakeBankBean]]()
    var userTypes:[String] = ["代理","会员"]
    var isProxy = true
    var selectedUserTypeIndex = 0
    
//    var userType = "" //用户类型
    var lotteryRebate = "";//选中的返点
    var sportRebate = "";//选中的体育返点
    var shabaRebate = "";//选中的沙巴体育返点
    var realRebate = "";//选中的真人返点
    var eqameRebate = "";//选中的电子返点
    
    var ratebackData:AllRateBack!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新建推广"

        tableView.delegate = self
        tableView.dataSource = self
        let identify = "SwiftCell"
        tableView.register(UINib.init(nibName: "CreateSpreadTBCell", bundle: nil), forCellReuseIdentifier: identify)
    
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        loadRatebackDatas(showDialog: true)
    }

    
    func getFakeModels(bank:AllRateBack?){
        var data1:[FakeBankBean] = []
        
        let item1 = FakeBankBean()
        item1.text = "推广域名:"
        item1.value = "本站"
        data1.append(item1)
        
        let item2 = FakeBankBean()
        item2.text = "用户类型:"
        item2.value = userTypes[self.selectedUserTypeIndex]
        data1.append(item2)
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
        
        if !isEmptyString(str: sport!) && sport == "on" && self.isProxy {
            let item22 = FakeBankBean()
            item22.text = "设置体育返点:"
            item22.value = "选择其他返点比例"
            item22.code = "tyfs"
            data2.append(item22)
        }
        
        if !isEmptyString(str: sbsport!) && sbsport == "on"  && self.isProxy{
            let item23 = FakeBankBean()
            item23.text = "设置沙巴体育返点:"
            item23.value = "选择其他返点比例"
            item23.code = "sbfs"
            data2.append(item23)
        }
        
        if !isEmptyString(str: zhenren!) && zhenren == "on"  && self.isProxy{
            let item24 = FakeBankBean()
            item24.text = "设置真人返点:"
            item24.value = "选择其他返点比例"
            item24.code = "zrfs"
            data2.append(item24)
        }
        
        if !isEmptyString(str: game!) && game == "on"  && self.isProxy{
            let item25 = FakeBankBean()
            item25.text = "设置电子返点:"
            item25.value = "选择其他返点比例"
            item25.code = "dzfs"
            data2.append(item25)
        }
        self.gameDatas.append(data2)
    }
    
    func loadRatebackDatas(showDialog:Bool) -> Void {
        
        self.gameDatas = [[FakeBankBean]]()
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
    
    
    @IBAction func createBtn(_ sender: UIButton) {

        if self.lotteryRebate == "" {
            showToast(view: self.view, txt: "请设置奖金!!!")
            return
        }
        
        let system = getSystemConfigFromJson()
        let sport = system?.content.onoff_sport_switch
        let sbsport = system?.content.onoff_sb_switch
        let zhenren = system?.content.onoff_zhen_ren_yu_le
        let game = system?.content.onoff_dian_zi_you_yi
        
        if isEmptyString(str: self.sportRebate) && sport == "on" && self.isProxy {
            showToast(view: self.view, txt: "请设置体育返点!!!")
            return
        }
        
        if isEmptyString(str: self.shabaRebate) && sbsport == "on" && self.isProxy{
            showToast(view: self.view, txt: "请设置沙巴体育返点!!!")
            return
        }
        
        if isEmptyString(str: self.realRebate) && zhenren == "on" && self.isProxy{
            showToast(view: self.view, txt: "请设置真人返点!!!")
            return
        }
        
        if isEmptyString(str: self.eqameRebate) && game == "on" && self.isProxy{
            showToast(view: self.view, txt: "请设置电子返点!!!")
            return
        }
        
        let userType = selectedUserTypeIndex == 0 ? "2" : "1"
        let map:[String : Any] = ["type":userType, "cpRolling":self.lotteryRebate,
                                  "realRebate":self.realRebate,"sportRebate":self.sportRebate,
                                  "egameRebate":self.eqameRebate,"shabaRebate":self.shabaRebate]
        //"/native/agent_save_prom_link.do"
        request(frontDialog: true, method: .post, loadTextStr: "正在生成中...", url: api_generate_link, params: map) { (resultJson:String, resultStatus:Bool) in
            if !resultStatus {
                return
            }
            showToast(view: self.view, txt: "生成链接成功!")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension CreateSpreadVC2 :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameDatas[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.gameDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "奖金设定"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftCell") as? CreateSpreadTBCell  else {
            fatalError("The dequeued cell is not an instance of AddBankTableCell.")
        }

        let model = self.gameDatas[indexPath.section][indexPath.row]
        cell.mylabel.text = model.text
        cell.mylabel2.text = model.value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 1 {
                if (isSelect == false) {
                    isSelect = true
                    self.showUserTypeListDialog()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isSelect = false
                    }
                }
                self.tableView.reloadData()
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
    
    
    
    private func showUserTypeListDialog(){
        let selectedView = LennySelectView(dataSource: self.userTypes, viewTitle: "请选择用户类型")
        selectedView.selectedIndex = self.selectedUserTypeIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.gameDatas[0][1].value = selectedView.kLenny_InsideDataSource[index]
            self?.isProxy = self?.gameDatas[0][1].value == "代理"
            self?.selectedUserTypeIndex = index
            self?.loadRatebackDatas(showDialog: true)
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
