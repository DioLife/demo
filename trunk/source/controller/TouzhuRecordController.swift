//
//  TouzhuRecordController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class TouzhuRecordController: BaseController,UITableViewDelegate,UITableViewDataSource,MenuBarDelegate,
LennyPullRefreshDelegate{
    
    var titleStr:String?
    var recordType:Int = MenuType.CAIPIAO_RECORD
    @IBOutlet weak var menuBar:PullMenuBar!
    @IBOutlet weak var tableView:UITableView!
    var lotteryDatas = [BcLotteryOrder]()
    var sportOrders = [SportOrder]()
    var accountChanges:[AccountRecord] = []
    var realGameResults:[RealBetBean] = []
    
    var statusCategory:String = "all"
    var dateTime:String = "today"
    var cpBianma:String = ""//查询的彩票编码,当是体育投注记录情况下，代表体育球类
    
    //体育记录过滤变量
    var dateTimeValue:String = "1";//时间
    var ballCategory:Int = 0;//球种 0-全部 1-足球 2-篮球
    
    //真人投注过滤条件
    var realDate:String = "";
    var realPlatform:String = "";
    
    //电子投注过滤条件
    var gameDate:String = "";
    var gamePlatform:String = "";
    
    var pageIndex:Int = 1
    var pageSize:Int = 40
    var totalCountFromWeb:Int = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        if let titleValue = titleStr{
            if !isEmptyString(str: titleValue){
                self.navigationItem.title = titleValue
            }else{
                self.navigationItem.title = "记录"
            }
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        setupMenuBar(type:recordType)
        tableView.delegate = self
        tableView.dataSource = self
        
        if recordType == MenuType.SPORT_RECORD && !isEmptyString(str: cpBianma){
            if cpBianma == "0"{
                ballCategory = FOOTBALL_CONSTANT
            }else if cpBianma == "1"{
                ballCategory = BASCKETBALL_CONSTANT
            }
        }
        tableView.setLennyPullRefresh(Style: .All, delegate: self)
        //load record datas from web
        loadDatas(pullDown: true,showDialog: true)
    }
    
    func LennyPullUpRequest() {
        loadDatas(pullDown: false,showDialog: false)
    }
    
    func LennyPullDownRequest() {
        loadDatas(pullDown: true,showDialog: false)
    }
    
    func loadDatas(pullDown down:Bool,showDialog:Bool) -> Void {
        
        var dataUrl = ""
        var params:Dictionary<String,AnyObject>!
        var getMethod = true
        switch recordType {
        case MenuType.CAIPIAO_RECORD,MenuType.LIUHE_RECORD:
            dataUrl = LOTTERY_RECORD_URL
            params = ["queryType":statusCategory as AnyObject,"dateTime":dateTime as AnyObject,"lotCode":cpBianma as AnyObject,
                      "page":pageIndex as AnyObject,"rows":pageSize as AnyObject]
        case MenuType.SPORT_RECORD:
            dataUrl = SPORT_RECORDS
            //若查询所有球种，则不传"sportType"到后台
            if self.ballCategory > 0{
                params = ["sportType":ballCategory as AnyObject,"date":dateTimeValue as AnyObject,"recordType":RECORD_TYPE_ALL as AnyObject]
            }else{
                params = ["date":dateTimeValue as AnyObject,"recordType":RECORD_TYPE_ALL as AnyObject]
            }
        case MenuType.REAL_MAN_RECORD:
            dataUrl = REAL_BET_RECORD_URL
            let value = convertRealMainPlatformValue(platform: realPlatform)
            params = ["dateType":realDate as AnyObject,"liveType":value as AnyObject]
            getMethod = false
        case MenuType.GAME_RECORD:
            dataUrl = GAME_BET_RECORD_URL
            let value = convertEgameValue(platform: gamePlatform)
            params = ["dateType":gameDate as AnyObject,"egameType":value as AnyObject]
        case MenuType.ACCOUNT_CHANGE_RECORD:
            dataUrl = ACCOUNT_CHANGE_RECORD_URL
            params = ["qtime":dateTime as AnyObject,"pageNumber":pageIndex as AnyObject,"pageSize":pageSize as AnyObject]
            getMethod = false
        default:
            break
        }
        print("the sport record params = ",params)
        request(frontDialog: showDialog, method:getMethod ? .get : .post, loadTextStr:"获取记录中", url:dataUrl,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    self.tableView.LennyDidCompletedWithRefreshIs(downPull: down)
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    //根据查询记录情况如彩票，六合，真人，体育，电子，帐变等类型的不同做不同的我结果解析处理
                    if self.recordType == MenuType.CAIPIAO_RECORD || self.recordType == MenuType.LIUHE_RECORD{
                        self.handleCaipiaoRecordResult(resultJson:resultJson)
                    }else if self.recordType == MenuType.SPORT_RECORD{
                        self.handleSportRecordResult(resultJson: resultJson)
                    }else if self.recordType == MenuType.ACCOUNT_CHANGE_RECORD{
                        self.handleAccountChangeResult(resultJson: resultJson)
                    }else if self.recordType == MenuType.REAL_MAN_RECORD{
                        self.handleRealPersonResult(resultJson: resultJson)
                    }
        })
    }
    
    func setupMenuBar(type:Int) -> Void {
        menuBar.menuBarDelegate = self
        menuBar.stepSubViews(type: type)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch recordType {
        case MenuType.CAIPIAO_RECORD,MenuType.LIUHE_RECORD:
            return self.lotteryDatas.count
        case MenuType.SPORT_RECORD:
            return self.sportOrders.count
        case MenuType.REAL_MAN_RECORD:
            return self.realGameResults.count
        case MenuType.GAME_RECORD:
            break
        case MenuType.ACCOUNT_CHANGE_RECORD:
            return self.accountChanges.count
        default:
            break
        }
        return 0
    }
    
    @objc func onCancelBtnClick(ui:UITableViewCell) -> Void {
        let data = self.lotteryDatas[ui.tag]
        request(frontDialog: true, method: .post, loadTextStr:"撤单中…", url:LOTTERY_CANCEL_ORDER_URL,params:["orderId":data.orderId,"lotCode":data.lotCode],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "撤单失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = CancelOrderWraper.deserialize(from: resultJson){
                        
                        if !result.success && !isEmptyString(str: result.msg){
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "撤单失败"))
                            }
                            return
                        }
                        showToast(view: self.view, txt: "撤单成功")
                        self.loadDatas(pullDown: true, showDialog: false)
                    }
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.recordType == MenuType.CAIPIAO_RECORD || self.recordType == MenuType.LIUHE_RECORD{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "touzhuRecord") as? TouzhuRecordCell  else {
                fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
            }
            cell.titleName.text = self.lotteryDatas[indexPath.row].lotName
            cell.statusStr.text = "wait"
            cell.totalMoneyStr.text = String.init(format: "下注总额:%.2f元", self.lotteryDatas[indexPath.row].buyMoney)
            cell.paijianMoney.text = String.init(format: "派奖金额:%.2f元", self.lotteryDatas[indexPath.row].winMoney)
            cell.statusStr.text = convertStatusStr(status: self.lotteryDatas[indexPath.row].status)
            cell.timeStr.text = timeStampToString(timeStamp: (self.lotteryDatas[indexPath.row].createTime)!)
            //if the status is waitting for open result, show cancel btn
            if self.lotteryDatas[indexPath.row].status == WAIT_KAIJIAN_STATUS{
                cell.cancelBtn.isHidden = false
            }else{
                cell.cancelBtn.isHidden = true
            }
            cell.cancelBtn.layer.cornerRadius = 10
            cell.cancelBtn.backgroundColor = UIColor.init(red: 245/255, green: 207/255, blue: 207/255, alpha: 1)
            cell.tag = indexPath.row
            cell.cancelBtn.addTarget(self, action: #selector(onCancelBtnClick), for: .touchUpInside)
            return cell
        }else if self.recordType == MenuType.SPORT_RECORD{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sportRecordCell") as? SportRecordCell  else {
                fatalError("The dequeued cell is not an instance of SportRecordCell.")
            }
            cell.accessoryType = .disclosureIndicator
            let data = self.sportOrders[indexPath.row]
//            cell.viewBtn.isHidden = true
            cell.ballCategoryUI.text = String.init(format: "球类: %@", convertSportBallon(ballType: data.sportType))
            cell.statusUI.text = convertSportRecordStatus(status: data.balance, betResult: data.bettingResult)
            if data.balance == BALANCE_UNDO{
                cell.statusUI.textColor = UIColor.lightGray
            }else if data.balance == BALANCE_CUT_GAME{
                cell.statusUI.textColor = UIColor.red
            }else if data.balance == BALANCE_DONE || data.balance == BALANCE_AGENT_HAND_DONE || data.balance == BALANCE_BFW_DONE {
                if data.bettingResult > 0{
                    cell.statusUI.textColor = UIColor.blue
                }else{
                    cell.statusUI.textColor = UIColor.red
                }
            }
            cell.touzhuMoneyUI.text = String.init(format: "投注金额: %.2f元", data.bettingMoney)
            cell.timeUI.text = timeStampToString(timeStamp: data.bettingDate)
//            cell.viewBtn.layer.cornerRadius = 14
//            cell.viewBtn.isUserInteractionEnabled = false
//            cell.viewBtn.backgroundColor = UIColor.init(red: 245/255, green: 207/255, blue: 207/255, alpha: 1)
            return cell
        }else if self.recordType == MenuType.ACCOUNT_CHANGE_RECORD{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountChangeCell") as? AccountChangeCell  else {
                fatalError("The dequeued cell is not an instance of AccountChangeCell.")
            }
            let data = self.accountChanges[indexPath.row]
            cell.orderidUI.text = String.init(format: "订单号: %@", data.orderno)
            cell.frontMoneyUI.text = String.init(format: "变动前金额:%.2f元", data.moneyBefore)
            cell.afterMoneyUI.text = String.init(format: "变动后金额:%.2f元", data.moneyAfter)
            cell.changeMoneyUI.text = String.init(format: "变动金额:%.2f元", (data.moneyAfter - data.moneyBefore))
            cell.datetimeUI.text = data.timeStr
            return cell
        }else if self.recordType == MenuType.REAL_MAN_RECORD {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "realManCell") as? RealManCell  else {
                fatalError("The dequeued cell is not an instance of realPersonCell.")
            }
            let data = self.realGameResults[indexPath.row]
            cell.platformTypeUI.text = String.init(format: "平台类型: %@", data.gameType)
            cell.yinkuiUI.text = String.init(format: "盈亏: %.2f元", data.payMoney)
            cell.moneyUI.text = String.init(format: "投注金额: %.2f", data.betMoney)
            cell.dateUI.text = data.bettime
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch recordType {
        case MenuType.CAIPIAO_RECORD,MenuType.LIUHE_RECORD:
            let loginVC = UIStoryboard(name: "touzhu_record_detail", bundle: nil).instantiateViewController(withIdentifier: "recordDetail")
            let recordPage = loginVC as! TouzhuRecordDetailController
            let data = self.lotteryDatas[indexPath.row]
            recordPage.orderId = data.orderId
            recordPage.cpBianma = data.lotCode
            self.navigationController?.pushViewController(recordPage, animated: true)
        case MenuType.SPORT_RECORD:
            let loginVC = UIStoryboard(name: "sport_order_detail", bundle: nil).instantiateViewController(withIdentifier: "sportOrderDetail")
            let recordPage = loginVC as! SportOrderDetailController
            let data = self.sportOrders[indexPath.row]
            recordPage.orderId = data.id
            self.navigationController?.pushViewController(recordPage, animated: true)
            break
        case MenuType.REAL_MAN_RECORD:
            break
        case MenuType.GAME_RECORD:
            break
        case MenuType.ACCOUNT_CHANGE_RECORD:

            let changeJson = self.accountChanges[indexPath.row].toJSONString()
            let loginVC = UIStoryboard(name: "account_detail_page", bundle: nil).instantiateViewController(withIdentifier: "accountChangeDetail")
            let recordPage = loginVC as! AccountChangeDetailController
            if let txt = changeJson{
                recordPage.changeJson = txt
            }
            self.navigationController?.pushViewController(recordPage, animated: true)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch recordType {
        case MenuType.CAIPIAO_RECORD,MenuType.LIUHE_RECORD:
            return 80
        case MenuType.SPORT_RECORD:
            return 80
        case MenuType.REAL_MAN_RECORD:
            return 75
        case MenuType.GAME_RECORD:
            break
        case MenuType.ACCOUNT_CHANGE_RECORD:
            return 100
        default:
            break
        }
        return 80
    }
    
    func convertStatusStr(status:Int) -> String {
        switch status {
        case WAIT_KAIJIAN_STATUS:
            return "未开奖"
        case ALREADY_WIN_STATUS:
            return "已中奖"
        case NOT_WIN_STATUS:
            return "未中奖"
        case CANCEL_ORDER_STATUS:
            return "已撤单"
        case ROLLBACK_SUCCESS_STATUS:
            return "派奖回滚成功"
        case ROLLBACK_FAIL_STATUS:
            return "回滚异常"
        case EXCEPTION_KAIJIAN_STATUS:
            return "开奖异常"
        default:
            break
        }
        return "未开奖"
    }
    
    //点击bar item时回调的item key
    func onMenuItemClick(key: String,itemTag:String) {
        print("callback key === \(key),itemtag = \(itemTag)")
//        if isEmptyString(str: key){
//            return
//        }
        if itemTag == "00"{
            self.statusCategory = key
        } else if itemTag == "01"{
            self.dateTime = key
        } else if itemTag == "02"{
            self.cpBianma = key
        } else if itemTag == "10"{
            self.dateTime = key
        } else if itemTag == "20"{
            self.dateTimeValue = key
        } else if itemTag == "21"{
            self.ballCategory = Int(key)!
        } else if itemTag == "30"{
            self.realDate = key
        } else if itemTag == "31"{
            self.realPlatform = key
        } else if itemTag == "40"{
            self.gameDate = key
        } else if itemTag == "41"{
            self.gamePlatform = key
        } else if itemTag == "50"{
            self.dateTime = key
        }
        loadDatas(pullDown: true,showDialog: true)
    }
    
    func handleRealPersonResult(resultJson:String) -> Void {
        
        if let result = RealBetResultWraper.deserialize(from: resultJson){
            
            if !result.success && !isEmptyString(str: result.msg){
                if !isEmptyString(str: result.msg){
                    showToast(view: self.view, txt: result.msg)
                }else{
                    showToast(view: self.view, txt: convertString(string: "获取记录失败"))
                }
                loginWhenSessionInvalid(controller: self)
                return
            }
            if result.code != 200{
                if !isEmptyString(str: result.message){
                    showToast(view: self.view, txt: result.message)
                }else{
                    showToast(view: self.view, txt: convertString(string: "获取记录失败"))
                }
                return
            }
            self.realGameResults.removeAll()
            self.realGameResults = self.realGameResults + result.data
            self.tableView.reloadData()
        }
    }
    
    func handleAccountChangeResult(resultJson:String) -> Void {
        
        if let result = AccountRecordWraper.deserialize(from: resultJson){
            if result.success{
                YiboPreference.setToken(value: result.accessToken as AnyObject)
                if let datas = result.content{
                    self.accountChanges.removeAll()
                    self.accountChanges = self.accountChanges + datas.results
                }
                self.tableView.reloadData()
            }else{
                if !isEmptyString(str: result.msg){
                    showToast(view: self.view, txt: result.msg)
                }else{
                    showToast(view: self.view, txt: convertString(string: "获取记录失败"))
                }
                if (result.code == 0) {
                    loginWhenSessionInvalid(controller: self)
                }
            }
        }
    }
    
    func handleCaipiaoRecordResult(resultJson:String) -> Void {
        if let result = LotteryRecordWrapper.deserialize(from: resultJson){
            if result.success{
                YiboPreference.setToken(value: result.accessToken as AnyObject)
                if  self.pageIndex == 1{
                    self.lotteryDatas.removeAll()
                }
                self.totalCountFromWeb = (result.content?.totalCount)!
                if result.content != nil{
                    if self.recordType == MenuType.CAIPIAO_RECORD{
                        var datas = [BcLotteryOrder]()
                        for bc in (result.content?.results)!{
                            //当前若是彩票投注记录，则过滤掉六合彩LHC的投注记录
//                            if (bc.lotCode != "LHC") {
                                datas.append(bc);
//                            }
                        }
                        self.lotteryDatas.removeAll()
                        self.lotteryDatas += datas
                    }else{
                        self.lotteryDatas += (result.content?.results)!
                    }
                    self.tableView.reloadData()
                    if self.totalCountFromWeb <= self.lotteryDatas.count{
                        //                                        recordList.setPullLoadEnable(false);
                    }else{
                        //                                        recordList.setPullLoadEnable(true);
                    }
                    //                                    self.pageIndex = self.pageIndex + 1
                }
            }else{
                if !isEmptyString(str: result.msg){
                    showToast(view: self.view, txt: result.msg)
                }else{
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }
                if (result.code == 0) {
                    loginWhenSessionInvalid(controller: self)
                }
            }
        }
    }
    
    
    func handleSportRecordResult(resultJson:String) -> Void {
        if let result = SportOrderWraper.deserialize(from: resultJson){
            if result.success{
                YiboPreference.setToken(value: result.accessToken as AnyObject)
//                if  self.pageIndex == 1{
//                self.sportOrders.removeAll()
//                }
                if let datas = result.content{
                    self.sportOrders.removeAll()
                    self.sportOrders = self.sportOrders + datas
                }
                self.tableView.reloadData()
            }else{
                if !isEmptyString(str: result.msg){
                    showToast(view: self.view, txt: result.msg)
                }else{
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }
                if (result.code == 0) {
                    loginWhenSessionInvalid(controller: self)
                }
            }
        }
    }
}

