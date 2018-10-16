//
//  TouzhuOrderController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class TouzhuOrderController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var againBtn:UIButton!
    @IBOutlet weak var randomBtn:UIButton!
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var zuihaoBtn:UIButton!
    @IBOutlet weak var touzhuBtn:UIButton!
    @IBOutlet weak var totalLabel:UILabel!
    var datas:[OrderDataInfo] = []
    var order:[OrderDataInfo]?
    var cpBianHao = "" // 彩票编号
    var cpTypeCode = "" //彩票类型
    var cpName = "" //  彩票名字
    var subPlayCode = ""
    var subPlayName = ""
    var cpVersion = "" //版本
    var lotteryIcon = ""//icon
    var officail_odds:[PeilvWebResult] = []
    var meminfo:Meminfo?
    
    
    var actionButton: ActionButton!//悬浮按钮

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        
        self.navigationItem.title = String.init(format: "购彩列表(%@)", cpName)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView.init(frame: CGRect.zero)
        
        zuihaoBtn.layer.cornerRadius = 3
        touzhuBtn.layer.cornerRadius = 3
        
        zuihaoBtn.backgroundColor = UIColor.init(hex: 0xff9c00)
        touzhuBtn.backgroundColor = UIColor.init(hex: 0xC81012)
        
        zuihaoBtn.setTitleColor(UIColor.white, for: .normal)
        touzhuBtn.setTitleColor(UIColor.white, for: .normal)
        
        againBtn.theme_setTitleColor("Global.themeColor", forState: .normal)
        randomBtn.theme_setTitleColor("Global.themeColor", forState: .normal)
        setupNoPictureAlphaBgView(view: againBtn)
        setupNoPictureAlphaBgView(view: randomBtn)
        againBtn.addTarget(self, action: #selector(onAgainBtn), for: .touchUpInside)
        randomBtn.addTarget(self, action: #selector(onRandomBtn), for: .touchUpInside)
        
        zuihaoBtn.addTarget(self, action: #selector(onZuiHaoClick), for: .touchUpInside)
        touzhuBtn.addTarget(self, action: #selector(onTouzhuClick), for: .touchUpInside)
        
//        actionButton = createCommonFAB(controller:self)
        
        if !self.datas.isEmpty{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "清空", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClearList))
        }
        
        let orderJson = YiboPreference.getTouzhuOrderJson()
        if !isEmptyString(str: orderJson){
            if let data = order{
                self.datas = self.datas + data
                let result:[OrderDataInfo] = JSONDeserializer<OrderDataInfo>.deserializeModelArrayFrom(json: orderJson)! as! [OrderDataInfo]
                for info in result{
//                    if !(info.numbers == info.numbers && info.subPlayCode == info.subPlayCode){
                        self.datas.append(info)
//                    }
                }
            }
        }else{
            if let data = order{
                self.datas = self.datas + data
            }
        }
        setBottomValue()
        tableview.reloadData()
    }
    
    @objc func onAgainBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onRandomBtn(){
        let orders = JianjinLotteryLogic.randomBet(orderCount: 1, cpCode: self.cpTypeCode, selectedSubCode: self.subPlayCode, peilv: self.officail_odds)
        if orders.isEmpty{
            showToast(view: self.view, txt: "没有机选出注单，请重试")
            return
        }
        for item in orders{
            if item.a == 0{
                item.a = 2
            }
            if item.n == 0{
                item.n = 1
            }
        }
        let order = fromBetOrder(official_orders: orders, subPlayName: self.subPlayName, subPlayCode: self.subPlayCode, selectedBeishu: 1, cpTypeCode: self.cpTypeCode, cpBianHao: self.cpBianHao, current_rate: 0, selectMode: "1")
        self.datas = order + self.datas
        self.tableview.reloadData()
        self.setBottomValue()
    }
    
    func buildTouzhuData(cpCode:String,cpName:String,playCode:String,playName:String,
                         subPlayCode:String,subPlayName:String,zhushu:Int,money:Float,
                         numbers:String,mode:Int) -> OrderDataInfo {
        let orderInfo = OrderDataInfo()
        orderInfo.playName = playName
        orderInfo.subPlayName = subPlayName
        orderInfo.playCode = playCode
        orderInfo.subPlayCode = subPlayCode
        orderInfo.beishu = 1
        orderInfo.zhushu = zhushu
        orderInfo.money = Double(money)
        orderInfo.numbers = numbers
        orderInfo.cpCode = cpCode
        orderInfo.lotcode = cpCode
        orderInfo.mode = mode
        return orderInfo
    }
    
//    func createCommonFAB(controller:UIViewController) -> ActionButton {
//        var items:[(title:String,imgname:String,action: (ActionButtonItem) -> Void)] = []
//        let manualItem = (title:"手选一单",imgname:"manual_bet_icon",action:{(item:ActionButtonItem)->Void in
//            self.navigationController?.popViewController(animated: true)
//        })
//        let randomItem = (title:"机选一单",imgname:"random_bet_icon",action:{(item:ActionButtonItem)->Void in
//            let orders = JianjinLotteryLogic.randomBet(orderCount: 1, cpCode: self.cpTypeCode, selectedSubCode: self.subPlayCode, peilv: self.officail_odds)
//            if orders.isEmpty{
//                showToast(view: self.view, txt: "没有机选出注单，请重试")
//                return
//            }
//            for item in orders{
//                if item.a == 0{
//                    item.a = 2
//                }
//                if item.n == 0{
//                    item.n = 1
//                }
//            }
//            let order = fromBetOrder(official_orders: orders, subPlayName: self.subPlayName, subPlayCode: self.subPlayCode, selectedBeishu: 1, cpTypeCode: self.cpTypeCode, cpBianHao: self.cpBianHao, current_rate: 0, selectMode: "1")
//            self.datas = order + self.datas
//            self.tableview.reloadData()
//            self.setBottomValue()
//        })
//        items.append(manualItem)
//        items.append(randomItem)
//        return showFAB(attachView: controller.view, items: items)
//    }
    
    @objc func onClearList() -> Void {
        self.datas.removeAll()
        self.tableview.reloadData()
        self.navigationItem.rightBarButtonItems?.removeAll()
        setBottomValue()
    }
    
    @objc func onZuiHaoClick() -> Void {
        if self.datas.isEmpty{
            showToast(view: self.view, txt: "您还没有选择下注号码！")
            return
        }
        openBraveZuiHaoPage(controller: self,order: self.datas,lotCode: self.cpBianHao,lotName: self.cpName,cpVersion: self.cpVersion,cptype: self.cpTypeCode)
    }
    
    @objc func setBottomValue() -> Void {
        if self.datas.isEmpty{
            totalLabel.text = String.init(format: "%d注%d元", 0,0)
            return
        }
        
        var totalZhushu = 0
        var totalMoney:Float = 0
        for info in self.datas{
            totalZhushu = totalZhushu + info.zhushu
            totalMoney = totalMoney + Float(info.money)
        }
//        let mode = self.datas.count > 0 ? self.datas[0].mode : 1
//        totalLabel.text = String.init(format: "%d注%.2f元", totalZhushu,totalMoney / Float(mode))
        totalLabel.text = String.init(format: "%d注%.2f元", totalZhushu,totalMoney)
    }
    
    ///MARK :投注后触发的方法
    @objc func onTouzhuClick() -> Void {
//        WHC_ModelSqlite.removeAllModel()
        self.postBets();
        
        let record:VisitRecords = VisitRecords()
        record.cpName = cpName //名字
        record.czCode = cpTypeCode //类型
        record.ago = "0" // 时间差 传默认值
        record.cpBianHao = cpBianHao //编号
        record.lotType = cpTypeCode //类型
        record.lotVersion = cpVersion //版本
        record.icon = lotteryIcon //icon
        CommonRecords.updateRecordInDB(record: record);
        
        ///MARK: 记录用户访问痕迹 到数据库
//        let resultArr:[VisitRecords] = WHC_ModelSqlite.query(VisitRecords.self, where: "cpBianHao = '\(cpBianHao)'") as! [VisitRecords]
//        if resultArr.count == 0 {
//            let record:VisitRecords = VisitRecords()
//            record.cpName = cpName //名字
//            record.czCode = cpTypeCode //类型
//            record.ago = "0" // 时间差 传默认值
//            record.cpBianHao = cpBianHao //编号
//            record.lotType = cpTypeCode //类型
//            record.lotVersion = cpVersion //版本
//            record.num = "1"
//            WHC_ModelSqlite.insert(record)
//        }else{
//            let record:VisitRecords = resultArr[0]
//            let bianhao:String = record.cpBianHao!
//            var num:Int = Int(record.num!)!
//            num += 1
//            let num2:String = String(num)
//            WHC_ModelSqlite.update(VisitRecords.self, value: "num = '\(num2)'", where: "cpBianHao = '\(bianhao)'")
//        }
//        print(cpBianHao, cpName)
        print("this is touzhu click button!!! ============== 常用玩法的所有记录!!!!!!!")
        let allData:[VisitRecords] = WHC_ModelSqlite.query(VisitRecords.self, where: nil) as! [VisitRecords]
        for item in allData {
            print(item.userName!,"\t\t\t",item.cpName!,"\t\t\t",
                  item.czCode!,"\t",item.ago!,"\t",item.cpBianHao!,"\t",
                  item.lotType!,"\t",item.lotVersion!,"\t\t\t\t",item.num!,"icon:",item.icon!)
        }
        
    }
    
    func postBets() -> Void {
        
        if self.datas.isEmpty{
            showToast(view: self.view, txt: "您还没有选择下注号码！")
            return
        }
        var totalMoney:Float = 0
        for info in self.datas{
            totalMoney = totalMoney + Float(info.money)
        }
        //若总投注金额大于账户余额，跳转到支付页
        
        
        let accoundMode = YiboPreference.getAccountMode()
        if let meminfo = self.meminfo{
            if !isEmptyString(str: meminfo.balance){
                let balance = Float(meminfo.balance)!
                if totalMoney > balance && accoundMode != 4{
                    showToast(view: self.view, txt: "余额不足，请先充值")
                    openChargeMoney(controller: self, meminfo: meminfo)
                    return
                }
            }
        }
        //构造下注POST数据
        var bets = [Dictionary<String,AnyObject>]()
        for order in self.datas{
            var bet = Dictionary<String,AnyObject>()
            bet["i"] = order.oddsCode as AnyObject
            bet["c"] = order.numbers as AnyObject
            bet["n"] = order.zhushu as AnyObject
            bet["t"] = order.beishu as AnyObject
            bet["k"] = order.rate as AnyObject
            bet["m"] = order.mode as AnyObject
            bet["a"] = order.money as AnyObject
            bets.append(bet)
        }
        let postData = ["lotCode":self.cpBianHao,"data":bets,"zuihaoList":"","stopAfterWin":true] as [String : Any]
        if (JSONSerialization.isValidJSONObject(postData)) {
            let data : NSData! = try? JSONSerialization.data(withJSONObject: postData, options: []) as NSData
            let str = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
            //do bet
            request(frontDialog: true, method: .post, loadTextStr: "正在下注...", url:DO_BETS_URL,params: ["data":str!],
                    callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "下注失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = DoBetWrapper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                self.datas.removeAll()
                                self.tableview.reloadData()
                                YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
                                self.setBottomValue()
                                self.showBetSuccessDialog()
                                //clear select balls after bet success
                            }else{
                                if !isEmptyString(str: result.msg){
                                    self.print_error_msg(msg: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "下注失败"))
                                }
                                //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                                //所以此接口当code == 0时表示帐号被踢，或登录超时
                                if (result.code == 0) {
                                    loginWhenSessionInvalid(controller: self)
                                    return
                                }
                            }
                        }
            })
        }
    }
    
    
    func viewLotRecord(){
        let page = GoucaiQueryController()
//        page.filterLotCode = self.cpBianHao
        page.isAttachInTabBar = false
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    func showBetSuccessDialog() -> Void {
        let alertController = UIAlertController(title: "温馨提示",
                                                message: "下注成功!", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "查看记录", style: .cancel, handler: {
            action in
            self.viewLotRecord()
        })
        let okAction = UIAlertAction(title: "继续下注", style: .default, handler: {
            action in
            self.navigationController?.popViewController(animated: false)
        })
        alertController.addAction(viewAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        YiboPreference.saveTouzhuOrderJson(value: datas.toJSONString() as AnyObject)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "order_cell") as? ConfirmTouzhCell  else {
            fatalError("The dequeued cell is not an instance of ConfirmTouzhCell.")
        }
        cell.setData(data: self.datas[indexPath.row])
        cell.deleteUI.tag = indexPath.row
        cell.deleteUI.layer.cornerRadius = 15
        cell.deleteUI.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func onDelete(cell:UITableViewCell) -> Void {
        self.datas.remove(at: cell.tag)
        self.tableview.reloadData()
        setBottomValue()
        if self.datas.isEmpty{
            self.navigationItem.rightBarButtonItems?.removeAll()
            YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        }
    }

}
