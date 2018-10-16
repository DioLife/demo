//
//  BraveZuihaoController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/8.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//智能追号
class BraveZuihaoController: BaseController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ZuihaoMenuBarDelegate {
    
    
    @IBOutlet weak var multipleBgView: UIView!
    @IBOutlet weak var perBeiViewConstraint:NSLayoutConstraint!
    @IBOutlet weak var startBeishuConstraint:NSLayoutConstraint!
    @IBOutlet weak var multiBeishuConstraint:NSLayoutConstraint!
    @IBOutlet weak var multiTxt:UILabel!
    @IBOutlet weak var zuihaoMenu:ZuihaoMenuView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var totalQishuUI:UILabel!
    @IBOutlet weak var goonZuihaoSwitch:UIButton!
    @IBOutlet weak var totalMoneyUI:UILabel!
    @IBOutlet weak var jianBtn:UIButton!
    @IBOutlet weak var totalQishuInput:CustomFeildText!
    @IBOutlet weak var addBtn:UIButton!
    @IBOutlet weak var touzhuBtn:UIButton!
    var datas:[ZuihaoListData] = []
    
    @IBOutlet weak var perBeishuInput:CustomFeildText!
    @IBOutlet weak var multipleBeishuInput:CustomFeildText!
    @IBOutlet weak var startBeishuInput:CustomFeildText!
    
    var meminfo:Meminfo?
    var accountBanlance = 0.0
    var totalTouzhuFee:Float = 0;//总追号投注金额
    var totalBaseMoney:Float = 0;//单位元
    var maxQishu = 0;//可追号最大期数
    var qihaos:[Int64] = [];
    var cpBianma:String = "";//彩票编号
    var cpLotName = ""
    var cpVersion = ""
    var lotteryicon = "";//icon
    var cptype = ""//lottery type code
    var orderInfo:[OrderDataInfo]?
    
//    var initBeishu = 1;
    var totalQishu = 10
    var initQishu = 10;
    
    var popMenu:SwiftPopMenu!
    let KSCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    var tag:Int = 1
    var currentPage = 0
    
    var titleBtn:UIButton!
    var secTitleUI:UILabel!
    var currentQihao = ""
    var endlineTouzhuTimer:Timer?//距离停止下注倒计时器
    let offset:Int = 1//偏差1秒
    var tickTime:Int64 = 0////倒计时查询最后开奖的倒计时时间
    var endBetDuration:Int = 0;//秒
    var endBetTime:Int = 0//距离停止下注的时间
    var timeoutQishuList:Set<String>!//在用户投注之前已经过期的期号
    
    var startBeishu = 1
    var beishuMultiple = 2
    var perItemBeishu = 1
    
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        setupNoPictureAlphaBgView(view: self.multipleBgView)
        
        accountWeb()
        
        self.navigationItem.title = "智能追号"
        let moreBtn = UIBarButtonItem(title: "更多", style: UIBarButtonItemStyle.plain, target: self, action:#selector(showMenu))
        moreBtn.theme_tintColor = "Global.barTextColor"
        self.navigationItem.rightBarButtonItem = moreBtn
        
        timeoutQishuList = Set<String>()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        if let info = self.orderInfo{
            totalBaseMoney = self.getTotalMoneyOfSelectedZhudang(order: info)
        }
        let maskPath = UIBezierPath(roundedRect: jianBtn.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 15, height: 15))
        let jianMaskLayer = CAShapeLayer()
        jianMaskLayer.frame = jianBtn.bounds
        jianMaskLayer.path = maskPath.cgPath
        jianBtn.layer.mask = jianMaskLayer
        
        let addMaskPath = UIBezierPath(roundedRect: addBtn.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        let addMaskLayer = CAShapeLayer()
        addMaskLayer.frame = addBtn.bounds
        addMaskLayer.path = addMaskPath.cgPath
        addBtn.layer.mask = addMaskLayer
        //开始当前期数倒计时
        getCountDownByCpcode(bianHao: self.cpBianma,cpVersion: self.cpVersion, controller: self)//获取截止下注倒计时
        //自定义标题栏，方便控制下注倒计数
//        self.customTitleView()
        self.navigationItem.title = cpLotName
        self.actionGetValidQishu(lotCode: cpBianma)
        
        self.addBtn.addTarget(self, action: #selector(onAddClick), for: .touchUpInside)
        self.jianBtn.addTarget(self, action: #selector(onJianClick), for: .touchUpInside)
        self.touzhuBtn.addTarget(self, action: #selector(onTouzhuClick), for: .touchUpInside)
        
        self.totalQishuInput.addTarget(self, action: #selector(onTotalQishuInputEvent), for: UIControlEvents.editingChanged)
        
        self.perBeishuInput.delegate = self
        self.multipleBeishuInput.delegate = self
        self.startBeishuInput.delegate = self
        
        self.perBeishuInput.addTarget(self, action: #selector(adjustBeishuViewEvent(view:)), for: UIControlEvents.editingChanged)
        perBeishuInput.tag = 100
        self.multipleBeishuInput.addTarget(self, action: #selector(adjustBeishuViewEvent(view:)), for: UIControlEvents.editingChanged)
        multipleBeishuInput.tag = 101
        self.startBeishuInput.addTarget(self, action: #selector(adjustBeishuViewEvent(view:)), for: UIControlEvents.editingChanged)
        startBeishuInput.tag = 102
        
        touzhuBtn.layer.cornerRadius = 3
        goonZuihaoSwitch.addTarget(self, action: #selector(goonZuihao(sender:)), for: .touchUpInside)
        goonZuihaoSwitch.theme_setImage("Global.Login_Register.rememberCheckboxNormal", forState: .normal)
        goonZuihaoSwitch.theme_setImage("Global.Login_Register.rememberCheckboxSelected", forState: .selected)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
//        //当键盘收起的时候会向系统发出一个通知，
//        //这个时候需要注册另外一个监听器响应该通知
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        zuihaoMenu.menuBarDelegate = self
    }
    
    @objc func goonZuihao(sender:UIButton){
        goonZuihaoSwitch.isSelected = !sender.isSelected
    }
    
    func onMenuItemClick(itemTag: Int) {
        print("itemtag = ",itemTag)
        self.currentPage = itemTag
        if itemTag == 0{
            startBeishuConstraint.constant = 0
            perBeiViewConstraint.constant = 0
            multiTxt.isHidden = false
            perBeishuInput.isEnabled = true
//            perBeishuInput.backgroundColor = UIColor.white
            perBeishuInput.textColor = UIColor.black
        }else{
            startBeishuConstraint.constant = kScreenWidth/6
            perBeiViewConstraint.constant = kScreenWidth/6
            multiTxt.isHidden = true
            perBeishuInput.isEnabled = false
//            perBeishuInput.backgroundColor = UIColor.lightGray
            perBeishuInput.textColor = UIColor.white
        }
        
        DispatchQueue.global().async {
            //根据后台返回的可用期数及当前要显示的期数，构造追号列表显示数据
            var list = [ZuihaoListData]()
            var currentTouzhuFee:Float = 0
            if self.qihaos.isEmpty{
                return
            }
            for index in 0...self.qihaos.count-1{
                if index < self.totalQishu{
                    let zuihaoListData = ZuihaoListData()
                    let beishu = self.calcBeishuWithMultipleMode(index: index)
                    zuihaoListData.beishu = beishu
                    zuihaoListData.touZhuMoney = self.totalBaseMoney*Float(beishu)
                    zuihaoListData.qihao = String.init(describing: self.qihaos[index])
                    list.append(zuihaoListData)
                    currentTouzhuFee = currentTouzhuFee + zuihaoListData.touZhuMoney
                }
            }
            //同步追号列表数据和金额到主UI
            DispatchQueue.main.async {
                if !list.isEmpty{
                    self.datas.removeAll()
                    self.datas = self.datas + list
                }
                self.refreshList()
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
                                //更新余额等信息
                                self.meminfo = memInfo
                                
                                
                                if !isEmptyString(str: memInfo.balance){
                                    let leftMoneyName = "\(memInfo.balance)"
                                    if let value = Double(leftMoneyName) {
                                        self.accountBanlance = value
                                    }
                                }
                                
                            }
                        }
                    }
        })
    }
    
    @objc func onTouzhuClick() -> Void {
//        let hasAskBeforeTouzhu = YiboPreference.getAskBeforeZuihao()
//        if !hasAskBeforeTouzhu{
        
        let accoundMode = YiboPreference.getAccountMode()
       if accountBanlance < Double(totalTouzhuFee) && accoundMode != 4{
            openChargeMoney(controller: self, meminfo: self.meminfo)
            showToast(view: self.view, txt: "余额不足，请充值")
            return
        }
        
        
            showAskForTouzhuDialog()
//            return
//        }
//        actionZuihao()
    }
    
    @objc func actionZuihao() -> Void {
        doBet()
    }
    
    func doBet(){
        if self.datas.isEmpty{
            showToast(view: self.view, txt: "您还没有选择下注号码！")
            return
        }
        var postData:Dictionary<String,AnyObject> = [:]
        //构造下注POST数据
        var bets = [Dictionary<String,AnyObject>]()
        guard let order_info = self.orderInfo else {return}
        for order in order_info{
            var bet = Dictionary<String,AnyObject>()
            bet["i"] = order.oddsCode as AnyObject
            bet["c"] = order.numbers as AnyObject
            bet["n"] = order.zhushu as AnyObject
            bet["t"] = order.beishu as AnyObject
            bet["k"] = order.rate as AnyObject
            bet["m"] = order.mode as AnyObject
            bet["a"] = order.money as AnyObject
            bets.append(bet)
        }
        postData["stopAfterWin"] = goonZuihaoSwitch.isSelected as AnyObject
        postData["lotCode"] = self.cpBianma as AnyObject
        postData["qiHao"] = "" as AnyObject
        postData["data"] = bets as AnyObject
        
        //准备追号数据
        if !datas.isEmpty{
            var betDatas:[ZuihaoListData] = []
            for i in 0...datas.count - 1{
                let data = datas[i]
                var isInvalid = false
                //投注时过滤过期的期号
                for invalid in timeoutQishuList{
                    if data.qihao == invalid{
                        isInvalid = true
                        break
                    }
                }
                if isInvalid{
                    continue
                }
                betDatas.append(data)
            }
            
            var periodArray = [Dictionary<String,AnyObject>]()
            for data in betDatas{
                var bet = Dictionary<String,AnyObject>()
                bet["times"] = data.beishu as AnyObject
                bet["qiHao"] = data.qihao as AnyObject
                periodArray.append(bet)
            }
            postData["zuihaoList"] = periodArray as AnyObject
        }
        if (JSONSerialization.isValidJSONObject(postData)) {
            let data : NSData! = try? JSONSerialization.data(withJSONObject: postData, options: []) as NSData
            let str = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
            //do bet
            request(frontDialog: true, method: .post, loadTextStr: "正在下注...", url:DO_BETS_URL,params: ["data":str!],
                    callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "下注失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = DoBetWrapper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                self.datas.removeAll()
                                self.timeoutQishuList.removeAll()
                                self.tableView.reloadData()
                                YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
                                
                                //saveCurrentLotData()
                                self.showBetSuccessDialog()
                                
                                
                                ///MARK: 222 记录用户访问痕迹 到数据库
                                let resultArr:[VisitRecords] = WHC_ModelSqlite.query(VisitRecords.self, where: "cpBianHao = '\(self.cpBianma)'") as! [VisitRecords]
                                if resultArr.count == 0 {
                                    let record:VisitRecords = VisitRecords()
                                    record.cpName = self.cpLotName //名字
                                    record.czCode = self.cptype //类型
                                    record.ago = "0" // 时间差 传默认值
                                    record.cpBianHao = self.cpBianma //编号
                                    record.lotType = self.cptype//类型
                                    record.lotVersion = self.cpVersion //版本
                                    record.num = "1"
                                    WHC_ModelSqlite.insert(record)
                                }else{
                                    let record:VisitRecords = resultArr[0]
                                    let bianhao:String = record.cpBianHao!
                                    var num:Int = Int(record.num!)!
                                    num += 1
                                    let num2:String = String(num)
                                    WHC_ModelSqlite.update(VisitRecords.self, value: "num = '\(num2)'", where: "cpBianHao = '\(bianhao)'")
                                }
                                //        print(cpBianHao, cpName)
                                print("this is touzhu click button!!! ============== go here!!!!!!!")
                                let allData:[VisitRecords] = WHC_ModelSqlite.query(VisitRecords.self, where: nil) as! [VisitRecords]
                                for item in allData {
                                    print(item.cpName!,"\t\t\t",item.czCode!,"\t",item.ago!,"\t",item.cpBianHao!,"\t",item.lotType!,"\t",item.lotVersion!,"\t\t\t\t",item.num!)
                                }
                                
                            }else{
                                if !isEmptyString(str: result.msg){
                                    self.print_error_msg(msg: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "下注失败"))
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
    }
    
    func viewLotRecord(){
        let page = ZuihaoQueryController()
        page.filterLotCode = self.cpBianma
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    func showBetSuccessDialog() -> Void {
        let alertController = UIAlertController(title: "温馨提示",
                                                message: "追号成功!", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "查看记录", style: .cancel, handler: {
            action in
            self.viewLotRecord()
        })
        let okAction = UIAlertAction(title: "继续下注", style: .default, handler: {
            action in
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(viewAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAskForTouzhuDialog() -> Void {
        
        //过期的期号列出
        var invalidQishu = ""
        for item in self.timeoutQishuList{
            invalidQishu = invalidQishu + String.init(format: "%@,", item)
        }
        if !isEmptyString(str: invalidQishu){
            invalidQishu = invalidQishu + "期号已经停止,将无法追这些期号;确定要提交投注吗?"
        }else{
            invalidQishu = "确定要提交投注吗?"
        }
        let alertController = UIAlertController(title: "温馨提示",
                                                message: invalidQishu, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            
        })
        let okAction = UIAlertAction(title: "下注", style: .default, handler: {
            action in
            self.actionZuihao()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func onAddClick(view:UIButton) -> Void {
        let currentQishu = self.totalQishuInput.text!
        if isEmptyString(str: currentQishu){
            showToast(view: self.view, txt: "请输入追号期数")
            return
        }
        if !isPurnInt(string: currentQishu){
            showToast(view: self.view, txt: "请输入字数格式的期数")
            return
        }
        var addInt = Int(currentQishu)!
        addInt = addInt + 1
        if addInt > maxQishu{
            showToast(view: self.view, txt: String.init(format: "对不起，当前只能追%d期", maxQishu))
            return
        }
        self.totalQishuInput.text = String.init(describing: addInt)
        self.totalQishu = Int(self.totalQishuInput.text!)!
        
        let addQihao = qihaos[addInt - 1]
        //提取旧追号数据中最后一期倍数+1做为新追加的一期的倍数
        let data = ZuihaoListData()
        let lastIndex = self.datas.count - 1
        if lastIndex + 1 < self.maxQishu{
            data.beishu = Int(self.calcBeishuWithMultipleMode(index: (lastIndex + 1)))
            data.touZhuMoney = totalBaseMoney*Float(data.beishu)
            data.qihao = String.init(describing: addQihao)
            self.datas.append(data)
            refreshList()
        }
        
        
    }
    
    @objc func onJianClick(view:UIButton) -> Void {
        let currentQishu = self.totalQishuInput.text!
        if isEmptyString(str: currentQishu){
            showToast(view: self.view, txt: "请输入追号期数")
            return
        }
        if !isPurnInt(string: currentQishu){
            showToast(view: self.view, txt: "请输入字数格式的期数")
            return
        }
        var jianInt = Int(currentQishu)!
        if jianInt == 1{
            return
        }
        jianInt = jianInt - 1
        self.totalQishuInput.text = String.init(describing: jianInt)
        if jianInt > self.datas.count{
            return
        }
        self.totalQishu = Int(self.totalQishuInput.text!)!
        self.datas.remove(at: self.datas.count - 1)
        refreshList()
    }
    
    func updateCurrenQihaoCountDown(countDown:CountDown) -> Void {
        //创建开奖周期倒计时器
        let serverTime = countDown.serverTime;
        let activeTime = countDown.activeTime;
        let value = activeTime - serverTime
        self.endBetDuration = Int(abs(value))/1000
        self.endBetTime = self.endBetDuration
        self.currentQihao = countDown.qiHao
//        let dealDuration = getFormatTime(secounds: TimeInterval(Int64(self.endBetDuration)))
//        self.secTitleUI.text = String.init(format: "%@期截止:%@", self.currentQihao,dealDuration)
        if let timer = self.endlineTouzhuTimer{
            timer.invalidate()
        }
        self.createEndBetTimer()
    }
    
    /**
     * 创建期号截止倒计时
     * @param duration
     */
    func createEndBetTimer() -> Void {
        self.endlineTouzhuTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(endBetTickDown), userInfo: nil, repeats: true)
    }
    
    @objc func endBetTickDown() -> Void {
        //将剩余时间减少1秒
        self.endBetTime -= 1
        //        print("bet count time = \(self.endBetTime)")
//        if self.endBetTime > 0{
//            let dealDuration = getFormatTime(secounds: TimeInterval(Int64(self.endBetTime)))
//            self.secTitleUI.text = String.init(format: "%@期截止:%@", self.currentQihao,dealDuration)
//        }else if self.endBetTime == 0{
//            self.secTitleUI.text = String.init(format: "%@期截止:%@", self.currentQihao,"当期停止下注")
//        }
        if self.endBetTime <= 0{
            if self.datas.isEmpty{
                return
            }
            //将期号到期的cell灰置
            for index in 0...self.datas.count-1{
                let data = self.datas[index]
                if data.qihao == self.currentQihao{
                    let cell = self.tableView.cellForRow(at: IndexPath.init(row: index, section: 0))
                    cell?.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
                    timeoutQishuList.insert(self.currentQihao)//当前期号结束投注时，添加到过期期号列表中
                    break
                }
            }
            
            //取消定时器
            if let timer = endlineTouzhuTimer{
                timer.invalidate()
            }
            //当前期数投注时间到时，继续请求同步服务器上下一期号及离投注结束倒计时时间
            //获取下一期的倒计时的同时，获取上一期的开奖结果
            self.getCountDownByCpcode(bianHao: self.cpBianma, cpVersion: self.cpVersion, controller: self)
        }
    }
    
    /**
     * 开始获取当前期号离结束投注倒计时
     * @param bianHao 彩种编号
     */
    func getCountDownByCpcode(bianHao:String,cpVersion:String,controller:BaseController) -> Void {
        let params = ["lotCode":bianHao,"version":cpVersion]
        request(frontDialog: false, url:LOTTERY_COUNTDOWN_URL,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取当前期号失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        self.currentQihao = "???????";
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
//                            self.secTitleUI.text = self.currentQihao
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
    
    //自定义标题栏，方便控制下注倒计数
    func customTitleView() -> Void {
        self.navigationItem.titleView?.isUserInteractionEnabled = true
        let titleView = UIView.init(frame: CGRect.init(x: KSCREEN_WIDTH/4, y: 0, width: kScreenWidth/2, height: 44))
        titleBtn = UIButton.init(frame: CGRect.init(x: titleView.bounds.width/2-56, y: 0, width: 112, height: 24))
        titleBtn.isUserInteractionEnabled = false
        let titleIndictor = UIImageView.init(frame: CGRect.init(x: titleView.bounds.width/2+titleBtn.bounds.width/2, y: 12-4, width: 8, height: 8))
        titleIndictor.theme_image = "FrostedGlass.Touzhu.navDownImage"
        
        secTitleUI = UILabel.init(frame: CGRect.init(x: 0, y: 24, width:titleView.bounds.width, height: 20))
        secTitleUI.font = UIFont.systemFont(ofSize: 10)
        secTitleUI.textAlignment = NSTextAlignment.center
        secTitleUI.textColor = UIColor.white
        
        titleView.addSubview(titleBtn)
        titleView.addSubview(titleIndictor)
        titleView.addSubview(secTitleUI)
        
        titleBtn.setTitle(self.cpLotName, for: .normal)
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.navigationItem.titleView = titleView
    }
    
    @objc func showMenu() -> Void {
        //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
        popMenu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 150 - 5, y: 56, width: 150, height: 56), arrowMargin: 18)
        
        let list = [(icon:"1",title:"投注记录")]
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
            viewLotRecord()
//            openTouzhuRecord(controller: self,title: self.cpLotName,code: self.cpBianma, recordType: isSixMark(lotCode: self.cpBianma) ? MenuType.CAIPIAO_RECORD : MenuType.CAIPIAO_RECORD)
//        case 1:
//            openPlayIntroduceController(controller: self, payRule: "", touzhu: "", winDemo: "")
//            break
        default:
            break
        }
    }
    
    
    func getTotalMoneyOfSelectedZhudang(order:[OrderDataInfo]) -> Float {
        var money:Float = 0
        for info in order{
            money = money + Float(info.money)
        }
        return Float(money)
    }
    
    func actionGetValidQishu(lotCode:String) -> Void {
        request(frontDialog: true,method: .get, loadTextStr:"获取可追期数中...",url:ZUIHAO_QISHU_URL,
                params:["lotCode":lotCode],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = ZuihaoQihaoWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if let content = result.content{
                                if !content.isEmpty{
                                    
                                    self.qihaos.removeAll()
                                    self.qihaos = self.qihaos + content
                                    
                                    self.maxQishu = content.count
                                    var showQishu = self.datas.count
                                    showQishu = self.maxQishu > self.initQishu ? self.initQishu : self.maxQishu
                                    //赋值总期数输入框为初始期数，即initQishu
                                    self.totalQishuInput.text = String.init(describing: showQishu)
                                    
                                    DispatchQueue.global().async {
                                        //根据后台返回的可用期数及当前要显示的期数，构造追号列表显示数据
                                        var list = [ZuihaoListData]()
                                        var currentTouzhuFee:Float = 0
                                        for index in 0...content.count-1{
                                            if index < showQishu{
                                                let zuihaoListData = ZuihaoListData()
                                                let beishu = self.calcBeishuWithMultipleMode(index: index)
                                                zuihaoListData.beishu = Int(beishu)
                                                zuihaoListData.touZhuMoney = self.totalBaseMoney*Float(beishu)
                                                zuihaoListData.qihao = String.init(describing: content[index])
                                                list.append(zuihaoListData)
                                                currentTouzhuFee = currentTouzhuFee + zuihaoListData.touZhuMoney
                                            }
                                        }
                                        //同步追号列表数据和金额到主UI
                                        DispatchQueue.main.async {
                                            if !list.isEmpty{
                                                self.datas.removeAll()
                                                self.datas = self.datas + list
                                            }
                                            self.refreshList()
                                        }
                                    }
                                }
                            }else{
                                showToast(view: self.view, txt: "获取失败")
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败,请重试"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func calcBeishuWithMultipleMode(index:Int) -> Int {
        var beishu = 0
        if self.currentPage == 0{
            if index < self.perItemBeishu{
                return self.startBeishu
            }else{
                let w = index/self.perItemBeishu
                var result = pow(Double(self.beishuMultiple), Double(w))
                result = result*Double(self.startBeishu)
                print("result === ",result)
                if result < 60368744177664.0 {
                    return Int(result)
                }else{
                    return Int(60368744177664.0)
                }
            }
        }else{
            beishu = self.startBeishu
        }
        print("per,start,multi = ",perItemBeishu,startBeishu,beishuMultiple)
        print("beishu = ",beishu)
        return beishu
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        //删除数据源的对应数据
//        self.datas.remove(at: indexPath.row)
//        //删除对应的cell
//        self.tableView?.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
//        self.refreshList()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "braveCell") as? BraveZuiHaoCell  else {
            fatalError("The dequeued cell is not an instance of BraveZuiHaoCell.")
        }
        let item = self.datas[indexPath.row]
        cell.beishuInput.text = String.init(describing: item.beishu)
        cell.qihaoUI.text = String.init(format: "期号-%@", item.qihao)
        let xiazhuFee = String.init(format: "下注金额：%.2f元", item.touZhuMoney)
        cell.moneyUI.text = xiazhuFee
        cell.beishuInput.delegate = self
        cell.beishuInput.tag = indexPath.row
        cell.beishuInput.addTarget(self, action: #selector(onBeishuInputEvent), for: UIControlEvents.editingChanged)
        cell.beishuInput.addTarget(self, action: #selector(onBeishuInputEndEvent), for: .editingDidEnd)
        cell.jianBtn.tag = indexPath.row
        cell.addBtn.tag = indexPath.row
        cell.jianBtn.addTarget(self, action: #selector(onJianBeishuClick), for: .touchUpInside)
        cell.addBtn.addTarget(self, action: #selector(onAddBeishuClick), for: .touchUpInside)
        
        let maskPath = UIBezierPath(roundedRect: cell.jianBtn.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 15, height: 15))
        let jianMaskLayer = CAShapeLayer()
        jianMaskLayer.frame = cell.jianBtn.bounds
        jianMaskLayer.path = maskPath.cgPath
        cell.jianBtn.layer.mask = jianMaskLayer
        
        let addMaskPath = UIBezierPath(roundedRect: cell.addBtn.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        let addMaskLayer = CAShapeLayer()
        addMaskLayer.frame = cell.addBtn.bounds
        addMaskLayer.path = addMaskPath.cgPath
        cell.addBtn.layer.mask = addMaskLayer
        
        return cell
    }
    
    @objc func adjustBeishuViewEvent(view:CustomFeildText) -> Void {
        let beishu = view.text
        if isEmptyString(str: beishu!){
            return
        }
        if !isEmptyString(str: beishu!) && !isPurnInt(string: beishu!){
            showToast(view: self.view, txt: "请输入正确的倍数格式")
            return
        }
        if view.tag == 100{
            self.perItemBeishu = Int(beishu!)!
        }else if view.tag == 101{
            self.beishuMultiple = Int(beishu!)!
        }else if view.tag == 102{
            self.startBeishu = Int(beishu!)!
        }
        print("peiitem = ",self.totalQishu)
        DispatchQueue.global().async {
            //根据后台返回的可用期数及当前要显示的期数，构造追号列表显示数据
            if self.qihaos.isEmpty{
                return
            }
            var list = [ZuihaoListData]()
            var currentTouzhuFee:Float = 0
            for index in 0...self.qihaos.count-1{
                if index < self.totalQishu{
                    let zuihaoListData = ZuihaoListData()
                    let beishu = self.calcBeishuWithMultipleMode(index: index)
                    zuihaoListData.beishu = Int(beishu)
                    zuihaoListData.touZhuMoney = self.totalBaseMoney*Float(beishu)
                    zuihaoListData.qihao = String.init(describing: self.qihaos[index])
                    list.append(zuihaoListData)
                    currentTouzhuFee = currentTouzhuFee + zuihaoListData.touZhuMoney
                }
            }
            //同步追号列表数据和金额到主UI
            DispatchQueue.main.async {
                if !list.isEmpty{
                    self.datas.removeAll()
                    self.datas = self.datas + list
                }
                self.refreshList()
            }
        }
    }
    
    @objc func onTotalQishuInputEvent(view:CustomFeildText) -> Void {
        let beishu = view.text
        if isEmptyString(str: beishu!){
            return
        }
        if !isEmptyString(str: beishu!) && !isPurnInt(string: beishu!){
            showToast(view: self.view, txt: "请输入正确的倍数格式")
            return
        }
        let newBeishuInt = Int(beishu!)!
        if newBeishuInt > self.maxQishu{
            showToast(view: self.view, txt: String.init(format: "对不起，当前只能追%d期", maxQishu))
            return
        }
        self.totalQishu = newBeishuInt
        DispatchQueue.global().async {
            //根据后台返回的可用期数及当前要显示的期数，构造追号列表显示数据
            var list = [ZuihaoListData]()
            var currentTouzhuFee:Float = 0
            for index in 0...self.qihaos.count-1{
                if index < newBeishuInt{
                    let zuihaoListData = ZuihaoListData()
                    let beishu = self.calcBeishuWithMultipleMode(index: index)
                    zuihaoListData.beishu = Int(beishu)
                    zuihaoListData.touZhuMoney = self.totalBaseMoney*Float(beishu)
                    zuihaoListData.qihao = String.init(describing: self.qihaos[index])
                    list.append(zuihaoListData)
                    currentTouzhuFee = currentTouzhuFee + zuihaoListData.touZhuMoney
                }
            }
            //同步追号列表数据和金额到主UI
            DispatchQueue.main.async {
                if !list.isEmpty{
                    self.datas.removeAll()
                    self.datas = self.datas + list
                }
                self.refreshList()
            }
        }
    }
    
    @objc func onBeishuInputEndEvent(view:CustomFeildText) -> Void {
        var beishu = view.text
        if isEmptyString(str: beishu!){
            view.text = "1"
            beishu = "1"
        }
        if !isEmptyString(str: beishu!) && !isPurnInt(string: beishu!){
            showToast(view: self.view, txt: "请输入正确的倍数格式")
            view.text = "1"
            beishu = "1"
        }
        
        if Int(beishu!) == 0 {
            view.text = "1"
            beishu = "1"
        }
        
        //更新列表数据
        let data = self.datas[view.tag]
        let new_data = ZuihaoListData()
        new_data.qihao = data.qihao
        new_data.touZhuMoney = self.totalBaseMoney*Float(beishu!)!
        new_data.beishu = Int(beishu!)!
        self.datas[view.tag] = new_data
        //        refreshList()
        //直接赋值新的下注金额及总金额
        self.totalTouzhuFee = 0
        for index in 0...self.datas.count-1{
            self.totalTouzhuFee = self.totalTouzhuFee + self.datas[index].touZhuMoney
        }
        self.totalQishuUI.text = String.init(format: "总期数:%d期", self.datas.count)
        let moneyString = String.init(format: "%.2f", self.totalTouzhuFee)
        self.totalMoneyUI.text = String.init(format: "总金额:%@元", moneyString)
        
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: view.tag, section: 0)) as! BraveZuiHaoCell
        let xiazhuFee = String.init(format: "下注金额：%.2f元", new_data.touZhuMoney)
        cell.moneyUI.text = xiazhuFee
    }
    
    @objc func onBeishuInputEvent(view:CustomFeildText) -> Void {
//        let beishu = view.text
//        if isEmptyString(str: beishu!){
//            return
//        }
//        if !isEmptyString(str: beishu!) && !isPurnInt(string: beishu!){
//            showToast(view: self.view, txt: "请输入正确的倍数格式")
//            return
//        }
//        //更新列表数据
//        let data = self.datas[view.tag]
//        let new_data = ZuihaoListData()
//        new_data.qihao = data.qihao
//        new_data.touZhuMoney = self.totalBaseMoney*Float(beishu!)!
//        new_data.beishu = Int(beishu!)!
//        self.datas[view.tag] = new_data
////        refreshList()
//        //直接赋值新的下注金额及总金额
//        self.totalTouzhuFee = 0
//        for index in 0...self.datas.count-1{
//            self.totalTouzhuFee = self.totalTouzhuFee + self.datas[index].touZhuMoney
//        }
//        self.totalQishuUI.text = String.init(format: "总期数:%d期", self.datas.count)
//        let moneyString = String.init(format: "%.2f", self.totalTouzhuFee)
//        self.totalMoneyUI.text = String.init(format: "总金额:%@元", moneyString)
//
//        let cell = self.tableView.cellForRow(at: IndexPath.init(row: view.tag, section: 0)) as! BraveZuiHaoCell
//        let xiazhuFee = String.init(format: "下注金额：%.2f元", new_data.touZhuMoney)
//        cell.moneyUI.text = xiazhuFee
    }
    
    @objc func onJianBeishuClick(view:UIButton) -> Void {
        let clickPos = view.tag
        let data = self.datas[clickPos]
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: clickPos, section: 0)) as! BraveZuiHaoCell
        let beishu = cell.beishuInput.text
        if isEmptyString(str: beishu!){
            showToast(view: self.view, txt: "请输入倍数")
            return
        }
        if !isPurnInt(string: beishu!){
            showToast(view: self.view, txt: "请输入正确的倍数格式")
            return
        }
        var beishuInt = Int(beishu!)
        if beishuInt == 1 {
            return
        }
        beishuInt = beishuInt! - 1
        if beishuInt! <= 0{
            beishuInt = 1
        }
        cell.beishuInput.text = String.init(describing: beishuInt)
        //更新列表数据
        let new_data = ZuihaoListData()
        new_data.qihao = data.qihao
        new_data.touZhuMoney = self.totalBaseMoney*Float(beishuInt!)
        new_data.beishu = beishuInt!
        self.datas[clickPos] = new_data
        refreshList()
    }
    
    @objc func onAddBeishuClick(view:UIButton) -> Void {
        let clickPos = view.tag
        let data = self.datas[clickPos]
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: clickPos, section: 0)) as! BraveZuiHaoCell
        let beishu = cell.beishuInput.text
        if isEmptyString(str: beishu!){
            showToast(view: self.view, txt: "请输入倍数")
            return
        }
        if !isPurnInt(string: beishu!){
            showToast(view: self.view, txt: "请输入正确的倍数格式")
            return
        }
        
        var beishuInt = Int(beishu!)
        beishuInt = beishuInt! + 1
        cell.beishuInput.text = String.init(describing: beishuInt)
        //更新列表数据
        let new_data = ZuihaoListData()
        new_data.qihao = data.qihao
        new_data.touZhuMoney = self.totalBaseMoney*Float(beishuInt!)
        new_data.beishu = beishuInt!
        self.datas[clickPos] = new_data
        refreshList()
    }
    
    func refreshList() -> Void {
        self.totalTouzhuFee = 0
        self.tableView.reloadData()
        for index in 0...self.datas.count-1{
            self.totalTouzhuFee = self.totalTouzhuFee + self.datas[index].touZhuMoney
        }
        self.totalQishuUI.text = String.init(format: "总期数:%d期", self.datas.count)
        let moneyString = String.init(format: "%.2f", self.totalTouzhuFee)
        self.totalMoneyUI.text = String.init(format: "总金额:%@元", moneyString)
        self.totalQishuInput.text = String.init(format: "%d", self.datas.count)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
