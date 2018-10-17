//
//  StartupController.swift
//  
//
//  Created by yibo-johnson on 2017/12/13.
//

import UIKit

class StartupController: BaseController {
    
    @IBOutlet  weak var jumpBtn:UIButton!
    @IBOutlet  weak var viewDomainBtn:UIButton!
    @IBOutlet  weak var imageUI:UIImageView!
    
    var downTimer:Timer?//动态密码倒计时器
    var COUNT_SECONDS = 3
    var main_page_style = OLD_CLASSIC_STYLE
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewDomainBtn.isHidden = false;
        jumpBtn.addTarget(self,action:#selector(checkVersion),for:.touchUpInside)
        viewDomainBtn.addTarget(self,action:#selector(onDomainClick),for:.touchUpInside)
        jumpBtn.layer.cornerRadius = 5
        //开始计时
        startCountDown()
    }
    
    func onJumpController() -> Void {
        let hasShow = UserDefaults.standard.bool(forKey: "showedPicture")
        if !hasShow{
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    if config.content != nil{
                        if config.content.native_welcome_page_switch == "on"{
                            let guideViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "guideViewController")
                            let pictureVC = guideViewController
                            self.present(pictureVC, animated: true, completion: nil)
                        }else{
                            if YiboPreference.getAutoLoginStatus(){
                                actionLogin(username: YiboPreference.getUserName(), pwd: YiboPreference.getPwd())
                            }else{
                                YiboPreference.saveLoginStatus(value: false as AnyObject)
                                openMain()
                            }
                        }
                    }
                }
            }
        }else{
            if YiboPreference.getAutoLoginStatus(){
                actionLogin(username: YiboPreference.getUserName(), pwd: YiboPreference.getPwd())
            }else{
                YiboPreference.saveLoginStatus(value: false as AnyObject)
                openMain()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func openMain() -> Void {
        goMainScreen(controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let timer = self.downTimer{
            timer.invalidate()
        }
    }
    
    func actionLogin(username:String,pwd:String) -> Void {
        if isEmptyString(str: username){
            self.navigationController?.popViewController(animated: true)
            openMain()
            return
        }
        if isEmptyString(str: pwd){
            self.navigationController?.popViewController(animated: true)
            openMain()
            return
        }
        request(frontDialog: true, method: .post, loadTextStr: "正在登录中...", url:LOGIN_URL,params:["username":username,"password":pwd],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "自动登录失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        YiboPreference.saveLoginStatus(value: false as AnyObject)
                        self.openMain()
                        return
                    }
                    
                    if let result = LoginResultWraper.deserialize(from: resultJson){
                        if result.success{
//                            showToast(view: self.view, txt: "登录成功")
                            YiboPreference.saveLoginStatus(value: true as AnyObject)
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            //记住密码
                            if (YiboPreference.getPwdState()) {
                                YiboPreference.savePwd(value: pwd as AnyObject)
                            }else{
                                YiboPreference.savePwd(value: "" as AnyObject)
                            }
                            if let content = result.content{
                                if let accountType = content.accountType{
                                    YiboPreference.setAccountMode(value:accountType as AnyObject)
                                }
                            }
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "自动登录失败"))
                            }
                            YiboPreference.saveLoginStatus(value: false as AnyObject)
                        }
                    }
                    self.openMain()
        })
    }
    
    func onDomainClick() -> Void {
        let domainValue = Bundle.main.infoDictionary!["domain_url"] as! String
        viewDomainDialog(domain:domainValue)
    }
    
    func updateTime(timer:Timer) {
        COUNT_SECONDS -= 1
        if COUNT_SECONDS > 0{
            updatejumpTxt(second:COUNT_SECONDS)
        }
        if COUNT_SECONDS == 0 {
            jumpBtn.setTitle(String.init(describing: String.init(describing: "跳过")), for:.normal)
//            loadSysConfigData()
            checkVersion()
        }
    }
    
    func updatejumpTxt(second:Int) ->  Void{
        jumpBtn.setTitle(String.init(describing: String.init(format: "跳过(%d)", second)), for:.normal)
    }
    
    func startCountDown() -> Void {
        //延时1秒执行
        let time: TimeInterval = 0.2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            if self.downTimer == nil{
                self.downTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime(timer:)), userInfo: nil, repeats: true)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        downTimer?.invalidate()
        downTimer = nil;
    }
    
    func viewDomainDialog(domain:String) {
        
        let message = "域名:"+domain
        let alertController = UIAlertController(title: convertString(string: "App域名"),message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "复制", style: .default, handler: {
            action in
            UIPasteboard.general.string = domain
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkVersion(){
        request(frontDialog: true, method: .post, loadTextStr: "版本检测中...", url:CHECK_UPDATE_URL,params:["curVersion":getVerionName(),"appID":getAPPID(),"platform":"ios"],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    var findNewVersion = false
                    if resultStatus{
                        if let result = CheckUpdateWraper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                if let content = result.content{
                                    if !isEmptyString(str: content.url){
                                        self.showUpdateDialog(version: content.version, content: content.content, url: content.url)
                                        findNewVersion = true
                                        return
                                    }
                                }
                            }
                        }
                    }
                    if !findNewVersion{
                        self.loadSysConfigData()
                    }
        })
    }
    
    func showUpdateDialog(version:String,content:String,url:String) ->Void{
        let alertController = UIAlertController(title: "发现新版本",
                                                message: content, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "去更新", style: .default, handler: {
            action in
            openBrower(urlString: url)
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            self.loadSysConfigData()
        })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        do{
            var msg = getAppName() + " " + version + "\n\n"
            if !isEmptyString(str: content){
                let split = content.components(separatedBy: ";")
                if !split.isEmpty{
                    for item in split{
                        msg = msg + item + "\n"
                    }
                }else{
                    msg = msg + content
                }
            }
            msg = msg + "\n"
            let attrStr = try NSAttributedString.init(data: msg.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
            alertController.setValue(attrStr, forKey: "attributedMessage")
        }catch{
            print(error)
        }
        self.present(alertController, animated: true, completion: nil)
    }
   
    func loadSysConfigData() {
        
        request(frontDialog: true,method: .get,loadTextStr: "加载配置中...", url:SYS_CONFIG_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取配置失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        self.syncLotteryData()
                        return
                    }
                    if let result = SystemWrapper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                UserDefaults.standard.setValue(token, forKey: "token")
                            }
                            //save lottery version
                            if let config = result.content{
                                YiboPreference.setVersion(value: config.version as AnyObject)
                                if !isEmptyString(str: config.yjf){
                                    YiboPreference.setYJFMode(value: config.yjf as AnyObject)
                                }
                                YiboPreference.saveMallStyle(value: config.native_style_code as AnyObject)
                            }
                            //save system config to user default
                            YiboPreference.saveConfig(value: resultJson as AnyObject)
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取配置失败,请重试"))
                            }
                        }
                    }
                    self.syncLotteryData()
        })
    }
    
    func syncLotteryData() -> Void {
        request(frontDialog: true,loadTextStr:"正在同步彩种...", url:LOTTERYS_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取彩种失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        self.onJumpController()
                        return
                    }
                    if let result = LotterysWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            //save lottery version
                            YiboPreference.saveLotterys(value: resultJson as AnyObject)
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取彩种失败,请重试"))
                            }
                        }
                    }
                    self.onJumpController()
        })
    }

}
