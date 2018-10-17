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

class TouzhController: BaseController,UITableViewDataSource,UITableViewDelegate,CellBtnsDelegate,
TouzhuWindowDelegate,CaiPiaoTitleDelegate,PeilvCellDelegate,UITextFieldDelegate,TouzhuBottomDelegate{
    
    let PLAY_RULE_TABLVIEW_TAG = 0
    let PLAY_PANE_TABLEVIEW_TAG = 1
    var lotData:LotteryData?
    var ballonDatas:[BallonRules] = []
    let BALL_COUNT_PER_LINE = 6
    let BALL_COUNT_PER_LINE_WHEN_EXPAND = 8
    
    var playCode:String = ""
    var playName = ""
    var subCode:String = ""
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
    
    var selectModeIndex = 0;//金额模式，元模式
    var selectedBeishu = 1;//选择的倍数
    var selectedMoney = 0.0;//总投注金额,单位元
    var selectedMinBounds = 0.0;//最不奖金
    var selectedMinRateBack = 0.0;//最小返利率
    var selectedNumbers = "";//选择好的投注号码
    var calcOutZhushu = 0;//计算出来的注数
    var winExample = "";
    var detailDesc = "";
    var playMethod = "";
    var notPopLater = true
    
    var currentQihao:String = "";//当前期号
    var cpVersion:String = lottery_identify_V1;//cai piao version
    
    var touzhuWindow:TouzhuWindow!
    var titleBtn:UIButton!
//    var secTitleUI:UILabel!
    @IBOutlet weak var topShow: UIView!//顶部显示条
    
    var peilvOrderWindow:PeilvOrderWindow!
    
    @IBOutlet weak var openNumberView:UIView!
    @IBOutlet weak var currentQihaoUI:UILabel!
    @IBOutlet weak var numViews:BallsView!
    @IBOutlet weak var exceptionNumTV:UILabel!
    @IBOutlet weak var pullBar:UIButton!
    @IBOutlet weak var playRuleTableView:UITableView!
    @IBOutlet weak var playPaneTableView:UITableView!
    @IBOutlet weak var countDownUI:UILabel!
    @IBOutlet weak var balanceTV:UILabel!
    
    @IBOutlet weak var moneyInutArea:UIView!
    @IBOutlet weak var moneyInput:CustomFeildText!
    @IBOutlet weak var betBtnInArea:UIButton!
    @IBOutlet weak var ruleLabel:UILabel!
    @IBOutlet weak var ruleWidthConstrait:NSLayoutConstraint!
    @IBOutlet weak var peilvMoneyInputAreaHeightConstrait:NSLayoutConstraint!
    @IBOutlet weak var kaijianResultAreaHeightConstrait:NSLayoutConstraint!

    @IBOutlet weak var bottomView:TouzhuBottomView!
    @IBOutlet weak var bottomViewHeightConstrant:NSLayoutConstraint!
    
//    @IBOutlet weak var clearBtn:UIButton!
//    @IBOutlet weak var touZhuBtn:UIButton!
//    @IBOutlet weak var zhushuBtn:UIButton!
//    @IBOutlet weak var touzhuMoneyBtn:UIButton!
//    @IBOutlet weak var settingBtn:UIButton!
    
    @IBOutlet weak var playRuleLayoutConstraint:NSLayoutConstraint!
    @IBOutlet weak var playPaneLayoutConstraint:NSLayoutConstraint!
    
    var isPlayBarHidden = false
    var popMenu:SwiftPopMenu!
    let KSCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    var tag:Int = 1
    
    var popWindow:TitlePopWindow?//点标题栏弹出的彩种浮框
    
    var lastKaiJianResultTimer:Timer?//查询最后开奖结果的倒计时器
    var endlineTouzhuTimer:Timer?//距离停止下注倒计时器
    
    var peilvListDatas:[PeilvData] = []
    var pageIndex = 1
    var pageSize = 40
    var lhcSelect = false;//是否在奖金版本中选中了六合彩，十分六合彩
    var betMoneyWhenPeilv = ""//每注下注金额
    
    var totalPeilvMoney = 0;//总投注金额
//    var calcOutZhushu = 0;//计算出来的注数
    var calcPeilv:Float = 0;//计算出来的赔率
    var selectedPeilvNumbers:[PeilvPlayData] = []
    
    var isViewVisible = true
    var headerLabel:UILabel!//玩法栏列表的头部
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notPopLater = YiboPreference.getNotTipLaterWhenTouzhu()
        pullBar.addTarget(self, action: #selector(clickBar), for: .touchUpInside)
        pullBar.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        pullBar.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        pullBar.titleLabel?.numberOfLines = 0
        pullBar.setTitleColor(UIColor.init(hex: 0xF36664), for: .normal)
        pullBar.setTitleColor(UIColor.init(hex: 0xEF241D), for: .highlighted)
        
        betBtnInArea.layer.cornerRadius = 5
        betBtnInArea.addTarget(self, action: #selector(clickTouzhuBtn), for: .touchUpInside)
        moneyInput.addTarget(self, action: #selector(peilvTouzhuMoneyTextChange), for: UIControlEvents.editingChanged)
        moneyInput.delegate = self
        
        bottomView.delegate = self
        if isPeilvVersion() || isSixMark(lotCode: cpBianHao){
            self.bottomViewHeightConstrant.constant = 60
            bottomView.createView(controller: self, isPeilv:true)
        }else{
            self.bottomViewHeightConstrant.constant = 100
            bottomView.createView(controller: self, isPeilv:false)
        }
        
        playRuleTableView.delegate = self
        playRuleTableView.dataSource = self

        playPaneTableView.delegate = self
        playPaneTableView.dataSource = self
        
        
        openNumberView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onOpenNumberClick)))
        
        fillConstants()
        //init play rule txt in top of window
        initPlayRuleTable()
        //setup setting menu on right part of nav bar
        let moreBtn = UIBarButtonItem(title: "更多", style: UIBarButtonItemStyle.plain, target: self, action:#selector(showMenu))
        moreBtn.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = moreBtn
        
        //figure out default play rule balls when enter page
        if let data = self.lotData?.rules?[0]{
            self.handlePlayRuleClick(playData: data,subIndex: 0,cpCode: (self.lotData?.czCode)!)
        }
        self.customTitleView()
        lastOpenResult(cpBianHao:self.cpBianHao);//获取开奖结果
        getCountDownByCpcode(bianHao: self.cpBianHao, controller: self)//获取截止下注倒计时
        //自定义标题栏，方便控制下注倒计数
        if isPeilvVersion(){
            moneyInutArea.isHidden = false
            peilvMoneyInputAreaHeightConstrait.constant = 48
        }else{
            moneyInutArea.isHidden = true
            peilvMoneyInputAreaHeightConstrait.constant = 0
        }
        
        //当键盘弹起的时候会向系统发出一个通知，
        //这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        if let json = getSystemConfigFromJson(){
            if json.content != nil{
                let colorHex = json.content.touzhu_color
                setColor(color: UIColor.init(hexString: colorHex)!)
            }
        }
    }
    
    
    func setColor(color:UIColor) {
        pullBar.backgroundColor = color
        topShow.backgroundColor = color
        betBtnInArea.backgroundColor = color
        headerLabel.backgroundColor = color
//        bottomView.backgroundColor = color
    }
    
    //自定义标题栏，方便控制下注倒计数
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
    
    
    
    func peilvTouzhuMoneyTextChange(textField:UITextField)->Void{
        let s = textField.text
        if let svalue = s{
            if isEmptyString(str: svalue){
                self.betMoneyWhenPeilv = ""
                return
            }
            if svalue.count > 20{
                self.betMoneyWhenPeilv = ""
                showToast(view: self.view, txt: "输入金额过大")
                textField.text = ""
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
    
    func titleClickEvent(recongnizer:UIPanGestureRecognizer) -> Void {
        popWindow = Bundle.main.loadNibNamed("title_pop_window", owner: nil, options: nil)?.first as? TitlePopWindow
        popWindow?.cpDelegate = self
        popWindow?.show(lotCode: self.cpBianHao)
    }
    
    func onCaiPiaoClick(data: LotteryData?) {
        if let dataValue = data{
            if self.cpBianHao != dataValue.code{
                guard let newCode = dataValue.code else {
                    print("lot code empty")
                    return
                }
                YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
                self.lhcSelect = isSixMark(lotCode: newCode)
                if lhcSelect{
                    self.bottomViewHeightConstrant.constant = 60
                    bottomView.createView(controller: self, isPeilv:true)
                }else{
                    if isPeilvVersion(lotCode:newCode){
                        self.bottomViewHeightConstrant.constant = 60
                        bottomView.createView(controller: self, isPeilv:true)
                    }else{
                        self.bottomViewHeightConstrant.constant = 100
                        bottomView.createView(controller: self, isPeilv:false)
                    }
                }
            }
            if let codeValue = dataValue.code{
                syncLotteryPlaysByCode(lotteryCode: codeValue)
            }
        }
    }
    
    func onOpenNumberClick() -> Void {
        print("on open number click")
        openOpenResultController(controller: self, cpName: cpName, cpBianMa: cpBianHao, cpTypeCode: cpTypeCode)
    }
    
    func fillConstants() -> Void {
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
        if let lotCodeType = lotData?.czCode{
            self.cpTypeCode = lotCodeType
        }
        self.tickTime = self.ago + self.offset
    }
    
    
    //获取开奖结果
    func lastOpenResult(cpBianHao:String) -> Void {
        request(frontDialog: false, url:LOTTERY_LAST_RESULT_URL,params: ["code":cpBianHao],
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
    
    func endBetTickDown() -> Void {
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
                self.getCountDownByCpcode(bianHao: self.cpBianHao, controller: self)
            }
        }
    }
    
    func showToastTouzhuEndlineDialog(qihao:String) -> Void {
        
        if !isViewVisible{
            return
        }
        let message = String.init(format: "%@期的投注已截止，投注时请注意检查当前期号是否正确！", qihao)
        let alertController = UIAlertController(title: "温馨提示",
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            self.getCountDownByCpcode(bianHao: self.cpBianHao, controller: self)
        })
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.getCountDownByCpcode(bianHao: self.cpBianHao, controller: self)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func lastResultTickDown() -> Void {
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
        let cpVersion = YiboPreference.getVersion()
        
//        let ballWidth:CGFloat = 35
//        let totalBallWidth = ballWidth * CGFloat(haomaArr.count)
        let viewPlaceHoldWidth = (kScreenWidth*4)/5 - 30
//        //如果ballview占位宽度不大于实际号码宽度，则需要换行处理
//        if totalBallWidth > viewPlaceHoldWidth{
//            kaijianResultAreaHeightConstrait.constant = 80
//        }else{
//            kaijianResultAreaHeightConstrait.constant = 45
//        }
//        let haomaArr = firstResult.haoMa.components(separatedBy: ",");
        var ballWidth:CGFloat = 30
        var small = false
        if isSaiche(lotType: cpTypeCode){
            ballWidth = 20
        }else if isFFSSCai(lotType:self.cpTypeCode){
            ballWidth = 30
            small = false
        }
        numViews.isHidden = false
        exceptionNumTV.isHidden = true
        numViews.setupBalls(nums: haomaArr, offset: 0, lotTypeCode: self.cpTypeCode, cpVersion: cpVersion,viewPlaceHoldWidth:viewPlaceHoldWidth,ballWidth: ballWidth,small: small)
        //获取到开奖结果后，更新余额
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.accountWeb()
        }
    }
    
    func updateLastKaiJianExceptionResult(result:String) -> Void {
        numViews.isHidden = true
        exceptionNumTV.isHidden = false
        exceptionNumTV.text = result
    }
    
    func clickClearBtn() -> Void {
        if !isPeilvVersion(){
            if self.ballonDatas.isEmpty{
                showToast(view: self.view, txt: "请先选择号码!")
                return
            }
        }else{
            if self.selectedPeilvNumbers.isEmpty{
                showToast(view: self.view, txt: "请先选择号码!")
                return
            }
        }
        self.refreshPaneAndClean()
        showToast(view: self.view, txt: "清除成功")
    }
    
    func refreshPaneAndClean() -> Void {
        self.clearAfterBetSuccess()
    }
    
    func clickTouzhuBtn() -> Void {
        if isPeilvVersion(){
            //多选情况下才需要判断快捷金额框是否有金额
            if isMulSelectMode(playCode: self.playCode){
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
            showConfirmBetDialog()
//            doPeilvBet()
        }else{
            if isEmptyString(str: selectedNumbers) {
                showToast(view: self.view, txt: "请先选择号码")
                return;
            }
            if calcOutZhushu == 0{
                showToast(view: self.view, txt: "您还没有下注")
                return;
            }
            let data = AdjustData()
            data.money = self.selectedMoney
            data.beishu = self.selectedBeishu
            data.modeIndex = self.selectModeIndex
            onAdustResult(data: data, notPop: notPopLater)
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
                    
                    if isMulSelectMode(playCode: self.playCode){
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
                    self.realPeilvPostBets(betDatas: selectedDatas, mulSelect:  isMulSelectMode(playCode: self.playCode), money:money)
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
                if isLianMa(playCode: self.playCode){
                    if betDatas.count > 10{
                        showToast(view: self.view, txt: "选球数不能超过10位")
                        return
                    }
                }
                //若是全不中玩法，则所选号码不能大于各子玩法指定的数
                if isQuanBuZhong(playCode: self.playCode){
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
                print("playcode ===== \(playCode)")
                let webResult = getPeilvDataInCommon(lotCode: cpBianHao, playCode: playCode, selectCount: betDatas.count, data: pData)
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
            params["playCode"] = subCode as AnyObject
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
                let webResult = getPeilvDataInCommon(lotCode: cpBianHao, playCode: playCode, selectCount: betDatas.count, data: pData)
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
            postData["groupCode"] = playCode as AnyObject
            postData["playCode"] = subCode as AnyObject
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
                            self.accountWeb()
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
    
    //确认投注框
    func showConfirmBetDialog() -> Void {
        let alertController = UIAlertController(title: "温馨提示",
                                                message: "是否提交下注？", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            
        })
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            self.doPeilvBet()
        })
        alertController.addAction(viewAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
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
    
    func showMenu() -> Void {
        //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
        popMenu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 150-5, y: 56, width: 150, height: 250), arrowMargin: 18)
        
        let list = [(icon:"1",title:"投注记录"),
                    (icon:"2",title:"历史开奖"),
                    (icon:"3",title:"玩法说明"),
                    (icon:"4",title:"今日输赢"),
                    (icon:"5",title:"设置")]
//        if isPeilvVersion(){
//            list.remove(at: 3)
//        }
        popMenu.popData = list
        //点击菜单
        popMenu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.popMenu.dismiss()
            print("block select \(index)")
            self?.onPopListClick(index: index)
        }
        popMenu.show()
        tag += 1
    }
    
    
    
    func onPopListClick(index:Int) -> Void {
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
//            if isPeilvVersion(){
//                openSetting(controller: self)
                //同步今日输赢数据
                self.syncWinLost()
//            }else{
//                actionBraveZuihao()
//                openBraveZuiHaoPage(controller: self)
//            }
//            showToast(view: self.view, txt: "敬请期待")
        case 4:
//            if isPeilvVersion(){
                openSetting(controller: self)
//            } else{
//                //同步今日输赢数据
//                self.syncWinLost()
//            }
        case 5:
//            if !isPeilvVersion(){
//                openSetting(controller: self)
//            }
            break
        default:
            break
        }
    }
    
    func actionBraveZuihao() -> Void {
        //orderd
        if self.calcOutZhushu == 0{
            showToast(view: self.view, txt: "请选择正确的投注号码")
            return
        }
        if isEmptyString(str: self.selectedNumbers){
            showToast(view: self.view, txt: "投注号码不正确，请重新投注")
            return
        }
        let orderInfo = addZhuDang()
        var datas = [OrderDataInfo]()
        datas.append(orderInfo)
        openBraveZuiHaoPage(controller: self,order: datas,lotCode: cpBianHao,lotName: self.cpName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("the hidden status = \(isPlayBarHidden)")
        isViewVisible = true
        updatePlayRuleConstraint(isHidden: isPlayBarHidden)
        accountWeb()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isViewVisible = false
        YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
    }
    
    func initPlayRuleTable() -> Void {
        self.playRuleTableView!.delegate = self
        self.playRuleTableView!.dataSource = self
        //创建表头标签
        headerLabel = UILabel(frame: CGRect(x:0, y:0,
                                                width:self.view.bounds.size.width, height:20))
        headerLabel.backgroundColor = UIColor(red: 254/255, green: 224/255, blue: 219/255, alpha: 1)
        headerLabel.textColor = UIColor.white
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.lineBreakMode = .byWordWrapping
        updatePlayListHeader(txt: "玩法选择")
        headerLabel.textColor = UIColor.red
        headerLabel.font = UIFont.italicSystemFont(ofSize: 14)
        self.playRuleTableView!.tableHeaderView = headerLabel
    }
    
    func updatePlayListHeader(txt:String) -> Void {
        headerLabel.text = txt
    }
    
    func clickBar() -> Void {
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
        }) { (finished) in
            self.updatePlayRuleConstraint(isHidden: self.isPlayBarHidden)
        }
    }
    
    func updatePlayRuleConstraint(isHidden:Bool) -> Void {
        let attrStr = NSAttributedString.imageTextInit(image: UIImage(named: isPlayBarHidden ? "pull_forward_icon" : "pull_bar_icon")!, imageW: 18, imageH: 9, labelTitle: isPlayBarHidden ? "点击展开玩法栏" : "点击隐藏玩法栏", fontSize: 12, titleColor: UIColor.lightGray, labelSpacing: 4)
        //设置按钮基本属性
        pullBar.titleLabel?.textAlignment = .center
        pullBar.titleLabel?.numberOfLines = 0
        pullBar.setAttributedTitle(attrStr, for: .normal)
//        pullBar.setTitle(isPlayBarHidden ? ">>点击展开玩法栏" : "<<点击隐藏玩法栏", for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.isPlayBarHidden = false
//        self.ballonDatas.removeAll()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            if let rules = lotData?.rules{
                let playItem = rules[section]
                return playItem.rules.count
            }
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
            let section = indexPath.section
            let subRules = self.lotData?.rules![section]
            if !(subRules?.rules.isEmpty)!{
                cell.textLabel!.text = subRules?.rules[indexPath.row].name
                cell.textLabel!.textAlignment = NSTextAlignment.center
                cell.textLabel!.font = UIFont.italicSystemFont(ofSize: 12)
            }
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
                //左导航栏是否隐藏
                cell.isPlayBarHidden = isPlayBarHidden
                cell.cellDelegate = self
                if !self.peilvListDatas.isEmpty{
                    if indexPath.row >= self.peilvListDatas.count{
                        return cell
                    }
                    let data = self.peilvListDatas[indexPath.row]
                    print("data count = ",data.tagName)
                    cell.tagUI.text = data.tagName
                    cell.setupViewAccordingData(peilvData: data,playPaneIsShow: !isPlayBarHidden,playCode: self.playCode,row:indexPath.row,cpCode:self.cpTypeCode,cpVersion:self.cpVersion)
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
            if let data = self.lotData?.rules?[indexPath.section]{
                self.handlePlayRuleClick(playData: data,subIndex: indexPath.row,cpCode: (self.lotData?.czCode)!)
            }
        }
    }
    
    func handlePlayRuleClick(playData:PlayItem?,subIndex:Int,cpCode:String) -> Void {
        if let data = playData{
//            ruleLabel.text = data.name + "-" + data.rules[subIndex].name
            ruleLabel.text = data.rules[subIndex].name
            if !isPeilvVersion(){
                self.updatePlayListHeader(txt: data.rules[subIndex].name)
            }
            //当切换其他玩法时，将保存的下注注单清空
            if !isPeilvVersion() && (data.code != self.playCode || data.rules[subIndex].code != self.subCode){
                YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
            }
            self.playCode = data.code
            self.playName = data.name
            self.subCode = data.rules[subIndex].code
            self.subPlayName = data.rules[subIndex].name
            self.selectedMinBounds = Double(data.rules[subIndex].minBonusOdds)
            self.selectedMinRateBack = Double(data.rules[subIndex].minRakeback)
            self.winExample = data.rules[subIndex].winExample
            self.detailDesc = data.rules[subIndex].detailDesc
            self.playMethod = data.rules[subIndex].playMethod
            
            if !isPeilvVersion(){
                //figure out play ballons
                clearBottomValue()
                let ballonRules = calcPaneMessageByPlayRule(cpVersion: YiboPreference.getVersion(), cpCode: cpCode, playCode: data.code, ruleCode: data.rules[subIndex].code)
                ballonDatas.removeAll()
                self.ballonDatas = self.ballonDatas + ballonRules
                self.playPaneTableView.reloadData()
                self.scrollToTop()
            }else{
                //figure out peilv play ballons. we get peilv first
                getPeilvData(lotCategoryType: cpTypeCode, subPlayCode: subCode, showDialog: true)
            }
        }
    }
    
    func scrollToTop() -> Void{
        if ballonDatas.isEmpty{
            return
        }
        if isPeilvVersion(){
            if self.peilvListDatas.isEmpty{
                return
            }
        }
        self.playPaneTableView.scrollToRow(at: IndexPath.init(item: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
    }
    
    func isPeilvVersion() ->  Bool{
        let versionFromWeb = YiboPreference.getVersion()
        if versionFromWeb == lottery_identify_V2 || versionFromWeb == lottery_identify_V4 ||
            versionFromWeb == lottery_identify_V5 || lhcSelect || isSixMark(lotCode: self.cpBianHao){
            return true
        }
        return false
    }
    
    func isPeilvVersion(lotCode:String) ->  Bool{
        let versionFromWeb = YiboPreference.getVersion()
        if versionFromWeb == lottery_identify_V2 || versionFromWeb == lottery_identify_V4 ||
            versionFromWeb == lottery_identify_V5 || lhcSelect || isSixMark(lotCode: lotCode){
            return true
        }
        return false
    }
    
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
    
    func clearBottomValue() -> Void {
//        zhushuBtn.setTitle("0注", for: .normal)
//        touzhuMoneyBtn.setTitle("0元", for: .normal)
        calcOutZhushu = 0;
        selectModeIndex = 0;
        selectedBeishu = 1;//选择的倍数
        selectedMoney = 0;//总投注金额
//        selectedMinBounds = 0;
//        selectedMinRateBack = 0;
        selectedNumbers="";//选择好的投注号码
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
        responseTouzhu(selectedDatas: ballonDatas, cpVersion: YiboPreference.getVersion(),
                       czCode: self.czCode, playCode: self.playCode, subCode: self.subCode, isRandom: false,cellPos: cellPos)
    }
    
    /**
     * 投注动作
     * @param selectedDatas 非机选投注时，用户已经选择完投注球的球列表数据
     * @param cpVersion 彩票版本
     * @param czCode 彩种代号
     * @param playCode 大玩法
     * @param subCode 小玩法
     * @param isRandom 是否机选
     * @param cellPos 点击的位置
     */
    func responseTouzhu(selectedDatas:[BallonRules],cpVersion:String,
                        czCode:String,playCode:String,
                        subCode:String,isRandom:Bool,cellPos:Int = -1) -> Void{
        
        DispatchQueue.global().async {
            //calculate touzhu count
            // if this operation is shake phone which mean random touzhu.
            // we perform a random number selecting
            var numbers:String = ""
            if isRandom{
                let ballonsAfterRandomSelect = LotteryPlayLogic.selectRandomDatas(cpVersion: cpVersion, czCode: czCode, playCode: playCode, subCode: subCode)
                if !ballonsAfterRandomSelect.isEmpty{
                    self.ballonDatas.removeAll()
                    self.ballonDatas = self.ballonDatas + ballonsAfterRandomSelect
                    numbers = LotteryPlayLogic.figureOutNumbersAfterUserSelected(listBeenSelected: self.ballonDatas, playCode: playCode, subPlayCode: subCode)
                }
            }else{
                numbers = LotteryPlayLogic.figureOutNumbersAfterUserSelected(listBeenSelected: selectedDatas, playCode: playCode, subPlayCode: subCode)
            }
            
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
                if isRandom {
//                    sendEmptyMessage(SEND_BALLON_VIEW_FOUND);
                    if cellPos == -1{
                        self.playPaneTableView.reloadData()
                    }else{
                        self.playPaneTableView.reloadRows(at: [IndexPath.init(item: cellPos, section: 0)], with: UITableViewRowAnimation.none)
                    }
                }
                //有注数时则弹出注单浮框,让用户调整注单并投注
                if zhushu > 0 {
                    self.showAdjustWindow(shouDong:false);
                }
            }
        }
        
    }
    
    
    func showPopupWindowWhenClickBtns() -> Void {
        if !isPeilvVersion(){
            showAdjustWindow(shouDong: true)
        }else{
            showPeilvOrderWindow()
        }
    }
    
    func showPeilvOrderWindow() -> Void {
        if selectedPeilvNumbers.isEmpty {
            showToast(view: self.view, txt: "请先选择号码")
            return;
        }
        if peilvOrderWindow == nil{
            peilvOrderWindow = Bundle.main.loadNibNamed("peilv_order_window", owner: nil, options: nil)?.first as! PeilvOrderWindow
        }
        var totalMoney = 0
        if !isEmptyString(str: self.betMoneyWhenPeilv){
            totalMoney = self.calcOutZhushu * Int(self.betMoneyWhenPeilv)!
        }
        peilvOrderWindow.setData(order: selectedPeilvNumbers, currentQihao: currentQihao, calZhushu: calcOutZhushu, calcPeilv: calcPeilv, totalMoney: Float(totalMoney), playName: playName, subName: subPlayName)
        peilvOrderWindow.show() 
    }
    
    func showAdjustWindow(shouDong:Bool) -> Void {
        if !shouDong {
            if notPopLater{
                return
            }
        }
        if isEmptyString(str: selectedNumbers) {
            showToast(view: self.view, txt: "请先选择号码")
            return;
        }
        if touzhuWindow == nil{
            touzhuWindow = Bundle.main.loadNibNamed("TouzhuWindow", owner: nil, options: nil)?.first as! TouzhuWindow
            touzhuWindow._delegate = self
        }
        let adjustData = AdjustData()
        adjustData.beishu = self.selectedBeishu
        adjustData.money = self.selectedMoney
        adjustData.zhushu = self.calcOutZhushu
        adjustData.modeIndex = self.selectModeIndex
        adjustData.jianjian = self.selectedMinBounds
        adjustData.maxRakeRate = self.selectedMinRateBack
        adjustData.basicMoney = 2
        adjustData.calcZhushu = self.calcOutZhushu
        touzhuWindow.setData(data: adjustData,notTipLater:self.notPopLater)
        touzhuWindow.show()
    }
    
    func onCancelClick(notPop:Bool) {
        self.notPopLater = notPop
        YiboPreference.saveNotTipLaterWhenTouzhu(value: self.notPopLater as AnyObject)
        touzhuWindow.dismiss()
    }
    
    func onAdustResult(data:AdjustData,notPop:Bool) {
        self.notPopLater = notPop
        self.selectedMoney = data.money
        self.selectedBeishu = data.beishu
        self.selectModeIndex = data.modeIndex
//        touzhuMoneyBtn.setTitle(String.init(format: "%.2f元", selectedMoney), for: .normal)
        
        let order = addZhuDang()
        openConfirmTouzhu(controller: self, data: order,lotCode: self.cpBianHao,lotName: self.cpName,playName: self.playName,playCode: self.playCode,subPlayCode: self.subCode,subPlayName: self.subPlayName,cpTypeCode: self.cpTypeCode)
        //注单浮框的投注点击后 ，将注单信息添加到数据库，然后直接投注
//        actionJianjinTouzhu(order: addZhuDang())
        if !isPeilvVersion(){
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
            self.playPaneTableView.reloadData()
            clearBottomValue()
        }
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
    
    func addZhuDang() -> OrderDataInfo {
        let orderInfo = OrderDataInfo()
        orderInfo.playName = playName
        orderInfo.subPlayName = subPlayName
        orderInfo.playCode = playCode
        orderInfo.subPlayCode = subCode
        orderInfo.beishu = selectedBeishu
        orderInfo.zhushu = calcOutZhushu
        orderInfo.money = selectedMoney
        orderInfo.numbers = selectedNumbers
        orderInfo.cpCode = cpBianHao
        orderInfo.lotcode = cpBianHao
        if (selectModeIndex == 0) {
            orderInfo.mode = YUAN_MODE
        } else if (selectModeIndex == 1) {
            orderInfo.mode = JIAO_MODE
        } else if (selectModeIndex == 2) {
            orderInfo.mode = FEN_MODE
        }
        return orderInfo
    }
    
    func updateBottomUI(totalMoney:Int) -> Void {
        if !isPeilvVersion(){
            bottomView.updateBottomDetail(zhushu: self.calcOutZhushu, money: Float(self.selectedMoney), rate: Float(self.selectedMinBounds))
        }else{
            bottomView.updateBottomDetail(zhushu: self.calcOutZhushu, money: Float(totalMoney > 0 ? totalMoney : self.totalPeilvMoney), rate: 0)
//            zhushuBtn.setTitle(String.init(format: "%d注", self.calcOutZhushu), for: .normal)
//            touzhuMoneyBtn.setTitle(String.init(format: "%d元", totalMoney > 0 ? totalMoney : self.totalPeilvMoney), for: .normal)
        }
    }
    
    func updatePeilvLabel(peilv:String,show:Bool){
        if show{
//            settingBtn.setTitle(peilv, for: .normal)
            bottomView.updateBottomPeilv(peilv: peilv)
        }else{
//            settingBtn.setTitle(String.init(format: "查看", peilv), for: .normal)
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
    
    //根据彩票编码获取所应的玩法数据
    func syncLotteryPlaysByCode(lotteryCode:String) -> Void {
        request(frontDialog: true, loadTextStr:"获取玩法中", url:GAME_PLAYS_URL,params:["lotCode":lotteryCode],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = LotPlayWraper.deserialize(from: resultJson){
                        if result.success{
                            if let lotteryPlayValue = result.content{
                                self.lotData = lotteryPlayValue
                                self.fillConstants()
                                self.titleBtn.setTitle(self.lotData?.name, for: .normal)
                                self.playRuleTableView.reloadData()
                                //figure out default play rule balls when enter page
                                if let data = self.lotData?.rules?[0]{
                                    self.handlePlayRuleClick(playData: data,subIndex: 0,cpCode: (self.lotData?.czCode)!)
                                }
                                self.lastOpenResult(cpBianHao:self.cpBianHao);//获取开奖结果
                                self.getCountDownByCpcode(bianHao: self.cpBianHao, controller: self)//获取截止下注倒计时
                                //如果是赔率投注，则显示金额输入区
                                if self.isPeilvVersion(){
                                    self.moneyInutArea.isHidden = false
                                    self.peilvMoneyInputAreaHeightConstrait.constant = 48
                                }else{
                                    self.moneyInutArea.isHidden = true
                                    self.peilvMoneyInputAreaHeightConstrait.constant = 0
                                }
                            }
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                        }
                    }
        })
    }
    
    /**
     * 开始获取当前期号离结束投注倒计时
     * @param bianHao 彩种编号
     */
    func getCountDownByCpcode(bianHao:String,controller:BaseController) -> Void {
        request(frontDialog: false, url:LOTTERY_COUNTDOWN_URL,params:["lotCode":bianHao],
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
    
    func onShakeStart(info:NSNotification)->Void{
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
        playVolumeWhenStartShake()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    func onEndShake(info:NSNotification)->Void{
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
        playVolumeWhenEndShake()
        //选择球的时候清除本地已选择的金额，倍数，注数等
        clearBottomValue()
        //开始计算投注号码串及注数
        responseTouzhu(selectedDatas: ballonDatas, cpVersion: YiboPreference.getVersion(), czCode: self.czCode, playCode: self.playCode, subCode: self.subCode, isRandom: true)
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
                            if isLianMaOrQuanbuZhong(playCode: self.playCode){
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
    
    
    //#mark bottom touzhu delegate
    func onClearOrRandomClick(zhushu:Int) {
        if self.calcOutZhushu > 0{
            clickClearBtn()
        }else{
            //开始计算投注号码串及注数
            responseTouzhu(selectedDatas: ballonDatas, cpVersion: YiboPreference.getVersion(),
                           czCode: self.czCode, playCode: self.playCode, subCode: self.subCode, isRandom: true,cellPos: -1)
        }
    }
    
    func onConfirm() {
        if !isPeilvVersion(){
            self.selectedMoney = Double(bottomView.money)
            self.selectedBeishu = bottomView.beishu
            self.selectModeIndex = bottomView.selectModeIndex
        }
        clickTouzhuBtn()
    }
    
    func onViewOrder() {
        self.showPopupWindowWhenClickBtns()
    }
    
    func onHistory() {
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
        let verion = isPeilvVersion() ? lottery_identify_V2 : YiboPreference.getVersion()
        if isEmptyString(str: verion) || isEmptyString(str: cpBianHao) ||
            isEmptyString(str: playCode) || isEmptyString(str: subCode){
            return
        }
        let resultDatas:[PeilvData] = figureOutPeilvPlayInfo(cpVersion: verion, cpCode: cpTypeCode, playCode: playCode, ruleCode: subCode, pageIndex: pageIndex, pageSize: pageSize, webResults: result)
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
    
    
    /**
     * 计算出对应玩法下的号码及赔率面板区域显示数据
     * @param cpVersion 彩票版本
     * @param cpCode 彩票类型代号
     * @param playCode 大玩法代号
     * @param subPlayCode 小玩法代号
     * @param pageIndex 页码
     * @param pageSize 每页大小
     * @param appendData 是否将计算出来的数据追加到原有数据后面
     * @param peilvWebResults 后台获取到的玩法对应的赔率数据
     */
    func figurePeilvPlayDatas(cpVersion:String,cpCode:String,playCode:String,
                              subCode:String,pageIndex:Int,pageSize:Int,appendData:Bool,
                              peilvWebResults:[PeilvWebResult]) -> Void {
        
        let data = figureOutPeilvPlayInfo(cpVersion: cpVersion, cpCode: cpCode, playCode: playCode, ruleCode: subCode, pageIndex: pageIndex, pageSize: pageSize, webResults: peilvWebResults)
        
        if data.isEmpty{
            self.peilvListDatas.removeAll()
            self.playPaneTableView.reloadData()
            return
        }
        if !appendData{
            self.peilvListDatas.removeAll()
            self.peilvListDatas = self.peilvListDatas + data
            self.playPaneTableView.reloadData()
        }else{
            if data.count == self.peilvListDatas.count{
                for index in 0...data.count-1{
                    let item = data[index]
                    let subData = item.subData
                    self.peilvListDatas[index].subData = self.peilvListDatas[index].subData + subData
                }
            }
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
            let webResult = getPeilvDataInCommon(lotCode: self.cpBianHao, playCode: self.playCode, selectCount: selectDatas.count, data: pData)
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
                        let rightWebResult = getPeilvDataInCommon(lotCode: self.cpBianHao, playCode: self.playCode, selectCount: selectDatas.count, data: selectDatas[0])
                        if let result = rightWebResult{
                            print("the peilv vaule when select one item === \(result.odds)")
                            if !dontShowPeilvWhenTouzhu(playCode: self.playCode){
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
    
    func accountWeb() -> Void {
        //帐户相关信息
        request(frontDialog: false, url:MEMINFO_URL,
           callback: {(resultJson:String,resultStatus:Bool)->Void in
            if !resultStatus {
                return
            }
            if let result = MemInfoWraper.deserialize(from: resultJson){
                if result.success{
                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                    if let memInfo = result.content{
                        //更新帐户名，余额等信息
                        self.updateAccount(memInfo:memInfo);
                    }
                }
            }
        })
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = String.init(format: "%.2f", Double(memInfo.balance)!)
        }else{
            leftMoneyName = "0"
        }
        balanceTV.text = String.init(format: "余额:%@元",  leftMoneyName)
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
        let titleDict = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize), NSForegroundColorAttributeName: titleColor]
        let text = NSAttributedString(string: labelTitle, attributes: titleDict)
        
        //3.换行文本可以让label长度不够时自动换行
        let spaceDict = [NSFontAttributeName:UIFont.systemFont(ofSize: labelSpacing)]
        let lineText = NSAttributedString(string: "\n\n", attributes: spaceDict)
        
        
        //4.合并属性文字
        let mutableAttr = NSMutableAttributedString(attributedString: imageText)
        mutableAttr.append(lineText)
        mutableAttr.append(text)
        
        //5.将属性文本返回
        return mutableAttr.copy() as! NSAttributedString
    }
    
}

