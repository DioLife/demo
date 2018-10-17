//
//  SBSportOrderDetailController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//沙巴体育详情页
//
import HandyJSON

//体育注单详情
class SBSportOrderDetailController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    var orderId = 0
    var datas:[SportListItem] = []
    var gameCount = 1 //比赛賽事数
    var order:SBOrderRealResult!;//订单详情json
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        filleSportDetails(detail: order)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sportOrderDetailCell") as? SportOrderDetailCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        cell.nameUI.text = datas[indexPath.row].name
        //        cell.valueUI.text = datas[indexPath.row].value
        do{
            let attrStr = try NSAttributedString.init(data: datas[indexPath.row].value.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
            cell.valueUI.attributedText = attrStr
        }catch{
            print(error)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            return CGFloat(60*self.order.childrens.count + 64)
        }
        return 64
    }
    
    func getMatchInfo(detail:SBOrderRealResult!) -> String{
        
        if detail == nil{
            return ""
        }
        
        if detail.mix == 1{
            var project = ""
            if !isEmptyString(str: detail.betTeamName){
                project = project + detail.betTeamName
                project = String.init(format: "%@ %d @ %.2f", project,detail.hdp,detail.betOdds)
            }
            var sb = ""
            sb = sb + detail.leagueName
            sb = sb + "<br/>"
            sb = sb + detail.homeName
            sb = sb + "&nbsp;&nbsp;vs."
            sb = sb + "&nbsp;&nbsp;"
            sb = sb + detail.awayName
            sb = sb + "<font color='red'>["
            sb = sb + detail.betTypeName + "]"
            sb = sb + "</font><br/>"
            sb = sb + "<font color='red'>"
            let bb = String.init(format: "%@ @ %.2f", detail.homeName,detail.betOdds)
            let b = (detail.betTypeName == "让球" ? bb : project)
            sb = sb + b
            sb = sb + "</font>"
            let html = String.init(format: "<html><head></head><body>%@</body></html>", sb)
            return html
        }
        
        if detail.mix == 2{
            var all = ""
            for item in detail.childrens{
                var project = ""
                if !isEmptyString(str: item.betTeamName){
                    project = project + item.betTeamName
                    project = String.init(format: "%@ %d @ %.2f", project,item.hdp,item.betOdds)
                }
                var sb = ""
                sb = sb + item.leagueName
                sb = sb + "<br/>"
                sb = sb + item.homeName
                sb = sb + "&nbsp;&nbsp;vs."
                sb = sb + "&nbsp;&nbsp;"
                sb = sb + item.awayName
                sb = sb + "<font color='red'>["
                sb = sb + item.betTypeName + "]"
                sb = sb + "</font><br/>"
                sb = sb + "<font color='red'>"
                let bb = String.init(format: "%@ @ %.2f", item.homeName,item.betOdds)
                let b = (item.betTypeName == "让球" ? bb : project)
                sb = sb + b
                sb = sb + "</font>"
                all = all + sb
                all = all + "<br/>"
                all = all + ".................................................."
                all = all + "<br/>"
            }
            let html = String.init(format: "<html><head></head><body>%@</body></html>", all)
            return html
        }
        return ""
    }
    
    private func getOrderStatus(status:String) -> String{
        switch status {
        case "waiting":
            return "待确认"
        case "VOID":
            return "系统作废(退款)"
        case "Reject":
            return "系统取消(退款)"
        case "Refund":
            return "系统退款"
        default:
            return "已确认"
        }
    }
    
    private func getBetStatus(status:String) -> String{
        switch status {
        case "DRAW":
            return "和局"
        case "running","waiting":
            return "未结算"
        case "Half WON","Half LOSE","WON","LOSE","VOID","Reject","Refund":
            return "已结算"
        default:
            return "结算失败"
        }
    }
    
    func filleSportDetails(detail:SBOrderRealResult!) -> Void{
        
        if detail == nil{
            return
        }
        self.datas.removeAll()
        
        let item1 = SportListItem()
        item1.name = "注单编号"
        item1.value = detail.transId
        self.datas.append(item1)
        
        let item2 = SportListItem()
        item2.name = "投注时间"
        item2.value = timeStampToString(timeStamp: detail.transactionTime)
        self.datas.append(item2)
        
        let item3 = SportListItem()
        item3.name = "赛事情况"
        item3.value = getMatchInfo(detail: detail)
        self.datas.append(item3)
        
        let item4 = SportListItem()
        item4.name = "球类"
        
        if detail.mix == 2{
            var ballName = ""
            for item in detail.childrens{
                ballName = item.sportTypeName
            }
            let a = String.init(format: "%@(%@)", ballName,detail.betTypeName)
            item4.value = a
        }else{
            let a = String.init(format: "%@(%@)", detail.sportTypeName,detail.betTypeName)
            item4.value = a
        }
        self.datas.append(item4)
        
        let item5 = SportListItem()
        item5.name = "类型"
        self.datas.append(item5)
        if detail.mix == 2{
            var panName = ""
            for item in detail.childrens{
                panName = panName + item.betTypeName
                panName = panName + "/"
            }
            item5.value = panName
        }else{
            let a = String.init(format: "%@ %d@%.2f", detail.betTeamName,detail.hdp,detail.betOdds)
            item5.value = a
        }
        
        let item6 = SportListItem()
        item6.name = "下注金额"
        item6.value = String.init(format: "%.2f元", detail.accountBetMoney)
        self.datas.append(item6)
        
        let item7 = SportListItem()
        item7.name = "提交状态"
        item7.value = getOrderStatus(status: detail.ticketStatus)
        self.datas.append(item7)
        
        let item8 = SportListItem()
        item8.name = "结算状态"
        item8.value = getBetStatus(status: detail.ticketStatus)
        self.datas.append(item8)
        
        let item9 = SportListItem();
        item9.name = "派彩金额";
        item9.value = detail.winLostMoney > 0 ? String.init(format: "%.2f元", detail.winLostMoney) :"-";
        self.datas.append(item9);
        
    }
    
}

