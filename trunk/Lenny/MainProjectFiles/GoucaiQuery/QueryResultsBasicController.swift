//
//  QueryResultsBasicController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import MJRefresh

class QueryResultsBasicController: LennyBasicViewController {
    
    //条件过滤变量
    var filterUsername:String = ""
    var filterLotCode:String = ""
    var filterStartTime:String = ""
    var filterEndTime:String = ""
    var goucaiDetailView: GoucaiDetailView =  GoucaiDetailView()
    var selectedView: GoucaiDetailView = GoucaiDetailView()
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
    
    /** 由子类重写 */
    @objc  func headerRefresh() {}
    /** 由子类重写 */
    @objc  func footerRefresh() {}
    
    func endRefresh() {
        self.mainTableView.mj_header.endRefreshing()
        self.mainTableView.mj_footer.endRefreshing()
    }
    
    func noMoreDataStatusRefresh(noMoreData: Bool = true) {
        if noMoreData {
            self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
        }else {
            self.mainTableView.mj_footer.resetNoMoreData()
        }
    }

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViews()
        setupRefreshView()
    }

    override var hasNavigationBar: Bool {
        return false
    }
    
    private let mainTableView = UITableView()
    private func setViews() {
        
        contentView.addSubview(mainTableView)
        setViewBackgroundColorTransparent(view: mainTableView)
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
extension QueryResultsBasicController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if (isSelect == false) {
            isSelect = true
            //在延时方法中将isSelect更改为false
            self.showGoucaiDetailView(indexPath: indexPath)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
        
    }
}

extension QueryResultsBasicController: UITableViewDataSource {
    
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
        
        let cell = QueryResultsCell.init(style: .default, reuseIdentifier: "cell")
        
        //定位crash
//        if (LennyModel.allLotteryQueryModel?.content?.rows) != nil {
        
        
//            if (LennyModel.allLotteryQueryModel?.content?.rows!.count)! > 0 {
//                let rows = LennyModel.allLotteryQueryModel?.content?.rows![indexPath.row]
        
                let rows = self.dataRows[indexPath.row]
                cell.setLotteryName(value: rows.lotName!)
                cell.setBalance(value: rows.buyMoney!)
                cell.setBetNumbers(value: rows.haoMa!)
                //        cell.setPaiJiangBalance(value: rows!.winMoney!)
                cell.setBetsType(value: rows.terminalBetType!)
                cell.setStatus(value: rows.status!)
                cell.setDate(value: rows.createTime!)
                return cell
        
//            }
//            else {
//                return cell
//            }
//
//        }else {
//            return cell
//        }
    }
    
    //MARK: - 购彩详情列表
    private func showGoucaiDetailView(indexPath: IndexPath){
        
//        let rows = LennyModel.allLotteryQueryModel?.content?.rows![indexPath.row]
        let rows = self.dataRows[indexPath.row]
        let dataSource = formatGoucaiDetailDatas(model: rows)
        
        selectedView = GoucaiDetailView()
        if rows.status == "1" {
             selectedView = GoucaiDetailView(dataSource: dataSource, viewTitle: "购彩详情", bottomHeight: 40)
        }else {
            selectedView = GoucaiDetailView(dataSource: dataSource, viewTitle: "购彩详情", bottomHeight: 0)
        }
        
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width - 100).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            self.selectedView.transform = CGAffineTransform.identity
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
                                    self.loadNetRequestWithViewSkeleton(animate: true)
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
        array.append(String.init(format: "订单号:%@", model.orderId!))
        //单价 = 购买金额 / 倍数/购买注数
        if !isEmptyString(str: model.buyMoney!) && !isEmptyString(str: model.multiple!) &&
            !isEmptyString(str: model.buyZhuShu!){
            let single = Float(model.buyMoney!)!/Float(model.multiple!)!/Float(model.buyZhuShu!)!
            array.append(String.init(format: "单注金额:%.2f元", single))
        }
        array.append(String.init(format: "下注时间:%@", model.createTime!))
        array.append(String.init(format: "投注注数:%@", model.buyZhuShu!))
        array.append(String.init(format: "彩种:%@", model.lotName!))
        if let haoma = model.openHaoMa{
            array.append(String.init(format: "开奖号码:%@", haoma))
        }
        if model.lotVersion == VERSION_1{
            array.append(String.init(format: "倍数:%@倍", model.multiple!))
            var modelStr = "元"
            if model.model! == "1"{
                modelStr = "元"
            }else if model.model! == "10"{
                modelStr = "角"
            }else if model.model! == "100"{
                modelStr = "分"
            }
            array.append(String.init(format: "倍彩模式:%@", modelStr))
        }
        array.append(String.init(format: "期号:%@", model.qiHao!))
        array.append(String.init(format: "投注总额:%@元", model.buyMoney!))
        array.append(String.init(format: "玩法:%@", model.playName!))
//        array.append(String.init(format: "奖金:%@元", model.winMoney!))
        array.append(String.init(format: "投注号码:%@", model.haoMa!))
        array.append(String.init(format: "状态:%@", statusToStringChar(status: model.status!)))
        if let zjje = model.winMoney{
//            array.append(String.init(format: "中奖金额:%@元", !isEmptyString(str: zjje) ? zjje:"0"))
            var myvalue:Double = 0.0
            if zjje != ""{
                myvalue = Double(zjje)!
            }
            array.append(String.init(format: "中奖金额:%.2f元", myvalue))
        }
//        if !isEmptyString(str: model.buyMoney!) && !isEmptyString(str: model.multiple!){
//            let win = Float((!isEmptyString(str: model.winMoney!) ? model.winMoney! : "0"))!
//            let buy = Float((!isEmptyString(str: model.buyMoney!) ? model.buyMoney! : "0"))!
//            array.append(String.init(format: "盈亏:%.2f元", (win-buy)))
//        }
        
        
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
