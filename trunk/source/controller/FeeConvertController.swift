//
//  FeeConvertController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher
//额度转换
class FeeConvertController: BaseController,UITableViewDelegate,UITableViewDataSource,ConvertDelegate {
    
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerBgImage: UIImageView!
    @IBOutlet weak var balanceUI:UILabel!
    @IBOutlet weak var tableView:UITableView!
    var datas:[OtherPlay] = []
    
    var convertWindow:ConvertWindow!
    var _activityIndeView:UIActivityIndicatorView!
    
    let REAL_CODE = "shaba";

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {} else { self.automaticallyAdjustsScrollViewInsets = false}
        self.title = "额度转换"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        _activityIndeView = activityIndeView()
        loadDatas()
        accountWeb()
        headerBgImage.theme_image = "General.personalHeaderBg"
        headerImage.theme_image = "General.placeHeader"
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
        if gameCode == REAL_CODE{
            url = SBSPORT_BALANCE_URL
        }else{
            url = REAL_GAME_BALANCE_URL
        }
        request(frontDialog: false,method: .post,url: url,params:["type":gameCode],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    self._activityIndeView.stopAnimating()
                    if isEmptyString(str: resultJson){
                        return
                    }
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
                    if !JSONSerialization.isValidJSONObject(json){
                        return
                    }
                    if (json?.keys.contains("success"))!{
                        let ok = json!["success"] as! Bool
                        if ok{
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
                        }else{
                            if (json?.keys.contains("msg"))!{
                                showToast(view: self.view, txt: json!["msg"] as! String)
                            }else{
//                                showToast(view: self.view, txt: "额度转换失败")
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
    
    //点击进入游戏
    @objc func clickEnterGame(btn:UIButton) -> Void {
        let playCode = self.datas[btn.tag].playCode
        print("the playcode = ",playCode)
        //真人
        if playCode == "ab" || playCode == "bbin" || playCode == "mg" || playCode == "ab" ||
            playCode == "og" || playCode == "ds" || playCode == "ag"{
            forwardReal(controller: self, requestCode: 0, playCode: playCode)
        }else if playCode == "shaba"{
            showToast(view: self.view, txt: "开发中，敬请期待")
        }else{
            //電子
            if playCode == "bydr" || playCode == "bbin" || playCode == "ab"{
                forwardGame(controller: self, playCode: playCode, gameCodeOrID: "")
            }else {
                let vc = UIStoryboard(name: "innner_game_list", bundle: nil).instantiateViewController(withIdentifier: "gameList") as! GameListController
                vc.gameCode = playCode
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
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
        //ipad使用，不加ipad上会崩溃
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect.init(x: kScreenWidth/4, y: kScreenHeight, width: kScreenWidth/2, height: 300)
        }
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
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "convertCell") as? ConvertListCell  else {
            fatalError("The dequeued cell is not an instance of ConvertListCell.")
        }
        let data = self.datas[indexPath.row]
        cell.enterBtn.tag = indexPath.row
        if let imageURL = URL(string: BASE_URL + PORT + data.imgUrl) {
            cell.iconImage.kf.setImage(with: ImageResource(downloadURL: imageURL))
        }
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
        if code == REAL_CODE{
            showToast(view: self.view, txt: "暂未开放，敬请期待")
            return
        }
        if (fromSys) {
            actionConvert(from: "sys", to: code, money: money,fromSys:true)
        }else{
            actionConvert(from: code, to: "sys", money: money,fromSys:false)
        }
    }
    
    func accountWeb() -> Void {
        //帐户相关信息
        request(frontDialog: false, url:MEMINFO_URL,
                           callback: {(resultJson:String,resultStatus:Bool)->Void in
                            if !resultStatus {
                                return
                            }
                            if let result = MemInfoWraper.deserialize(from: resultJson){
                                if result.success{
                                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                                    if let memInfo = result.content{
                                        self.updateAccount(memInfo:memInfo);
                                    }
                                }
                            }
        })
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = "\(memInfo.balance)"
        }else{
            leftMoneyName = "0"
        }
        balanceUI.text = String.init(format: "账户余额:%@元",  leftMoneyName)
    }
    
    func actionConvert(from:String,to:String,money:String,fromSys:Bool) -> Void {
        
        var url = ""
        if to == REAL_CODE || from == REAL_CODE{
            url = SBFEE_CONVERT_URL
        }else{
            url = FEE_CONVERT_URL
        }
        let params = ["changeFrom":from,"changeTo":to,"money":money] as Dictionary<String, AnyObject>
        request(frontDialog: true,method: .post, loadTextStr:"转换中...", url:url,
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
                    if isEmptyString(str: resultJson){
                        return
                    }
                    let data = resultJson.data(using: String.Encoding.utf8, allowLossyConversion: true)
                    //把Data对象转换回JSON对象
                    let json = try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                    if (json?.keys.contains("success"))!{
                        let ok = json!["success"] as! Bool
                        if ok{
                            showToast(view: self.view, txt: "额度转换成功")
                            self.getBalance(gameCode: fromSys ? to : from)
                        }else{
                            if (json?.keys.contains("msg"))!{
                                showToast(view: self.view, txt: json!["msg"] as! String)
                            }else{
                                showToast(view: self.view, txt: "额度转换失败")
                            }
                        }
                    }
        })
    }
    
    
    
}
