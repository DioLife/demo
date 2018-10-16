//
//  BetHistoryController.swift
//  gameplay
//
//  Created by admin on 2018/8/17.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit
import MJRefresh

class BetHistoryController: BaseController {
    
    
    @IBOutlet weak var titleHeader: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var titleHeaderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var timesAmountLabel: UILabel!
    @IBOutlet weak var expenditureAmountLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var profitAmountLabel: UILabel!
    
    lazy var filterView = Bundle.main.loadNibNamed("BetHistorylistFilterView", owner: nil, options: nil)?.first as! BetHistorylistFilterView
    
    /** -1不存在，0 真人注单，1电子注单 */
    var viewControllerType = -1
    var datas = [BetHistoryRowModel]()
    var betModle: BetHistoryModel?
    var startTime = getTodayZeroTime()
    var endTime = getTomorrowNowTime()
    var isSelectedEnd = false
    var selectedIndex = 0
    var platformNames = [Any]()
    var meminfo:Meminfo?
    
    lazy var  start_Timer:CustomDatePicker = {
        let datePick = CustomDatePicker()
        datePick.tag = 101
        return datePick
    }()//开始时间选择器02
    
    lazy var end_Timer:CustomDatePicker = {
        let datePick = CustomDatePicker()
        datePick.tag = 102
        return datePick
    }()//结束时间选择器02
    
    
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
        self.loadAllDatas(isLoadMoreData: false)
    }
    
    @objc fileprivate func footerRefresh() {
        self.loadAllDatas(isLoadMoreData: true)
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
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        setupRefreshView()
        
        setupUI()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDatePicker()
    }
    
    private func setupDatePicker() {
        self.view.addSubview(self.start_Timer)
        self.view.addSubview(self.end_Timer)
        self.start_Timer.isHidden = true
        self.end_Timer.isHidden = true
        
        self.end_Timer.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(250)
        }
        
        self.start_Timer.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(250)
        }
    }
    
    private func setupData() {
        loadAllDatas(isLoadMoreData: true)
        getPlatformNames()
        accountWeb()
    }
    
    private func setupUI() {
        
        setupNoPictureAlphaBgView(view: self.titleHeader, alpha: 0.4, bgViewColor: "FrostedGlass.subColorImageCoverDarkColorForNotGlass")
        
        if self.viewControllerType == 0 {
            self.title = "真人注单"
        }else {
            self.title = "电子注单"
        }
        
        setupRightNavBarItem()
        setupFilterView()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
    }
    
    private func setupRightNavBarItem() {
        let button = UIButton(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        
        button.setTitle("筛选", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
        button.theme_setTitleColor("Global.barTextColor", forState: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    private func setupFilterView() {
        self.filterView.didClickCancelAcion = {
            self.removeFilterView()
        }
        
        self.filterView.didClickConfirmAction = {
            
            self.removeFilterView()
            self.loadAllDatas(isLoadMoreData: false)
        }
        
        self.filterView.didClickStartTimeAction = {
            self.view.endEditing(true)
            
            self.start_Timer.canButtonReturnB = {
                self.start_Timer.isHidden = true
            }
            
            self.start_Timer.sucessReturnB = { returnValue in
                self.startTime = returnValue
                self.filterView.startTimeLabel.text = returnValue
                self.start_Timer.isHidden = true
            }
            
            self.gototargetView(targetView: self.start_Timer)
        }
        
        
        self.filterView.didClickEndTimeaAction = {
            self.view.endEditing(true)
            
            self.end_Timer.canButtonReturnB = {
                self.end_Timer.isHidden = true
            }
            
            self.end_Timer.sucessReturnB = { returnValue in
                self.endTime = returnValue
                self.filterView.endTimeLabel.text = returnValue
                self.end_Timer.isHidden = true
            }
            self.gototargetView(targetView: self.end_Timer)
        }
        
        self.filterView.didClickPlatformAction = {
            self.view.endEditing(true)
            self.showSelectedView()
        }
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        self.filterView.startTimeLabel.text = self.startTime
        self.filterView.endTimeLabel.text = self.endTime
        
        self.start_Timer.isHidden = true
        self.end_Timer.isHidden = true
        
        if button.isSelected == false {
            addFilterView(button: button)
            
        }else {
            removeFilterView(button: button)
        }
    }
    
    private func addFilterView(button: UIButton) {
        button.isSelected = true
        
        let filterViewHeight: CGFloat = 200
        
        self.view.addSubview(filterView)
        self.filterView.frame = CGRect.init(x: 0, y: glt_iphoneX ? 24 : (64 - filterViewHeight), width: screenWidth, height: filterViewHeight)
        
        //filterViwe设置
        
        UIView.animate(withDuration: 0.2) {
            self.titleHeaderTopConstraint.constant = filterViewHeight
            self.filterView.alpha = 1.0
            self.filterView.frame = CGRect.init(x: 0, y: glt_iphoneX ? 88 : 64, width: screenWidth, height: filterViewHeight)
        }
    }
    
    private func removeFilterView(button: UIButton) {
        button.isSelected = false
        
        removeFilterView()
    }
    
    private func removeFilterView() {
        let filterViewHeight: CGFloat = 200
        
        UIView.animate(withDuration: 0.2, animations: {
            self.titleHeaderTopConstraint.constant = 0
            self.filterView.alpha = 0.2
            self.filterView.frame = CGRect.init(x: 0, y: glt_iphoneX ? 24 : (64 - filterViewHeight) , width: screenWidth, height: filterViewHeight)
        }) { (_) in
            self.filterView.removeFromSuperview()
        }
    }
    
    func gototargetView(targetView:UIView)  {
        
        targetView.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** isLoadMoreData = true 加载更多，false 刷新 */
    func loadAllDatas(isLoadMoreData:Bool,showDialog:Bool = true,pageSize: Int = defaultCountOfRequestPagesize) -> Void {
        
        var userName = ""
        if let userNameP = self.filterView.firstTextField.text {
            userName = userNameP
        }
        
        var orderId = ""
        if let orderIdP = self.filterView.secondTextField.text {
            orderId = orderIdP
        }
        
        var platform = ""
        if getRealOrGamesTitles().0.count > 0 {
            platform = getRealOrGamesTitles().0[self.selectedIndex]
        }
        
        var pageNumber = 1
        
        if isLoadMoreData {
            if self.datas.count % pageSize == 0 {
                pageNumber = self.datas.count / pageSize + 1
            }else {
                noMoreDataStatusRefresh()
                return
            }
        }
        
        let params = ["startTime": self.startTime,"endTime": self.endTime,"username": userName,"platform": platform,"orderId": orderId,"pageNumber": "\(pageNumber)","pageSize": "\(pageSize)"] as [String : Any]
        
        self.requestAllDatasWithParams(isLoadMoreData:isLoadMoreData,showDialog:showDialog,params: params,pageSize: pageSize)
    }
    
    
    private func requestAllDatasWithParams(isLoadMoreData:Bool,showDialog:Bool,params: Dictionary<String, Any>,pageSize: Int) {
        
        super.request(frontDialog: showDialog, method:.get, loadTextStr:"获取中...", url:viewControllerType == 0 ? API_REAL_ORDERLISTDATA : API_EGAME_ORDERLISTDATA ,params:params,
                      callback: {(resultJson:String,resultStatus:Bool)->Void in
                        
                        self.endRefresh()
                        
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            
                            return
                        }
                        
                        if let result = BetHistoryModelWraper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                
                                if !isEmptyString(str: result.content) {
                                    if let contentModel = BetHistoryModel.deserialize(from: result.content) {
                                        self.betModle = contentModel
                                        //                                        self.datas = contentModel.rows
                                        
                                        if !isLoadMoreData {
                                            self.datas.removeAll()
                                            self.refreshData()
                                        }
                                        
                                        if contentModel.rows.count > 0 {
                                            
                                            self.datas += contentModel.rows
                                            self.refreshData()
                                        }
                                        
                                        self.noMoreDataStatusRefresh(noMoreData: false)
                                        self.noMoreDataStatusRefresh(noMoreData: contentModel.rows.count == 0 || contentModel.rows.count % pageSize != 0)
                                    }
                                }
                                
                            }else{
                                if !isEmptyString(str: result.msg){
                                    self.print_error_msg(msg: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                                }
                                if (result.code == 0) {
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }
                        }
        })
    }
    
    //MARK: 平台名
    private func getPlatformNames() {
        let params = [String:Any]()
        request(frontDialog: false, method: .get, loadTextStr: "获取中", url: API_PLATFORM_LIST, params: params) { (resultJson:String, resultStatus:Bool) in
            
            if !resultStatus {
                if resultJson.isEmpty {
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }else{
                    showToast(view: self.view, txt: resultJson)
                }
                return
            }
            
            if let result = EgameAndRealFatherModel.deserialize(from: resultJson) {
                if result.success {
                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                    
                    if self.viewControllerType == 0 {
                        if let model = result.content {
                            if let realModels = model.real {
                                self.platformNames = realModels
                            }
                        }
                        
                    }else if self.viewControllerType == 1 {
                        if let model = result.content {
                            if let egameModels = model.egame {
                                self.platformNames = egameModels
                            }
                        }
                    }
                    
                }else {
                    if !isEmptyString(str: result.msg){
                        self.print_error_msg(msg: result.msg)
                    }else{
                        showToast(view: self.view, txt: convertString(string: "获取失败"))
                    }
                    if (result.code == 0) {
                        loginWhenSessionInvalid(controller: self)
                    }
                }
            }
            
            print("获取到的平台名：\(resultJson)")
            
        }
    }
    
    //MARK: 刷新数据
    private func refreshData() {
        
        if let model = betModle {
            self.timesAmountLabel.text = "\(model.total)笔"
            
            if let aggsDataModel = model.aggsData {
                self.expenditureAmountLabel.text = "\(aggsDataModel.bettingMoneyCount)元"
                self.incomeAmountLabel.text = "\(aggsDataModel.winMoneyCount)元"
                
                let profitAmountMoney = aggsDataModel.winMoneyCount - aggsDataModel.bettingMoneyCount
                let profitAmountMoneyStr = String.init(format: "%.4f",profitAmountMoney)
                if let profitAmountMoneyFloat = Float(profitAmountMoneyStr) {
                    self.profitAmountLabel.text = "\(profitAmountMoneyFloat)"
                }
            }
        }
        
        self.mainTableView.reloadData()
    }
    
    
    func accountWeb() -> Void {
        //帐户相关信息
        self.request(frontDialog: false, url:MEMINFO_URL,
                     callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            return
                        }
                        if let result = MemInfoWraper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                if let memInfo = result.content{
                                    //更新帐户名，余额等信息
                                    self.meminfo = memInfo
                                }
                            }
                        }
        })
    }
    
    
    private func showSelectedView() {
        
        let titlesAndValues = getRealOrGamesTitles()
        
        let selectedView = LennySelectView(dataSource: titlesAndValues.1, viewTitle: "平台名称")
        
        selectedView.selectedIndex = self.selectedIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.selectedIndex = index
            self?.filterView.platformNameLabel.text = (titlesAndValues.1)[index]
        }
        view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (make) in
            
        }
    }
    
    //MARK: 获得真人，电子的数据的 名称列表 和 类型列表
    private func getRealOrGamesTitles() -> ([String],[String]) {
        var titles = [String]()
        var types = [String]()
        if viewControllerType == 0 {
            var array = platformNames as! [RealModel]
            
            let model = RealModel()
            model.name = "所有"
            model.value = ""
            array.insert(model, at: 0)
            
            for model in array {
                titles.append(model.name)
                types.append(model.value)
            }
        }else if viewControllerType == 1 {
            var array = platformNames as! [EgameModel]
            
            let model = EgameModel()
            model.name = "所有"
            model.value = ""
            array.insert(model, at: 0)
            
            for model in array {
                titles.append(model.name)
                types.append(model.value)
            }
        }
        
        return (types,titles)
    }
    
    private func getNameWithType(typeP: String) -> String {
        var name = ""
        
        var realOrGamesTypes = getRealOrGamesTitles().0
        var realOrGamesTitles = getRealOrGamesTitles().1
        
        for index in 0..<realOrGamesTypes.count {
            let typeName = realOrGamesTypes[index]
            if typeName == typeP {
                name = realOrGamesTitles[index]
                break
            }
            
        }
        
        return name
    }
    
    func formatGoucaiDetailDatas(model: BetHistoryRowModel) -> [String] {
        var array = [String]()
        array.append("订单号： \(model.orderId)")
        
        var accountNameStr = ""
        if let meminfo = self.meminfo {
            if !isEmptyString(str: meminfo.account) {
                accountNameStr = meminfo.account
            }
        }
        
        array.append("用户名： \(accountNameStr)")
        
        let dateStr = timeStampToString(timeStamp: model.bettingTime)
        array.append("下注时间： \(dateStr)")
        array.append("投注内容： \(model.bettingContent)")
        array.append("局号： \(model.tableCode)")
        array.append("有效打码量： \(model.realBettingMoney)")
        
        return array
    }
    
    
    //MARK: 点击cell显示投注详情
    //MARK: - 购彩详情列表
    private func showGoucaiDetailView(indexPath: IndexPath){
        
        let model = self.datas[indexPath.row]
        let dataSource = formatGoucaiDetailDatas(model: model)
        var selectedView = GoucaiDetailView()
        
        selectedView = GoucaiDetailView(dataSource: dataSource, viewTitle: viewControllerType == 0 ? "真人投注详情" : "电子投注详情", bottomHeight: 0)
        
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width - 100).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
        }
        
    }
    
    
}

extension BetHistoryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        showGoucaiDetailView(indexPath: indexPath)
    }
}

extension BetHistoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "betHistoryCell") as? BetHistoryCell else {fatalError("The dequeued cell is not an instance of betHistoryCell.")}
        
        let model = self.datas[indexPath.row]
        let name = self.getNameWithType(typeP: model.platformType)
        model.typeValueName = name
        cell.configCellWithModel(model: model)
        
        return cell
    }
}


























