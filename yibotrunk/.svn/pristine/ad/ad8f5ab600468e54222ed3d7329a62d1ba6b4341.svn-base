//
//  FeeConvertController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//额度转换
class FeeConvertController: BaseController,UITableViewDelegate,UITableViewDataSource,ConvertDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    var datas:[OtherPlay] = []
    
    var convertWindow:ConvertWindow!
    var _activityIndeView:UIActivityIndicatorView!
    
    let SHABA_CODE = "shaba"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "额度转换"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        _activityIndeView = activityIndeView()
//        //当键盘弹起的时候会向系统发出一个通知，
//        //这个时候需要注册一个监听器响应该通知
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//        //当键盘收起的时候会向系统发出一个通知，
//        //这个时候需要注册另外一个监听器响应该通知
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        loadDatas()
    }
    
    func loadDatas() -> Void {
        request(frontDialog: true,method: .get, loadTextStr:"正在获取...",url: REAL_CONVERT_DATA_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result =  OtherPlayWrapper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if let content = result.content{
                                self.datas.removeAll()
                                self.datas = self.datas + content
                                self.tableView.reloadData()
                            }
                            //开始异步获取各游戏的余额
                            self.getBalances(datas: self.datas);
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func getBalance(gameCode:String) -> Void {
        
        var url = ""
        if gameCode == SHABA_CODE{
            url = SBSPORT_BALANCE_URL
        }else{
            url = REAL_GAME_BALANCE_URL
        }
        var code = gameCode
        if gameCode == "kyqp"{
            code = "ky"
        }
        request(frontDialog: false,method: .post,url: url,params:["type":code],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    self._activityIndeView.stopAnimating()
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "同步余额失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    let data = resultJson.data(using: String.Encoding.utf8, allowLossyConversion: true)
                    //把Data对象转换回JSON对象
                    let json = try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                    if (json?.keys.contains("balance"))!{
                        for index in 0...self.datas.count-1{
                            let play = self.datas[index]
                            if play.playCode == gameCode{
                                let m = json!["balance"] as! NSNumber
                                play.balance = m.floatValue
                                self.datas[index] = play
                                self.tableView.reloadData()
                                break
                            }
                        }
                    }else if (json?.keys.contains("money"))!{
                        for index in 0...self.datas.count-1{
                            let play = self.datas[index]
                            if play.playCode == gameCode{
                                let m = json!["money"] as! NSNumber
                                play.balance = m.floatValue
                                self.datas[index] = play
                                self.tableView.reloadData()
                                break
                            }
                        }
                    }
        })
    }
    
    func activityIndeView() -> UIActivityIndicatorView {
        if _activityIndeView == nil{
            _activityIndeView = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
            _activityIndeView.hidesWhenStopped = true
        }
        return _activityIndeView
    }
    
    //获取每种游戏余额
    func getBalances(datas:[OtherPlay]) -> Void {
        if datas.isEmpty{
            return
        }
        for play in datas{
            self._activityIndeView.startAnimating()
            getBalance(gameCode: play.playCode)
        }
    }
    
    func requestSbSportUrl(){
        request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:SPSPORT_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SBSportForwardWrapper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.content){
                                openBrower(urlString: result.content)
                            }else{
                                showToast(view: self.view, txt: "没有链接，无法打开")
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                                if result.msg == "超时" || result.msg == "登录"{
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                            }
                        }
                    }
        })
    }
    
    //点击进入游戏
    func clickEnterGame(btn:UIButton) -> Void {
        
        let playCode = self.datas[btn.tag].playCode
        var url = ""
        var params:Dictionary<String,AnyObject> = [:]
        if playCode == "ag"{//AG真人娱乐
            url = url + REAL_AG_URL
            params["h5"] = 1 as AnyObject
            params["gameType"] = 11 as AnyObject
        }else if playCode == "mg"{//MG真人娱乐
            url = url + REAL_MG_URL
            params["gameId"] = 66936 as AnyObject
            params["gameType"] = 1 as AnyObject
        }else if playCode == "bbin"{//BBIN真人娱乐
            url = url + REAL_BBIN_URL
            params["type"] = "live" as AnyObject
        }else if playCode == "ab"{//ab真人娱乐
            url = url + REAL_AB_URL
        }else if playCode == "og"{//OG真人娱乐
            url = url + REAL_OG_URL
        }else if playCode == "ds"{//ds真人娱乐
            url = url + REAL_DS_URL
        }else if playCode == "mg" || playCode == "pt" || playCode == "qt"{
            //MG,PT电子是先在自已应用内部展示游戏列表，点列表项再请求数据
            var name = playCode == "mg" ? "MG电子游戏" : "PT电子游戏"
            if playCode == "qt"{
                name = "QT电子游戏"
            }
            actionOpenGameList(controller: self,gameCode: playCode,title: name)
            return
        }else if playCode == "qt"{//BBIN真人娱乐
            showToast(view: self.view, txt: "即将开放")
            return;
        }else if playCode == "bydr"{
            url = url + "/forwardAg.do"
            params["h5"] = 0 as AnyObject
            params["gameType"] = 6 as AnyObject
        }
        else if playCode == SHABA_CODE{
            requestSbSportUrl()
            return
        }else if playCode == "nb" || playCode == "kyqp"{
            var title = "NB电子"
            if playCode == "kyqp"{
                title = "开元棋牌"
            }
            actionOpenGameList(controller: self,gameCode: playCode,title: title)
            return
        }else if playCode == TT_CODE{
            url = url + GAME_TT_URL
        }
            
        request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:url,
               params: params,
               callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    if resultJson.isEmpty {
                        showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                    }else{
                        showToast(view: self.view, txt: resultJson)
                    }
                    return
                }
                if let result = RealPlayWraper.deserialize(from: resultJson){
                    if result.success{
                        if !isEmptyString(str: result.url){
                            openBrower(urlString: result.url)
                        }
                    }else{
                        if !isEmptyString(str: result.msg){
                            showToast(view: self.view, txt: result.msg)
                        }else{
                            showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                        }
                    }
                }
        })
    }
    
    func showConvertWindow(code:String,title:String,sin:Bool) -> Void {
        if convertWindow == nil{
            convertWindow = Bundle.main.loadNibNamed("convert_window", owner: nil, options: nil)?.first as! ConvertWindow
        }
        convertWindow.convertDelegate = self
        convertWindow.setData(code:code,title:title,convertIn: sin)
        convertWindow.show()
    }
    
    func convertInOut(sin:Bool,code:String,title:String) -> Void {
        showConvertWindow(code: code, title: title,sin:sin)
    }
    
    func showSheetConvertDialog(code:String,title:String) -> Void {
        let alert = UIAlertController.init(title: "额度转换", message: nil, preferredStyle: .actionSheet)
        let convertInAction = UIAlertAction.init(title: "转入", style: .default, handler: {(action:UIAlertAction) in
            self.convertInOut(sin:true,code:code,title: title)
        })
        let convertOutAction = UIAlertAction.init(title: "转出", style: .default, handler: {(action:UIAlertAction) in
            self.convertInOut(sin:false,code:code,title: title)
        })
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(convertInAction)
        alert.addAction(convertOutAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击列表项弹也转换列表
        let data = self.datas[indexPath.row]
        showSheetConvertDialog(code:data.playCode,title: data.title)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "convertCell") as? ConvertListCell  else {
            fatalError("The dequeued cell is not an instance of ConvertListCell.")
        }
        let data = self.datas[indexPath.row]
        cell.enterBtn.tag = indexPath.row
        cell.gameNameUI.text = data.title
        cell.moneyUI.text = String.init(format: "%.2f元", data.balance)
        cell.enterBtn.addTarget(self, action: #selector(clickEnterGame(btn:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    func onConvert(code: String,fromSys:Bool,money:String) {
        //开始发起转换
        if isEmptyString(str: money){
            showToast(view: self.view, txt: "请输入金额")
            return
        }
        if !isPurnInt(string: money){
            showToast(view: self.view, txt: "金额须为整数")
            return
        }
        if (fromSys) {
            actionConvert(from: "sys", to: code, money: money,fromSys:true)
        }else{
            actionConvert(from: code, to: "sys", money: money,fromSys:false)
        }
    }
    
    func actionConvert(from:String,to:String,money:String,fromSys:Bool) -> Void {
        
        
        var url = ""
        var params:Dictionary<String,AnyObject> = [:]
        if to == SHABA_CODE || from == SHABA_CODE{
            url = SBFEE_CONVERT_URL
            params = ["changeFrom":from,"changeTo":to,"quota":money,"v":"fafsdafsdafds"] as Dictionary<String, AnyObject>
        }else{
            url = FEE_CONVERT_URL
            var myto = to
            var myfrom = from
            if fromSys{
                if myto == "kyqp"{
                    myto = "ky"
                }
            }else{
                if myfrom == "kyqp"{
                    myfrom = "ky"
                }
            }
            params = ["changeFrom":myfrom,"changeTo":myto,"quota":money] as Dictionary<String, AnyObject>
        }
        request(frontDialog: true,method: .post, loadTextStr:"转换中.", url:url,
                params: params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "额度转换失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    let data = resultJson.data(using: String.Encoding.utf8, allowLossyConversion: true)
                    //把Data对象转换回JSON对象
                    let json = try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                    if (json?.keys.contains("success"))!{
                        let ok = json!["success"] as! Bool
                        if ok{
                            showToast(view: self.view, txt: "额度转换成功")
                            //成功转换后，刷新余额
                            self.getBalance(gameCode: fromSys ? to : from)
                        }else{
                            if (json?.keys.contains("msg"))!{
                                let msg = json!["msg"] as! String
                                if msg == "登录" || msg == "超时"{
                                    showToast(view: self.view, txt: "请先登录再重试")
                                    loginWhenSessionInvalid(controller: self)
                                }else{
                                    showToast(view: self.view, txt: json!["msg"] as! String)
                                }
                            }else{
                                showToast(view: self.view, txt: "额度转换失败")
                            }
                        }
                    }
        })
    }
    
    
    
}
