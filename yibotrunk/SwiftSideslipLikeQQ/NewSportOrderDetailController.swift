//
//  SportOrderDetailController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/25.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

//体育注单详情
class NewSportOrderDetailController: BaseController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    var order:NewSportOrderBean?
    var datas:[SportListItem] = []
    var gameCount = 1 //比赛賽事数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if let o = order{
            filleSportDetails(detail: o)
        }
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
            return CGFloat(60*gameCount + 40)
        }
        return 44
    }
    
    func toBetJson(detail:NewSportOrderBean,result:NewCampionResult) -> String {
        let con = result.con
        var scoreStr = ""
//        if detail.gameTimeType == 1{
//            if homeFirst{
//                scoreStr = String.init(format: "(%d:%d)", detail.scoreH,detail.scoreC)
//            }else{
//                scoreStr = String.init(format: "(%d:%d)", detail.scoreC,detail.scoreH)
//            }
//        }
        scoreStr = !isEmptyString(str: detail.result) ? String.init(format: "(%@)", detail.result) : ""
        var home = result.homeTeam
        var guest = result.guestTeam
        
        if result.half && detail.mix == 2{
            home = home + "<font color='gray'>[上半]</font>"
            guest = guest + "<font color='gray'>[上半]</font>"
        }
        
        let html = result.league + "<br/>" +
            home + "&nbsp;&nbsp;" + con + "&nbsp;&nbsp;" + guest + "<br/>" +
            "<font color='red'>"+result.result + "</font>&nbsp;&nbsp;" +
            "@" + "&nbsp;&nbsp;<font color='red'>" +
            String.init(format: "%.2f", result.odds) + "</font>&nbsp;&nbsp;<font color='blue'>"+scoreStr+"</font>";
        
        return html
    }
    
    func getMatchInfo(detail:NewSportOrderBean) -> (html:String,gameCount:Int){
        let remark = detail.remark
        if isEmptyString(str: remark){
            return (html:"",gameCount:1)
        }
        if detail.mix != 2{
            if let result = NewCampionResult.deserialize(from: remark){
                var sb = ""
                sb = sb + toBetJson(detail: detail, result: result)
                let html = String.init(format: "<html><head></head><body>%@</body></html>", sb)
                return (html:html,gameCount:1)
            }
        }else{
            if !isEmptyString(str: remark){
                if let result = JSONDeserializer<NewCampionResult>.deserializeModelArrayFrom(json: remark) {
                    var sb = ""
                    if !result.isEmpty{
                        for index in 0...result.count-1{
                            let campionResult = result[index]
                            sb = sb + toBetJson(detail: detail, result: campionResult!)
                            if (index != result.count - 1){
                                sb = sb + "<br/>" + ".................................................." + "<br/>"
                            }
                        }
                        let html = String.init(format: "<html><head></head><body>%@</body></html>", sb)
                        return (html:html,gameCount:result.count)
                    }
                }
            }
        }
        return (html:"",gameCount:1)
    }
    
    func filleSportDetails(detail:NewSportOrderBean) ->   Void{
        let item1 = SportListItem()
        item1.name = "注单编号"
        item1.value = detail.orderId
        self.datas.append(item1)
        
        let item2 = SportListItem()
        item2.name = "投注时间"
        item2.value = timeStampToString(timeStamp: detail.createDatetime)
        self.datas.append(item2)
        
        let item3 = SportListItem()
        item3.name = "赛事情况"
        let tuple = getMatchInfo(detail: detail)
        let (str,count) = tuple
        self.gameCount = count
        item3.value = str
        self.datas.append(item3)
        
        let item4 = SportListItem()
        item4.name = "球类"
        item4.value = convertSportBallon(ballType: detail.sportType)
        self.datas.append(item4)
        
        let item5 = SportListItem()
        item5.name = "类型"
        item5.value = detail.typeNames
        self.datas.append(item5)
        
        let item6 = SportListItem()
        item6.name = "下注金额"
        item6.value = String.init(format: "%.2f元", detail.bettingMoney)
        self.datas.append(item6)
        
        let item7 = SportListItem()
        item7.name = "提交状态"
        item7.value = convertSportCommitStatus(mode: detail.bettingStatus)
        self.datas.append(item7)
        
        let item8 = SportListItem()
        item8.name = "结算状态"
        
        var balanceValue = ""
        if(detail.resultStatus == BALANCE_HALF_WIN ||
            detail.resultStatus == BALANCE_ALL_WIN){
            balanceValue = String.init(format: "%@(%.2f元)", convertBalanceStatus(status: detail.resultStatus),
            detail.winMoney)
            item8.value = balanceValue
            self.datas.append(item8);
        }else{
            item8.value = convertBalanceStatus(status: detail.resultStatus)
            self.datas.append(item8);
        }
    }
    
    
    func convertBalanceStatus(status:Int) -> String {
        if (status == BALANCE_ALL_LOST) {
            return "全输";
        }else if (status == BALANCE_HALF_LOST) {
            return "输一半";
        }else if (status == BALANCE_DRAW) {
            return "平局";
        }else if (status == BALANCE_HALF_WIN) {
            return "赢一半";
        }else if (status == BALANCE_ALL_WIN) {
            return "全赢";
        }
        return "等待开奖";
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
