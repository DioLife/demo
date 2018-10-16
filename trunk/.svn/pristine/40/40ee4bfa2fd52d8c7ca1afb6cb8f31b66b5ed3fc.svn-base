//
//  PeilvOrderController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/16.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class PeilvOrderController: BaseController,UITextFieldDelegate {
    
    @IBOutlet weak var againBtn:UIButton!
    @IBOutlet weak var randomBtn:UIButton!
    
    @IBOutlet weak var tableviewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var clearBtn:UIButton!
    @IBOutlet weak var touzhuBtn:UIButton!
    @IBOutlet weak var fastMoneyInput:CustomFeildText!
    
    var accountBanlance = 0.0
    var meminfo:Meminfo?
    var moneyTotal = 0
    var datas:[OrderDataInfo] = []
    var order:[OrderDataInfo]?
    var peilvs:[BcLotteryPlay]?
    var lhcLogic:LHCLogic2?
    
    var subPlayName = ""
    var subPlayCode = ""
    var cpTypeCode = ""
    var cpBianHao = ""
    var current_rate:Float = 0
    var cpName = ""
    var cpVersion = ""
    var lotteryicon = ""//icon
    
    
//    var actionButton: ActionButton!//悬浮按钮
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        accountWeb()
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        
        self.navigationItem.title = String.init(format: "购彩列表(%@)", cpName)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView.init()
        clearBtn.layer.cornerRadius = 5
        touzhuBtn.layer.cornerRadius = 5
        clearBtn.addTarget(self, action: #selector(onClearClick), for: .touchUpInside)
        touzhuBtn.addTarget(self, action: #selector(onTouzhuClick), for: .touchUpInside)
        fastMoneyInput.addTarget(self, action: #selector(onFastMoneyInput(ui:)), for: .editingChanged)
        fastMoneyInput.delegate = self
//        actionButton = createCommonFAB(controller:self)
        
        againBtn.theme_setTitleColor("Global.themeColor", forState: .normal)
        randomBtn.theme_setTitleColor("Global.themeColor", forState: .normal)
        setupNoPictureAlphaBgView(view: againBtn)
        setupNoPictureAlphaBgView(view: randomBtn)
        againBtn.addTarget(self, action: #selector(onAgainBtn), for: .touchUpInside)
        randomBtn.addTarget(self, action: #selector(onRandomBtn), for: .touchUpInside)
        
        //当键盘弹起的时候会向系统发出一个通知，
        //这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        tableview.reloadData()
    }
    
//    var onAgainBtnClick:((_ shouldClearData:Bool) -> Void)?
    
    @objc func onAgainBtn(){
//        onAgainBtnClick?(false)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onRandomBtn(){
        if let handle = self.lhcLogic{
            if let peilvs = self.peilvs{
                let orders = handle.randomBet(choosePlays: peilvs, orderCount: 1)
                if orders.isEmpty{
                    showToast(view: (self.view)!, txt: "没有机选出注单，请重试")
                    return
                }
                let data = fromPeilvBetOrder(peilv_orders: orders, subPlayName: self.subPlayName, subPlayCode: self.subPlayCode, cpTypeCode: self.cpTypeCode, cpBianHao: self.cpBianHao, current_rate: self.current_rate)
                for d in data{
                    if let fastMoney = self.fastMoneyInput.text{
                        if !isEmptyString(str: fastMoney) && isPurnInt(string: fastMoney){
                            d.money = Double(fastMoney)!
                        }
                    }
                }
                self.datas = data + self.datas
                self.tableview.reloadData()
            }
        }
    }
    
    //金额输入框内容变化回调
    @objc func onFastMoneyInput(ui:UITextField) -> Void {
        let moneyValue = ui.text!
        if isEmptyString(str: moneyValue){
            return
        }
        if moneyValue.starts(with: "0") && moneyValue.count > 0 {
//            showToast(view: self.view, txt: "请输入正确格式的金额")
            fastMoneyInput.text = ""
            return
        }
        for data in self.datas{
            data.money = Double(moneyValue)!
        }
        self.tableview.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func createCommonFAB(controller:UIViewController) -> ActionButton {
//        var items:[(title:String,imgname:String,action: (ActionButtonItem) -> Void)] = []
//        let manualItem = (title:"手选一注",imgname:"manual_bet_icon",action:{(item:ActionButtonItem)->Void in
//            self.navigationController?.popViewController(animated: true)
//        })
//        let randomItem = (title:"机选一注",imgname:"random_bet_icon",action:{(item:ActionButtonItem)->Void in
//
//
//        })
//        items.append(manualItem)
//        items.append(randomItem)
//        return showFAB(attachView: controller.view, items: items)
//    }
    
    @objc func onExitClick() -> Void {
        YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        self.datas.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClearClick() -> Void {
        for data in self.datas{
            data.money = 0
        }
        self.tableview.reloadData()
        self.navigationItem.rightBarButtonItems?.removeAll()
        self.fastMoneyInput.text = ""
    }
    
    @objc func onTouzhuClick() -> Void {
        
        for model in self.datas {
            moneyTotal += Int(model.money)
        }
        
        let accoundMode = YiboPreference.getAccountMode()
        if accountBanlance < Double(moneyTotal) && accoundMode != 4{
            openChargeMoney(controller: self, meminfo: self.meminfo)
            showToast(view: self.view, txt: "余额不足，请充值")
            return
        }
        
        if formatData().count == 0 {return}
        self.do_peilv_bet(datas: formatData(), rateback: 0)
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
                                //更新余额等信息
                               self.meminfo = memInfo
                                
                                
                                if !isEmptyString(str: memInfo.balance){
                                    let leftMoneyName = "\(memInfo.balance)"
                                    if let value = Double(leftMoneyName) {
                                        self.accountBanlance = value
                                    }
                                }
                                
                            }
                        }
                    }
        })
    }
    
    private func formatData() -> [PeilvOrder] {
        var peilvOrders:[PeilvOrder] = []
        for data in self.datas{
            if data.money == 0{
                showToast(view: self.view, txt: "号码没有下注金额，请先输入金额")
                return peilvOrders
            }
            
            let order = PeilvOrder()
            order.i = data.oddsCode
            order.c = data.numbers
            order.d = data.cpCode
            order.a = Float(data.money)
            peilvOrders.append(order)
        }
        
        return peilvOrders
    }
    
    //MARK: 构造下注post数据
    private func buildPostData(datas: [PeilvOrder]) -> [Dictionary<String,AnyObject>] {
        var bets = [Dictionary<String,AnyObject>]()
        for order in datas{
            var bet = Dictionary<String,AnyObject>()
            bet["i"] = order.i as AnyObject
            bet["c"] = order.c as AnyObject
            bet["d"] = order.d as AnyObject
            bet["a"] = order.a as AnyObject
            bets.append(bet)
        }
        
        return bets
    }
    
    /*
     真正开始赔率下注
     @param order 下注注单
     @param rateback 用户选择的返水
     */
    func do_peilv_bet(datas:[PeilvOrder],rateback:Float){
        if datas.isEmpty{
            showToast(view: self.view, txt: "没有需要提交的订单，请先投注!")
            return
        }
        
        let bets = buildPostData(datas: datas)
        
        let postData = ["lotCode":self.cpBianHao,"data":bets,"kickback":rateback] as [String : Any]
        if (JSONSerialization.isValidJSONObject(postData)) {
            let data : NSData! = try? JSONSerialization.data(withJSONObject: postData, options: []) as NSData
            let str = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
            //do bet
            request(frontDialog: true, method: .post, loadTextStr: "正在下注...", url:DO_PEILVBETS_URL,params: ["data":str!],
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
                                
                                //把投注成功的结果记录在常用玩法的数据库
                                let record:VisitRecords = VisitRecords()
                                record.cpName = self.cpName //名字
                                record.czCode = self.cpTypeCode //类型
                                record.ago = "0" // 时间差 传默认值
                                record.cpBianHao = self.cpBianHao //编号
                                record.lotType = self.cpTypeCode //类型
                                record.lotVersion = self.cpVersion //版本
                                record.icon = self.lotteryicon //icon
                                CommonRecords.updateRecordInDB(record: record);
                                
                                self.showBetSuccessDialog()
                                YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
                                self.datas.removeAll()
                                self.tableview.reloadData()
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
        if self.datas.isEmpty{
            YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        }else{
            YiboPreference.saveTouzhuOrderJson(value: datas.toJSONString() as AnyObject)
        }
    }
    
    @objc func onDelete(ui:UIButton) -> Void {
        print("the cell tag === ",ui.tag)
        self.datas.remove(at: ui.tag)
        self.tableview.reloadData()
        if self.datas.isEmpty{
            self.navigationItem.rightBarButtonItems?.removeAll()
            YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        }
    }
    
    //键盘弹起响应
    @objc override func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            let deltaY = intersection.height
  
            if keyBoardNeedLayout {
                tableviewTopConstraint.constant = deltaY
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
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            let deltaY = intersection.height
            
            tableviewTopConstraint.constant = 0
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: {
                            self.view.frame = CGRect.init(x:0,y:deltaY,width:self.view.bounds.width,height:self.view.bounds.height)
                            self.keyBoardNeedLayout = true
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }


}

extension PeilvOrderController : UITableViewDelegate,UITableViewDataSource,PeilvOrderDelegate{
    
    func onMoneyChange(money: Float, row: Int) {
        self.datas[row].money = Double(money)
        //
//        self.tableview.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .none)
    }
    
    func updateTableAction() {
//        self.tableview.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .none)
        self.tableview.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "peilv_order_cell") as? PeilvOrderCell  else {
            fatalError("The dequeued cell is not an instance of PeilvOrderCell.")
        }
        cell.delegate = self
        cell.setData(data: self.datas[indexPath.row],row: indexPath.row)
        cell.deleteUI.tag = indexPath.row
        cell.deleteUI.layer.cornerRadius = 15
        cell.deleteUI.addTarget(self, action: #selector(onDelete(ui:)), for: .touchUpInside)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
