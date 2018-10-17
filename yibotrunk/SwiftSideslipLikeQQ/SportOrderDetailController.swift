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
class SportOrderDetailController: BaseController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    var orderId = 0
    var datas:[SportListItem] = []
    var gameCount = 1 //比赛賽事数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadDatas(id: orderId)
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
    
    func loadDatas(id:Int) -> Void {
        request(frontDialog: true, url:SPORT_RECORDS_DETAIL,params:["id":id],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SportOrderDetailWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                UserDefaults.standard.setValue(token, forKey: "token")
                            }
                            
                            //fill order details
                            if let data = result.content{
                                self.datas.removeAll()
                                self.filleSportDetails(detail: data)
                                self.tableView.reloadData()
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
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
    
    func toBetJson(detail:SportOrderDetail,result:CampionResult) -> String {
        let con = result.con
        let homeFirst = detail.homeTeam == result.firstTeam//主队是否在前
        var scoreStr = ""
        if detail.gameTimeType == 1{
            if homeFirst{
                scoreStr = String.init(format: "(%d:%d)", detail.scoreH,detail.scoreC)
            }else{
                scoreStr = String.init(format: "(%d:%d)", detail.scoreC,detail.scoreH)
            }
        }
        var home = result.firstTeam
        var guest = result.lastTeam
        
        if result.half && detail.mix == 2{
            home = home + "<font color='gray'>[上半]</font>"
            guest = guest + "<font color='gray'>[上半]</font>"
        }
        
        var html = result.league + "<br/>" +
            home + "&nbsp;&nbsp;" + con + "&nbsp;&nbsp;" + guest + scoreStr + "<br/>" +
            "<font color='red'>"+result.result + "</font>&nbsp;&nbsp;" +
            "@" + "&nbsp;&nbsp;<font color='red'>" +
            String.init(format: "%.2f", result.odds) + "</font>";
        
        let balance = detail.mix != 2 ? detail.balance : result.balance
        let bt = detail.bettingStatus
        if balance == 4{
            html = "<s style='color:red;'>" + html+"(赛事腰斩)</s>";
        }else if bt == 3 || bt == 4{
            html = "<s style='color:red;'>" + html
            html = html + String.init(format: "(%@)</s>", !isEmptyString(str: detail.statusRemark) ? detail.statusRemark : "未填写取消说明")
        }else if balance == 2 || balance == 5 || balance == 6{
            let mr = detail.mix != 2 ? detail.result : result.matchResult
            if homeFirst{
                html = html + "&nbsp;<font color='blue'>("+mr+")</font>";
            }else{
                var ss = mr.components(separatedBy: ":")
                if !ss.isEmpty && ss.count == 2{
                    html = html + String.init(format: "&nbsp;<font color='blue'>(%@:%@)</font>", ss[0],ss[1])
                }
            }
        }
        return html
    }
    
    func getMatchInfo(detail:SportOrderDetail) -> (html:String,gameCount:Int){
        let remark = detail.remark
        if isEmptyString(str: remark){
            return (html:"",gameCount:1)
        }
        if detail.mix != 2{
            if let result = CampionResult.deserialize(from: remark){
                var sb = ""
                sb = sb + toBetJson(detail: detail, result: result)
                let html = String.init(format: "<html><head></head><body>%@</body></html>", sb)
                return (html:html,gameCount:1)
            }
        }else{
            if !isEmptyString(str: remark){
                if let result = JSONDeserializer<CampionResult>.deserializeModelArrayFrom(json: remark) {
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
    
    func getSportName(type:Int) -> String {
        if type == 1{
            return "足球"
        }
        if type == 2{
            return "篮球"
        }
        return "其他"
    }
    
    func filleSportDetails(detail:SportOrderDetail) ->   Void{
        let item1 = SportListItem()
        item1.name = "注单编号"
        item1.value = detail.bettingCode
        self.datas.append(item1)
        
        let item2 = SportListItem()
        item2.name = "投注时间"
        item2.value = timeStampToString(timeStamp: detail.bettingDate)
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
        item4.value = getSportName(type: detail.sportType)
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
        item8.value = convertBalanceStatus(status: detail.balance)
        self.datas.append(item8)
        
        if(detail.balance == BALANCE_DONE ||
            detail.balance == BALANCE_AGENT_HAND_DONE ||
            detail.balance == BALANCE_BFW_DONE){
            let item9 = SportListItem();
            item9.name = "派彩金额";
            item9.value = detail.bettingResult > 0 ? String.init(format: "%.2f元", detail.bettingResult) :"-";
            self.datas.append(item9);
        }
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
