//
//  RegisterController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/17.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class RegisterController: BaseController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var regButton:UIButton!
    @IBOutlet weak var customServer:UILabel!
    @IBOutlet weak var directLoginUI:UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var freeTrialButton: UIButton!
    @IBOutlet weak var backBtnTopConstraint: NSLayoutConstraint!
    
    var argeeButton: UIButton!
    
    var loginAndRegDelegate:LoginAndRegisterDelegate?
    
//    var registers = [["name":"用户帐号:","hintText":"请输入用户名","neccessary":true],["name":"登录密码:","hintText":"请输入密码","neccessary":true],["name":"确认密码:","hintText":"请再次输入密码","neccessary":true]]
    var basicRegisters:[RegConfig] = []
    
    let ACCOUNT_ROW_INDEX = 0
    let PWD_ROW_INDEX = 1
    let AGAIN_PWD_INDEX = 2
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAnnounce(controller: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if glt_iphoneX {
            backBtnTopConstraint.constant = 54
        }else {
            backBtnTopConstraint.constant = 30
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
//        self.tableView.register(RegisterTableCell.self, forCellReuseIdentifier: "registerCell")
        
        self.navigationItem.title = "注册"
//        self.view.backgroundColor = UIColor.orange
        let imageViewBG = UIImageView()
        self.view.insertSubview(imageViewBG, belowSubview: tableView)
        imageViewBG.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        imageViewBG.theme_image = "Global.Login_Register.background"
        imageViewBG.isHidden = false
        
        let logoUI = UIImageView()
        self.view.addSubview(logoUI)
        self.view.insertSubview(imageViewBG, belowSubview: tableView)
        logoUI.whc_Center(0, y: -200).whc_Height(100)
        logoUI.whc_Left(30).whc_Right(30)
        logoUI.contentMode = .scaleAspectFit
//        logoUI.frame = CGRect
        updateAppLogo(logo: logoUI)
        
        directLoginUI.whc_Top(30, toView: logoUI).whc_Height(10).whc_WidthAuto().whc_RightEqual(tableView)
        directLoginUI.textColor = UIColor.white
        let str = NSMutableAttributedString.init(string: "已有账号,点击登录")
        str.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: str.length))
//        str.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 0, range: NSRange(location: 0, length: str.length))
        directLoginUI.attributedText = str
        
        customServer.whc_Top(30, toView: logoUI).whc_Height(10).whc_WidthAuto().whc_LeftEqual(tableView)
        customServer.textColor = UIColor.white
        let str2 = NSMutableAttributedString.init(string: "在线客服")
        str2.addAttribute(.underlineStyle, value: 1, range: NSRange.init(location: 0, length: str2.length))
        customServer.attributedText = str2
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.whc_ResetConstraints()
        tableView.whc_Top(10, toView: directLoginUI).whc_Width(MainScreen.width - 40).whc_Height(200).whc_CenterX(0)
//        tableView.whc_Center(0, y: -30).whc_Width(MainScreen.width - 100).whc_Height(200)
        tableView.tableFooterView = UIView()
        tableView.layer.cornerRadius = 5
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        
        let button = UIButton()
        self.view.addSubview(button)
        button.whc_Top(10, toView: tableView).whc_LeftEqual(tableView).whc_WidthAuto().whc_Height(15)
        button.setTitle("同意并愿意遵守本公司用户注册协议", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.imageView?.contentMode = .scaleAspectFit
        button.theme_setImage("Global.Login_Register.rememberCheckboxNormal", forState: .normal)
        button.theme_setImage("Global.Login_Register.rememberCheckboxSelected", forState: .selected)
        
        button.isSelected = true //默认勾选
        button.tag = 123
        button.addTarget(self, action: #selector(button_TongyizhuceHandle(button:)), for: .touchUpInside)
        argeeButton = button
        
        self.regButton.whc_Top(10, toView: button).whc_LeftEqual(tableView).whc_WidthEqual(tableView)
        self.regButton.addTarget(self, action: #selector(onRegClick), for: UIControlEvents.touchUpInside)
        regButton.backgroundColor = UIColor.black
        regButton.layer.cornerRadius = 3.0
        regButton.clipsToBounds = true
        regButton.setTitle("确认注册", for: .normal)
        regButton.setTitleColor(UIColor.white, for: .normal)
//        regButton.setTitleColor(UIColor.mainColor(), for: .normal)
        
        
        //准备帐号，密码，再次密码注册项
        let accountConfig = RegConfig()
        accountConfig.required = 2
        accountConfig.name = "用户帐号"
        accountConfig.show = 2
        accountConfig.uniqueness = 2
        accountConfig.validate = 2
        accountConfig.key = "reg_Account"
        
        let pwdConfig = RegConfig()
        pwdConfig.required = 2
        pwdConfig.name = "登录密码"
        pwdConfig.show = 2
        pwdConfig.uniqueness = 2
        pwdConfig.validate = 2
        pwdConfig.key = "reg_pwd"
        
        let pwdAgainConfig = RegConfig()
        pwdAgainConfig.required = 2
        pwdAgainConfig.name = "确认密码"
        pwdAgainConfig.show = 2
        pwdAgainConfig.uniqueness = 2
        pwdAgainConfig.validate = 2
        pwdAgainConfig.key = "reg_again_pwd"
        
        basicRegisters.append(accountConfig)
        basicRegisters.append(pwdConfig)
        basicRegisters.append(pwdAgainConfig)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        customServer.addGestureRecognizer(tap1)
        directLoginUI.addGestureRecognizer(tap2)
        
        let system = getSystemConfigFromJson()
        if let value = system{
            let datas = value.content
            if !isEmptyString(str: (datas?.onoff_mobile_guest_register)!) && datas?.onoff_mobile_guest_register == "on"{
                let rightBtn = UIBarButtonItem.init(title: "免费试玩", style: UIBarButtonItemStyle.plain, target: self, action: #selector(freeRegisterAction))
                self.navigationItem.rightBarButtonItem = rightBtn
            }
        }
        loadDatas()
        
        self.view.bringSubview(toFront: backButton)
        self.view.bringSubview(toFront: freeTrialButton)
        
        configDynamicUI()
    }
    
    //键盘弹起响应
    @objc override func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let deltaY = abs((frame.origin.y - regButton.origin.y - 44))
            
            if keyBoardNeedLayout {
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: {
                                self.view.frame = CGRect.init(x:0,y:-deltaY,width:self.view.bounds.width,height:self.view.bounds.height)
                                self.keyBoardNeedLayout = false
                                self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    //键盘隐藏响应
    @objc override func keyboardWillHide(notification: NSNotification) {

        if let userInfo = notification.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: {
                            self.view.frame = CGRect.init(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height)
                            self.keyBoardNeedLayout = true
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func updateAppLogo(logo:UIImageView) -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        
        var newLogoImg = sys.content.login_page_logo_url
        
        if !isEmptyString(str: newLogoImg) {
            
            newLogoImg = handleImageURL(logoImgP: newLogoImg)
            
            let imageURL = URL(string: newLogoImg)
            logo.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
        }else {
            var logoImg = sys.content.lottery_page_logo_url
            if !isEmptyString(str: logoImg){
                logoImg = handleImageURL(logoImgP: logoImg)
                
                let imageURL = URL(string: logoImg)
                logo.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }else{
                logo.image = nil
            }
            
        }
    }
    
    //MARK: 地址可能是相对地址的处理
    private func handleImageURL(logoImgP: String) -> String{
        var logoImg = logoImgP
        if logoImg.contains("\t"){
            let strs = logoImg.components(separatedBy: "\t")
            if strs.count >= 2{
                logoImg = strs[1]
            }
        }
        logoImg = logoImg.trimmingCharacters(in: .whitespaces)
        if !logoImg.hasPrefix("https://") && !logoImg.hasPrefix("http://"){
            logoImg = String.init(format: "%@/%@", BASE_URL,logoImg)
        }
        
        return logoImg
    }
    
    @objc private func button_TongyizhuceHandle(button: UIButton) {
        button.isSelected = !button.isSelected
    }
    
    @objc func tapEvent(recongnizer: UIPanGestureRecognizer) {
        let label = recongnizer.view as! UILabel
        switch label.tag {
        case 10:
            openContactUs(controller: self)
        case 11:
            self.navigationController?.popViewController(animated: true)
            let vc = UIStoryboard(name: "login",bundle:nil).instantiateViewController(withIdentifier: "login_page") as! LoginController
//            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true) {
                
            }
        default:
            break
        }
    }
    
    @objc func freeRegisterAction() -> Void {
        freeRegister(controller: self, showDialog: true, showText: "试玩注册中...",delegate: self.loginAndRegDelegate)
    }
    
    @objc func onRegClick() -> Void {
        
        if self.basicRegisters.isEmpty{
            showToast(view: self.view, txt: "没有注册数据")
            return
        }
        
        self.view.endEditing(true)
        
        if !argeeButton.isSelected {
            showToast(view: self.view, txt: "请先同意注册协议")
            return
        }
        
        
        let accountModle = self.basicRegisters[0]
        let account  = accountModle.inputContent
        
        if isEmptyString(str: account){
            showToast(view: self.view, txt: "请输入帐号")
            return
        }
        if !limitAccount(account: account){
            showToast(view: self.view, txt: "账号由5-11个数字和字母组成,不能包含中文")
            return
        }
        
//        let pwdModle = modelDic["1"] as CellContentsModel?
        let pwdModle = self.basicRegisters[1]
        let pwd = pwdModle.inputContent
        if isEmptyString(str: pwd){
            showToast(view: self.view, txt: "请设置密码")
            return
        }
        if !limitPwd(account: pwd){
            showToast(view: self.view, txt: "密码请输入6-16个英文字母和数字组合")
            return
        }
        
//        let apwdModel = modelDic["2"] as CellContentsModel?
        let apwdModel = self.basicRegisters[2]
        let apwd = apwdModel.inputContent
        if isEmptyString(str: apwd){
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
        
        let webRows = self.basicRegisters.count
        print(webRows)
        if webRows >= 4{
            for index in 3...webRows-1{
                //将所有列表行数加上前面三项固定项:帐号，密码，确认密码
                //用于校验从后台获取的注册项
//                let cellIndex = "\(index)"
//                let cellModel = modelDic[cellIndex] as CellContentsModel?
                let cellModel = self.basicRegisters[index]
                let cellInput = cellModel.inputContent
                
                //检查必输配置
                if cellModel.show == 2{
                    if (isEmptyString(str: cellInput) && cellModel.required == 2) {
                        showToast(view: self.view, txt: String.init(format: "请输入%@", cellInput))
                        return
                    }
                    //校验输入
                    if !isEmptyString(str: cellModel.regex){
                        if (cellModel.validate == 2 && !isMatchRegex(text: cellInput, regex: cellModel.regex)
                            && !isEmptyString(str: cellInput)) {
                            showToast(view: self.view, txt: String.init(format: "请输入正确格式的%@",   cellModel.name))
                            return;
                        }
                    }
                }
                params[cellModel.key] = cellInput
            }
        }
        let vcCodeModel = self.basicRegisters.last
        if let vc = vcCodeModel{
            let vcCodeText = vc.inputContent
            if isEmptyString(str: vcCodeText){
                showToast(view: self.view, txt: "请输入验证码")
                return
            }
            params["verifyCode"] = vcCodeText
        }
        
        //发起注册
        actionRegister(params: params)
    }
    
    func actionRegister(params:Dictionary<String,String>) ->  Void{
        
        print(params)
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
                                //自动登录的情况下，要记住帐号密码
                                if YiboPreference.getAutoLoginStatus(){
                                    if !isEmptyString(str: infos.account){
                                        YiboPreference.saveUserName(value: infos.account as AnyObject)
                                    }
                                    if self.basicRegisters.count > 1{
                                        let name = self.basicRegisters[0].inputContent
                                        let pwd = self.basicRegisters[1].inputContent
                                        YiboPreference.savePwd(value: pwd as AnyObject)
                                        YiboPreference.saveUserName(value: name as AnyObject)
                                    }
                                }
                            }
//                            goMainScreenInPushMethod(controller: self)
//                            self.navigationController?.popViewController(animated: true)
                            self.onBackClick()
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
//                                    self.webRegisters.removeAll()
                                    for config in configValues{
                                        if config.show == 2{
//                                            self.webRegisters.append(config)
                                            config.key = config.eleName
                                            self.basicRegisters.append(config)
                                        }
                                    }
                                    
                                }
                            }
                            //显示验证码区
                            let vcCodeConfig = RegConfig()
                            vcCodeConfig.required = 2
                            vcCodeConfig.name = "验证码"
                            vcCodeConfig.show = 2
                            vcCodeConfig.uniqueness = 2
                            vcCodeConfig.required = 2
                            vcCodeConfig.validate = 1
                            vcCodeConfig.key = "verifyCode"
//                            self.webRegisters.append(vcCodeConfig)
                            self.basicRegisters.append(vcCodeConfig)
                            
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
        return basicRegisters.count
    }
    
    @objc func inputUIContentChange(textField:UITextField)->Void{
        let index = (textField.tag - 1000)
        if !basicRegisters.isEmpty{
            basicRegisters[index].inputContent = textField.text!
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "registerCell", for: indexPath) as? RegisterTableCell else {
            fatalError("The dequeued cell is not an instance of RegisterTableCell.")
        }
        
        cell.inputUI.tag = indexPath.row + 1000
        cell.inputUI.addTarget(self, action: #selector(inputUIContentChange(textField:)), for: UIControlEvents.editingDidEnd)
        
        let item:RegConfig = basicRegisters[indexPath.row]
        
        cell.isRequire = item.required //  是否必须
        
        let account = item.inputContent
        cell.inputUI.text = account
        
        if item.key == "reg_pwd" || item.key == "reg_again_pwd"{
            cell.inputUI.isSecureTextEntry = true
        }else{
            cell.inputUI.isSecureTextEntry = false
        }
        
        cell.fillNameUI(regName: item.name,index: indexPath.row)
        if item.key == "verifyCode"{
            cell.vcCodeUI.isHidden = false
            //开始异步获取验证码图片
            cell.fillImage()
        }else{
            cell.vcCodeUI.isHidden = true
        }
        return cell
    }
    
    
  
    //MARK: - 点击事件
    @IBAction func backAction() {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func freeTrialAction() {
        self.dismiss(animated: false) {
            freeRegister(controller: self, showDialog: true, showText: "试玩注册中...", delegate: nil)
        }
    }
    
    private func configDynamicUI() {
        let system = getSystemConfigFromJson()
        if let value = system{
            let datas = value.content
            if !isEmptyString(str: (datas?.onoff_mobile_guest_register)!) && datas?.onoff_mobile_guest_register == "on"{
                freeTrialButton.isHidden = false
            }else{
                freeTrialButton.isHidden = true
            }
            
            if !isEmptyString(str: (datas?.online_customer_showphone)!) && datas?.online_customer_showphone == "on"{
                customServer.isHidden = false
            }else{
                customServer.isHidden = false
            }
        }
    }
    
    
//    func showNoticeDialog(title:String,content:String) -> Void {
//        let qrAlert = PopupAlert.init(title: title, message: content, cancelButtonTitle: nil, sureButtonTitle: "我知道了")
//        qrAlert.show()
//    }
    
    
    // 遍历数组,取出公告赋值
    private func forArrToAlert(notices: Array<NoticeResult>) {
        
        var noticesP = notices
        noticesP = noticesP.sorted { (noticesP1, noticesP2) -> Bool in
            return noticesP1.sortNum < noticesP2.sortNum
        }
        
        var models = [NoticeResult]()
        for index in 0..<noticesP.count {
            let model = noticesP[index]
            if model.isReg {
                models.append(model)
            }
        }
        
        if models.count > 0 {
            let weblistView = WebviewList.init(noticeResuls: models)
            weblistView.show()
        }
        
    }
    
    
    
    private func showAnnounce(controller:BaseController) {
        if YiboPreference.isShouldAlert_isAll() == "" {
            YiboPreference.setAlert_isAll(value: "on" as AnyObject)
        }
        
        if YiboPreference.isShouldAlert_isAll() == "off"{
            return
        }
        //获取公告弹窗内容
        controller.request(frontDialog: false, url:ACQURIE_NOTICE_POP_URL,params:["code":19],
                           callback: {(resultJson:String,resultStatus:Bool)->Void in
                            if !resultStatus {
                                return
                            }
                            
                            if let result = NoticeResultWraper.deserialize(from: resultJson){
                                if result.success{
                                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                                    if let notices = result.content{
                                        //显示公告内容
                                        if notices.isEmpty{
                                            return
                                        }else {
                                            
                                            self.forArrToAlert(notices: notices)
                                        }
                                    }
                                }
                            }
        })
    }
}
