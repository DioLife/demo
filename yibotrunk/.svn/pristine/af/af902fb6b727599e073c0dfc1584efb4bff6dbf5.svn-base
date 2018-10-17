//
//  LotteryOpenResultController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class LotteryOpenResultController: BaseTableViewController {
    
//    @IBOutlet weak var tableview: UITableView!
    var cpName:String?
    var cpBianMa :String?
    var cpTypeCode = ""
    var lotVersion = ""
    var pageNo = 1;
    let pageSize = 20;
    var datas:[OpenResultDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cpNameValue = cpName{
            self.navigationItem.title = cpNameValue
        }
        
        loadDatas()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datas.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ballWidth:CGFloat = 30
        let data = self.datas[indexPath.row]
        let totalBallWidth = ballWidth * CGFloat(data.haoMaList.count)
        let viewPlaceHoldWidth = kScreenWidth - 32
        //如果ballview占位宽度不大于实际号码宽度，则需要换行处理
        if totalBallWidth > viewPlaceHoldWidth{
            if needCalcTotalDSDXInKaiJianDetailActivity(lotCode: self.cpBianMa!){
                if isSixMark(lotCode: self.cpBianMa!){
                    return 165
                }else{
                    return 135
                }
            }else{
                return 115
            }
        }else{
            if isSixMark(lotCode: self.cpBianMa!){
                return 125
            }else{
                return 95
            }
        }
    }
    
    func needCalcTotalDSDXInKaiJianDetailActivity(lotCode:String) -> Bool{
        let lotCodes = ["FFC",/*"BJSC",*/"CQSSC","EFC","WFC",/*"XYFT",*/"XJSSC",/*"JSSB3",*/
            /*"HBK3","AHK3","GXK3","HEBK3","SHHK3",*/"JX11X5","GD11X5","SD11X5","SH11X5","PCEGG","JND28","FC3D","PL3"]
        for code in lotCodes{
            if code == lotCode{
                return true
            }
        }
        return false
    }
    
    func getMaxOpenNumFromLotCode(haomas:[String],lotCode:String,lotType:String) -> Int{
        var totalNum = 0
        if isKuaiLeCai(lotCode: lotCode){
            totalNum = 20*haomas.count
        }else if isSaiche(lotType: lotType){
            totalNum = 20
        }else if is11x5(lotType: lotCode){
            totalNum = 11*haomas.count + 1*haomas.count
        }else{
            totalNum = 9*haomas.count
        }
        return totalNum
    }
    
    func figureOutALLDXDS(haomas:[String],lotCode:String,lotType:String) -> [BallListItemInfo]{
        if haomas.isEmpty{
            return []
        }
        let totalNum = getMaxOpenNumFromLotCode(haomas: haomas, lotCode: lotCode,lotType: lotType)
        var total = 0//当前开奖号码总和
        
        for index in 0...haomas.count-1{
            let num = haomas[index]
            if !isEmptyString(str: num) && isPurnInt(string: num){
                if isSaiche(lotType: lotType){
                    if index <= 1{
                        total = total + Int(num)!
                    }
                }else{
                    total = total + Int(num)!
                }
            }
        }
        
        var appendList = [BallListItemInfo]()
        let numInfo = BallListItemInfo()
        numInfo.num = String(total)
        appendList.append(numInfo)
        
        if total > 0{
            //大或小
            print("total == ",total)
            print("totalnum = ",totalNum)
            if is11x5(lotType: lotCode){
                if total >= totalNum/2{
                    let bigInfo = BallListItemInfo()
                    bigInfo.num = "大"
                    appendList.append(bigInfo)
                }else{
                    let smallInfo = BallListItemInfo()
                    smallInfo.num = "小"
                    appendList.append(smallInfo)
                }
            }else{
                if total > totalNum/2{
                    let bigInfo = BallListItemInfo()
                    bigInfo.num = "大"
                    appendList.append(bigInfo)
                }else{
                    let smallInfo = BallListItemInfo()
                    smallInfo.num = "小"
                    appendList.append(smallInfo)
                }
            }
            
            //单或双
            if total % 2 == 0{
                let bigInfo = BallListItemInfo()
                bigInfo.num = "双"
                appendList.append(bigInfo)
            }else{
                let smallInfo = BallListItemInfo()
                smallInfo.num = "单"
                appendList.append(smallInfo)
            }
        }else{
            //大或小
            if total > totalNum/2{
                let bigInfo = BallListItemInfo()
                bigInfo.num = "无"
                appendList.append(bigInfo)
            }
            //单或双
            if total % 2 == 0{
                let bigInfo = BallListItemInfo()
                bigInfo.num = "无"
                appendList.append(bigInfo)
            }
        }
        return appendList
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "openResult") as? OpenResultCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        let item = self.datas[indexPath.row]
        cell.qishuUI.text = String.init(format: "第%@期", item.qiHao)
        cell.timeUI.text = item.date + " " + item.time
        
        var ballWidth:CGFloat = 30
        var small = false
        if isSaiche(lotType: cpTypeCode){
            ballWidth = 25
        }else if isFFSSCai(lotType:self.cpTypeCode){
            ballWidth = 30
            small = false
        }
        let viewPlaceHoldWidth = kScreenWidth - 32
        if let code = self.cpBianMa{
            if needCalcTotalDSDXInKaiJianDetailActivity(lotCode: code){
                cell.totalTV.isHidden = false
                cell.bigsmallTV.isHidden = false
                cell.danshuangTV.isHidden = false
                let appendInfos = figureOutALLDXDS(haomas: item.haoMaList, lotCode: code, lotType: self.cpTypeCode)
                if code == "PCEGG" || code == "JND28" || code == "FC3D" || code == "PL3"{
                    let n = item.haoMaList[item.haoMaList.count-1]
                    if isEmptyString(str: n) || !isPurnInt(string: n){
                        cell.totalTV.text = "总和:无"
                        cell.bigsmallTV.text = "大小:无"
                        cell.danshuangTV.text = "单双:无"
                    }else{
                        cell.totalTV.text = String.init(format: "总和:%@", n)
//                        let total = getMaxOpenNumFromLotCode(haomas: item.haoMaList, lotCode: code, lotType: self.cpTypeCode)
                        let total = 27
                        let nnn = Int(n)!
                        cell.bigsmallTV.text = String.init(format: "大小:%@", nnn <= total/2 ? "小" : "大")
                        cell.danshuangTV.text = String.init(format: "单双:%@", (nnn%2 == 0 ? "双" : "单"))
                    }
                }else{
                    if appendInfos.count == 3{
                        cell.totalTV.text = String.init(format: "总和:%@", appendInfos[0].num)
                        cell.bigsmallTV.text = String.init(format: "大小:%@", appendInfos[1].num)
                        cell.danshuangTV.text = String.init(format: "单双:%@", appendInfos[2].num)
                    }
                }
            }else{
                cell.totalTV.isHidden = true
                cell.bigsmallTV.isHidden = true
                cell.danshuangTV.isHidden = true
                //六合彩彩种时需要显示生肖
                if isSixMark(lotCode: self.cpBianMa!){
                    cell.summaryView.isHidden = false
                    cell.summaryHeightConstant.constant = 30
                    var sx = [String]()
                    if !item.haoMaList.isEmpty{
                        for index in 0...item.haoMaList.count-1{
                            sx.append(getShenXiaoFromNumber(number: item.haoMaList[index]))
                        }
                        cell.summaryView.setupBalls(nums: sx, offset: 0, lotTypeCode: self.cpTypeCode, cpVersion: self.lotVersion, viewPlaceHoldWidth: viewPlaceHoldWidth,ballWidth:30,small:false,summary:true)
                    }
                }else{
                    cell.summaryView.isHidden = true
                    cell.summaryHeightConstant.constant = 0
                }
            }
        }
        cell.ballView.setupBalls(nums: item.haoMaList, offset: 0,lotTypeCode: self.cpTypeCode, cpVersion: YiboPreference.getVersion(), viewPlaceHoldWidth: viewPlaceHoldWidth,ballWidth: ballWidth,small: small)
        return cell
    }
    
    func loadDatas() -> Void {
        
        let dataUrl = OPEN_RESULT_DETAIL_URL
        let params:Dictionary<String,AnyObject> = ["lotCode":cpBianMa as AnyObject,"page":pageNo as AnyObject,"rows":pageSize as AnyObject]
        
        request(frontDialog: true, loadTextStr:"获取记录中", url:dataUrl,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    self.parseWebResult(resultJson: resultJson)
        })
    }
    
    func parseWebResult(resultJson:String) -> Void {
        if let result = OpenResultDetailWraper.deserialize(from: resultJson){
            if result.success{
                YiboPreference.setToken(value: result.accessToken as AnyObject)
                if  self.pageNo == 1{
                    self.datas.removeAll()
                }
                if result.content != nil{
                    self.datas += result.content
                    self.tableView.reloadData()
                    //self.pageIndex = self.pageIndex + 1
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
    
}
