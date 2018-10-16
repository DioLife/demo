//
//  QueryResultsAllController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ZuihaoResultsAllController: QueryResultsBasicController {

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
        
        LennyNetworkRequest.obtainLotteryQuery(lotteryCode: self.filterLotCode, startTime: self.filterStartTime, endTime: self.filterEndTime, qihao: "", version: "", order: "", zuihaoOrder: "", status: "", queryType: "1", playCode: "", include: "1", username: self.filterUsername,pageSize: "\(pageSize)",pageNumber: "\(pageNumber)") { (model) in
            
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
                return
            }
            
            self.view.hideSkeleton()
            self.refreshTableViewData()
        }
    }
    
    @objc override func headerRefresh() {
        
    }
    
    @objc override func footerRefresh() {
        
    }
    
}
