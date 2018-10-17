//
//  RegisterController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/17.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class RegisterController: BaseController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var regButton:UIButton!
    @IBOutlet weak var customServer:UILabel!
    @IBOutlet weak var directLoginUI:UILabel!
    
    var loginAndRegDelegate:LoginAndRegisterDelegate?
    
//    var registers = [["name":"用户帐号:","hintText":"请输入用户名","neccessary":true],["name":"登录密码:","hintText":"请输入密码","neccessary":true],["name":"确认密码:","hintText":"请再次输入密码","neccessary":true]]
    var basicRegisters:[RegConfig] = []
    var webRegisters:[RegConfig] = []
    
    let ACCOUNT_ROW_INDEX = 0
    let PWD_ROW_INDEX = 1
    let AGAIN_PWD_INDEX = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "注册"
        
        self.regButton.addTarget(self, action: #selector(onRegClick), for: UIControlEvents.touchUpInside)
        
        //准备帐号，密码，再次密码注册项
        let accountConfig = RegConfig()
        accountConfig.requiredVal = 2
        accountConfig.name = "用户帐号"
        accountConfig.showVal = 2
        accountConfig.uniqueVal = 2
        accountConfig.validateVal = true
        accountConfig.key = "reg_Account"
        
        let pwdConfig = RegConfig()
        pwdConfig.requiredVal = 2
        pwdConfig.name = "登录密码"
        pwdConfig.showVal = 2
        pwdConfig.uniqueVal = 2
        pwdConfig.validateVal = true
        pwdConfig.key = "reg_pwd"
        
        let pwdAgainConfig = RegConfig()
        pwdAgainConfig.requiredVal = 2
        pwdAgainConfig.name = "确认密码"
        pwdAgainConfig.showVal = 2
        pwdAgainConfig.uniqueVal = 2
        pwdAgainConfig.validateVal = true
        pwdAgainConfig.key = "reg_again_pwd"
        
        basicRegisters.append(accountConfig)
        basicRegisters.append(pwdConfig)
        basicRegisters.append(pwdAgainConfig)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        customServer.addGestureRecognizer(tap1)
        directLoginUI.addGestureRecognizer(tap2)
        
        regButton.layer.cornerRadius = 22.5
        
        let system = getSystemConfigFromJson()
        if let value = system{
            let datas = value.content
            if !isEmptyString(str: (datas?.onoff_mobile_guest_register)!) && datas?.onoff_mobile_guest_register == "on"{
                let rightBtn = UIBarButtonItem.init(title: "免费试玩", style: UIBarButtonItemStyle.plain, target: self, action: #selector(freeRegisterAction))
                self.navigationItem.rightBarButtonItem = rightBtn
            }
        }
        loadDatas()
        
    }
    
    func tapEvent(recongnizer: UIPanGestureRecognizer) {
        let label = recongnizer.view as! UILabel
        switch label.tag {
        case 10:
            openContactUs(controller: self)
        case 11:
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
    func freeRegisterAction() -> Void {
        freeRegister(controller: self, showDialog: true, showText: "试玩注册中...",delegate: self.loginAndRegDelegate)
    }
    
    func onRegClick() -> Void {
        let accountCell = self.tableView.cellForRow(at: IndexPath.init(row: ACCOUNT_ROW_INDEX, section: 0)) as! RegisterTableCell
        let account = accountCell.inputUI.text
        if isEmptyString(str: account!){
            showToast(view: self.view, txt: "请输入帐号")
            return
        }
        if !limitAccount(account: account!){
            showToast(view: self.view, txt: "帐号请输入5-11个英文字母和数字组合,不能包含中文")
            return
        }
        
        let pwdCell = self.tableView.cellForRow(at: IndexPath.init(row: PWD_ROW_INDEX, section: 0)) as! RegisterTableCell
        let pwd = pwdCell.inputUI.text
        if isEmptyString(str: pwd!){
            showToast(view: self.view, txt: "请设置密码")
            return
        }
//        if !limitPwd(account: pwd!){
//            showToast(view: self.view, txt: "密码请输入6-16个英文字母和数字组合")
//            return
//        }
        
        let againPwdCell = self.tableView.cellForRow(at: IndexPath.init(row: AGAIN_PWD_INDEX, section: 0)) as! RegisterTableCell
        let apwd = againPwdCell.inputUI.text
        if isEmptyString(str: apwd!){
            showToast(view: self.view, txt: "请再次确认密码")
            return
        }
        if pwd != apwd{
            showToast(view: self.view, txt: "两次密码设置不一致")
            return
        }
        
        var params:Dictionary<String,String> = [:]
        params["account"] = account
        params["password"] = pwd
        params["rpassword"] = apwd
        
        let webRows = self.tableView.numberOfRows(inSection: 0)
        print(webRows)
        if webRows > 4{
            for index in 3...webRows-1{
                //将所有列表行数加上前面三项固定项:帐号，密码，确认密码
                //用于校验从后台获取的注册项
                let cell = self.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! RegisterTableCell
                let value = cell.inputUI.text
                if let valueLet = value{
                    //检查必输配置
                    if (isEmptyString(str: valueLet) && cell.isRequire) {
                        showToast(view: self.view, txt: String.init(format: "请输入%@", valueLet))
                        return
                    }
                    //校验输入
                    if (cell.validate && !isMatchRegex(text: valueLet, regex: cell.regex))
                        && !isEmptyString(str: valueLet) {
                        showToast(view: self.view, txt: String.init(format: "请输入正确格式的%@", cell.regName))
                        return;
                    }
                    params[cell.key] = valueLet
                }
            }
        }
        let vcCodeRow = self.basicRegisters.count+self.webRegisters.count-1
        let vcCodeCell = self.tableView.cellForRow(at: IndexPath.init(row: vcCodeRow, section: 0)) as! RegisterTableCell
        let vcCodeText = vcCodeCell.inputUI.text
        if let code = vcCodeText{
            if isEmptyString(str: code){
                showToast(view: self.view, txt: "请输入验证码")
                return
            }
            params["verifyCode"] = code
        }
        //发起注册
        actionRegister(params: params)
    }
    
    func actionRegister(params:Dictionary<String,String>) ->  Void{
        request(frontDialog: true,method: .post, loadTextStr: "正在注册中...", url:REGISTER_URL,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "注册失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        self.tableView.reloadData()
                        return
                    }
                    if let result = RegisterResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            showToast(view: self.view, txt: "注册成功")
                            YiboPreference.saveLoginStatus(value: true as AnyObject)
                            //获取注册帐户相关信息
                            if let infos = result.content{
                                YiboPreference.setAccountMode(value: infos.accountType as AnyObject)
                                YiboPreference.setVersion(value: infos.cpVersion as AnyObject)
                                //自动登录的情况下，要记住帐号密码
                                if YiboPreference.getAutoLoginStatus(){
                                    if !isEmptyString(str: infos.account){
                                        YiboPreference.saveUserName(value: infos.account as AnyObject)
                                    }
                                    let pwdCell = self.tableView.cellForRow(at: IndexPath.init(row: self.PWD_ROW_INDEX, section: 0)) as! RegisterTableCell
                                    let pwd = pwdCell.inputUI.text
                                    YiboPreference.savePwd(value: pwd! as AnyObject)
                                }
                            }
//                            goMainScreenInPushMethod(controller: self)
                            self.navigationController?.popViewController(animated: true)
                            if let delegate = self.loginAndRegDelegate{
                                delegate.fromRegToLogin()
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "注册失败"))
                            }
                            self.tableView.reloadData()
                        }
                    }
        })
    }
    
    
    func loadDatas() -> Void {
        request(frontDialog: true, loadTextStr: "获取注册配置中...", url:REG_CONFIG_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = RegisterConfigWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let configValues = result.content{
                                if !configValues.isEmpty{
                                    self.webRegisters.removeAll()
                                    for config in configValues{
                                        if config.showVal == 2{
                                            self.webRegisters.append(config)
                                        }
                                    }
                                    
                                }
                            }
                            //显示验证码区
                            let vcCodeConfig = RegConfig()
                            vcCodeConfig.requiredVal = 2
                            vcCodeConfig.name = "验证码"
                            vcCodeConfig.showVal = 2
                            vcCodeConfig.uniqueVal = 2
                            vcCodeConfig.requiredVal = 2
                            vcCodeConfig.validateVal = false
                            vcCodeConfig.key = "verifyCode"
                            self.webRegisters.append(vcCodeConfig)
                            
                            self.tableView.reloadData()
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                        }
                    }
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basicRegisters.count + webRegisters.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "registerCell") as? RegisterTableCell  else {
            fatalError("The dequeued cell is not an instance of RegisterTableCell.")
        }
        let datas = self.basicRegisters + self.webRegisters
        let item:RegConfig = datas[indexPath.row]
        
        if item.key == "reg_pwd" || item.key == "reg_again_pwd"{
            cell.inputUI.isSecureTextEntry = true
        }else{
            cell.inputUI.isSecureTextEntry = false
        }
        cell.fillNameUI(regName: item.name)
        cell.regex = item.regex
        cell.isRequire = item.requiredVal == 2
        cell.key = item.key
        cell.showVCode = false
        cell.validate = item.validateVal
        cell.isRequire = item.requiredVal == 2
        cell.star.isHidden = !(item.requiredVal == 2)
        cell.vcCodeUI.isHidden = !(item.key == "verifyCode")
        if item.key == "verifyCode"{
            //开始异步获取验证码图片
            cell.fillImage()
        }
        return cell
    }


}
