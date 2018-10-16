//
//  SportController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/20.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit


protocol SportHeaderDelegate {
    func onHeaderClick(section:Int)
}

protocol SportGameItemDelegate {
    func onGameItemClick(sport:SportBean)
}

//体育页面
class SportController: BaseController,UITableViewDelegate,UITableViewDataSource,SportMenuBarDelegate,
SportHeaderDelegate,SportGameItemDelegate,SportWindowDelegate {
    
    @IBOutlet weak var menuBar:SportMenuBar!
    @IBOutlet weak var menuLine:UIView!
    @IBOutlet weak var menuLineConstraint:NSLayoutConstraint!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var emptyView:UIView!
    @IBOutlet weak var emptyTxt:UILabel!
    
    //底部投注，清除面板
    @IBOutlet weak var refreshBtn:UIButton!
    @IBOutlet weak var touzhuBtn:UIButton!
    @IBOutlet weak var zhudanUI:UIButton!
    @IBOutlet weak var changUI:UIButton!
    @IBOutlet weak var viewUI:UIButton!
    
    var countDownUI:UILabel!//体育赛事同步倒计数UI
    var gameTimer:Timer?//距离刷新赛事结果倒计时器
    var endGameTime = 30
    
    var sportDatas:[[Dictionary<String,String>]] = []
    lazy var openArray:NSMutableArray=NSMutableArray()//保存各分组的开闭状态，若数组中包含分组section，则说明该分组是展开的
    
    let BALL_TYPES = ["FT","BK"]
    let GAME_TYPES = ["RB", "TD", "FT"]
    
    let footballCategoryDic = [["MN":"全部"],["TI":"波胆"],["BC":"总入球"],["HF":"半场/全场"],["MX":"混合过关"],["br":"下注记录"]]
    let basketballCategorys = [["MN":"全部"],["MX":"混合过关"],["br":"下注记录"]]
    let bet_records = ["下注记录"]
    
    var ftCategory = "MN"
    var bkCategory = "MN"
    var ftCategoryValue = "全部";
    var bkCategoryValue = "全部";
    
    var pageIndex = 1;
    var currentSegmentPage = 0;//当前segment页码
    var currentPage = 1;//0-滚球页，1-今日赛事页，2-早盘页
    
    var selectSports:[SportBean] = []
    var selectedBallType = 0;
    var selectedCategoryType = "";
    var selectedPlayType = "";
    var inputMoney = ""//输入的投注金额
    var noAutoPopWindow = false
    var appcetBestPeilv = false
    
    var popMenu:SwiftPopMenu!
    var sportWindow:SportPopWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        menuBar.menuBarDelegate = self
        
        //底部按钮的圆角处理
        let maskPath = UIBezierPath(roundedRect: zhudanUI.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = zhudanUI.bounds
        maskLayer.path = maskPath.cgPath
        zhudanUI.layer.mask = maskLayer
        
        let viewMaskPath = UIBezierPath(roundedRect: viewUI.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let settingMaskLayer = CAShapeLayer()
        settingMaskLayer.frame = viewUI.bounds
        settingMaskLayer.path = viewMaskPath.cgPath
        viewUI.layer.mask = settingMaskLayer
        
        refreshBtn.layer.cornerRadius = 5
        touzhuBtn.layer.cornerRadius = 5
        
        refreshBtn.addTarget(self, action: #selector(onRefreshClick), for: .touchUpInside)
        touzhuBtn.addTarget(self, action: #selector(onTouzhuClick), for: .touchUpInside)
        zhudanUI.addTarget(self, action: #selector(onOrderClick), for: .touchUpInside)
        changUI.addTarget(self, action: #selector(onOrderClick), for: .touchUpInside)
        viewUI.addTarget(self, action: #selector(onOrderClick), for: .touchUpInside)
        menuLine.theme_backgroundColor = "Global.themeColor"
        
        self.updateMenuBottomLine(tabIndex: currentPage)
        self.customTitleView()
        self.navigationItem.leftBarButtonItem?.title = "返回"
        //        self.customRightView()
        self.updateRightMenuTxt()
        loadSportDatas(pageIndex: pageIndex, segmentPage: currentSegmentPage, currentPage: currentPage, categoryType: getCurrentCategory(), showDialog: true)
    }
    
    @objc func onRightMenuClick() -> Void {
        //滚球栏时点击打开体育下注记录
        if currentPage == 0{
            openTouzhuRecord(controller: self, title: "体育投注记录", code: String.init(describing: currentSegmentPage), recordType: MenuType.SPORT_RECORD)
        }else{
            let menuArr = currentSegmentPage == FOOTBALL_PAGE ? footballCategoryDic : basketballCategorys
            showRightMenu(dic: menuArr)
        }
    }
    
    func showRightMenu(dic:[Dictionary<String,String>]) -> Void {
        //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
        popMenu = SwiftPopMenu(frame: CGRect(x: Int(kScreenWidth-155), y: 56, width: 150, height: 50*dic.count), arrowMargin: 18)
        if dic.isEmpty{
            return
        }
        var arr = [(icon:String,title:String)]()
        for index in 0...dic.count-1{
            let values = dic[index] as Dictionary<String,String>
            for str in values.values{
                let tuple = (icon:String.init(describing: index),title:str)
                arr.append(tuple)
                break
            }
        }
        popMenu.popData = arr
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            self?.onMenuItemClick(index: index,dic:dic)
        }
        popMenu.show()
    }
    
    func onMenuItemClick(index:Int,dic:[Dictionary<String,String>]) -> Void {
        if index == dic.count - 1{
            openTouzhuRecord(controller: self, title: "体育投注记录", code: String.init(describing: currentSegmentPage), recordType: MenuType.SPORT_RECORD)
        }else{
            let dicValue = dic[index]
            for item in dicValue{
                if currentSegmentPage == FOOTBALL_PAGE{
                    ftCategory = item.key
                    ftCategoryValue = item.value
                } else if currentSegmentPage == BASKETBALL_PAGE{
                    bkCategory = item.key
                    bkCategoryValue = item.value
                }
                break
            }
            self.updateRightMenuTxt()
            //筛选比赛玩法时，先清除之前选择过的赔率项
            clearConstant()
            performMenuItemClick()
        }
    }
    
    /**
     * 右上角玩法过滤下拉菜单项点击事件
     */
    func performMenuItemClick() -> Void {
        pageIndex = 1
        loadSportDatas(pageIndex: pageIndex, segmentPage: currentSegmentPage, currentPage: currentPage, categoryType: getCurrentCategory(), showDialog: true)
    }
    
    func updateRightNavTitle(title:String) -> Void {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: title, style: UIBarButtonItemStyle.plain, target: self, action: #selector(onRightMenuClick))
    }
    
    func updateMenuBottomLine(tabIndex:Int) -> Void {
        self.menuLineConstraint.constant = CGFloat(tabIndex) * kScreenWidth/3
    }
    
    //自定义标题栏，方便控制足球，篮球分类
    func customTitleView() -> Void {
        let titleView = UIView.init(frame: CGRect.init(x: kScreenWidth/4, y:  kScreenHeight/2-22, width: kScreenWidth/2, height: 44))
        let ballSegment = UISegmentedControl.init(frame: CGRect.init(x: titleView.bounds.width/6, y: 0, width: (titleView.bounds.width*2/3), height: 24))
        ballSegment.insertSegment(withTitle: "足球", at: 0, animated: true)
        ballSegment.insertSegment(withTitle: "篮球", at: 1, animated: true)
        ballSegment.selectedSegmentIndex = self.currentSegmentPage
        ballSegment.addTarget(self, action: #selector(onSegmentChange), for: UIControlEvents.valueChanged)
        countDownUI = UILabel.init(frame: CGRect.init(x: 0, y: 24, width:titleView.bounds.width, height: 20))
        countDownUI.font = UIFont.systemFont(ofSize: 10)
        countDownUI.textAlignment = NSTextAlignment.center
        countDownUI.textColor = UIColor.white
        //        countDownUI.text = "距离同步赛事还有60秒"
        titleView.addSubview(ballSegment)
        titleView.addSubview(countDownUI)
        self.navigationItem.titleView = titleView
    }
    
    @objc func onSegmentChange(sender:UISegmentedControl) -> Void {
        self.currentSegmentPage = sender.selectedSegmentIndex
        if currentSegmentPage == FOOTBALL_PAGE{
            self.ftCategory = "MN"
            self.ftCategoryValue = "全部"
        }else{
            self.bkCategory = "MN"
            self.bkCategoryValue = "全部"
        }
        selectSports.removeAll()
        updateRightMenuTxt()
        self.openArray.removeAllObjects()
        updateBottom(orderCount: 0, sportSize: selectSports.count)
        loadSportDatas(pageIndex: pageIndex, segmentPage: currentSegmentPage, currentPage: currentPage, categoryType: getCurrentCategory(), showDialog: true)
    }
    
    //自定义右侧菜单栏
    func customRightView() -> Void {
        let rightView = UIView.init(frame: CGRect.init(x: (kScreenWidth*3/4), y:  kScreenHeight/2-22, width: kScreenWidth/4, height: 44))
        rightView.backgroundColor = UIColor.white
        let menuUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width:rightView.bounds.width, height: 24))
        menuUI.font = UIFont.systemFont(ofSize: 14)
        menuUI.textAlignment = NSTextAlignment.center
        menuUI.textColor = UIColor.white
        menuUI.text = "下注记录"
        rightView.addSubview(menuUI)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightView)
    }
    
    //点击刷新
    @objc func onRefreshClick() -> Void {
        loadSportDatas(pageIndex: pageIndex, segmentPage: currentSegmentPage, currentPage: currentPage, categoryType: getCurrentCategory(), showDialog: true)
    }
    
    //点击投注
    @objc func onTouzhuClick() -> Void {
        if selectSports.isEmpty{
            showToast(view: self.view, txt: "请先选择号码并投注")
            return
        }
        if isEmptyString(str: inputMoney){
            showToast(view: self.view, txt: "请输入金额(整数金额)")
            return
        }
        if !isPurnInt(string: inputMoney){
            showToast(view: self.view, txt: "金额须为整数")
            return
        }
        if Int(inputMoney)! < 10 {
            showToast(view: self.view, txt: "单注最低10元")
            return
        }
        let data = formSportBetJson(ballType: currentSegmentPage, gameCategory: GAME_TYPES[currentPage], playCategory: getCurrentCategory()
            , selectSports: selectSports, acceptBestOdds: appcetBestPeilv, money: inputMoney)
        
        
        let postJson = data.toJSONString()
        if let json = postJson{
            print("the sport post json = \(json)")
            request(frontDialog: true,method: .post,loadTextStr: "正在下注...",url:SPORT_BETS_URL,params:["data":json],
                    callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "下注失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = SportBetResultWraper.deserialize(from: resultJson){
                            if result.success{
                                if let token = result.accessToken{
                                    UserDefaults.standard.setValue(token, forKey: "token")
                                }
                                showToast(view: self.view, txt: "下注成功")
                                self.clearConstant()
                            }else{
                                if let errorMsg = result.msg{
                                    showToast(view: self.view, txt: errorMsg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "下注失败"))
                                }
                                if result.code == 0{
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }
                        }
            })
        }
    }
    
    
    /**
     * 封装下注json
     * @param ballType 球类型
     * @param gameCategory 分类，早盘，今日赛事，滚球
     * @param playCategory 玩法
     * @param selectSports 已选择的赔率项信息集
     * @param acceptBestOdds 是否接受最佳赔率
     * @param money 下注金额
     */
    func formSportBetJson(ballType:Int,gameCategory:String,playCategory:String,selectSports:[SportBean],
                          acceptBestOdds:Bool,money:String) ->  SportBetData{
        let sportBetData = SportBetData()
        sportBetData.plate = "H"
        let gameType = String.init(format: "%@_%@_%@", BALL_TYPES[ballType],gameCategory,playCategory)
        sportBetData.gameType = gameType
        sportBetData.money = !isEmptyString(str: money) ? Int(money)! : 0
        sportBetData.acceptBestOdds = acceptBestOdds
        var items = [SportBet]()
        for sport in selectSports{
            let sportBet = SportBet()
            sportBet.gid = !isEmptyString(str: sport.gid) ? Int(sport.gid)! : 0
            var peilv = sport.peilv
            if !isEmptyString(str: peilv){
                let peilvFloat = Float(peilv);
                peilv = String.init(format: "%.2f", peilvFloat!)
            }
            sportBet.odds = peilv
            sportBet.project = !isEmptyString(str: sport.project) ? sport.project : ""
            sportBet.type = !isEmptyString(str: sport.peilvKey) ? sport.peilvKey : ""
//            if ballType == BASKETBALL_PAGE{
                sportBet.mid = !isEmptyString(str: sport.mid) ? Int(sport.mid)! : 0
//            }else{
//                sportBet.mid = 0
//            }
            items.append(sportBet)
        }
        sportBetData.items = items
        return sportBetData
    }
    
    //点击查看体育寒事注单
    @objc func onOrderClick() -> Void {
        showOrderWindow()
    }
    
    func showOrderWindow() -> Void {
        if selectSports.isEmpty {
            showToast(view: self.view, txt: "请先选择要投注的赛事")
            return;
        }
        if sportWindow == nil{
            sportWindow = Bundle.main.loadNibNamed("sport_pop_window", owner: nil, options: nil)?.first as! SportPopWindow
        }
        sportWindow.windowDelegate = self
        sportWindow.setData(items: selectSports, acceptPeilv: self.appcetBestPeilv, inputMoney: self.inputMoney, notAutoPop: noAutoPopWindow)
        sportWindow.show()
    }
    
    func getCurrentCategory() -> String {
        return currentSegmentPage == FOOTBALL_PAGE ? ftCategory : bkCategory
    }
    
    //点击分栏菜单的回调事件
    func onMenuItemClick(itemTag: Int) {
        currentPage = itemTag
        if currentSegmentPage ==  FOOTBALL_PAGE{
            ftCategory = "MN"
        }else{
            bkCategory = "MN"
        }
        self.openArray.removeAllObjects()
        self.updateMenuBottomLine(tabIndex: itemTag)
        self.updateRightMenuTxt()
        loadSportDatas(pageIndex: pageIndex, segmentPage: currentSegmentPage, currentPage: currentPage, categoryType: getCurrentCategory(), showDialog: true)
    }
    
    func updateRightMenuTxt() -> Void {
        if currentPage == 0{
            self.updateRightNavTitle(title: "下注记录")
        } else{
            if currentSegmentPage == FOOTBALL_PAGE{
                self.updateRightNavTitle(title: ftCategoryValue)
            }else{
                self.updateRightNavTitle(title: bkCategoryValue)
            }
        }
    }
    
    func toggleEmpty(isEmpty:Bool) -> Void {
        self.emptyView.isHidden = !isEmpty
        self.tableView.isHidden = isEmpty
    }
    
    /**
     * 获取体育数据
     * @param context
     * @param pageIndex 当前页码
     * @param segmentPage 足球或篮球分栏页索引
     * @param currentPage 当前页索引，0-滚球页 1-赛事 2-早盘
     * @param categoryType 玩法分类
     * @param showDialog 是否显示加载框
     */
    func loadSportDatas(pageIndex:Int,segmentPage:Int,currentPage:Int,categoryType:String,showDialog:Bool) -> Void {
        
        let gameType = BALL_TYPES[segmentPage] + "_" + GAME_TYPES[currentPage] + "_" +
        categoryType
        print("gameType = \(gameType)")
        let params = ["gameType":gameType,"pageNo":pageIndex,"sortType":"2"] as [String : Any]
        request(frontDialog: true, method: .post, loadTextStr: "获取赛事中...", url:SPORT_DATA_URL,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SportDataWraper.deserialize(from: resultJson){
                        if result.success{
                            showToast(view: self.view, txt: "获取成功")
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            
                            if let data = result.content{
                                
                                var results:Dictionary<String,AnyObject> = [:]
                                //开启异步线程，更新体育数据
                                if let result = SportData.deserialize(from: data){
                                    //更新滚球，今日赛事，早盘的 足球和篮球赛数
                                    results["counts"] = result.gameCount
                                    //更新赛事列表
                                    let games = result.games
                                    let headers = result.headers
                                    var datas = [Dictionary<String,String>]()
                                    if !games.isEmpty{
                                        for index in 0...games.count - 1{
                                            let item = games[index]
                                            if item.count != headers.count{
                                                continue
                                            }
                                            //将每项赛事数据依据headers数据项一一对应装入Map
                                            let itemLength = item.count
                                            let headerLength = headers.count
                                            var map = Dictionary<String,String>()
                                            if itemLength == headerLength{
                                                for j in 0...itemLength-1{
                                                    map[headers[j] as String] = item[j] as String
                                                }
                                                datas.append(map)
                                            }
                                        }
                                    }
                                    //将所有数据按联赛名称分类
                                    var dataItem:Dictionary<String,String>!
                                    var resultMap = Dictionary<String,[Dictionary<String,String>]>()
                                    if !datas.isEmpty{
                                        for index in 0...datas.count-1{
                                            dataItem = datas[index]
                                            if resultMap.keys.contains(dataItem["league"]!){
                                                resultMap[dataItem["league"]!]?.append(dataItem)
                                            }else{
                                                var list = [Dictionary<String,String>]()
                                                list.append(dataItem)
                                                resultMap[dataItem["league"]!] = list
                                            }
                                        }
                                    }
                                    //更新滚球，今日赛事，早盘的 足球和篮球赛数
                                    results["games"] = resultMap as AnyObject as AnyObject
                                    self.updateAfterSportDataCompeletion(results: results)
                                    //获取到体育赛事数据后开始倒计时
                                    self.countDownGames()
                                }
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
        
    }
    
    //创建并开始赛事结果同步定时器
    func countDownGames() -> Void {
        //创建开奖周期倒计时器
        self.endGameTime = self.currentPage == 0 ? 30 : 180
        self.countDownUI.text = String.init(format: "距离同步赛事还有:%d秒", endGameTime)
        if let timer = self.gameTimer{
            timer.invalidate()
        }
        self.createGameTimer()
    }
    
    
    /**
     * 创建停止下注倒计时
     * @param duration
     */
    func createGameTimer() -> Void {
        self.gameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickGameTimer), userInfo: nil, repeats: true)
    }
    
    @objc func tickGameTimer() -> Void {
        //将剩余时间减少1秒
        self.endGameTime -= 1
        if self.endGameTime > 0{
            self.countDownUI.text = String.init(format: "距离同步赛事还有:%d秒",endGameTime)
        }
        if self.endGameTime <= 0{
            //取消定时器
            if let timer = self.gameTimer{
                timer.invalidate()
            }
            //再次获取赛事
            loadSportDatas(pageIndex: pageIndex, segmentPage: currentSegmentPage, currentPage: currentPage, categoryType: getCurrentCategory(), showDialog: true)
        }
    }
    
    
    func updateAfterSportDataCompeletion(results:Dictionary<String,AnyObject>) -> Void{
        //获取新数据时先清除之前选择过的赔率项
        clearConstant()
        sportDatas.removeAll()
        //更新分栏tabs各赛事场数
        if results.keys.contains("counts"){
            let countBean:SportGameCount = results["counts"] as! SportGameCount
            if currentSegmentPage == FOOTBALL_PAGE{
                let tab1 = String.init(format: "滚球(%d)", countBean.RB_FT)
                let tab2 = String.init(format: "今日赛事(%d)", countBean.TD_FT)
                let tab3 = String.init(format: "早盘(%d)", countBean.FT_FT)
                let arr = [tab1,tab2,tab3]
                self.menuBar.updateTabs(arr:arr)
            }else if currentSegmentPage == BASKETBALL_PAGE{
                let tab1 = String.init(format: "滚球(%d)", countBean.RB_BK)
                let tab2 = String.init(format: "今日赛事(%d)", countBean.TD_BK)
                let tab3 = String.init(format: "早盘(%d)", countBean.FT_BK)
                let arr = [tab1,tab2,tab3]
                self.menuBar.updateTabs(arr:arr)
            }
        }
        
        if !results.keys.contains("games"){
            toggleEmpty(isEmpty: true)
            return
        }
        let gameResult:Dictionary<String,[Dictionary<String,String>]> = results["games"] as! Dictionary<String, [Dictionary<String, String>]>
        if !gameResult.isEmpty{
            toggleEmpty(isEmpty: false)
            //清除寒事列表数据，并刷新列表
            sportDatas.removeAll()
            for item in gameResult.values{
                sportDatas.append(item)
            }
            self.tableView.reloadData()
        }else{
            toggleEmpty(isEmpty: true)
        }
    }
    
    func clearConstant() -> Void {
        selectSports.removeAll()
        selectedBallType = 0
        selectedCategoryType = ""
        selectedPlayType = ""
        //        inputMoney = ""
        appcetBestPeilv = false
        updateBottom(orderCount: 0, sportSize: 0)
    }
    
    func loadSportData(item:[Dictionary<String,String>]) -> [[SportBean]] {
        let columnSize = SportTableContainer.tableColumnSize(ballType: currentSegmentPage, playCategory: getCurrentCategory())
        print("table column header size = \(columnSize)")
        let playCategory = getCurrentCategory()
        var sportDatas:[[SportBean]] = []
        for data in item{
            let sportBeanList = SportTableContainer.fillSportResultData(item: data as Dictionary<String, AnyObject>, ballType: currentSegmentPage, playCategory: playCategory, columns: columnSize, gameCategory: GAME_TYPES[self.currentPage])
            sportDatas.append(sportBeanList)
        }
        return sportDatas
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sportDatas.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //如果数组中包含当前的section则返回数据源中当前section的数组大小，否则返回零
        if(self.openArray.contains(section)){
            return self.sportDatas[section].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as? GameCell  else {
            fatalError("The dequeued cell is not an instance of GameCell.")
        }
        
        cell.sportItemDelegate = self
        let data:[Dictionary<String,String>] = self.sportDatas[indexPath.section]
        //设置每个赛事项中比分，两队名称，比赛时间等UI
        let header:Dictionary<String,String> = data[indexPath.row]
        
        var timeStr = ""
        var scoreTxt = ""
        if GAME_TYPES[currentPage] == RB_TYPE{
            if currentSegmentPage == FOOTBALL_PAGE{
                let scoreH = header.keys.contains("scoreH") ? header["scoreH"] : ""
                let scoreC = header.keys.contains("scoreC") ? header["scoreC"] : ""
                let retimeset = header.keys.contains("retimeset") ? header["retimeset"] : ""
                if let retime = retimeset{
                    if !isEmptyString(str: retime) && retime.contains("^"){
                        let halfValue = retime.substring(to: retime.index(of: "^")!)
                        let timeValue = retime.substring(from: retime.index(of: "^")!)
                        print("halfvalue = \(halfValue),timeValue = \(timeValue)")
                        timeStr = String.init(format: "%@ %@", halfValue == "1H" ? "上半场" : "下半场",timeValue)
                    }else if !isEmptyString(str: retime){
                        timeStr = "半场"
                    }
                }
                scoreTxt = String.init(format: "%@-%@", scoreH!,scoreC!)
            }else{
                let nowSession = header.keys.contains("nowSession") ? header["nowSession"] : ""
                if nowSession == "OT"{
                    timeStr = "加时"
                }else if nowSession == "1Q"{
                    timeStr = "第一节"
                }else if nowSession == "2Q"{
                    timeStr = "第二节"
                }else if nowSession == "3Q"{
                    timeStr = "第三节"
                }else if nowSession == "4Q"{
                    timeStr = "第四节"
                }
            }
        }else{
            let openTime = header.keys.contains("openTime") ? header["openTime"] : "0"
            timeStr = timeStampToString(timeStamp: Int64(openTime!)!, format: "MM-dd HH:mm")
        }
        
        let mainTeamName = header.keys.contains("home") ? header["home"] : "暂无队名"
        let guestTeamName = header.keys.contains("guest") ? header["guest"] : "暂无队名"
        let isLive = header.keys.contains("live") ? Bool(header["live"]!) : false
        cell.qiuDuiUI.text = String.init(format: "%@    VS    %@", mainTeamName!,guestTeamName!)
        cell.gameTime.text = timeStr
        cell.scoreUI.text = isLive! ? String.init(format: "%@(滚球)", scoreTxt) : String.init(format: "%@", scoreTxt)
        
        //绑定表格头部行
        let columns = cell.tableHeader.setupView(arr: SportTableContainer.getTableHeaderArray(ballType: self.currentSegmentPage, playCategory: self.getCurrentCategory()))
        
        //根据赛事数据计算显示赛事结果的数据
        let sportBeans = SportTableContainer.fillSportResultData(item: header as Dictionary<String, AnyObject>, ballType: currentSegmentPage, playCategory: self.getCurrentCategory(), columns: columns, gameCategory: GAME_TYPES[currentPage])
        //将赛事各输赢比分等的赔率及文字设置进表格单元格
        cell.setupDataAndReload(datas: sportBeans, columns: columns)//填充赛事赔率数据
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //绑定表格头部行
        let columns = SportTableContainer.getTableHeaderArray(ballType: self.currentSegmentPage, playCategory: self.getCurrentCategory()).count
        let data:[Dictionary<String,String>] = self.sportDatas[indexPath.section]
        let header:Dictionary<String,String> = data[indexPath.row]
        //根据赛事数据计算显示赛事结果的数据
        let sportBeans = SportTableContainer.fillSportResultData(item: header as Dictionary<String, AnyObject>, ballType: currentSegmentPage, playCategory: self.getCurrentCategory(), columns: columns, gameCategory: GAME_TYPES[currentPage])
        //计算每个赛事项的高度
        let height = sportBeans.count/columns * 50 + 100
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SportHeader.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 41))
        header.setupSection(section: section)//绑定section,方便标识子项的开闭状态
        header.sportHeaderDelegate = self
        header.indictor.image = UIImage.init(named: "pulldown")
        let data:[Dictionary<String,String>] = self.sportDatas[section]
        if !data.isEmpty{
            let map:Dictionary<String,String> = data[0]
            let time = map["openTime"]
            header.timeUI.text = timeStampToString(timeStamp: Int64(time!)!, format: "HH:mm")
            let league = map["league"]
            header.leagueUI.text = String.init(format: "%@(%d)场", league!,data.count)
        }
        
        let isExpand = self.openArray.contains(section)
        header.updateIndictor(expand: isExpand)
        header.backgroundColor = isExpand ? UIColor.init(red: 252/255, green: 248/255, blue: 208/255, alpha: 1.0) : UIColor.white
        return header
    }
    
    // MARK: - 点击section的header响应事件
    func onHeaderClick(section: Int) {
        print("the click header section = \(section)")
        //判断是否是张开或合住
        if(self.openArray.contains(section)) {
            self.openArray.remove(section)
        }else {
            self.openArray.add(section)
        }
        self.tableView.reloadSections(IndexSet.init(integer: section), with: UITableViewRowAnimation.fade)
    }
    
    //球赛赔率项点击回调事件
    func onGameItemClick(sport: SportBean) {
        if sport.fakeItem{
            return
        }
        print("gameid = \(sport.gid),peilv = \(sport.peilv)")
        if isEmptyString(str: sport.peilv){
            return
        }
        //由于足球或篮球的混合过关可以选择不同球赛的赔率下注，所以会有多个赔率数据项的情况
        //其它情况下只有一个比赛赔率下注
        let playCategory = getCurrentCategory()
        if playCategory == BK_MX || playCategory == FT_MX{
            if !selectSports.isEmpty{
                var hasFoundSameGame = false
                for index in 0...selectSports.count-1{
                    let sb = selectSports[index]
                    if playCategory == BK_MX || playCategory == FT_MX{
                        if sb.gid == sport.gid{
                            selectSports[index] = sport
                            hasFoundSameGame = true
                            break
                        }
                    }
                }
                if !hasFoundSameGame{
                    selectSports.append(sport)
                }
            }else{
                selectSports.append(sport)
            }
        }else{
            selectSports.removeAll()
            selectSports.append(sport)
        }
        //刷新底部赛事场数
        updateBottom(orderCount: 1, sportSize: selectSports.count)
        
        if !self.noAutoPopWindow{
            showOrderWindow()
        }
    }
    
    func updateBottom(orderCount:Int,sportSize:Int) -> Void {
        zhudanUI.setTitle(String.init(format: "%d单", orderCount), for: .normal)
        changUI.setTitle(String.init(format: "%d场", sportSize), for: .normal)
    }
    
    //点击投注单弹窗中的投注按钮的回调
    func onSportWindowCallback(acceptBestPeilv:Bool,inputMoney:String,notAutoPop:Bool,datas:[SportBean]) {
        self.appcetBestPeilv = acceptBestPeilv
        self.inputMoney = inputMoney
        self.noAutoPopWindow = notAutoPop
        self.selectSports.removeAll()
        self.selectSports = self.selectSports + datas
        updateBottom(orderCount: self.selectSports.count > 0 ? 1 : 0, sportSize: self.selectSports.count)
        onTouzhuClick()
    }
    
    //点击注单窗口中的暂不投注回调
    func onSportWindowClose(acceptBestPeilv: Bool, inputMoney: String,notAutoPop:Bool,datas:[SportBean]) {
        self.appcetBestPeilv = acceptBestPeilv
        self.inputMoney = inputMoney
        self.noAutoPopWindow = notAutoPop
        self.selectSports.removeAll()
        self.selectSports = self.selectSports + datas
        updateBottom(orderCount: self.selectSports.count > 0 ? 1 : 0, sportSize: self.selectSports.count)
    }
    
}
