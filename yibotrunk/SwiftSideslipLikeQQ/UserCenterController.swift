//
//  UserCenterController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/2.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//


import UIKit
import HandyJSON

class UserCenterController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    var datas:[String] = []
//    var headerView:UIView!
    var accountTV:UILabel!
    var levelImg:UIImageView!
    var levelTV:UILabel!
    var scoreTV:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = addHeaderContent()
        self.title = "用户中心"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        loadAccountData()
//        loadDatas()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "userCenterCell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "userCenterCell")
        }
        cell?.textLabel?.text = self.datas[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.textLabel?.textColor = UIColor.lightGray
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func loadAccountData() -> Void {
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
                        //加载数据
                        self.loadDatas()
                    }
                }
            }
        })
    }
    
    func addHeaderContent() -> UIView {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 80))
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 80))
        bg.image = UIImage.init(named: "member_page_header")
        headerView.addSubview(bg)
        
        accountTV = UILabel.init(frame: CGRect.init(x: 16, y: 8, width: kScreenWidth-32, height: 20))
        levelImg = UIImageView.init(frame: CGRect.init(x: 16, y: 28, width: 20, height: 20))
        levelTV = UILabel.init(frame: CGRect.init(x: 43, y: 28, width: kScreenWidth-66, height: 20))
        scoreTV = UILabel.init(frame: CGRect.init(x: 16, y: 48, width: kScreenWidth-32, height: 20))
        
        accountTV.font = UIFont.systemFont(ofSize: 14)
        levelTV.font = UIFont.systemFont(ofSize: 14)
        scoreTV.font = UIFont.systemFont(ofSize: 14)
        accountTV.textColor = UIColor.white
        levelTV.textColor = UIColor.white
        scoreTV.textColor = UIColor.white
        
        bg.addSubview(accountTV)
        bg.addSubview(levelImg)
        bg.addSubview(levelTV)
        bg.addSubview(scoreTV)
        return headerView
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var accountNameStr = ""
        if !isEmptyString(str: memInfo.account){
            accountNameStr = String.init(format: "会员帐号：%@", memInfo.account)
        }else{
            accountNameStr = "会员帐号：暂无"
        }
        accountTV.text = accountNameStr
        levelTV.text = !isEmptyString(str: memInfo.level) ? memInfo.level : "默认等级"
        updateLevelLogo(icon: memInfo.level_icon, image: self.levelImg)
        scoreTV.text = "会员积分：\(memInfo.score)"
    }
    
    func updateLevelLogo(icon:String,image:UIImageView) -> Void {
        if !isEmptyString(str: icon){
            if let url = URL.init(string: icon){
                downloadImage(url: url, imageUI: image)
            }
        }else{
            image.image = UIImage.init(named: "default_placeholder_picture.png")
        }
    }
    
    func loadDatas() -> Void {
        request(frontDialog: true, url:ACCOUNT_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = AccountResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                UserDefaults.standard.setValue(result.accessToken, forKey: "token")
                            }
                            //fill order details
                            if let data = result.content{
                                self.datas.removeAll()
                                self.fileContents(detail: data)
                                self.tableView.reloadData()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败,请重试"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    
    func fileContents(detail:AccountResult) ->   Void{
        self.datas.append(String.init(format: "帐号：%@", !isEmptyString(str: detail.account) ? detail.account : ""))
        self.datas.append(String.init(format: "真实姓名：%@", !isEmptyString(str: detail.userName) ? detail.userName : ""))
        self.datas.append(String.init(format: "手机号码：%@", !isEmptyString(str: detail.phone) ? detail.phone : ""))
        self.datas.append(String.init(format: "邮箱：%@", !isEmptyString(str: detail.email) ? detail.email : ""))
        self.datas.append(String.init(format: "QQ：%@", !isEmptyString(str: detail.qq) ? detail.qq : ""))
        self.datas.append(String.init(format: "微信：%@", !isEmptyString(str: detail.wechat) ? detail.wechat : ""))
        self.datas.append(String.init(format: "卡号：%@", !isEmptyString(str: detail.cardNo) ? detail.cardNo : ""))
        self.datas.append(String.init(format: "开户行：%@", !isEmptyString(str: detail.bankName) ? detail.bankName : ""))
        self.datas.append(String.init(format: "开户行地址：%@", !isEmptyString(str: detail.bankAddress) ? detail.bankAddress : ""))
        print(self.datas)
    }
    
    func convertBalanceStatus(status:Int) -> String {
        if (status == BALANCE_UNDO) {
            return "未结算";
        }
        if (status == BALANCE_CUT_GAME) {
            return "赛事取消";
        }
        
        if(status == BALANCE_DONE || status == BALANCE_AGENT_HAND_DONE
            || status == BALANCE_BFW_DONE){
            return "已结算";
        }
        return "未结算";
    }
    
    func convertSportCommitStatus(mode:Int) -> String {
        if mode == 1{
            return "待确认"
        }else if mode == 2{
            return "已确认"
        }else if mode == 3{
            return "已取消"
        }else if mode == 4{
            return "手动取消"
        }
        return "待确认"
    }
    
}
