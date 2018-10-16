//
//  GerenReportController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/19.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import MJRefresh

class GerenReportController: LennyBasicViewController {
    
    var filterLotCode = ""
    var filterStartTime = ""
    var filterEndTime = ""
    var current_index = 0
    var model:GeRenBaoBiaoModel!
    
    let label_win_total = UILabel()
    let label_bet_total = UILabel()
    
    var dataRows = [ReportModeRows]()
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
        self.mainTableView.mj_header.endRefreshing()
        self.mainTableView.mj_footer.endRefreshing()
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
        
        initDate()
        setViews()
        setupRefreshView()
        self.loadNetRequest(isLoadMoreData: false)
    }
    
    private let mainTableView = UITableView()
    private func setViews() {

        self.title = "个人报表"
        
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
        setViewBackgroundColorTransparent(view: mainTableView)
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.tableHeaderView = tableHeaderView()
        mainTableView.tableFooterView = UIView()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 56
        
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            if contentView.viewWithTag(101) != nil { return }
            let filterView = GerenFilterView(height: 200,controller:self)
            filterView.initializeDate(start: self.filterStartTime, end: self.filterEndTime)
            
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.didClickConfirmButton = {(lotCode:String,startTime:String,endTime:String)->Void in
                self.rightBarButtonItemAction(button: button)
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
    
    private func tableHeaderView() -> UIView {
        
        let viewHeader = UIView(frame: CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 66))
        
        let totalHeader = UIView(frame: CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 33))
        setupNoPictureAlphaBgView(view: totalHeader, alpha: 0.4, bgViewColor: "FrostedGlass.subColorImageCoverDarkColorForNotGlass")
        
        let label = UILabel()
        totalHeader.addSubview(label)
        label.whc_CenterY(0).whc_Left(0).whc_Width(MainScreen.width/3).whc_Height(20)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.red
        label.text = "合计"
        
//        let label_bet_total = UILabel()
        totalHeader.addSubview(label_bet_total)
        label_bet_total.whc_CenterY(0).whc_Left(0, toView: label).whc_Width(MainScreen.width/3).whc_Height(20)
        label_bet_total.font = UIFont.systemFont(ofSize: 12)
        label_bet_total.textAlignment = NSTextAlignment.center
        label_bet_total.textColor = UIColor.red
        label_bet_total.text = "0元"
        
//        let label_win_total = UILabel()
        totalHeader.addSubview(label_win_total)
        label_win_total.whc_CenterY(0).whc_Left(0, toView: label_bet_total).whc_Width(MainScreen.width/3).whc_Height(20)
        label_win_total.font = UIFont.systemFont(ofSize: 12)
        label_win_total.textAlignment = NSTextAlignment.center
        label_win_total.textColor = UIColor.red
        label_win_total.text = "0元"
        
        let secondHeader = UIView(frame: CGRect.init(x: 0, y: 33, width: MainScreen.width, height: 33))
        setupNoPictureAlphaBgView(view: secondHeader, alpha: 0.4)

        let label_date = UILabel()
        secondHeader.addSubview(label_date)
        label_date.whc_CenterY(0).whc_Left(0).whc_Width(MainScreen.width/3).whc_Height(20)
        label_date.font = UIFont.systemFont(ofSize: 12)
        label_date.textAlignment = NSTextAlignment.center
//        label_date.textColor = UIColor.white
        label_date.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_date.text = "日期"

        let label_bet = UILabel()
        secondHeader.addSubview(label_bet)
        label_bet.whc_CenterY(0).whc_Left(0, toView: label_date).whc_Width(MainScreen.width/3).whc_Height(20)
        label_bet.font = UIFont.systemFont(ofSize: 12)
        label_bet.textAlignment = NSTextAlignment.center
//        label_bet.textColor = UIColor.white
        label_bet.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_bet.text = "彩票投注"

        let label_win = UILabel()
        secondHeader.addSubview(label_win)
        label_win.whc_CenterY(0).whc_Left(0, toView: label_bet).whc_Width(MainScreen.width/3).whc_Height(20)
        label_win.font = UIFont.systemFont(ofSize: 12)
        label_win.textAlignment = NSTextAlignment.center
//        label_win.textColor = UIColor.white
        label_win.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_win.text = "彩票盈亏"
        
        viewHeader.addSubview(totalHeader)
        viewHeader.addSubview(secondHeader)
        return viewHeader
    }
    
    func initDate(){
        self.filterStartTime = getTodayZeroTime()
        self.filterEndTime = getTomorrowNowTime()
    }
    
    func loadNetRequest(isLoadMoreData: Bool,pageSize: Int = defaultCountOfRequestPagesize) {
        
        var pageNumber = 1
        if isLoadMoreData {
            if self.dataRows.count % pageSize == 0 {
                pageNumber = self.dataRows.count / pageSize + 1
            }else {
                noMoreDataStatusRefresh()
                return
            }
        }
        
        LennyNetworkRequest.obtainPersonReports(startTime: self.filterStartTime, endTime: self.filterEndTime, lotCode: self.filterLotCode, queryType: 1, pageNumber: pageNumber, pageSize: pageSize){
            (model) in
            
            self.endRefresh()
            
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
                return
            }
            
            self.model = model
            
            guard let contentP = self.model.content else {return}
            guard let pageP = contentP.page else {return}
            guard let rowsP = pageP.rows else {return}
            
            if !isLoadMoreData {
                self.dataRows.removeAll()
            }
            self.dataRows += rowsP
            self.noMoreDataStatusRefresh(noMoreData: rowsP.count % pageSize != 0 || rowsP.count == 0)
            
            self.updateTotalInfoAfterSync()
            self.view.hideSkeleton()
            self.refreshTableViewData()
        }
    }
    
    override func refreshTableViewData() {
        mainTableView.reloadData()
    }
    
    private func updateTotalInfoAfterSync(){
        if self.model == nil{
            return
        }
        guard let content = self.model.content else {return}
        label_bet_total.text = String.init(format: "%.2f元", content.lotteryBetAmountCount)
        label_win_total.text = String.init(format: "%.2f元", content.profitAndLossTotal)
    }
}

extension GerenReportController: UITableViewDelegate {
    
}

extension GerenReportController: UITableViewDataSource {
    
    @objc func onItemClick(datasoure:[String]){
        if datasoure.isEmpty{
            return
        }
        let dialog = DetailListDialog(dataSource: datasoure, viewTitle: "报表详情")
        dialog.selectedIndex = 0
//        randomView.didSelected = {
//        }
        self.view.window?.addSubview(dialog)
        dialog.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(dialog.kHeight)
        dialog.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            dialog.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func formSource(row:Int) -> [String]{
//        if let model = self.model{
//            guard let content = model.content else { return []}
//            guard let page = content.page else {return []}
//            guard let rows = page.rows else {return []}
//            let data = rows[row]
        let data = self.dataRows[row]
            var sources = [String]()
            //彩票投注
            let cptz = String.init(format: "彩票投注: %.2f元", data.lotteryBetAmount)
            //彩票阴亏
            let yinkui = data.lotteryWinAmount + data.lotteryRebateAmount - data.lotteryBetAmount
            let dlyk = String.init(format: "彩票赢亏: %.2f元", yinkui)
            //tikuan
            let withdraw = String.init(format: "提款: %.2f元", data.withdrawAmount)
            //charge
            let charge = String.init(format: "充值: %.2f元", data.depositAmount)
            //彩票中奖
            let cpzj = String.init(format: "彩票中奖: %.2f元", data.lotteryWinAmount)
            //代理返点
            let dlfd = String.init(format: "代理返点: %.2f", data.proxyRebateAmount)
            //投注返点
            let tzfd = String.init(format: "投注返点: %.2f", data.lotteryRebateAmount)
            sources.append(cptz)
            sources.append(dlyk)
            sources.append(withdraw)
            sources.append(charge)
            sources.append(cpzj)
            sources.append(dlfd)
            sources.append(tzfd)
            return sources
//        }
//        return []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemClick(datasoure: formSource(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //暂时没找出为什么不能从数据库中查出个人报表model对象，这里直接使用从网络获取到的model
//        if let model = LennyModel.geRenBaoBiaoModel{
//        if let model = self.model{
//            guard let content = model.content else { return 0}
//            guard let page = content.page else {return 0}
//            guard let rows = page.rows else {return 0}
//            return rows.count
//        }
//        return 0
        
        return self.dataRows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GerenReportCell.init(style: .default, reuseIdentifier: "cell")
//        let rows = LennyModel.geRenBaoBiaoModel?.content?.page?.rows![indexPath.row]
        
        let rows = self.dataRows[indexPath.row]
        
//        if let rows = self.model.content?.page?.rows![indexPath.row]{
            cell.setDate(value: (rows.statDate)!)
            cell.setBetLabel(value: String.init(format: "%.2f元", rows.lotteryBetAmount))
            let yinkui = rows.lotteryWinAmount + rows.lotteryRebateAmount - rows.lotteryBetAmount
            cell.setWinLabel(value: String.init(format: "%.2f元", yinkui))
//        }
        return cell
    }
}

