//
//  AccountChangeController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import MJRefresh

class AccountChangeController: LennyBasicViewController {
    
    var filterUserName = ""
    var filterStartTime = ""
    var filterEndTime = ""
    var filterTypes = 0
    var include_below = false
    var model:AccountChangeModel!
    var dataRows = [AccountChangeRowModel]()
    var currentPage = 1
    var isSelect = false
    
    let label_sell_total = UILabel()
    let label_earn_total = UILabel()
    
    let refreshHeader = MJRefreshNormalHeader()
    let refreshFooter = MJRefreshBackNormalFooter()
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        initDate()
        setViews()
//        loadNetRequestWithViewSkeleton(animate: true)
        self.loadNetRequest(isLoadMoreData: false)
        setupRefreshView()
    }
    
    private let mainTableView = UITableView()
    private func setViews() {
        
        self.title = "账变报表"
        
        let button = UIButton(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
//        button.setImage(UIImage.init(named: "filter"), for: .normal)
        button.setTitle("筛选", for: .normal)
        button.theme_setTitleColor("Global.barTextColor", forState: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
        button.isSelected = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
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
            let filterView = AccountChangeFilterView(height: 200,controller:self)
            filterView.initializeDate(start: self.filterStartTime, end: self.filterEndTime,username: self.filterUserName)
            
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.didClickConfirmButton = {(username:String,startTime:String,endTime:String,include:Bool,type:Int)->Void in
                self.rightBarButtonItemAction(button: button)
                self.filterUserName = username
                self.filterStartTime = startTime
                self.filterEndTime = endTime
                self.include_below = include
                self.filterTypes = type
//                self.loadNetRequestWithViewSkeleton(animate: true)
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
//        totalHeader.backgroundColor = UIColor.lightGray
        setViewBackgroundColorTransparent(view: totalHeader)
        
        let label = UILabel()
        totalHeader.addSubview(label)
        label.whc_CenterY(0).whc_Left(0).whc_Width(MainScreen.width/3).whc_Height(20)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.red
        label.text = "合计"
        
        //        let label_bet_total = UILabel()
        totalHeader.addSubview(label_sell_total)
        label_sell_total.whc_CenterY(0).whc_Left(0, toView: label).whc_Width(MainScreen.width/3).whc_Height(20)
        label_sell_total.font = UIFont.systemFont(ofSize: 12)
        label_sell_total.textAlignment = NSTextAlignment.center
        label_sell_total.textColor = UIColor.red
        label_sell_total.text = "0元"
        
        //        let label_win_total = UILabel()
        totalHeader.addSubview(label_earn_total)
        label_earn_total.whc_CenterY(0).whc_Left(0, toView: label_sell_total).whc_Width(MainScreen.width/3).whc_Height(20)
        label_earn_total.font = UIFont.systemFont(ofSize: 12)
        label_earn_total.textAlignment = NSTextAlignment.center
        label_earn_total.textColor = UIColor.red
        label_earn_total.text = "0元"
        
        let secondHeader = UIView(frame: CGRect.init(x: 0, y: 33, width: MainScreen.width, height: 33))
//        secondHeader.backgroundColor = UIColor.ccolor(with: 71, g: 71, b: 69)
        setViewBackgroundColorTransparent(view: secondHeader)
        
        let label_Username = UILabel()
        secondHeader.addSubview(label_Username)
        label_Username.whc_CenterY(0).whc_Left(0).whc_Width(MainScreen.width/4).whc_Height(20)
        label_Username.font = UIFont.systemFont(ofSize: 12)
        label_Username.textAlignment = NSTextAlignment.center
        label_Username.textColor = UIColor.white
        label_Username.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Username.text = "用户"
        
        let label_earn = UILabel()
        secondHeader.addSubview(label_earn)
        label_earn.whc_CenterY(0).whc_Left(0, toView: label_Username).whc_Width(MainScreen.width/4).whc_Height(20)
        label_earn.font = UIFont.systemFont(ofSize: 12)
        label_earn.textAlignment = NSTextAlignment.center
        label_earn.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_earn.text = "收入"
        
        let label_sell = UILabel()
        secondHeader.addSubview(label_sell)
        label_sell.whc_CenterY(0).whc_Left(0, toView: label_earn).whc_Width(MainScreen.width/4).whc_Height(20)
        label_sell.font = UIFont.systemFont(ofSize: 12)
        label_sell.textAlignment = NSTextAlignment.center
        label_sell.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_sell.text = "支出"
        
        let label_left = UILabel()
        secondHeader.addSubview(label_left)
        label_left.whc_CenterY(0).whc_Left(0, toView: label_sell).whc_Width(MainScreen.width/4).whc_Height(20)
        label_left.font = UIFont.systemFont(ofSize: 12)
        label_left.textAlignment = NSTextAlignment.center
        label_left.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_left.text = "余额"
        
        setupNoPictureAlphaBgView(view: totalHeader, alpha: 0.4, bgViewColor: "FrostedGlass.subColorImageCoverDarkColorForNotGlass")
        setupNoPictureAlphaBgView(view: secondHeader, alpha: 0.4)
        viewHeader.addSubview(totalHeader)
        viewHeader.addSubview(secondHeader)
        return viewHeader
    }
    
    func initDate(){
        self.filterStartTime = getTodayZeroTime()
        self.filterEndTime = getTomorrowNowTime()
    }
    
//    override func loadNetRequestWithViewSkeleton(animate: Bool) {
    
    override func refreshTableViewData() {
        mainTableView.reloadData()
    }
    
    private func loadNetRequest(isLoadMoreData: Bool,pageSize: Int = defaultCountOfRequestPagesize) {
        
        var pageNumber = 1
        if isLoadMoreData {
            if self.dataRows.count % pageSize == 0 {
                pageNumber = self.dataRows.count / pageSize + 1
            }else {
                noMoreDataStatusRefresh()
                return
            }
        }
        
        LennyNetworkRequest.obtainAccountChangeReports(startTime: self.filterStartTime, endTime: self.filterEndTime, include: self.include_below ? 1 : 0, username: self.filterUserName, pageNumber: pageNumber, pageSize: pageSize,
                                                       types: self.filterTypes != 0 ? String(self.filterTypes) : ""){
                                                        (model) in
                                                        
                                                        
                                                        self.endRefresh()
                                                        
                                                        if model?.code == 0 && !(model?.success)!{
                                                            loginWhenSessionInvalid(controller: self)
                                                            return
                                                        }
                                                        
                                                        self.model = model
                                                        
                                                        if let modelP = model {
                                                            guard let content = modelP.content else { return }
                                                            guard let page = content.page else {return }
                                                            guard let rows = page.rows else {return }
                                                            
                                                            if !isLoadMoreData {
                                                                self.dataRows.removeAll()
                                                            }
                                                            
                                                            self.dataRows += rows
                                                            
                                                            self.noMoreDataStatusRefresh(noMoreData: rows.count % pageSize != 0 || rows.count == 0)
                                                            
                                                            self.updateTotalInfoAfterSync()
                                                            self.refreshTableViewData()
                                                        }
                                                        
//                                                        self.updateTotalInfoAfterSync()
                                                        self.view.hideSkeleton()
//                                                        self.refreshTableViewData()
        }
    }
    
    private func updateTotalInfoAfterSync(){
        if self.model == nil{
            return
        }
        guard let content = self.model.content else {return}
        label_sell_total.text = String.init(format: "总支出:%.2f元", content.totalZMoney)
        label_earn_total.text = String.init(format: "总收入:%.2f元", content.totalSMoney)
    }
}

extension AccountChangeController: UITableViewDataSource {
    
     func onItemClick(datasoure:[String]){
        if datasoure.isEmpty{
            return
        }
        let dialog = DetailListDialog(dataSource: datasoure, viewTitle: "账变详情")
        dialog.selectedIndex = 0
        //        randomView.didSelected = {
        //        }
        self.view.window?.addSubview(dialog)
        dialog.whc_Center(0, y: 0).whc_Width(MainScreen.width - 100).whc_Height(dialog.kHeight)
        dialog.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.05, animations: {
            dialog.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func formSource(row:Int) -> [String]{
        if let model = self.model{
            guard let content = model.content else { return []}
            guard let page = content.page else {return []}
            guard let rows = page.rows else {return []}
            let data = rows[row]
            var sources = [String]()
            let cptz = String.init(format: "用户: %@", data.username!)
            sources.append(cptz)
            if (data.add){
                let earn = String.init(format: "收入:%.2f元", data.money)
                sources.append(earn)
                let out = "支出: 0元 "
                sources.append(out)
            }else{
                let earn = "收入: 0元 "
                sources.append(earn)
                let out = String.init(format: "支出:%.2f元", data.money)
                sources.append(out)
            }
            let left = String.init(format: "余额:%.2f元", (data.afterMoney))
            let cpzj = String.init(format: "变动时间: %@", data.createDatetime!)
            let dlfd = String.init(format: "账变类型: %@", data.typeCn!)
            let tzdf = String.init(format: "备注: %@", data.remark!)
            sources.append(left)
            sources.append(cpzj)
            sources.append(dlfd)
            sources.append(tzdf)
            return sources
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (isSelect == false) {
            isSelect = true
            onItemClick(datasoure: formSource(row: indexPath.row))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let cell = AccountChangeFilterCell.init(style: .default, reuseIdentifier: "cell")
        //        let rows = LennyModel.geRenBaoBiaoModel?.content?.page?.rows![indexPath.row]
//        let rows = self.model.content?.page?.rows![indexPath.row]
        let rows = self.dataRows[indexPath.row]
        cell.setUsername(value: (rows.username)!)
        if (rows.add){
            cell.setEarnLabel(value: String.init(format: "收入:%.2f元", (rows.money)))
            cell.setSellLabel(value: "")
        }else{
            cell.setEarnLabel(value: "")
            cell.setSellLabel(value: String.init(format: "支出:%.2f元", (rows.money)))
        }
        cell.setLeftMoney(value: String.init(format: "%.2f元", (rows.afterMoney)))
        return cell
    }
}

extension AccountChangeController {
    
    //MARK: - 刷新
    private func setupRefreshView() {
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.mainTableView.mj_header = refreshHeader
        self.mainTableView.mj_footer = refreshFooter
    }
    
    @objc fileprivate func headerRefresh() {
        loadNetRequest(isLoadMoreData: false)
    }
    
    @objc fileprivate func footerRefresh() {
        loadNetRequest(isLoadMoreData: true)
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

}

