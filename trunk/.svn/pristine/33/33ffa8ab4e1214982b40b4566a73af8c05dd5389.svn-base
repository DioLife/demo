//
//  TopupViewController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/2.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit
import MJRefresh

class TopupViewController: LennyBasicViewController {
    
    //条件过滤变量
    var filterOrderNum:String = ""
    var filterStartTime:String = ""
    var filterEndTime:String = ""
    
    var model:ChargeModel!

//    private var  mainTableView: UITableView!
    private lazy var mainTableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.zero, style: .plain)
        return tb
    }()
    
    var dataRows = [Rows]()
    let refreshHeader = MJRefreshNormalHeader()
    let refreshFooter = MJRefreshBackNormalFooter()
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViews()
        self.setupRefreshView()
        self.loadObtainChargeQueryRequest(isLoadMoreData: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("")
    }
    
//    override func loadNetRequestWithViewSkeleton(animate: Bool) {
     func loadObtainChargeQueryRequest(isLoadMoreData: Bool,pageSize: Int = defaultCountOfRequestPagesize) {
        
        var pageNumber = 1
        if isLoadMoreData {
            if self.dataRows.count % pageSize == 0 {
                pageNumber = self.dataRows.count / pageSize + 1
            }else {
                noMoreDataStatusRefresh()
                return
            }
        }
        
        LennyNetworkRequest.obtainChargeQuery(order: self.filterOrderNum, startTime: self.filterStartTime, endTime: self.filterEndTime, type: 0, pageNumber: pageNumber, pageSize: pageSize){
            (model) in
            
            self.endRefresh()
            
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
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
    
    private func setViews() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView.init()
        setViewBackgroundColorTransparent(view: mainTableView)
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.tableFooterView = UIView()
        mainTableView.register(TopupTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(mainTableView.numberOfSections)
        print(mainTableView.numberOfRows(inSection: 0))
        print(mainTableView.visibleCells)
    }
}

extension TopupViewController {
   
    //MARK: - 刷新
    private func setupRefreshView() {
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.mainTableView.mj_header = refreshHeader
        self.mainTableView.mj_footer = refreshFooter
    }
    
    @objc fileprivate func headerRefresh() {
        self.loadObtainChargeQueryRequest(isLoadMoreData: false)
    }
    
    @objc fileprivate func footerRefresh() {
        self.loadObtainChargeQueryRequest(isLoadMoreData: true)
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

extension TopupViewController: UITableViewDelegate {
    
}

extension TopupViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let rows = LennyModel.chargeModel?.content?.rows {
        //        if let model = LennyModel.geRenBaoBiaoModel{

        //        if let model = self.model{
//            return (model.content?.rows?.count)!
//        }
//        return 0
        
        return self.dataRows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func convertBank(depositType:Int) -> String{
        if depositType == 1{
            return "在线支付"
        }else if depositType == 2{
            return "快速入款"
        }else if depositType == 3{
            return "银行转账"
        }else if depositType == 4{
            return "手动加款"
        }
        return "在线支付"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let rows = LennyModel.chargeModel?.content?.rows![indexPath.row]
//        let rows = self.model.content?.rows![indexPath.row]
        let rows = self.dataRows[indexPath.row]
        let cell = TopupTableViewCell.init(style: .default, reuseIdentifier: "")
        cell.setOrder(value: (rows.orderId)!)
        cell.setDate(value: (rows.createDatetime)!)
        cell.setBank(value: convertBank(depositType: (rows.depositType)))
        cell.setStatus(value: (rows.status))
        cell.setBalance(value: String.init(format: "%.2f元", rows.money))
        return cell
    }
}
