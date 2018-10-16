//
//  JianjinTouzhController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/15.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation


protocol CellBtnsDelegate:NSObjectProtocol {
    func onBtnsClickCallback(btnTag:Int,cellPos:Int)
    func onNumBallClickCallback(number:String,cellPos:Int)
}

class TouzhController: BaseController,UITableViewDataSource,UITableViewDelegate,CellBtnsDelegate,PeilvCellDelegate,UITextFieldDelegate,TouzhuBottomDelegate{
    
    func onClearOrRandomClick(zhushu: Int) {
        
    }

    func onHistory() {
        
    }

    func onViewOrder() {
        
    }
    
    
    let PLAY_RULE_TABLVIEW_TAG = 0
    let PLAY_PANE_TABLEVIEW_TAG = 1
    var lotData:LotteryData?
    var ballonDatas:[BallonRules] = []
    let BALL_COUNT_PER_LINE = 6
    let BALL_COUNT_PER_LINE_WHEN_EXPAND = 8
    
    var currentQihao:String = "";//当前期号
    var cpVersion:String = VERSION_1;//当前彩票版本
    var subPlayCode:String = ""
    var subPlayName = ""
    var czCode:String = ""
    var cpBianHao:String = "";//彩票编码
    var cpTypeCode:String = ""////彩票类型代号
    var cpName:String = ""
    var ago:Int = 0//开奖时间与封盘时间差,单位秒
    let offset:Int = 1//偏差1秒
    var tickTime:Int = 0////倒计时查询最后开奖的倒计时时间
    var endBetDuration:Int = 0;//秒
    var endBetTime:Int = 0//距离停止下注的时间
    
    var selectMode = "";//金额模式，元模式
    var selectedBeishu = 1;//选择的倍数
    var selectedMoney = 0.0;//总投注金额,单位元
    var selectedNumbers = "";//选择好的投注号码
    var calcOutZhushu = 0;//计算出来的注数
    var winExample = "";
    var detailDesc = "";
    var playMethod = "";
    
    var playRules:[BcLotteryPlay] = []//所有叶子玩法列表数据
    
    var titleBtn:UIButton!
    @IBOutlet weak var openNumberView:UIView!
    @IBOutlet weak var currentQihaoUI:UILabel!
    @IBOutlet weak var numViews:BallsView!
    @IBOutlet weak var exceptionNumTV:UILabel!
    @IBOutlet weak var pullpushBar:UIButton!//玩法推拉条
    @IBOutlet weak var playRuleTableView:UITableView!
    @IBOutlet weak var playPaneTableView:UITableView!
    @IBOutlet weak var countDownUI:UILabel!
    
    @IBOutlet weak var moneyInutArea:UIView!
    @IBOutlet weak var moneyInput:CustomFeildText!
    @IBOutlet weak var betBtnInArea:UIButton!
    @IBOutlet weak var ruleWidthConstrait:NSLayoutConstraint!
    @IBOutlet weak var peilvMoneyInputAreaHeightConstrait:NSLayoutConstraint!
    @IBOutlet weak var kaijianResultAreaHeightConstrait:NSLayoutConstraint!

    @IBOutlet weak var bottomView:TouzhuBottomView!//底部投注view
    @IBOutlet weak var bottomViewHeightConstrant:NSLayoutConstraint!

    @IBOutlet weak var playRuleLayoutConstraint:NSLayoutConstraint!
    @IBOutlet weak var playPaneLayoutConstraint:NSLayoutConstraint!
    
    var isPlayBarHidden = false
    var right_top_menu:SwiftPopMenu!//右上角悬浮框
    let KSCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    var tag:Int = 1
    
    var lastKaiJianResultTimer:Timer?//查询最后开奖结果的倒计时器
    var endlineTouzhuTimer:Timer?//距离停止下注倒计时器
    
    var peilvListDatas:[PeilvData] = []
    var pageIndex = 1
    var pageSize = 40
    var lhcSelect = false;//是否在奖金版本中选中了六合彩，十分六合彩
    var betMoneyWhenPeilv = ""//每注下注金额
    
    var totalPeilvMoney = 0;//总投注金额
    var calcPeilv:Float = 0;//计算出来的赔率
    var selectedPeilvNumbers:[PeilvPlayData] = []
    
    var isViewVisible = true
    
    //静态数据
    //右上角更多弹出浮框的列表数据源
    var right_top_datasources = [(icon:"1",title:"投注记录"),(icon:"2",title:"历史开奖"),(icon:"3",title:"玩法说明"),(icon:"4",title:"今日输赢"),
                (icon:"5",title:"设置")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup setting menu on right part of nav bar
        let moreBtn = UIBarButtonItem(title: "更多", style: UIBarButtonItemStyle.plain, target: self,
                                      action:#selector(showRightTopMenuWhenResponseClick))
        moreBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = moreBtn
        //初始化玩法推拉条相关数据
        pullpushBar.addTarget(self, action: #selector(clickPlayRulePushpullBar), for: .touchUpInside)
        pullpushBar.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        pullpushBar.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        pullpushBar.titleLabel?.numberOfLines = 0
        pullpushBar.setTitleColor(UIColor.init(hex: 0xF36664), for: .normal)
        pullpushBar.setTitleColor(UIColor.init(hex: 0xEF241D), for: .highlighted)
        //赔率版快捷投注的投注按钮和金额输入框
        betBtnInArea.layer.cornerRadius = 5
        betBtnInArea.addTarget(self, action: #selector(click_bet_button), for: .touchUpInside)
        moneyInput.addTarget(self, action: #selector(peilvTouzhuMoneyTextChange), for: UIControlEvents.editingChanged)
        moneyInput.delegate = self
        //绑定底部投注视图的代理
        bottomView.delegate = self
        //初始化并自定义标题兰
        self.customTitleView()
        //绑定开奖号码视图的点击事件，打开开奖结果列表
        openNumberView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onOpenNumberClick)))
        //init play rule txt in top of window
        initPlayRuleTable()
        initPlayPaneTable()
        //开始根据彩种信心获取对应的玩法
        sync_playrule_from_current_lottery(lottery: self.lotData)
    }
    
    //获取到彩种及玩法信息后，更新本地相关变量，重新开始获取开奖结果，重新当前旗号和开始倒计时
    func sync_local_constan_restart_something_after_playrule_obtain(lottery:LotteryData?) -> Void {
        if let lot = lottery{
            self.lotData = lot
        }
        //根据彩种信息更新本地彩票相关变量
        updateLocalConstants(lotData: self.lotData)
        if (self.lotData?.rules.isEmpty)!{
            return
        }
        
        //奖获取到的玩法平铺成一级数组列表，展现出来的玩法是所有叶子结点的玩法数据
        if let lottery = self.lotData{
            let rules:[BcLotteryPlay] = PlayTool.leaf_play_rules(lottery: lottery)
            if !rules.isEmpty{
                playRules.removeAll()
                playRules = playRules + rules
            }
        }
        if playRules.isEmpty{
            return
        }
        let first_play_obj = playRules[0]
        self.handlePlayRuleClick(playData: first_play_obj, position: 0)
        //获取开奖结果
        lastOpenResult(cpBianHao:self.cpBianHao);
        //获取截止下注倒计时
        getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: cpVersion,controller: self)
        if isPeilvVersion(){
            moneyInutArea.isHidden = false
            peilvMoneyInputAreaHeightConstrait.constant = 48
        }else{
            moneyInutArea.isHidden = true
            peilvMoneyInputAreaHeightConstrait.constant = 0
        }
        YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        if isPeilvVersion(){
            self.bottomViewHeightConstrant.constant = 60
            bottomView.createView(controller: self, isPeilv:true)
        }else{
            self.bottomViewHeightConstrant.constant = 100
            bottomView.createView(controller: self, isPeilv:false)
        }
    }
    
    
    //根据最新的彩种信息获取对应的玩法数据
    //网络获取
    //说明:当当前彩种变化时都需要调用此方法同步下玩法数据
    func sync_playrule_from_current_lottery(lottery:LotteryData?) -> Void {
        
        guard let lot = lottery else {return}
        
        let parameters = ["lotType":lot.lotType,"lotCode":lot.code!,"lotVersion":lot.lotVersion] as [String : Any]
        request(frontDialog: true, loadTextStr:"获取玩法中", url:GAME_PLAYS_URL,params:parameters,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取玩法失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LotPlayWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            self.sync_local_constan_restart_something_after_playrule_obtain(lottery: result.content)
                        }else{
                            self.print_error_msg(msg: result.msg)
                        }
                    }
        })
    }
    
    //自定义标题栏，方便点击标题栏切换彩票版本
    func customTitleView() -> Void {
        self.navigationItem.titleView?.isUserInteractionEnabled = true
        let titleView = UIView.init(frame: CGRect.init(x: kScreenWidth/4, y: 0, width: kScreenWidth/2, height: 44))
        titleBtn = UIButton.init(frame: CGRect.init(x: titleView.bounds.width/2-56, y: 0, width: 112, height: 44))
        titleBtn.isUserInteractionEnabled = false
        let titleIndictor = UIImageView.init(frame: CGRect.init(x: titleView.bounds.width/2+titleBtn.bounds.width/2, y: 22-6, width: 12, height: 12))
        titleIndictor.image = UIImage.init(named: "down")
        titleView.addSubview(titleBtn)
        titleView.addSubview(titleIndictor)
        titleBtn.setTitle(self.cpName, for: .normal)
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.navigationItem.titleView = titleView
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleClickEvent(recongnizer:)))
        self.navigationItem.titleView?.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func peilvTouzhuMoneyTextChange(textField:UITextField)->Void{
        let s = textField.text
        if let svalue = s{
            if isEmptyString(str: svalue){
                self.betMoneyWhenPeilv = ""
                return
            }
            if !isPurnInt(string: svalue){
                return
            }
            DispatchQueue.global().async {
                if isEmptyString(str: svalue){
                    return
                }
                if self.selectedPeilvNumbers.isEmpty{
                    return
                }
                let moneyValue = Float(svalue)!
                for data in self.selectedPeilvNumbers{
                    if data.isSelected{
                        data.money = moneyValue
                    }
                }
                let count = figureOutColumnCount(peilvData: self.peilvListDatas[0])
                for i in 0...self.peilvListDatas.count-1{
                    let peilvData  = self.peilvListDatas[i]
                    if !peilvData.subData.isEmpty{
                        for j in 0...peilvData.subData.count-1{
                            let data = peilvData.subData[j]
                            if data.isSelected{
                                let data = self.peilvListDatas[i].subData[j]
                                if data.isSelected{
                                    DispatchQueue.main.async {
                                        let cellIndex = j + count
                                        self.onCellSelect(data: data, cellIndex: cellIndex, row: i, headerColumns: count,volume:false)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.betMoneyWhenPeilv = svalue
            let totalMoney = Int(betMoneyWhenPeilv)!*calcOutZhushu
            self.updateBottomUI(totalMoney:totalMoney)
        }
    }
    
    //处理顶部标题栏点击事件
    @objc func titleClickEvent(recongnizer:UIPanGestureRecognizer) -> Void {
        //显示彩票版本切换弹出框
    }
    
    @objc func onOpenNumberClick() -> Void {
        print("on open number click")
        openOpenResultController(controller: self, cpName: cpName, cpBianMa: cpBianHao, cpTypeCode: cpTypeCode)
    }
    
    func updateLocalConstants(lotData:LotteryData?) -> Void {
        if let lotName = lotData?.name{
            self.cpName = lotName
        }
        if let lotCode = lotData?.czCode{
            self.czCode = lotCode
        }
        if let lotAgo = lotData?.ago{
            self.ago = lotAgo
        }
        if let lotCpCode = lotData?.code{
            self.cpBianHao = lotCpCode
        }
        if let lotCodeType = lotData?.lotType{
            self.cpTypeCode = String.init(describing: lotCodeType)
        }
        if let lotVersion = lotData?.lotVersion{
            self.cpVersion = String.init(describing: lotVersion)
        }
        self.tickTime = self.ago + self.offset
        if isSixMark(lotCode: self.cpBianHao){
            lhcSelect = true
        }
    }
    
    
    //获取开奖结果
    func lastOpenResult(cpBianHao:String) -> Void {
        request(frontDialog: false, url:LOTTERY_LAST_RESULT_URL,params: ["lotCode":cpBianHao,"pageSize":10],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取最近开奖结果失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = LastResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
//                            //更新开奖结果
                            if let results = result.content{
                                self.updateLastKaiJianResult(result:results);
                            }
//                            //开始请求开奖结果倒计时，时长以对应彩种中封盘时间与开奖时间差为主
                            if let timer = self.lastKaiJianResultTimer{
                                timer.invalidate()
                                self.createLastResultTimer()
                            }else{
                                self.createLastResultTimer();
                            }
                        }else{
                            if let timer = self.lastKaiJianResultTimer{
                                timer.invalidate()
                            }
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                                self.updateLastKaiJianExceptionResult(result: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取最近开奖结果失败"))
                                self.updateLastKaiJianExceptionResult(result: "获取开奖结果失败")
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                                return
                            }
                        }
                    }
        })
    }
    
    /**
     * 创建查询开奖结果倒计时
     * @param duration
     */
    func createLastResultTimer() -> Void {
        self.lastKaiJianResultTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(lastResultTickDown), userInfo: nil, repeats: true)
    }
    
    /**
     * 创建停止下注倒计时
     * @param duration
     */
    func createEndBetTimer() -> Void {
        self.endlineTouzhuTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(endBetTickDown), userInfo: nil, repeats: true)
    }
    
    @objc func endBetTickDown() -> Void {
        //将剩余时间减少1秒
        self.endBetTime -= 1
//        print("bet count time = \(self.endBetTime)")
        if self.endBetTime > 0{
            let dealDuration = getFormatTime(secounds: TimeInterval(Int64(self.endBetTime)))
            self.countDownUI.text = String.init(format: "%@期截止:%@", self.currentQihao,dealDuration)
        }else if self.endBetTime == 0{
            self.countDownUI.text = String.init(format: "%@期截止:%@", self.currentQihao,"停止下注")
        }
        if self.endBetTime <= 0{
            //取消定时器
            if let timer = endlineTouzhuTimer{
                timer.invalidate()
            }
            let status = YiboPreference.getNotToastWhenTouzhuEnd()
            if !status{
                //弹框提示当前期号投注结束
                self.showToastTouzhuEndlineDialog(qihao: self.currentQihao)
            }else{
                //当前期数投注时间到时，继续请求同步服务器上下一期号及离投注结束倒计时时间
                //获取下一期的倒计时的同时，获取上一期的开奖结果
                self.getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: cpVersion,controller: self)
            }
        }
    }
    
    //当前这期下注截止时间到时的弹框提示
    func showToastTouzhuEndlineDialog(qihao:String) -> Void {
        
        if !isViewVisible{
            return
        }
        let message = String.init(format: "%@期的投注已截止，投注时请注意检查当前期号是否正确！", qihao)
        let alertController = UIAlertController(title: "温馨提示",
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            self.getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: self.cpVersion,controller: self)
        })
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: self.cpVersion,controller: self)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func lastResultTickDown() -> Void {
        //将剩余时间减少1秒
        self.tickTime -= 1
        if self.tickTime <= 0{
            //取消定时器
            if let timer = lastKaiJianResultTimer{
                timer.invalidate()
            }
            //当前期数投注时间到时，继续请求同步服务器上下一期号及离投注结束倒计时时间
            //获取下一期的倒计时的同时，获取上一期的开奖结果
            self.tickTime = self.ago + self.offset
            self.lastOpenResult(cpBianHao: self.cpBianHao)
        }
    }
    
    /**
     * 更新开奖结果
     * @param result
     */
    func updateLastKaiJianResult(result:BcLotteryData) -> Void {
        if isEmptyString(str: result.qiHao) || isEmptyString(str: result.haoMa){
            return
        }
        currentQihaoUI.text = String.init(format: "第%@期:", result.qiHao)
        if isEmptyString(str: result.haoMa){
            return
        }
        let haomaArr = result.haoMa.components(separatedBy: ",");
        let ballWidth:CGFloat = 20
        let totalBallWidth = ballWidth * CGFloat(haomaArr.count)
        let viewPlaceHoldWidth = (kScreenWidth*4)/5
        //如果ballview占位宽度不大于实际号码宽度，则需要换行处理
        if totalBallWidth > viewPlaceHoldWidth{
            kaijianResultAreaHeightConstrait.constant = 60
        }else{
            kaijianResultAreaHeightConstrait.constant = 30
        }
        numViews.isHidden = false
        exceptionNumTV.isHidden = true
        numViews.setupBalls(nums: haomaArr, offset: 0, lotTypeCode: self.cpTypeCode, cpVersion: cpVersion,viewPlaceHoldWidth:viewPlaceHoldWidth,ballWidth: ballWidth,small: true)
    }
    
    func updateLastKaiJianExceptionResult(result:String) -> Void {
        numViews.isHidden = true
        exceptionNumTV.isHidden = false
        exceptionNumTV.text = result
    }
    
    func click_bottom_clear_button() -> Void {
//        if !isPeilvVersion(){
//            if self.ballonDatas.isEmpty{
//                showToast(view: self.view, txt: "请先选择号码!")
//                return
//            }
//        }else{
//            if self.selectedPeilvNumbers.isEmpty{
//                showToast(view: self.view, txt: "请先选择号码!")
//                return
//            }
//        }
//        self.refreshPaneAndClean()
        showToast(view: self.view, txt: "清除成功")
    }
    
    func refreshPaneAndClean() -> Void {
        self.clearAfterBetSuccess()
    }
    
    //底部投注按钮点击事件
    @objc func click_bet_button() -> Void {
        if isPeilvVersion(){
            //多选情况下才需要判断快捷金额框是否有金额
            if isMulSelectMode(subCode: self.subPlayCode){
                guard let money = self.moneyInput.text else{
                    showToast(view: self.view, txt: "请输入金额(整数金额)")
                    moneyInput.becomeFirstResponder()
                    return
                }
                if isEmptyString(str: money){
                    showToast(view: self.view, txt: "请输入金额(整数金额)")
                    moneyInput.becomeFirstResponder()
                    return
                }
                if !isPurnInt(string: money){
                    showToast(view: self.view, txt: "金额须为整数")
                    return
                }
            }
            doPeilvBet()
        }else{
            if isEmptyString(str: selectedNumbers) {
                showToast(view: self.view, txt: "请先选择号码")
                return;
            }
            if calcOutZhushu == 0{
                showToast(view: self.view, txt: "您还没有下注")
                return;
            }
            //准备数据，进入下一页主单列表
            formBetDataAndEnterOrderPage()
        }
    }
    
    //开始赔率版下注提交
    func doPeilvBet(){
        if (selectedPeilvNumbers.isEmpty) {
            showToast(view: self.view, txt: "请先选择号码")
            return;
        }
        //若有选中的赔率项，但金额为0，则过滤掉这项赔率投注项
        var realPeilvItems:[PeilvPlayData] = []
        for item in selectedPeilvNumbers{
            if item.isSelected{
//                if item.checkbox || item.money > 0{
                    realPeilvItems.append(item)
//                }
            }
        }
        self.selectedPeilvNumbers.removeAll()
        self.selectedPeilvNumbers = self.selectedPeilvNumbers + realPeilvItems
        print("real selected touzhu items == \(self.selectedPeilvNumbers.count)")
        //准备投注号码等数据
        asyncPeilvBet(selectedDatas: selectedPeilvNumbers)
    }
    
    /**
     * 投注动作
     * @param selectedDatas 用户已经选择完投注球的球列表数据
     */
    func asyncPeilvBet(selectedDatas:[PeilvPlayData]) -> Void{
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                if !selectedDatas.isEmpty{
                    
                    var allNotMoney = true
                    var sb = ""
                    for item in selectedDatas{
                        if item.money == 0{
                            sb = sb + String.init(format: "%@%@%@%@", "\"", !isEmptyString(str: item.itemName) ? item.itemName+"-" : "",item.number,"\"")
                        }else{
                            allNotMoney = false
                        }
                    }
                    
                    if isMulSelectMode(subCode: self.subPlayCode){
                        guard let money = self.moneyInput.text else{
                            showToast(view: self.view, txt: "请先输入下注金额再投注")
                            self.moneyInput.becomeFirstResponder()
                            return
                        }
                        if isEmptyString(str: money){
                            showToast(view: self.view, txt: "请先输入下注金额再投注")
                            self.moneyInput.becomeFirstResponder()
                            return
                        }
                    }else{
                        if allNotMoney{
                            //择好号码，但没有输入金额时，先弹出键盘输入金额
                            showToast(view: self.view, txt: "请先输入下注金额再投注")
                            self.moneyInput.becomeFirstResponder()
                            return
                        }
                        if !isEmptyString(str: sb){
                            showToast(view: self.view, txt: String.init(format: "%@号码未输入金额,请输入后再投注", sb))
                            return
                        }
                    }
                    guard let money = self.moneyInput.text else{
                        return
                    }
                    self.realPeilvPostBets(betDatas: selectedDatas, mulSelect:  isMulSelectMode(subCode: self.subPlayCode), money:money)
                }else{
                    showToast(view: self.view, txt: "请先选择号码并投注")
                }
            }
        }
        
    }
    
    /**
     * 赔率版下单投注
     * @param betDatas
     * @param money,若金额不为空，说明是多选状态
     */
    private func realPeilvPostBets(betDatas:[PeilvPlayData],mulSelect:Bool,money:String) {
        if betDatas.isEmpty{
            return
        }
        let isMulSelect = mulSelect
        var postUrl = ""
        var postData = Dictionary<String,AnyObject>()
        //构造下注POST数据
        if isSixMark(lotCode: cpBianHao){//六合彩的情况
            var betsArray:[Dictionary<String,AnyObject>]!
            if isMulSelect{
                let pData = betDatas[0]
                let minSelectCount = pData.peilvData.minSelected
                if minSelectCount > betDatas.count{
                    showToast(view: self.view, txt: String.init(format: "请至少选择%d个选项", minSelectCount))
                    return
                }
                //若是连码情况，则所选号码不能大于10个
                if isLianMa(playCode: self.subPlayCode){
                    if betDatas.count > 10{
                        showToast(view: self.view, txt: "选球数不能超过10位")
                        return
                    }
                }
                //若是全不中玩法，则所选号码不能大于各子玩法指定的数
                if isQuanBuZhong(playCode: self.subPlayCode){
                    let counts =  betDatas.count
                    switch minSelectCount{
                    case 3,4:
                        if counts > 8{
                            showToast(view: self.view, txt: "选球数请勿大于8位!")
                            return
                        }
                    case 5,6:
                        if counts > minSelectCount + 3{
                            showToast(view: self.view, txt: String.init(format: "选球数请勿大于%d位!", minSelectCount+3))
                            return
                        }
                    case 7,8,9,10,11,12:
                        if counts > minSelectCount + 2{
                            showToast(view: self.view, txt: String.init(format: "选球数请勿大于%d位!", minSelectCount+2))
                            return
                        }
                    default:
                        break
                    }
                }
                
                var numbers = [String]()
                for data in betDatas{
                    numbers.append(data.number)
                }
                //对号码数组进行从小到大的排序
//                numbers.sort(by: {(num1: Int, num2: Int) -> Bool in return num1 > num2 })
//                numbers.sort(by: {(num1:Int,num2:Int) -> Bool in return num1 < num2})
                var sb = ""
                for index in 0...numbers.count-1{
                    let num = numbers[index]
                    sb.append(num)
                    if index != numbers.count - 1{
                        sb.append(",")
                    }
                }
                //从多个赔率数据中根据用户选择的选项数，选择出选项数正确的赔率数据
                betsArray = [Dictionary<String,AnyObject>]()
                let webResult = getPeilvDataInCommon(lotCode: cpBianHao, playCode: self.subPlayCode, selectCount: betDatas.count, data: pData)
                if let webData = webResult{
                    //先判断下注的总金额是否在最大和最小下注金额之间
                    if !isEmptyString(str: money){
                        let moneyFloat = Float(money)
                        let rightMoney = moneyLimit(maxMoney: webData.maxBetAmmount, minMoney: webData.minBetAmmount, money: moneyFloat!)
                        if !rightMoney{
                            return
                        }
                    }
                    var item = Dictionary<String,AnyObject>()
                    item["haoma"] = sb as AnyObject
                    item["money"] = money as AnyObject
                    item["markSixId"] = webData.id as AnyObject
                    betsArray.append(item)
                }
            } else{
                betsArray = [Dictionary<String,AnyObject>]()
                for data in betDatas{
                    //先判断下注的总金额是否在最大和最小下注金额之间
                    if !isEmptyString(str: money){
                        let moneyFloat = Float(money)
                        let peilvData = data.peilvData
                        let rightMoney = moneyLimit(maxMoney: peilvData.maxBetAmmount, minMoney: peilvData.minBetAmmount, money: moneyFloat!)
                        if !rightMoney{
                            break
                        }
                    }
                    var item = Dictionary<String,AnyObject>()
                    item["haoma"] = getPeilvPostNumbers(data: data) as AnyObject
                    item["money"] = data.money as AnyObject
                    item["markSixId"] = data.peilvData.id as AnyObject
                    betsArray.append(item)
                }
            }
            
            
            postUrl = DO_SIX_MARK_URL
            var params = Dictionary<String,AnyObject>()
            params["lotCode"] = cpBianHao as AnyObject
            params["playCode"] = self.subPlayCode as AnyObject
            params["state"] = (isMulSelect ? 1 : 2) as AnyObject
            params["qiHao"] = currentQihao as AnyObject
            params["pour"] = betsArray as AnyObject
            
            postData["data"] = params as AnyObject
        }else{
            var betJson = ""
            let pData = betDatas[0]
            if isMulSelect{
                let minSelectCount = pData.peilvData.minSelected
                if minSelectCount > betDatas.count{
                    showToast(view: self.view, txt: String.init(format: "请至少选择%d个选项", minSelectCount))
                    return
                }
                var numbers = [String]()
                for data in betDatas{
                    numbers.append(data.number)
                }
                //对号码数组进行从小到大的排序
                //                numbers.sort(by: {(num1: Int, num2: Int) -> Bool in return num1 > num2 })
                //                numbers.sort(by: {(num1:Int,num2:Int) -> Bool in return num1 < num2})
                var sb = ""
                for index in 0...numbers.count-1{
                    let num = numbers[index]
                    sb.append(num)
                    if index != numbers.count - 1{
                        sb.append(",")
                    }
                }
                
                var item = Dictionary<String,AnyObject>()
                item["name"] = sb as AnyObject
                item["money"] = money as AnyObject
                
                //从多个赔率数据中根据用户选择的选项数，选择出选项数正确的赔率数据
                var betsArray = [Dictionary<String,AnyObject>]()
                let webResult = getPeilvDataInCommon(lotCode: cpBianHao, playCode: self.subPlayCode, selectCount: betDatas.count, data: pData)
                if let webData = webResult{
                    //先判断下注的总金额是否在最大和最小下注金额之间
                    if !isEmptyString(str: money){
                        let moneyFloat = Float(money)
                        let rightMoney = moneyLimit(maxMoney: webData.maxBetAmmount, minMoney: webData.minBetAmmount, money: moneyFloat!)
                        if !rightMoney{
                            return
                        }
                    }
                    item["oddsId"] = webData.id  as AnyObject
                    item["rate"] = webData.rakeBack  as AnyObject
                }
                betsArray.append(item)
                if (JSONSerialization.isValidJSONObject(betsArray)) {
                    let data : NSData! = try? JSONSerialization.data(withJSONObject: betsArray, options: []) as NSData
                    let str = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
                    betJson = str! as String
                }
            }else{
                var betsArray = [Dictionary<String,AnyObject>]()
                for data in betDatas{
                    let peilvData = data.peilvData
                    let rightMoney = moneyLimit(maxMoney: peilvData.maxBetAmmount, minMoney: peilvData.minBetAmmount, money: data.money)
                    if !rightMoney{
                        break
                    }
                    var item = Dictionary<String,AnyObject>()
                    item["name"] = getPeilvPostNumbers(data: data) as AnyObject
                    item["money"] = data.money as AnyObject
                    item["oddsId"] = data.peilvData.id as AnyObject
                    item["rate"] = data.peilvData.rakeBack as AnyObject
                    betsArray.append(item)
                }
                if (JSONSerialization.isValidJSONObject(betsArray)) {
                    let data : NSData! = try? JSONSerialization.data(withJSONObject: betsArray, options: []) as NSData
                    let str = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
                    betJson = str! as String
                }
            }
            
            postUrl = DO_PEILVBETS_URL
            postData["data"] = betJson as AnyObject
            postData["lotCode"] = cpBianHao as AnyObject
            postData["playCode"] = self.subPlayCode as AnyObject
            postData["lotType"] = cpTypeCode as AnyObject
            postData["qiHao"] = currentQihao as AnyObject
            postData["stId"] = pData.peilvData.stationId as AnyObject
            print("post bet json == \(betJson)")
        }
        
        print("post data === \(postData)")
        if isSixMark(lotCode: cpBianHao){
            let value = postData["data"] as! Dictionary<String,AnyObject>
            if (JSONSerialization.isValidJSONObject(value)) {
                let data : NSData! = try? JSONSerialization.data(withJSONObject: value, options: []) as NSData
                let str = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
                let betJson = str! as String
                postData["data"] = betJson as AnyObject
            }
        }
        
        request(frontDialog: true,method: .post,loadTextStr: "正在下注...", url: postUrl, params:postData,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "下注失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = BetTokenWrapper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
//                            showToast(view: self.view, txt: "投注成功")
                            self.showBetSuccessDialog()
                            self.clearAfterBetSuccess()
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "下注失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0 || result.code == nil) {
                                loginWhenSessionInvalid(controller: self)
                                return
                            }
                        }
                    }
        })
        
    }
    
    //下注成功的时候提示框
    func showBetSuccessDialog() -> Void {
        let alertController = UIAlertController(title: "温馨提示",
                                                message: "下注成功!", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "查看记录", style: .cancel, handler: {
            action in
            openTouzhuRecord(controller: self,title: self.cpName,code: self.cpBianHao, recordType: isSixMark(lotCode: self.cpBianHao) ? MenuType.LIUHE_RECORD : MenuType.CAIPIAO_RECORD)
        })
        let okAction = UIAlertAction(title: "继续下注", style: .default, handler: {
            action in
        })
        alertController.addAction(viewAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //下注时的下注金额上下限限制
    func moneyLimit(maxMoney:Float,minMoney:Float,money:Float) -> Bool{
        if money < minMoney{
            showToast(view: self.view, txt: String.init(format: "投注金额不能小于%.2f元", minMoney))
            return false
        }
        if money > maxMoney{
            showToast(view: self.view, txt: String.init(format: "投注金额不能大于%.2f元", maxMoney))
            return false
        }
        return true
    }
    
    @objc func showRightTopMenuWhenResponseClick() -> Void {
        //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
        right_top_menu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 150 - 5, y: 56, width: 150, height: 250), arrowMargin: 18)
        right_top_menu.popData = right_top_datasources
        //点击菜单事件
        right_top_menu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.right_top_menu.dismiss()
            self?.onMenuListClick(index: index)
        }
        right_top_menu.show()
        tag += 1
    }
    
    
    //右上角悬浮框列表相点击回调事件
    func onMenuListClick(index:Int) -> Void {
        switch index {
        case 0://touzhu record
            var lotName = ""
            if let lotNameValue = lotData?.name{
                lotName = lotNameValue
            }
            openTouzhuRecord(controller: self,title: lotName,code: self.cpBianHao, recordType: isSixMark(lotCode: cpBianHao) ? MenuType.LIUHE_RECORD : MenuType.CAIPIAO_RECORD)
        case 1:
            openOpenResultController(controller: self, cpName: self.cpName, cpBianMa: self.cpBianHao,cpTypeCode: self.cpTypeCode)
            break
        case 2://play rule introduction
            openPlayIntroduceController(controller: self, payRule: self.playMethod, touzhu: self.detailDesc, winDemo: self.winExample)
        case 3:
            self.syncWinLost()
        case 4:
            openSetting(controller: self)
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("the hidden status = \(isPlayBarHidden)")
        isViewVisible = true
        updatePlayRuleConstraint(isHidden: isPlayBarHidden)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isViewVisible = false
        YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
    }
    
    //设置侧边玩法兰列表的代理及数据原
    func initPlayRuleTable() -> Void {
        self.playRuleTableView!.delegate = self
        self.playRuleTableView!.dataSource = self
    }
    
    func initPlayPaneTable() -> Void {
        playPaneTableView.delegate = self
        playPaneTableView.dataSource = self
    }
    
    //点击侧边玩法兰推拉条事件
    @objc func clickPlayRulePushpullBar() -> Void {
        isPlayBarHidden = !isPlayBarHidden
        //            if self.isPeilvVersion(){
        self.playPaneTableView.reloadData()
        //            }
        UIView.animate(withDuration: 0.3, animations: {
            if self.isPlayBarHidden{
                self.playRuleLayoutConstraint.constant = -kScreenWidth*0.24
                self.playPaneLayoutConstraint.constant = kScreenWidth*0.24
            }else{
                self.playRuleLayoutConstraint.constant = 0
                self.playPaneLayoutConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }) { (finished) in
            self.updatePlayRuleConstraint(isHidden: self.isPlayBarHidden)
        }
    }
    
    func updatePlayRuleConstraint(isHidden:Bool) -> Void {
        let attrStr = NSAttributedString.imageTextInit(image: UIImage(named: isPlayBarHidden ? "pull_forward_icon" : "pull_bar_icon")!, imageW: 18, imageH: 9, labelTitle: isPlayBarHidden ? "点击展开玩法栏" : "点击隐藏玩法栏", fontSize: 12, titleColor: UIColor.lightGray, labelSpacing: 4)
        //设置按钮基本属性
        pullpushBar.titleLabel?.textAlignment = .center
        pullpushBar.titleLabel?.numberOfLines = 0
        pullpushBar.setAttributedTitle(attrStr, for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.isPlayBarHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            return playRules.count
        }
        if !isPeilvVersion(){
            return self.ballonDatas.count
        }else{
            return self.peilvListDatas.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == PLAY_PANE_TABLEVIEW_TAG{
            if !isPeilvVersion(){
                let ballCount = self.ballonDatas[indexPath.row].ballonsInfo.count
                let isWeishuShow = self.ballonDatas[indexPath.row].showWeiShuView
                if !isPlayBarHidden{
                    var lines = ballCount / BALL_COUNT_PER_LINE
                    if ballCount > BALL_COUNT_PER_LINE{
                        if ballCount % BALL_COUNT_PER_LINE != 0{
                            lines = lines + 1
                        }
                    }
                    if lines == 0{
                        lines = lines + 1
                    }
                    var height = CGFloat(CGFloat(lines)*43.875+70)
                    if isWeishuShow!{
                        height = height + 35
                    }
                    return height
                }else{
                    var lines = ballCount / BALL_COUNT_PER_LINE_WHEN_EXPAND
                    if ballCount > BALL_COUNT_PER_LINE_WHEN_EXPAND{
                        if ballCount % BALL_COUNT_PER_LINE_WHEN_EXPAND != 0{
                            lines = lines + 1
                        }
                    }
                    if lines == 0{
                        lines = lines + 1
                    }
                    var height = CGFloat(CGFloat(lines)*43.875+70)
                    if isWeishuShow!{
                        height = height + 35
                    }
                    return height
                }
            }else{
                if !self.peilvListDatas.isEmpty{
                    let itemColumnCount = figureOutColumnCount(peilvData: self.peilvListDatas[0])
                    let itemCount = self.peilvListDatas[indexPath.row].subData.count
                    var cellItemCount = itemCount/itemColumnCount
                    cellItemCount = cellItemCount + itemCount%itemColumnCount
                    let height = cellItemCount * 50 + 30 + 50//加上头部高度,加上标签高度
                    return CGFloat(height)
                }else{
                    return 200
                }
            }
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            if let rules = lotData?.rules{
                return rules[section].name
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
            let row = indexPath.row
            let subRules = self.playRules[row]
            cell.textLabel!.text = subRules.name
            cell.textLabel!.textAlignment = NSTextAlignment.center
            cell.textLabel!.font = UIFont.italicSystemFont(ofSize: 12)
            return cell
        }else{
            if !isPeilvVersion(){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "paneCell") as? JianjinPaneCell  else {
                    fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
                }
                //bind cell delegate
                cell.btnsDelegate = self
                cell.ruleUI.setTitle(self.ballonDatas[indexPath.row].ruleTxt, for: .normal)
                cell.ruleUI.layer.cornerRadius = 10
                cell.weishuView.cellDelegate = self
                cell.funcView.cellDelegate = self
                cell.weishuView.cellPos = indexPath.row
                cell.funcView.cellPos = indexPath.row
                cell.toggleWeishuView(show: self.ballonDatas[indexPath.row].showWeiShuView)
                cell.initFuncView(playRuleShow:!isPlayBarHidden)
                if self.ballonDatas[indexPath.row].showWeiShuView{
                    cell.weishuView.setData(array: self.ballonDatas[indexPath.row].weishuInfo,playRuleShow:!isPlayBarHidden)
                }
                cell.fillBallons(balls: self.ballonDatas[indexPath.row].ballonsInfo)
                return cell
            } else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "peilvCell") as? PeilvTouzhuCell  else {
                    fatalError("The dequeued cell is not an instance of peilvCell.")
                }
                cell.cellDelegate = self
                if !self.peilvListDatas.isEmpty{
                    if indexPath.row >= self.peilvListDatas.count{
                        return cell
                    }
                    let data = self.peilvListDatas[indexPath.row]
                    cell.tagUI.text = data.tagName
                    cell.setupViewAccordingData(peilvData: data,playPaneIsShow: !isPlayBarHidden,playCode: self.subPlayCode,row:indexPath.row)
                }
                return cell
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            if let rules = lotData?.rules{
                return rules.count
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            let select_rule = self.playRules[indexPath.row]
            self.handlePlayRuleClick(playData: select_rule,position: indexPath.row)
        }
    }
    
    
    //侧边玩法兰列表项点击事件
    func handlePlayRuleClick(playData:BcLotteryPlay,position:Int) -> Void {
        
        if playData.status != 2{
            showToast(view: self.view, txt: "该玩法已被关闭使用，开关此玩法请至平台配置")
            return
        }
        
        //当切换到其他玩法时，将保存的下注注单清空
        if playData.code != self.subPlayCode{
            YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        }
        self.subPlayCode = playData.code
        self.subPlayName = playData.name
        self.winExample = playData.winExample
        self.detailDesc = playData.detailDesc
        self.playMethod = playData.playMethod
        
        //更新标题栏
        update_title_rule_label(playname: self.subPlayName)
        //重新刷新投注面板
        if !isPeilvVersion(){
            //figure out play ballons
            clearBottomValue()
            //根据彩票版本和玩法确定下注球列表数据
            let ballonRules = form_jianjing_pane_datasources(lotType: cpTypeCode, subCode: self.subPlayCode)
            ballonDatas.removeAll()
            self.ballonDatas = self.ballonDatas + ballonRules
            self.playPaneTableView.reloadData()
            self.scrollToTop()
        }else{
            //figure out peilv play ballons. we get peilv first
            getPeilvData(lotCategoryType: cpTypeCode, subPlayCode: self.subPlayCode, showDialog: true)
        }
    }
    
    
    func update_title_rule_label(playname:String) -> Void {
        let titleName = cpVersion == VERSION_1 ? "官方下注" : "信用下注"
        titleBtn.setTitle(titleName, for: .normal)
//        play_rule.text = playname
    }
    
    //将玩法球列表滚动到第一行
    func scrollToTop() -> Void{
        if ballonDatas.isEmpty{
            return
        }
        if isPeilvVersion() && self.peilvListDatas.isEmpty{
            return
        }
        self.playPaneTableView.scrollToRow(at: IndexPath.init(item: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
    }
    
    
    //是否赔率版下注
    func isPeilvVersion() ->  Bool{
        if self.cpVersion == VERSION_2 || lhcSelect{
            return true
        }
        return false
    }
    
    //点击“万千百十个”位数按钮时的响应动作
    func clickWeiBtns(weiTag:Int,cellPos:Int,btnIndex:Int) -> Void {
        switch weiTag {
        default:
            let cell = self.playPaneTableView.cellForRow(at: IndexPath.init(row: cellPos, section: 0)) as! JianjinPaneCell
            let isSelected = self.ballonDatas[cellPos].weishuInfo?[btnIndex].isSelected
            let weiBtn = cell.viewWithTag(weiTag) as! UIButton
            print("btn tag = \(weiBtn.tag)")
            if !isSelected!{
                weiBtn.setTitleColor(UIColor.white, for: .normal)
                weiBtn.backgroundColor = UIColor.red
            }else{
                weiBtn.setTitleColor(UIColor.black, for: .normal)
                weiBtn.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
            }
            self.ballonDatas[cellPos].weishuInfo?[btnIndex].isSelected = !isSelected!
        }
    }
    
    
    //奖金版下注时--点击每个列玩法球中的辅助功能按钮的响应事件
    func onBtnsClickCallback(btnTag: Int, cellPos: Int) {
        print("the btntag = \(btnTag),the cell pos = \(cellPos)")
        if YiboPreference.isPlayTouzhuVolume(){
            playVolume()
        }
        switch btnTag {
        case 20,21,22,23,24://wan
            clickWeiBtns(weiTag: btnTag, cellPos: cellPos,btnIndex: btnTag - 20)
        //all
        case 10:
            let ball = self.ballonDatas[cellPos]
            for ballNumInfo in ball.ballonsInfo{
                ballNumInfo.isSelected = true
            }
            self.playPaneTableView.reloadData()
            break
        //big
        case 11:
            self.clickBigSmall(isBig: true, cellPos: cellPos)
            break
        //small
        case 12:
            self.clickBigSmall(isBig: false, cellPos: cellPos)
            break
        //single
        case 13:
            self.clickSingleDouble(isSingle: true, cellPos: cellPos)
            break
        //doule
        case 14:
            self.clickSingleDouble(isSingle: false, cellPos: cellPos)
            break
        case 15:
            let ball = self.ballonDatas[cellPos]
            for ballNumInfo in ball.ballonsInfo{
                ballNumInfo.isSelected = false
            }
            self.playPaneTableView.reloadData()
            break
        default:
            break
        }
        onNumBallClickCallback(number: "", cellPos: 0)
    }
    
    //清除下注底部兰的视图数据
    func clearBottomValue() -> Void {
        calcOutZhushu = 0;
        selectMode = "y";
        selectedBeishu = 1;//选择的倍数
        selectedMoney = 0;//总投注金额
        selectedNumbers = "";//选择好的投注号码
        selectedPeilvNumbers.removeAll()
        totalPeilvMoney = 0
        calcPeilv = 0
        bottomView.updateBottomDetail(zhushu: 0, money: 0, rate: 0)
    }
    
    func clearAfterBetSuccess() -> Void {
        
        for ball in self.ballonDatas{
            for ballNumInfo in ball.ballonsInfo{
                ballNumInfo.isSelected = false
            }
            if ball.showWeiShuView{
                for weishuData in ball.weishuInfo{
                    weishuData.isSelected = false
                }
            }
        }
        
        for peilvData in self.peilvListDatas{
            let sub = peilvData.subData
            for item in sub{
//                item.checkbox = false
                item.isSelected = false
                item.money = 0
            }
        }
        self.playPaneTableView.reloadData()
        clearBottomValue()
    }
    
    func playVolume() -> Void{
        var soundID:SystemSoundID = 0
        //get volume file path
        let path = Bundle.main.path(forResource: "bet_select", ofType: "mp3")
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
    }
    
    func playVolumeWhenStartShake() -> Void {
        var soundID:SystemSoundID = 0
        //get volume file path
        let path = Bundle.main.path(forResource: "rock", ofType: "mp3")
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
    }
    
    func playVolumeWhenEndShake() -> Void {
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
        var soundID:SystemSoundID = 0
        //get volume file path
        let path = Bundle.main.path(forResource: "rock_end", ofType: "mp3")
        let baseURL = NSURL(fileURLWithPath: path!)
        //赋值
        AudioServicesCreateSystemSoundID(baseURL, &soundID)
        //播放声音
        AudioServicesPlaySystemSound(soundID)
    }
    
    func onNumBallClickCallback(number: String, cellPos: Int) {
        //播放按键音
        if YiboPreference.isPlayTouzhuVolume(){
            playVolume()
        }
        //选择球的时候清除本地已选择的金额，倍数，注数等
        clearBottomValue()
        //开始计算投注号码串及注数
        dobet_when_click(selectedDatas: ballonDatas, czCode: self.cpTypeCode, subCode: self.subPlayCode,cellPos: cellPos)
    }
    
    /**
     * 投注动作
     * @param selectedDatas 非机选投注时，用户已经选择完投注球的球列表数据
     * @param cpVersion 彩票版本
     * @param czCode 彩种代号
     * @param subCode 小玩法
     * @param cellPos 点击的位置
     */
    func dobet_when_click(selectedDatas:[BallonRules],czCode:String,subCode:String,cellPos:Int = -1) -> Void{
        
        DispatchQueue.global().async {
            var numbers = ""
            print("figure out the tou zhu post numbers = \(numbers)")
            if isEmptyString(str: numbers){
                return;
            }
            //根据下注号码计算注数
            let zhushu = JieBaoZhuShuCalculator.calc(lotType: Int((czCode as NSString).intValue), playCode: subCode, haoMa: numbers)
            DispatchQueue.main.async {
                print("the zhushu === main = \(zhushu)")
                self.calcOutZhushu = zhushu
                self.selectedMoney = Double(zhushu*2)
                self.selectedNumbers = numbers
                self.updateBottomUI(totalMoney: 0)
            }
        }
        
    }
    
    //准备住单数据并进入主单列表页
    func formBetDataAndEnterOrderPage() {
        let order = fromBetOrder()
        openBetOrderPage(controller: self, data: order,lotCode: self.cpBianHao,lotName: self.cpName,playName: "",playCode: "",subPlayCode: self.subPlayCode,subPlayName: self.subPlayName,cpTypeCode: self.cpTypeCode)
    }
    
    func syncWinLost() -> Void {
        request(frontDialog: true, method: .get, url:WIN_LOST_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = WinLostWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            guard let content = result.content else {return}
                            self.showWinLostDialog(result:  content)
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                                return
                            }
                        }
                    }
        })
        
    }
    
    func showWinLostDialog(result:WinLost) -> Void {
        if !isViewVisible{
            return
        }
        let message = String.init(format: "今日消费:%.2f元\n今日中奖:%.2f元\n今日盈亏:%.2f元", result.allBetAmount,result.allWinAmount,result.yingkuiAmount)
        let alertController = UIAlertController(title: "今日输赢",
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fromBetOrder() -> OrderDataInfo {
        let orderInfo = OrderDataInfo()
        orderInfo.subPlayName = subPlayName
        orderInfo.subPlayCode = self.subPlayCode
        orderInfo.beishu = selectedBeishu
        orderInfo.zhushu = calcOutZhushu
        orderInfo.money = selectedMoney
        orderInfo.numbers = selectedNumbers
        orderInfo.cpCode = cpBianHao
        orderInfo.lotcode = cpBianHao
        if (selectMode == "y") {
            orderInfo.mode = 1
        } else if (selectMode == "yj") {
            orderInfo.mode = 10
        } else if (selectMode == "yjf") {
            orderInfo.mode = 100
        }
        return orderInfo
    }
    
    func updateBottomUI(totalMoney:Int) -> Void {
        if !isPeilvVersion(){
            bottomView.updateBottomDetail(zhushu: self.calcOutZhushu, money: Float(self.selectedMoney), rate: 0)
        }else{
            bottomView.updateBottomDetail(zhushu: self.calcOutZhushu, money: Float(totalMoney > 0 ? totalMoney : self.totalPeilvMoney), rate: 0)
        }
    }
    
    func updatePeilvLabel(peilv:String,show:Bool){
        if show{
            bottomView.updateBottomPeilv(peilv: peilv)
        }else{
            bottomView.updateBottomPeilv(peilv: "")
        }
    }
    
    func clickBigSmall(isBig:Bool,cellPos:Int) -> Void{
        let ball = self.ballonDatas[cellPos]
        for index in 0...ball.ballonsInfo.count-1{
            if index >= ball.ballonsInfo.count/2{
                ball.ballonsInfo[index].isSelected = isBig ? true : false
            }else{
                ball.ballonsInfo[index].isSelected = isBig ? false : true
            }
        }
        self.playPaneTableView.reloadData()
    }
    
    func clickSingleDouble(isSingle:Bool,cellPos:Int) -> Void {
        let ball = self.ballonDatas[cellPos]
        for ballInfo in ball.ballonsInfo{
            if isPurnInt(string: ballInfo.num){
                let scanner = Scanner(string: ballInfo.num)
                scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
                var number :Int = 0
                scanner.scanInt(&number)
                if !isSingle{
                    if number % 2 == 0{
                        ballInfo.isSelected = true
                    }else{
                        ballInfo.isSelected = false
                    }
                }else{
                    if number % 2 == 0{
                        ballInfo.isSelected = false
                    }else{
                        ballInfo.isSelected = true
                    }
                }
            }else{
                ballInfo.isSelected = false
            }
        }
        self.playPaneTableView.reloadData()
    }
    
    /**
     * 开始获取当前期号离结束投注倒计时
     * @param bianHao 彩种编号
     * @param lotVersion 彩票版本
     */
    func getCountDownByCpcode(bianHao:String,lotVersion:String,controller:BaseController) -> Void {
        request(frontDialog: false, url:LOTTERY_COUNTDOWN_URL,params:["lotCode":bianHao,"version":lotVersion],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取当前期号失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        self.currentQihao = "???????";
                        self.countDownUI.text = self.currentQihao
                        return
                    }
                    if let result = LocCountDownWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            //更新当前这期离结束投注的倒计时显示
                            if let value = result.content{
                                self.updateCurrenQihaoCountDown(countDown: value)
                            }
                        }else{
                            self.currentQihao = "???????";
                            self.countDownUI.text = self.currentQihao
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取当前期号失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func updateCurrenQihaoCountDown(countDown:CountDown) -> Void {
        //创建开奖周期倒计时器
        let serverTime = countDown.serverTime;
        let activeTime = countDown.activeTime;
        let value = abs(activeTime) - abs(serverTime)
        self.endBetDuration = Int(abs(value))/1000
        self.endBetTime = self.endBetDuration
        self.currentQihao = countDown.qiHao
        let dealDuration = getFormatTime(secounds: TimeInterval(Int64(self.endBetDuration)))
        self.countDownUI.text = String.init(format: "%@期截止:%@", self.currentQihao,dealDuration)
        if let timer = self.endlineTouzhuTimer{
            timer.invalidate()
        }
        self.createEndBetTimer()
    }
    
    @objc func onShakeStart(info:NSNotification)->Void{
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
        playVolumeWhenStartShake()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    @objc func onEndShake(info:NSNotification)->Void{
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
        playVolumeWhenEndShake()
        //选择球的时候清除本地已选择的金额，倍数，注数等
        clearBottomValue()
        //开始计算投注号码串及注数
        dobet_when_click(selectedDatas: ballonDatas, czCode: self.cpTypeCode, subCode: self.subPlayCode)
    }
    
    /**
     * 根据小玩法及彩种编码获取赔率信息
     * @param lotCategoryType 彩种类型编码
     * @param subPlayCode 玩法代号
     * @param showDialog
     */
    func getPeilvData(lotCategoryType:String,subPlayCode:String,showDialog:Bool) -> Void {
        request(frontDialog: showDialog, loadTextStr:"赔率获取中..",url:GET_PVODDS_URL,params:["playCode":subPlayCode,"lotType":lotCategoryType],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = PeilvWebResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            //更新赔率面板号码区域赔率等数据
                            self.updatePeilvPlayArea(result: result.content)
                            //清除底部UI及变量
                            self.clearBottomValue()
                            self.updateBottomUI(totalMoney: 0)
                            //获取到赔率数据后，若是六合彩中的连码或全不中，则直接将赔率显示出来
                            if isLianMaOrQuanbuZhong(playCode: self.subPlayCode){
                                let webResult = result.content
                                if !webResult.isEmpty{
                                    self.updatePeilvLabel(peilv: String.init(format: "赔率: %.2f", webResult[0].odds), show: true)
                                }
                            }else{
                                self.updatePeilvLabel(peilv: "", show: false)
                            }
                            self.scrollToTop()
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func onConfirm() {
        getBetParamsFromBottomView()
        click_bet_button()
    }
    
    func convert_index_to_mode(index:Int) -> String {
        if index == 0{
            return YUAN_MODE
        }else if index == 1{
            return JIAO_MODE
        }else if index == 2{
            return FEN_MODE
        }
        return YUAN_MODE
    }
    
    func getBetParamsFromBottomView() -> Void {
        if !isPeilvVersion(){
            self.selectedMoney = Double(bottomView.money)
            self.selectedBeishu = bottomView.beishu
            self.selectMode = convert_index_to_mode(index: bottomView.selectModeIndex)
        }
    }
    
    func click_lottery_record_history() {
        var lotName = ""
        if let lotNameValue = lotData?.name{
            lotName = lotNameValue
        }
        openTouzhuRecord(controller: self,title: lotName,code: self.cpBianHao, recordType: isSixMark(lotCode: cpBianHao) ? MenuType.LIUHE_RECORD : MenuType.CAIPIAO_RECORD)
    }
    /**
     * 获取到后台赔率数据后更新玩法号码面板，更新赔率及号码
     * @param results
     */
    func updatePeilvPlayArea(result:[PeilvWebResult]) -> Void {
        if result.isEmpty{
            self.peilvListDatas.removeAll()
            self.playPaneTableView.reloadData()
            return
        }
        let verion = isPeilvVersion() ? VERSION_2 : VERSION_1
        if isEmptyString(str: verion) || isEmptyString(str: cpBianHao) ||
            isEmptyString(str: subPlayCode) || isEmptyString(str: self.subPlayCode){
            return
        }
        let resultDatas:[PeilvData] = []
        self.peilvListDatas.removeAll()
        self.peilvListDatas = self.peilvListDatas + resultDatas
        //刷新投注面板
        self.playPaneTableView.reloadData()
    }
    
    func refreshPaneAndClean(noClearView:Bool) -> Void {
        self.playPaneTableView.reloadData()
        if !noClearView{
            clearBottomValue()
        }
    }
    
    //在直接赔率项输入项中输入金额后，回调此方法来计算注数
    func callAsyncCalcZhushu() {
        //开始计算投注号码串及注数
        asyncCalcPeilvData(pdata: self.peilvListDatas)
    }
    
    //赔率cellviewview cell点击回调
    func onCellSelect(data: PeilvPlayData, cellIndex: Int,row:Int,headerColumns:Int,volume:Bool=true) {
        print("cellIndex === \(cellIndex),row = \(row)")
        //播放按键音
        if volume{
            if YiboPreference.isPlayTouzhuVolume(){
                playVolume()
            }
        }
        let mCell = self.playPaneTableView.cellForRow(at: IndexPath.init(row: row, section: 0))
        if mCell == nil{
            return
        }
        let cell:PeilvTouzhuCell = mCell as! PeilvTouzhuCell
        let cell2:PeilvCollectionViewCell = cell.tableContent.cellForItem(at: IndexPath.init(row: cellIndex, section: 0)) as! PeilvCollectionViewCell
        let clickData = self.peilvListDatas[row].subData[cellIndex-headerColumns]
        if !clickData.checkbox{
            if clickData.isSelected{
                if !isEmptyString(str: self.betMoneyWhenPeilv){
                    cell2.moneyTextUI.text = self.betMoneyWhenPeilv
                    clickData.money = Float(self.betMoneyWhenPeilv)!
                }
            }else{
                cell2.moneyTextUI.text = ""
                clickData.money = 0
            }
        }else{
            if clickData.isSelected{
                cell2.checkboUI.image = UIImage.init(named: "checkbox_press")
            }else{
                cell2.checkboUI.image = UIImage.init(named: "checkbox_normal")
            }
        }
        print("the select data count = \(selectedPeilvNumbers.count)")
        //开始计算投注号码串及注数
        asyncCalcPeilvData(pdata: self.peilvListDatas)
        
    }
    
    func calcZhushuAndSendMessage(selectDatas:[PeilvPlayData]) -> (Int,Float,Int,Bool,[PeilvPlayData]){
        let pData = selectDatas[0]
        var totalZhushu = 0
        var totalMoney = 0
        var peilvWhenMultiSelect:Float = 0
        let isMultiSelect = pData.checkbox
        //若是多选情况下，则将多个号码拼接起来,以逗号分隔
        if isMultiSelect{
            let minSelectCount = pData.peilvData.minSelected
            if minSelectCount > selectDatas.count{
                //Utils.LOG("aa","选择的号码小于"+pData.getPeilvData().getMinSelected()+",不必计算注数");
                return (0,0,0,isMultiSelect,selectDatas)
            }
            var numbers = ""
            for index in 0...selectDatas.count-1{
                let playData = selectDatas[index]
                numbers.append(playData.number)
                if index != selectDatas.count - 1{
                    numbers.append(",")
                }
            }
            let webResult = getPeilvDataInCommon(lotCode: self.cpBianHao, playCode: self.subPlayCode, selectCount: selectDatas.count, data: pData)
            if let wr = webResult{
                let zhushu = PeilvZhushuCalculator.buyZhuShuValidate(haoMa: numbers, minSelected: wr.minSelected, playCode: wr.playCode)
                print("zhushu == \(zhushu)")
                totalZhushu = totalZhushu + zhushu
                //totalMoney = Int(self.betMoneyWhenPeilv)!
                peilvWhenMultiSelect = wr.odds
                totalMoney = 0
            }
        }else{
            for data in selectDatas{
//                if data.money > 0{//金额大于0的选中项才计算注数
                    let zhushu = PeilvZhushuCalculator.buyZhuShuValidate(haoMa: data.number, minSelected: data.peilvData.minSelected, playCode: data.peilvData.playCode)
                    print("zhushu == \(zhushu)")
                    totalZhushu = totalZhushu + zhushu
                    let dm:Int = Int(data.money)
                    totalMoney = totalMoney + dm
//                }
            }
        }
        return (totalMoney,peilvWhenMultiSelect,totalZhushu,isMultiSelect,selectDatas)
    }
    
    func asyncCalcPeilvData(pdata:[PeilvData]) -> Void{
        DispatchQueue.global().async {
            var selectedDatas = [PeilvPlayData]()
            var tupleResult:(Int,Float,Int,Bool,[PeilvPlayData])!
            for data in pdata{
                let subs = data.subData
                for mData in subs{
                    if isSelectedNumber(data: mData){
                        if !mData.filterSpecialSuffix{
                            mData.appendTag = data.appendTag
                            mData.itemName = (!isEmptyString(str: data.postTagName) && !isEmptyString(str: data.postTagName)) ? data.postTagName : data.tagName
                        }else{
                            mData.appendTag = false
                        }
                        selectedDatas.append(mData)
                    }
                }
            }
            if !selectedDatas.isEmpty{
                tupleResult = self.calcZhushuAndSendMessage(selectDatas: selectedDatas)
            }
            DispatchQueue.main.async {
                if tupleResult == nil{
                    return
                }
                let (totalMoney,peilvWhenMultiSelect,totalZhushu,isMultiSelect,selectDatas) = tupleResult
                self.selectedPeilvNumbers.removeAll()
                for item in selectDatas{
                    self.selectedPeilvNumbers.append(item)
                }
                
                //若是多选组合号码，则这里的总金额是输入框输入的金额，而不是注数*每注金额
                if isMultiSelect{
                    if !isEmptyString(str: self.betMoneyWhenPeilv){
                        self.totalPeilvMoney = Int(self.betMoneyWhenPeilv)!*totalZhushu
                    }
                    if totalZhushu > 0{//当有注数时计算多选玩法下的正确赔率
                        let rightWebResult = getPeilvDataInCommon(lotCode: self.cpBianHao, playCode: self.subPlayCode, selectCount: selectDatas.count, data: selectDatas[0])
                        if let result = rightWebResult{
                            print("the peilv vaule when select one item === \(result.odds)")
                            if !dontShowPeilvWhenTouzhu(playCode: self.subPlayCode){
                                self.updatePeilvLabel(peilv: String.init(format: "赔率: %.2f", result.odds), show: true)
                            }
                        }
                    }else{
                        self.updatePeilvLabel(peilv: "", show: false)
                    }
                }else{
                    self.totalPeilvMoney = totalMoney
                }
                self.calcPeilv = peilvWhenMultiSelect
                self.calcOutZhushu = totalZhushu
                //update bottom value
                self.updateBottomUI(totalMoney: 0)
            }
        }
        
    }
    
}

// MARK: -使用图像和文本生成上下排列的属性文本
extension NSAttributedString {
    
    //将图片属性以及文字属性用方法名传入
    class func imageTextInit(image: UIImage, imageW: CGFloat, imageH: CGFloat, labelTitle: String, fontSize: CGFloat, titleColor: UIColor, labelSpacing: CGFloat) -> NSAttributedString{
        
        //1.将图片转换成属性文本
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect.init(x: 0, y: 0, width: imageW, height: imageH)
        let imageText = NSAttributedString(attachment: attachment)
        
        //2.将标题转化为属性文本
        let titleDict = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize), NSAttributedStringKey.foregroundColor: titleColor]
        let text = NSAttributedString(string: labelTitle, attributes: titleDict)
        
        //3.换行文本可以让label长度不够时自动换行
        let spaceDict = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: labelSpacing)]
        let lineText = NSAttributedString(string: "\n\n", attributes: spaceDict)
        
        
        //4.合并属性文字
        let mutableAttr = NSMutableAttributedString(attributedString: imageText)
        mutableAttr.append(lineText)
        mutableAttr.append(text)
        
        //5.将属性文本返回
        return mutableAttr.copy() as! NSAttributedString
    }
    
}

