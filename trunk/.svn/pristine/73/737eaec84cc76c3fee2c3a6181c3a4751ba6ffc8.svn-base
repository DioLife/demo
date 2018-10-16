//
//  GerenProfileController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

//个人&团队总览
class GerenTeamProfileController: BaseController,UITableViewDelegate,UITableViewDataSource{
    
    var datas:[[GerenOverviewBean]] = []
    @IBOutlet weak var tableview: UITableView!
    var fromTeam:Bool = false
    var filterStartTime = ""
    var filterEndTime = ""
    var filterUsername = ""
    var includeBelowUser = false
    var accountId:Int64 = 0
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view,alpha: 0)
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        self.title = fromTeam ? "团队总览" : "个人总览"
        let filterViewHeight: CGFloat = 120
        self.tableview.whc_Left(0).whc_Top(64).whc_Right(0).whc_Height(screenHeight - filterViewHeight - 64)
        setupFooter(type: fromTeam ? 2 : 1)
        initDate()
        
        let button = UIButton(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        button.setTitle("筛选", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
        button.isSelected = false
        button.theme_setTitleColor("Global.barTextColor", forState: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        self.loadGlobalData()
    }
    
    /** 个人总览 1，团队总览：2 */
    private func setupFooter(type: Int) {
        let footer = UIView()
        footer.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 50)
        footer.backgroundColor = UIColor.clear
        
        let label = UILabel()
        footer.addSubview(label)
        label.whc_Top(0).whc_Left(10).whc_Bottom(0).whc_Right(0)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14.0)
        

        let topLine = UIView()
        footer.addSubview(topLine)
        topLine.whc_Left(0).whc_Top(0).whc_Right(0).whc_Height(1)
        topLine.backgroundColor = UIColor.gray.withAlphaComponent(0.15)
        
        let bottomLine = UIView()
        footer.addSubview(bottomLine)
        bottomLine.whc_Left(0).whc_Bottom(0).whc_Right(0).whc_Height(1)
        bottomLine.backgroundColor = UIColor.gray.withAlphaComponent(0.15)
        
        var contents = ""
        if type == 1 {
            contents = "净盈利=中奖金额+投注返水-投注金额"
        }else if type == 2 {
            contents = "净盈利=中奖金额+投注返水-投注金额"
        }
        label.text = contents
        
        tableview.tableFooterView = footer
    }
    
    func initDate(){
        self.filterStartTime = getTodayZeroTime()
        self.filterEndTime = getTomorrowNowTime()
    }
    
    private func loadGlobalData(){
        fromTeam ? self.loadTeamData() : accountWeb()
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            if self.view.viewWithTag(101) != nil { return }
            let filterHeight: CGFloat = 120
            let filterView = ReportViewFilter(height: filterHeight,controller:self)
            filterView.initializeDate(start: self.filterStartTime, end: self.filterEndTime)
            
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.didClickConfirmButton = {(lotCode:String,startTime:String,endTime:String)->Void in
                self.rightBarButtonItemAction(button: button)
                self.filterStartTime = startTime
                self.filterEndTime = endTime
                self.loadGlobalData()
            }
            filterView.tag = 101
            self.view.addSubview(filterView)
//            filterView.frame = CGRect.init(x: 0, y: -100, width: MainScreen.width, height: 100)
            let filerviewHeight: CGFloat = 120
            filterView.whc_Top(64-filterHeight).whc_Left(0).whc_Right(0).whc_Height(filerviewHeight)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                filterView.whc_Left(0).whc_Top(64).whc_Right(0).whc_Height(filerviewHeight)
                self.tableview.whc_Left(0).whc_Top(filterHeight+64).whc_Right(0).whc_Height(screenHeight - filterHeight - 64)
            }) { ( _) in
                button.isSelected = true
            }
        }else {
            let filerviewHeight: CGFloat = 120
            button.isSelected = false
            let filterView = self.view.viewWithTag(101)
            UIView.animate(withDuration: 0.5, animations: {
                filterView?.alpha = 0
                filterView?.whc_Left(0).whc_Top(0-filerviewHeight).whc_Right(0).whc_Height(filerviewHeight)
                self.tableview.whc_Left(0).whc_Top(64).whc_Right(0).whc_Height(screenHeight - filerviewHeight - 64)
            }) { ( _) in
                filterView?.removeFromSuperview()
                button.isSelected = false
            }
        }
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
                                //定位crash
                                var balance:Float = 0
                                if !isEmptyString(str: memInfo.balance){
                                    balance = Float(memInfo.balance)!
                                }
                                self.loadGata(balance:balance)
                            }
                        }
                    }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var line = self.datas.count / 3
        if self.datas.count % 3 > 0{
            line += 1
        }
        return CGFloat(line*80 + 45)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "zl") as? ZonglangTableCell  else {
            fatalError("The dequeued cell is not an instance of zhonglang cell.")
        }
        let data = self.datas[indexPath.row]
        cell.setDatas(data: data, label: getCellLabel(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    private func getCellLabel(index:Int) -> String{
        if index == 0{
            return fromTeam ? "团队详情" : "个人详情"
        }else if index == 1{
            return "彩票游戏"
        }else if index == 2 {
            return "体育竞技"
        }else if index == 3{
            return "电子游戏"
        }else if index == 4{
            return "真人娱乐"
        }else if index == 5{
            return "沙巴体育"
        }
        return ""
    }
    
}

extension GerenTeamProfileController{
    
}

extension GerenTeamProfileController{
    
    func prepareDatas(model:GerenOVContent?,balance:Float){
        if let content = model{
            
            self.datas.removeAll()
            //个人详情
            var persons = [GerenOverviewBean]()
            let item1 = GerenOverviewBean()
            item1.label = "余额"
            item1.content = String.init(format: "%.2f元", balance)
            persons.append(item1)
            
            let item2 = GerenOverviewBean()
            item2.label = "总充值"
            let money = content.depositArtificial + content.depositAmount
            item2.content = String.init(format: "%.2f元", money)
            persons.append(item2)
            
            let item3 = GerenOverviewBean()
            item3.label = "总提现"
            item3.content = String.init(format: "%.2f元", content.withdrawAmount)
            persons.append(item3)
            
            let item63 = GerenOverviewBean()
            item63.label = "返点"
            item63.content = String.init(format: "%.2f", content.proxyRebateAmount)
            persons.append(item63)
            
            
            self.datas.append(persons)
            
            
            
            //彩票游戏
            var caipiaos = [GerenOverviewBean]()
            let item4 = GerenOverviewBean()
            item4.label = "投注金额"
            item4.content = String.init(format: "%.2f元", content.lotteryBetAmount)
            caipiaos.append(item4)
            
            let item5 = GerenOverviewBean()
            item5.label = "净盈利"
            let cpjyl = content.lotteryWinAmount + content.lotteryRebateAmount - content.lotteryBetAmount
            item5.content = String.init(format: "%.2f元", cpjyl)
            caipiaos.append(item5)
            
            let item6 = GerenOverviewBean()
            item6.label = "中奖金额"
            item6.content = String.init(format: "%.2f元", content.lotteryWinAmount)
            caipiaos.append(item6)
            
            let item8 = GerenOverviewBean()
            item8.label = "投注返点"
            item8.content = String.init(format: "%.2f", content.lotteryRebateAmount)
            caipiaos.append(item8)
            self.datas.append(caipiaos)
            
            
            //体育竞技
            var tiyus = [GerenOverviewBean]()
            let item9 = GerenOverviewBean()
            item9.label = "投注金额"
            item9.content = String.init(format: "%.2f元", content.sportsBetAmount)
            tiyus.append(item9)
            
            let item10 = GerenOverviewBean()
            item10.label = "净盈利"
            let tyjyl = content.sportsWinAmount + content.sportsRebateAmount - content.sportsBetAmount
            item10.content = String.init(format: "%.2f元", tyjyl)
            tiyus.append(item10)
            
            
            let item11 = GerenOverviewBean()
            item11.label = "中奖金额"
            item11.content = String.init(format: "%.2f元", content.sportsWinAmount)
            tiyus.append(item11)
            
            let item12 = GerenOverviewBean()
            item12.label = "投注返点"
            item12.content = String.init(format: "%.2f", content.sportsRebateAmount)
            tiyus.append(item12)
            self.datas.append(tiyus)
            
            //电子游戏
            var dianzi = [GerenOverviewBean]()
            let item13 = GerenOverviewBean()
            item13.label = "投注金额"
            item13.content = String.init(format: "%.2f元", content.egameBetAmount)
            dianzi.append(item13)
            
            let item14 = GerenOverviewBean()
            item14.label = "净盈利"
            let egamejyl = content.egameWinAmount + content.egameRebateAmount - content.egameBetAmount
            item14.content = String.init(format: "%.2f元", egamejyl)
            dianzi.append(item14)
            
            let item15 = GerenOverviewBean()
            item15.label = "中奖金额"
            item15.content = String.init(format: "%.2f元", content.egameWinAmount)
            dianzi.append(item15)
            
            let item16 = GerenOverviewBean()
            item16.label = "投注返点"
            item16.content = String.init(format: "%.2f", content.egameRebateAmount)
            dianzi.append(item16)
            self.datas.append(dianzi)
            
            //真人娱乐
            var zhenren = [GerenOverviewBean]()
            let item17 = GerenOverviewBean()
            item17.label = "投注金额"
            item17.content = String.init(format: "%.2f元", content.realBetAmount)
            zhenren.append(item17)
            
            let item18 = GerenOverviewBean()
            item18.label = "净盈利"
            let realjyl = content.realWinAmount + content.realRebateAmount - content.realBetAmount
            item18.content = String.init(format: "%.2f元", realjyl)
            zhenren.append(item18)
            
            let item19 = GerenOverviewBean()
            item19.label = "中奖金额"
            item19.content = String.init(format: "%.2f元", content.realWinAmount)
            zhenren.append(item19)
            
            let item20 = GerenOverviewBean()
            item20.label = "投注返点"
            item20.content = String.init(format: "%.2f", content.realRebateAmount)
            zhenren.append(item20)
            self.datas.append(zhenren)
            
            
            //沙巴体育
            var shaba = [GerenOverviewBean]()
            let item30 = GerenOverviewBean()
            item30.label = "投注金额"
            item30.content = String.init(format: "%.2f元", content.sbSportsBetAmount)
            shaba.append(item30)
            
            let item31 = GerenOverviewBean()
            item31.label = "净盈利"
            let shabajyl = content.sbSportsWinAmount + content.sbSportsRebateAmount - content.sbSportsBetAmount
            item31.content = String.init(format: "%.2f元", shabajyl)
            shaba.append(item31)
            
            let item32 = GerenOverviewBean()
            item32.label = "中奖金额"
            item32.content = String.init(format: "%.2f元", content.sbSportsWinAmount)
            shaba.append(item32)
            
            let item33 = GerenOverviewBean()
            item33.label = "投注返点"
            item33.content = String.init(format: "%.2f", content.sbSportsRebateAmount)
            shaba.append(item33)
            self.datas.append(shaba)
            
        }
    }
    
    func prepareTeamDatas(model:TeamOverviewBean?){
        if let content = model{
            
            self.datas.removeAll()
            //团队详情
            var tuanDuiDetails = [GerenOverviewBean]()
            
            let item11 = GerenOverviewBean()
            item11.label = "团队人数"
            item11.content = String.init(format: "%d人", (content.memberCount+content.proxyCount))
            tuanDuiDetails.append(item11)
            
            let item22 = GerenOverviewBean()
            item22.label = "当前在线"
            item22.content = String.init(format: "%d人", (content.onlineNum))
            tuanDuiDetails.append(item22)
            
            let item1 = GerenOverviewBean()
            item1.label = "团队余额"
            item1.content = String.init(format: "%.2f元", (content.teamMoney))
            tuanDuiDetails.append(item1)
            
            let item2 = GerenOverviewBean()
            item2.label = "充值"
            item2.content = String.init(format: "%.2f元", (content.dailyMoney?.depositAmount)!)
            tuanDuiDetails.append(item2)
            
            let item3 = GerenOverviewBean()
            item3.label = "提现"
            item3.content = String.init(format: "%.2f元", (content.dailyMoney?.withdrawAmount)!)
            tuanDuiDetails.append(item3)
            
            guard let subData = content.dailyMoney else {return}
            
            
            let item40 = GerenOverviewBean()
            item40.label = "团队返点"
            item40.content = String.init(format: "%.2f元", subData.proxyRebateAmount)
            tuanDuiDetails.append(item40)
            self.datas.append(tuanDuiDetails)
            
            //彩票游戏
            var caipiaos = [GerenOverviewBean]()
            let item4 = GerenOverviewBean()
            item4.label = "投注金额"
            item4.content = String.init(format: "%.2f元", subData.lotteryBetAmount)
            caipiaos.append(item4)
            
            let item5 = GerenOverviewBean()
            item5.label = "净盈利"
//            let cpjyl = subData.lotteryWinAmount + subData.lotteryRebateAmount + subData.proxyRebateAmount - subData.lotteryBetAmount
            let cpjyl = subData.lotteryWinAmount + subData.lotteryRebateAmount - subData.lotteryBetAmount
            item5.content = String.init(format: "%.2f元", cpjyl)
            caipiaos.append(item5)
            
            let item6 = GerenOverviewBean()
            item6.label = "中奖金额"
            item6.content = String.init(format: "%.2f元", subData.lotteryWinAmount)
            caipiaos.append(item6)
            
            let item8 = GerenOverviewBean()
            item8.label = "投注返点"
            item8.content = String.init(format: "%.2f", subData.lotteryRebateAmount)
            caipiaos.append(item8)
            self.datas.append(caipiaos)
            
            
            //体育竞技
            var tiyus = [GerenOverviewBean]()
            let item9 = GerenOverviewBean()
            item9.label = "投注金额"
            item9.content = String.init(format: "%.2f元", subData.sportsBetAmount)
            tiyus.append(item9)
            
            let item10 = GerenOverviewBean()
            item10.label = "净盈利"
//            let tyjyl = subData.sportsWinAmount + subData.sportsRebateAmount + subData.proxyRebateAmount - subData.sportsBetAmount
            let tyjyl = subData.sportsWinAmount + subData.sportsRebateAmount - subData.sportsBetAmount
            item10.content = String.init(format: "%.2f元", tyjyl)
            tiyus.append(item10)
            
            
            let item51 = GerenOverviewBean()
            item51.label = "中奖金额"
            item51.content = String.init(format: "%.2f元", subData.sportsWinAmount)
            tiyus.append(item51)
            
            let item12 = GerenOverviewBean()
            item12.label = "投注返点"
            item12.content = String.init(format: "%.2f", subData.sportsRebateAmount)
            tiyus.append(item12)
            self.datas.append(tiyus)
            
            //电子游戏
            var dianzi = [GerenOverviewBean]()
            let item13 = GerenOverviewBean()
            item13.label = "投注金额"
            item13.content = String.init(format: "%.2f元", subData.egameBetAmount)
            dianzi.append(item13)
            
            let item14 = GerenOverviewBean()
            item14.label = "净盈利"
//            let egamejyl = subData.egameWinAmount + subData.egameRebateAmount + subData.proxyRebateAmount - subData.egameBetAmount
            let egamejyl = subData.egameWinAmount + subData.egameRebateAmount - subData.egameBetAmount
            item14.content = String.init(format: "%.2f元", egamejyl)
            dianzi.append(item14)
            
            let item15 = GerenOverviewBean()
            item15.label = "中奖金额"
            item15.content = String.init(format: "%.2f元", subData.egameWinAmount)
            dianzi.append(item15)
            
            let item16 = GerenOverviewBean()
            item16.label = "投注返点"
            item16.content = String.init(format: "%.2f", subData.egameRebateAmount)
            dianzi.append(item16)
            self.datas.append(dianzi)
            
            //真人娱乐
            var zhenren = [GerenOverviewBean]()
            let item17 = GerenOverviewBean()
            item17.label = "投注金额"
            item17.content = String.init(format: "%.2f元", subData.realBetAmount)
            zhenren.append(item17)
            
            let item18 = GerenOverviewBean()
            item18.label = "净盈利"
//            let realjyl = subData.egameWinAmount + subData.egameRebateAmount + subData.proxyRebateAmount - subData.egameBetAmount
            let realjyl = subData.realWinAmount + subData.realRebateAmount - subData.realBetAmount
            item18.content = String.init(format: "%.2f元", realjyl)
            zhenren.append(item18)
            
            let item19 = GerenOverviewBean()
            item19.label = "中奖金额"
            item19.content = String.init(format: "%.2f元", subData.realWinAmount)
            zhenren.append(item19)
            
            let item20 = GerenOverviewBean()
            item20.label = "投注返点"
            item20.content = String.init(format: "%.2f", subData.realRebateAmount)
            zhenren.append(item20)
            self.datas.append(zhenren)
            
            
            //沙巴体育
            var shaba = [GerenOverviewBean]()
            let item30 = GerenOverviewBean()
            item30.label = "投注金额"
            item30.content = String.init(format: "%.2f元", subData.sbSportsBetAmount)
            shaba.append(item30)
            
            let item31 = GerenOverviewBean()
            item31.label = "净盈利"
//            let shabajyl = subData.sbSportsWinAmount + subData.sbSportsRebateAmount + subData.proxyRebateAmount - subData.sbSportsBetAmount
            let shabajyl = subData.sbSportsWinAmount + subData.sbSportsRebateAmount - subData.sbSportsBetAmount
            item31.content = String.init(format: "%.2f元", shabajyl)
            shaba.append(item31)
            
            let item32 = GerenOverviewBean()
            item32.label = "中奖金额"
            item32.content = String.init(format: "%.2f元", subData.sbSportsWinAmount)
            shaba.append(item32)
            
            let item33 = GerenOverviewBean()
            item33.label = "投注返点"
            item33.content = String.init(format: "%.2f", subData.sbSportsRebateAmount)
            shaba.append(item33)
            self.datas.append(shaba)
        }
    }
    
    
    func loadTeamData(){
        
        let parameter = ["startTime": self.filterStartTime,"endTime":self.filterEndTime,
                         "accountId":accountId] as [String : Any]
        request(frontDialog: true, method:.get, loadTextStr:"获取中...", url:API_TEAM_OVERVIEW,params:parameter,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = TeamOverViewWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if result.content != nil{
                                self.prepareTeamDatas(model: result.content)
                                self.tableview.reloadData()
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
        })
    }
    
    func loadGata(balance:Float){
        
        let parameter = ["startTime": self.filterStartTime,"endTime":self.filterEndTime,"username":self.filterUsername,
                         "include":includeBelowUser] as [String : Any]
        request(frontDialog: true, method:.get, loadTextStr:"获取中...", url:API_PERSON_OVERVIEW,params:parameter,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = GerenOverviewWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if result.content != nil{
                                self.prepareDatas(model: result.content,balance:balance)
                                self.tableview.reloadData()
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
        })
    }
}

