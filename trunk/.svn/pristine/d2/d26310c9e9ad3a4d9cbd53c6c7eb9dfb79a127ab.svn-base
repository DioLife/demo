//
//  WithdrawViewController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/2.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit
import MJRefresh

class WithdrawRecordsViewController: LennyBasicViewController {
    
    //条件过滤变量
    var filterOrderNum:String = ""
    var filterStartTime:String = ""
    var filterEndTime:String = ""
    var model:WithdrawModel!
    var shouldGotoLogin = true
    
    var dataRows = [WithdrawRows]()
    let refreshHeader = MJRefreshNormalHeader()
    let refreshFooter = MJRefreshBackNormalFooter()

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViews()
        self.setupRefreshView()
        self.loadObtainwithdrawQueryRequest(isLoadMoreData: false)
    }
    
    func loadObtainwithdrawQueryRequest(isLoadMoreData: Bool,pageSize: Int = defaultCountOfRequestPagesize) {
        
        var pageNumber = 1
        if isLoadMoreData {
            if self.dataRows.count % pageSize == 0 {
                pageNumber = self.dataRows.count / pageSize + 1
            }else {
                noMoreDataStatusRefresh()
                return
            }
        }

        
        LennyNetworkRequest.obtainWidthdrawQuery(order: self.filterOrderNum, startTime: self.filterStartTime, endTime: self.filterEndTime, type: 1, pageNumber: pageNumber, pageSize: pageSize){
            (model) in
            
            self.endRefresh()
            
            if model?.code == 0 && !(model?.success)!{
                if self.shouldGotoLogin {
                    loginWhenSessionInvalid(controller: self)
                }
                return
            }
            self.model = model
            
            
            guard let modelP = model else {return}
            guard let contentsP = modelP.content else {return}
            guard let rowsP = contentsP.rows else {return}
            self.dataRows = rowsP
            
            if !isLoadMoreData {
                self.dataRows.removeAll()
            }
            self.dataRows += rowsP
            self.noMoreDataStatusRefresh(noMoreData: rowsP.count % pageSize != 0 || rowsP.count == 0)
            
            
            self.view.hideSkeleton()
            self.refreshTableViewData()
        }
    }
    
    override func refreshTableViewData() {
        mainTableView.reloadData()
    }
    
    override var hasNavigationBar: Bool {
        return false
    }
    
    private var mainTableView: UITableView!
    
    private func setViews() {
        
        mainTableView = UITableView()
        mainTableView.tableFooterView = UIView.init()
        setViewBackgroundColorTransparent(view: mainTableView)
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
}

extension WithdrawRecordsViewController {
    //MARK: - 刷新
    private func setupRefreshView() {
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.mainTableView.mj_header = refreshHeader
        self.mainTableView.mj_footer = refreshFooter
    }
    
    @objc fileprivate func headerRefresh() {
        self.loadObtainwithdrawQueryRequest(isLoadMoreData: false)
    }
    
    @objc fileprivate func footerRefresh() {
        self.loadObtainwithdrawQueryRequest(isLoadMoreData: true)
    }
    
    
    private func noMoreDataStatusRefresh(noMoreData: Bool = true) {
        if noMoreData {
            self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
        }else {
            self.mainTableView.mj_footer.resetNoMoreData()
        }
    }
    
    private func endRefresh() {
        self.mainTableView.mj_header.endRefreshing()
        self.mainTableView.mj_footer.endRefreshing()
    }
}

extension WithdrawRecordsViewController: UITableViewDelegate {
    
}

extension WithdrawRecordsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if let model = LennyModel.geRenBaoBiaoModel{
        if let model = self.model{
            return (model.content?.rows!.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let rows = LennyModel.withdrawModel?.content?.rows![indexPath.row]
        let rows = self.model.content?.rows![indexPath.row]
        let cell = TopupTableViewCell.init(style: .default, reuseIdentifier: "")
        cell.setOrder(value: (rows?.orderId)!)
        cell.setDate(value: (rows?.createDatetime)!)
        cell.setBank(value: (rows?.bankName)!)
        cell.setStatus(value: (rows?.status)!)
        cell.setBalance(value: String.init(format: "%.2f元", rows!.drawMoney))
        return cell
    }
    
}







