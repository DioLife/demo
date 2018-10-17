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
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var zuihaoBtn:UIButton!
    @IBOutlet weak var touzhuBtn:UIButton!
    @IBOutlet weak var totalLabel:UILabel!
    var datas:[OrderDataInfo] = []
    var order:OrderDataInfo?
    var cpBianHao = ""
    var cpTypeCode = ""
    var cpName = ""
    var playCode = ""
    var playName = ""
    var subPlayCode = ""
    var subPlayName = ""
    
    
    var actionButton: ActionButton!//悬浮按钮

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = String.init(format: "购彩列表(%@)", cpName)
        tableview.delegate = self
        tableview.dataSource = self
        
        zuihaoBtn.layer.cornerRadius = 5
        touzhuBtn.layer.cornerRadius = 5
        
        zuihaoBtn.addTarget(self, action: #selector(onZuiHaoClick), for: .touchUpInside)
        touzhuBtn.addTarget(self, action: #selector(onTouzhuClick), for: .touchUpInside)
        
        
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let zuihao = config.content.lottery_order_chase_switch
                if !isEmptyString(str: zuihao) && zuihao == "on"{
                    zuihaoBtn.isHidden = false
                }
            }
        }
        actionButton = createCommonFAB(controller:self)
        
        if !self.datas.isEmpty{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "清空", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClearList))
        }
        
        let orderJson = YiboPreference.getTouzhuOrderJson()
        if !isEmptyString(str: orderJson){
            let result:[OrderDataInfo] = JSONDeserializer<OrderDataInfo>.deserializeModelArrayFrom(json: orderJson)! as! [OrderDataInfo]
            if let data = order{
                self.datas.append(data)
                for info in result{
                    if !(info.numbers == data.numbers && info.subPlayCode == data.subPlayCode){
                        self.datas.append(info)
                    }else{
                        showToast(view: self.view, txt: "此投注号码已存在，请重新选择")
                    }
                }
            }
        }else{
            if let data = order{
                self.datas.append(data)
            }
        }
        setBottomValue()
        tableview.reloadData()
    }
    
    /**
     * 投注动作
     * @param selectedDatas 非机选投注时，用户已经选择完投注球的球列表数据
     * @param cpVersion 彩票版本
     * @param czCode 彩种代号
     * @param playCode 大玩法
     * @param subCode 小玩法
     * @param isRandom 是否机选
     * @param cellPos 点击的位置
     */
    func responseTouzhu(cpVersion:String,
                        czCode:String,playCode:String,playName:String,
                        subCode:String,subPlayName:String) -> Void{
        
        DispatchQueue.global().async {
            //calculate touzhu count
            // if this operation is shake phone which mean random touzhu.
            // we perform a random number selecting
            var numbers:String = ""
            let ballonsAfterRandomSelect = LotteryPlayLogic.selectRandomDatas(cpVersion: cpVersion, czCode: czCode, playCode: playCode, subCode: subCode)
            if !ballonsAfterRandomSelect.isEmpty{
                numbers = LotteryPlayLogic.figureOutNumbersAfterUserSelected(listBeenSelected: ballonsAfterRandomSelect, playCode: playCode, subPlayCode: subCode)
            }
            print("figure out the tou zhu post numbers = \(numbers)")
            if isEmptyString(str: numbers){
                return;
            }
            //根据下注号码计算注数
            let zhushu = JieBaoZhuShuCalculator.calc(lotType: Int((czCode as NSString).intValue), playCode: subCode, haoMa: numbers)
            DispatchQueue.main.async {
                let data = self.buildTouzhuData(cpCode: self.cpBianHao, cpName: self.cpName, playCode: playCode, playName: playName, subPlayCode: subCode, subPlayName: subPlayName, zhushu: zhushu, money: Float(zhushu*2), numbers: numbers, mode: YUAN_MODE)
                self.datas.insert(data, at: 0)
                self.setBottomValue()
                self.tableview.reloadData()
            }
        }
        
    }
    
    func buildTouzhuData(cpCode:String,cpName:String,playCode:String,playName:String,subPlayCode:String,subPlayName:String,
                    zhushu:Int,money:Float,numbers:String,mode:Int) -> OrderDataInfo {
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
    
    func createCommonFAB(controller:UIViewController) -> ActionButton {
        var items:[(title:String,imgname:String,action: (ActionButtonItem) -> Void)] = []
        let manualItem = (title:"增加手动投注",imgname:"manual_bet_icon",action:{(item:ActionButtonItem)->Void in
            self.navigationController?.popViewController(animated: true)
        })
        let randomItem = (title:"增加随机投注",imgname:"random_bet_icon",action:{(item:ActionButtonItem)->Void in
            self.responseTouzhu(cpVersion: YiboPreference.getVersion(), czCode: self.cpTypeCode, playCode: self.playCode, playName: self.playName, subCode: self.subPlayCode, subPlayName: self.subPlayName)
        })
        items.append(manualItem)
        items.append(randomItem)
        return showFAB(attachView: controller.view, items: items)
    }
    
    func onClearList() -> Void {
        self.datas.removeAll()
        self.tableview.reloadData()
        self.navigationItem.rightBarButtonItems?.removeAll()
        setBottomValue()
    }
    
    func onZuiHaoClick() -> Void {
        if self.datas.isEmpty{
            showToast(view: self.view, txt: "您还没有选择下注号码！")
            return
        }
        openBraveZuiHaoPage(controller: self,order: self.datas,lotCode: self.cpBianHao,lotName: self.cpName)
    }
    
    func setBottomValue() -> Void {
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
        totalLabel.text = String.init(format: "%d注%.2f元", totalZhushu,totalMoney)
    }
    
    func onTouzhuClick() -> Void {
        if self.datas.isEmpty{
            showToast(view: self.view, txt: "您还没有选择下注号码！")
            return
        }
        doBets()
    }
    
    func postBets(token:String) -> Void {
        
        if self.datas.isEmpty{
            showToast(view: self.view, txt: "您还没有选择下注号码！")
            return
        }
        //构造下注POST数据
        var bets = [String]()
        for order in self.datas{
            var sb = ""
            sb.append(order.lotcode)
            sb.append("|")
            sb.append(order.subPlayCode)
            sb.append("|")
            sb.append(String(convertPostMode(mode: order.mode)))
            sb.append("|");
            sb.append(String(order.beishu))
            sb.append("|");
            sb.append(order.numbers);
            bets.append(sb)
        }
        let postData = ["lotCode":cpBianHao,"qiHao":"","token":token,"bets":bets] as [String : Any]
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
                                self.showBetSuccessDialog()
                                //clear select balls after bet success
                            }else{
                                if !isEmptyString(str: result.msg){
                                    showToast(view: self.view, txt: result.msg)
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
    
    func showBetSuccessDialog() -> Void {
        let alertController = UIAlertController(title: "温馨提示",
                                                message: "下注成功!", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "查看记录", style: .cancel, handler: {
            action in
            openTouzhuRecord(controller: self,title: self.cpName,code: self.cpBianHao, recordType: isSixMark(lotCode: self.cpBianHao) ? MenuType.LIUHE_RECORD : MenuType.CAIPIAO_RECORD)
        })
        let okAction = UIAlertAction(title: "继续下注", style: .default, handler: {
            action in
            self.navigationController?.popViewController(animated: false)
        })
        alertController.addAction(viewAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func doBets() -> Void {
        //验证下注口令
        request(frontDialog: true, method: .post, url:TOKEN_BETS_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取下注口令失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = BetTokenWrapper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            //获取下注口令后开始下注
                            self.postBets(token:result.content);
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取下注口令失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0 || result.code == nil) {
                                loginWhenSessionInvalid(controller: self)
                                return
                            }
                        }
                    }
        })
        
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
        cell.tag = indexPath.row
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
    
    func onDelete(cell:UITableViewCell) -> Void {
        self.datas.remove(at: cell.tag)
        self.tableview.reloadData()
        setBottomValue()
        if self.datas.isEmpty{
            self.navigationItem.rightBarButtonItems?.removeAll()
            YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        }
    }

}
