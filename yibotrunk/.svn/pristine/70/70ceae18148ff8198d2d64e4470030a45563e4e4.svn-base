//
//  TouzhuRecordDetailController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/19.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//彩票，六合彩投注记录详情
class TouzhuRecordDetailController: BaseTableViewController {

    var orderId = ""
    var cpBianma = ""
    var datas:[Dictionary<String,String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "投注记录详情"
        loadDetailData(lotCode: self.cpBianma, orderId: self.orderId)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordDetailCell") as? RecordDetailCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        let data = self.datas[indexPath.row]
        cell.nameUI.text = data["name"]
        cell.valueUI.text = data["value"]
        return cell
    }
    
    
    /**
     * 获取投注记录
     * @param lotCode 彩种编码
     * @param orderId 订单号
     */
    func loadDetailData(lotCode:String,orderId:String) -> Void {
        request(frontDialog: true, loadTextStr:"获取中...",url:LOTTERY_RECORD_DETAIL_URL,params:["orderId":orderId,"lotCode":lotCode],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取数据失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LotteryRecordDetailWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if let content = result.content{
                                self.datas.removeAll()
                                var dic1 = Dictionary<String,String>()
                                dic1["name"] = "订单号:"
                                dic1["value"] = content.orderId
                                
                                var dic2 = Dictionary<String,String>()
                                dic2["name"] = "单注金额:"
                                dic2["value"] = YiboPreference.isPeilvVersion() ? String.init(format: "%.2f元", content.buyMoney/Float(content.buyZhuShu)) : String.init(format: "%.2f元", (2.0/Float(content.model)))
                                
                                var dic3 = Dictionary<String,String>()
                                dic3["name"] = "下注时间:"
                                dic3["value"] = timeStampToString(timeStamp: content.createTime)
                                
                                var dic4 = Dictionary<String,String>()
                                dic4["name"] = "投注注数:"
                                dic4["value"] = String.init(format: "%d", content.buyZhuShu)
                                
                                var dic5 = Dictionary<String,String>()
                                dic5["name"] = "彩种:"
                                dic5["value"] = content.lotName
                                
                                var dic6 = Dictionary<String,String>()
                                dic6["name"] = "倍数:"
                                dic6["value"] = String.init(format: "%d", content.multiple)
                                
                                let isPeilvVersion = isSixMark(lotCode: self.cpBianma) ? true : YiboPreference.isPeilvVersion()
                                
                                
                                var dic7 = Dictionary<String,String>()
                                if isPeilvVersion{
                                    dic7["name"] = "赔率:"
                                    dic7["value"] = content.peilv
                                }
                                
                                var dic8 = Dictionary<String,String>()
                                dic8["name"] = "期号:"
                                dic8["value"] = content.qiHao
                                
                                var dic9 = Dictionary<String,String>()
                                dic9["name"] = "投注总额:"
                                dic9["value"] = String.init(format: "%.2f元", content.buyMoney)
                                
                                var dic10 = Dictionary<String,String>()
                                dic10["name"] = "玩法:"
                                dic10["value"] = String.init(format: "%@-%@", content.groupName,content.playName)
                                
                                var dic11 = Dictionary<String,String>()
                                dic11["name"] = "奖金:"
                                dic11["value"] = String.init(format: "%.2f元", content.minBonusOdds)
                                
                                var dic12 = Dictionary<String,String>()
                                dic12["name"] = "投注号码:"
                                dic12["value"] = content.haoMa
                                
                                var dic13 = Dictionary<String,String>()
                                dic13["name"] = "中奖注数:"
                                dic13["value"] = content.winZhuShu != nil ? String.init(format: "%d", content.winZhuShu) : "0"
                                
                                var dic14 = Dictionary<String,String>()
                                dic14["name"] = "状态:"
                                dic14["value"] = self.getStatusStr(status: content.status)
                                
                                var dic17 = Dictionary<String,String>()
                                dic17["name"] = "开奖号码:"
                                dic17["value"] = content.openHaoma
                                
                                var dic15 = Dictionary<String,String>()
                                dic15["name"] = "中奖金额:"
                                dic15["value"] = String.init(format: "%.2f元", content.winMoney)
                                
                                var dic16 = Dictionary<String,String>()
                                dic16["name"] = "盈亏:"
                                dic16["value"] = content.status == WAIT_KAIJIAN_STATUS ? "0" : String.init(format: "%.2f元", content.yingKui)
                                
                                self.datas.append(dic1)
                                self.datas.append(dic2)
                                self.datas.append(dic3)
                                self.datas.append(dic4)
                                self.datas.append(dic5)
                                self.datas.append(dic6)
                                if isPeilvVersion{
                                    self.datas.append(dic7)
                                }
                                self.datas.append(dic8)
                                self.datas.append(dic9)
                                self.datas.append(dic10)
                                self.datas.append(dic11)
                                self.datas.append(dic12)
                                self.datas.append(dic13)
                                self.datas.append(dic14)
                                self.datas.append(dic17)
                                self.datas.append(dic15)
                                self.datas.append(dic16)
                                
                                self.tableView.reloadData()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取数据失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func getStatusStr(status:Int) -> String {
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
        return ""
    }

}
