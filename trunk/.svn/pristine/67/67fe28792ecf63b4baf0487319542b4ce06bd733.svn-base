//
//  GoucaiQueryController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import MJRefresh

// buy lottery record query page
class ZuihaoQueryController: LennyBasicViewController {
    var goucaiDetailView: GoucaiDetailView =  GoucaiDetailView()
    var isSelect: Bool = false
    
    var dataRows = [AllLotteryQueryModelRows]()
    
    let refreshHeader = MJRefreshNormalHeader()
    let refreshFooter = MJRefreshBackNormalFooter()
    
    //MARK: - 刷新
    private func setupRefreshView() {
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.mainTableView.mj_header = refreshHeader
        self.mainTableView.mj_footer = refreshFooter
    }
    
    @objc fileprivate func headerRefresh() {
        self.loadNetRequest(isLoadMoreData: false)
    }
    
    @objc fileprivate func footerRefresh() {
        self.loadNetRequest(isLoadMoreData: true)
    }
    
    private func endRefresh() {
        self.mainTableView.mj_footer.endRefreshing()
        self.mainTableView.mj_header.endRefreshing()
    }
    
    private func noMoreDataStatusRefresh(noMoreData: Bool = true) {
        if noMoreData {
            self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
        }else {
            self.mainTableView.mj_footer.resetNoMoreData()
        }
    }

    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setupthemeBgView(view: self.view, alpha: 0)
        initData()
        setViews()
        
        self.setupRefreshView()
        self.loadNetRequest(isLoadMoreData: false)
    }
        
    private let mainPageView = WHC_PageView()
    private let layoutParameter = WHC_PageViewLayoutParam()
    
    var filterUsername = ""
    var filterLotCode = ""
    var filterStartTime = ""
    var filterEndTime = ""
    var current_index = 0
    
    private let mainTableView = UITableView()
    
    private func setViews() {
        self.title = "追号查询"
        
        let button = UIButton(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
//        button.setImage(UIImage.init(named: "filter"), for: .normal)
        button.setTitle("筛选", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
        button.isSelected = false
        button.theme_setTitleColor("Global.barTextColor", forState: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        contentView.addSubview(mainTableView)
        setViewBackgroundColorTransparent(view: mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.tableFooterView = UIView()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 56
        
    }
    
    func update(lotCode:String){
        self.loadNetRequest(isLoadMoreData: false)
    }
    
    func initData(){
        self.filterStartTime = getTodayZeroTime()
        self.filterEndTime = getTomorrowNowTime()
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            if contentView.viewWithTag(101) != nil { return }
            let filterView = ZuihaoFilterView(height: 200,controller:self)
            filterView.initializeDate(start: self.filterStartTime, end: self.filterEndTime)
            
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.didClickConfirmButton = {(username:String,lotCode:String,startTime:String,endTime:String)->Void in
                self.rightBarButtonItemAction(button: button)
                self.filterUsername = username
                self.filterLotCode = lotCode
                self.filterStartTime = startTime
                self.filterEndTime = endTime
                self.loadNetRequest(isLoadMoreData: false)
            }
            filterView.tag = 101
            contentView.addSubview(filterView)
            filterView.frame = CGRect.init(x: 0, y: -180, width: MainScreen.width, height: 180)
            contentView.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                filterView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 180)
                self.mainTableView.frame = CGRect.init(x: 0, y: 180, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                button.isSelected = true
            }
        }else {
            button.isSelected = false
            let filterView = contentView.viewWithTag(101)
            UIView.animate(withDuration: 0.5, animations: {
                filterView?.alpha = 0
                filterView?.frame = CGRect.init(x: 0, y: -180, width: MainScreen.width, height: 180)
                self.mainTableView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                filterView?.removeFromSuperview()
                button.isSelected = false
            }
        }
    }
    
    private func loadNetRequest(isLoadMoreData: Bool,pageSize: Int =  defaultCountOfRequestPagesize) {
        
        var pageNumber = 1
        if isLoadMoreData {
            if self.dataRows.count % pageSize == 0 {
                pageNumber = self.dataRows.count / pageSize + 1
            }else {
                noMoreDataStatusRefresh()
                return
            }
        }
        
        LennyNetworkRequest.obtainLotteryQuery(lotteryCode: self.filterLotCode, startTime: self.filterStartTime, endTime: self.filterEndTime, qihao: "", version: "", order: "", zuihaoOrder: "", status: "", queryType: "2", playCode: "", include: "1", username: self.filterUsername,pageSize: "\(pageSize)",pageNumber: "\(pageNumber)") { (model) in
            
            self.endRefresh()
            
            self.view.hideSkeleton()
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
                return
            }

            guard let modelP = model else {return}
            guard let contetP = modelP.content else {return}
            guard let rowsP = contetP.rows else {return}
            
            self.dataRows = rowsP
            
            if !isLoadMoreData {
                self.dataRows.removeAll()
            }
            self.dataRows += rowsP
            self.noMoreDataStatusRefresh(noMoreData: rowsP.count % pageSize != 0 || rowsP.count == 0)
            
            self.mainTableView.reloadData()
        }
    }
}

extension ZuihaoQueryController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (isSelect == false) {
            isSelect = true
            showGoucaiDetailView(indexPath: indexPath)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
    }
    
    
    //MARK: - 购彩详情列表
    private func showGoucaiDetailView(indexPath: IndexPath){
        
//        let rows = LennyModel.allLotteryQueryModel?.content?.rows![indexPath.row]
        
        let rows = self.dataRows[indexPath.row]
        let dataSource = formatGoucaiDetailDatas(model: rows)
        
        var selectedView = GoucaiDetailView()
        if rows.status == "1" {
            selectedView = GoucaiDetailView(dataSource: dataSource, viewTitle: "追号详情", bottomHeight: 40)
        }else {
            selectedView = GoucaiDetailView(dataSource: dataSource, viewTitle: "追号详情", bottomHeight: 0)
        }
        
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width - 100).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
        }
        
        if rows.status == "1" {
            let withdrawalButton = UIButton()
            withdrawalButton.tag = 100 + indexPath.row
            withdrawalButton.addTarget(self, action: #selector(QueryResultsBasicController.withdrawAction(button:)), for: .touchUpInside)
            withdrawalButton.setTitleColor(UIColor.white, for: .normal)
            withdrawalButton.theme_backgroundColor = "Global.themeColor"
            withdrawalButton.setTitle("撤单", for: .normal)
            selectedView.bringSubview(toFront: withdrawalButton)
            selectedView.addSubview(withdrawalButton)
            goucaiDetailView = selectedView
            
            withdrawalButton.snp.makeConstraints { (make) in
                make.leading.trailing.equalTo(0)
                make.bottom.equalTo(0)
                make.height.equalTo(40)
            }
        }
    }
    
    
    func withDrawalWebMethod(index: Int) {
        
        goucaiDetailView.dismissGroupDetailView()
//        let rows = LennyModel.allLotteryQueryModel?.content?.rows![index]
        let rows = self.dataRows[index]
        var order = ""
        if let o = rows.orderId{
            order = o
        }
        var lotCode = ""
        if let code = rows.lotCode{
            lotCode = code
        }
        let isTest = YiboPreference.getAccountMode() == GUEST_TYPE
        let parameters = ["isTest":isTest,"lotCode":lotCode,"orderIds":order] as [String : Any]
        print("parame === ",parameters)
        self.request(frontDialog: true, method: .post,url: LOTTERY_CANCEL_ORDER_URL,params:parameters,
                     callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "提交失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = CancelOrderWraper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                if result.content{
                                    showToast(view: self.view, txt: "撤单成功")
                                    self.loadNetRequest(isLoadMoreData: false)
                                }else{
                                    showToast(view: self.view, txt: "撤单失败")
                                }
                            }else{
                                if !isEmptyString(str: result.msg){
                                    showToast(view: self.view, txt: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "撤单失败"))
                                }
                                if result.code == 0{
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }
                        }
        })
    }
    
    @objc func withdrawAction(button:UIButton) {
        let message = "确定要撤单吗？"
        let alertController = UIAlertController(title: "温馨提示",
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.withDrawalWebMethod(index: button.tag - 100)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func formatGoucaiDetailDatas(model: AllLotteryQueryModelRows) -> [String] {
        
        var array = [String]()
        
        array.append(String.init(format: "追号编号: %@", model.orderId!))
   
        array.append(String.init(format: "追号时间: %@", model.createTime!))
        array.append(String.init(format: "用户: %@", model.username!))
        if let haoma = model.openHaoMa{
            array.append(String.init(format: "开奖号码:%@", haoma))
        }
        if let zjje = model.winMoney{
            array.append(String.init(format: "中奖金额:%@元", !isEmptyString(str: zjje) ? zjje:"0"))
        }
        array.append(String.init(format: "彩种: %@", model.lotName!))
        array.append(String.init(format: "玩法: %@", model.playName!))
        array.append(String.init(format: "追号内容: %@", model.haoMa!))
        array.append(String.init(format: "购买金额: %@元", model.buyMoney!))
        array.append(String.init(format: "被追号编号: %@", model.zhuiOrderId!))
        array.append(String.init(format: "状态: %@", statusToStringChar(status: model.status!)))
        return array
    }
    
    
    
    
    //状态标识转换为对应字符串
    //// 1未开奖 2已中奖 3未中奖 4撤单 5派奖回滚成功 6和局
    private func statusToStringChar(status:String) -> String {
        switch status {
        case "1":
            return "未开奖"
        case "2":
            return "已中奖"
        case "3":
            return "未中奖"
        case "4":
            return "已撤单"
        case "5":
            return "派奖回滚成功"
        case "6":
            return "和局"
        default:
            return "未开奖"
        }
    }

}

extension ZuihaoQueryController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let rows = LennyModel.allLotteryQueryModel?.content?.rows {
//            return rows.count
//        }
//        return 0
        return self.dataRows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let rows = LennyModel.allLotteryQueryModel?.content?.rows![indexPath.row]
        let rows = self.dataRows[indexPath.row]
        let cell = QueryResultsCell.init(style: .default, reuseIdentifier: "cell")
        cell.setBetNumbers(value: rows.haoMa!)
        cell.setLotteryName(value: rows.lotName!)
        cell.setBalance(value: rows.buyMoney!)
        cell.setPaiJiangBalance(value: rows.winMoney!)
        cell.setBetsType(value: rows.terminalBetType!)
        cell.setStatus(value: rows.status!)
        cell.setDate(value: rows.createTime!)
        return cell
    }
}

