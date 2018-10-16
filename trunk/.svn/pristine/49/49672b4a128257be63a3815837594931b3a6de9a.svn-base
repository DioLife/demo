//
//  LotteryResultsDisplayController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/24.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import SkeletonView

///开奖页面
class LotteryResultsDisplayController: LennyBasicViewController {
    var isAttachInTabBar = true
    private let mainTableView = UITableView()
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
    }
    
    private var selectedIndex: Int = 0
    
    override var hasNavigationBar: Bool {
        return false
    }
    
    override func viewDidLayoutSubviews() {
        
        if !isAttachInTabBar{
            mainTableView.frame  = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 64 - 90)
        }else {
            if #available(iOS 11, *) {} else {
                mainTableView.frame  = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 64 - 90 - 49)
            }
        }
    }
    
    private func setViews() {
        contentView.addSubview(mainTableView)
        setViewBackgroundColorTransparent(view: mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 44)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.estimatedRowHeight = 80
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.separatorStyle = .none
//        mainTableView.isSkeletonable = true
        
        /* 在footer上添加一个按钮 */
        let myfooterView = UIView()
        myfooterView.frame = CGRect(x: 0, y: 0, width: mainTableView.width, height: 85)
        mainTableView.tableFooterView = myfooterView
        
        let button = UIButton()
        myfooterView.addSubview(button)
        button.whc_Top(10, toView: myfooterView).whc_Left(20, toView: myfooterView).whc_Right(20, toView: myfooterView).whc_Height(35)
        button.setTitle("加载更多", for: .normal)
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(footerRefresh), for: .touchUpInside)
        
    }
    // 顶部刷新
    @objc fileprivate func headerRefresh(){
        self.mainTableView.mj_header.endRefreshing()
    }
    // 底部刷新
    @objc fileprivate func footerRefresh(){
        pageNum += 1
        loadLotteryResults(pageNumber: pageNum, code: code)
    }
    
    private var lotteryTypes: [String]!
    
    var pageNum:Int = 1  //页数
    var dataArr:[AllLotteryResultsList] = [AllLotteryResultsList]()//保存数据
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setViews()
        print("viewdidapprear display controller ------")
        self.mainTableView.reloadData()
    }
    
    private func loadLotteryResults(pageNumber: Int, code:String) {
        
        LennyNetworkRequest.obtainLotteryResults(pageNumber: pageNumber, gameCode: code) { [weak self](model) in
            DispatchQueue.main.async {
                if model == nil{
                    return
                }
                if model?.content == nil{
                    return
                }
                if model?.content?.history == nil{
                    return
                }
                if model?.content?.history?.list == nil{
                    return
                }
                self?.analysis(list: (model!.content?.history?.list)!)
            }
        }
    }
    //解析请求数据结果 AllLotteryResultsModel
    func analysis(list:[AllLotteryResultsList]) {
        if list.count == 0 {
            showToast(view: self.view, txt: "没有更多数据")
        }else {
            self.dataArr += list
            self.mainTableView.reloadData()
        }
        
    }
    
    var code: String! = "CQSSC" {
        didSet {
            self.dataArr.removeAll()
            loadLotteryResults(pageNumber: 1, code: code)
        }
    }
    
    var lotType: String = "1"
}

extension LotteryResultsDisplayController: UITableViewDelegate {
    
}
extension LotteryResultsDisplayController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LennyModel.allLotteryResultsModel?.content?.history?.list == nil {
            return 0
        }
        
        print("self.dataArr的数目 ：\(self.dataArr.count)")
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if lotType == "1" || lotType == "2" || lotType == "4" || lotType == "7" || lotType == "8"
        {
            let item = self.dataArr[indexPath.row]
            let cell = ShiShiCaiCell.init(style: .default, reuseIdentifier: "cell")
            cell.lotType = lotType
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            cell.setDate(value: item.date!)
            cell.setValues(values: item.results())
            return cell
        }else if lotType == "6"
        {
            let cell = LiuHeCaiCell.init(style: .default, reuseIdentifier: "cell")
            if self.dataArr.count != 0 {
                let item = self.dataArr[indexPath.row]
                cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
                cell.setDate(value: item.date!)
                cell.setValues(values: item.results())
            }
            
            return cell
        }else if lotType == "5"
        {
            let item = self.dataArr[indexPath.row]
            let cell = ElevenInFiveCell.init(style: .default, reuseIdentifier: "cell")
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            cell.setDate(value: item.date!)
            cell.setValues(values: item.results())
            return cell
        }else if lotType == "3"
        {
            let item = self.dataArr[indexPath.row]
            let cell = ElevenInFiveCell.init(style: .default, reuseIdentifier: "cell")
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            cell.setDate(value: item.date!)
            cell.setValues(values: item.results())
            return cell
        }else if lotType == "9"
        {
            let item = self.dataArr[indexPath.row]
            let cell = ElevenInFiveCell.init(style: .default, reuseIdentifier: "cell")
            cell.setTitle(value: "第" + trimQihao(currentQihao: item.period!) + "期")
            cell.setDate(value: item.date!)
            cell.setValues(values: item.results())
            return cell
        }
        
        return UITableViewCell()
    }
}

