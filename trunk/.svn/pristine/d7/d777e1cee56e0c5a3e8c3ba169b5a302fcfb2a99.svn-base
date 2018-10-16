//
//  QueryResultsYiZhongJiangController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class QueryResultsYiZhongJiangController: QueryResultsBasicController {

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViewBackgroundColorTransparent(view: self.view)
        
        loadNetRequest(isLoadMoreData: false)
    }
    
    func loadNetRequest(isLoadMoreData: Bool,pageSize: Int = defaultCountOfRequestPagesize) {
        
        var pageNumber = 1
        if isLoadMoreData {
            if self.dataRows.count % pageSize == 0 {
                pageNumber = self.dataRows.count / pageSize + 1
            }else {
                super.noMoreDataStatusRefresh()
                return
            }
        }
        
        LennyNetworkRequest.obtainLotteryQuery(lotteryCode: self.filterLotCode, startTime: self.filterStartTime, endTime: self.filterEndTime, qihao: "", version: "", order: "", zuihaoOrder: "", status: "2", queryType: "1", playCode: "", include: "1", username: self.filterUsername,pageSize: "\(pageSize)",pageNumber: "\(pageNumber)") { (model) in
            
            super.endRefresh()
            
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
                return
            }
            
            guard let modelP = model else {return}
            guard let contentP = modelP.content else {return}
            guard let rowsP = contentP.rows else {return}
            
            if !isLoadMoreData {
                self.dataRows.removeAll()
            }
            self.dataRows += rowsP
            self.noMoreDataStatusRefresh(noMoreData: rowsP.count % pageSize != 0 || rowsP.count == 0)
            
            self.view.hideSkeleton()
            self.refreshTableViewData()
        }
    }
    
    @objc override func headerRefresh() {
        self.loadNetRequest(isLoadMoreData: false)
    }
    
    @objc override func footerRefresh() {
        self.loadNetRequest(isLoadMoreData: true)
    }
}
