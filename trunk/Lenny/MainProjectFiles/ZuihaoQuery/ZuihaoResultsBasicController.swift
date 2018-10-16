//
//  QueryResultsBasicController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ZuihaoResultsBasicController: LennyBasicViewController {
    
    //条件过滤变量
    var filterUsername:String = ""
    var filterLotCode:String = ""
    var filterStartTime:String = ""
    var filterEndTime:String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }

    override var hasNavigationBar: Bool {
        return false
    }
    
    private let mainTableView = UITableView()
    private func setViews() {
        
        contentView.addSubview(mainTableView)
//        mainTableView.isSkeletonable = true
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = 80
        mainTableView.tableFooterView = UIView()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.separatorStyle = .none
    }
    
    override func setStaticViewsAndContent() {
        super.setStaticViewsAndContent()
        loadNetRequestWithViewSkeleton(animate: true)
    }
    
    override func refreshTableViewData() {
        mainTableView.reloadData()
    }
}
extension ZuihaoResultsBasicController: UITableViewDelegate {
    
}
extension ZuihaoResultsBasicController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = LennyModel.allLotteryQueryModel?.content?.rows {
            return rows.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rows = LennyModel.allLotteryQueryModel?.content?.rows![indexPath.row]
        let cell = ZuihaoResultsCell.init(style: .default, reuseIdentifier: "cell")
        cell.setLotteryName(value: rows!.lotName!)
        cell.setBalance(value: rows!.buyMoney!)
        cell.setPaiJiangBalance(value: rows!.winMoney!)
        cell.setBetsType(value: rows!.terminalBetType!)
        cell.setStatus(value: rows!.status!)
        cell.setDate(value: rows!.createTime!)
        return cell
    }
}
