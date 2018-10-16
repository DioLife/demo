//
//  NewBigPanController.swift
//  gameplay
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit

class NewBigPanController: BaseController {

    
    @IBOutlet weak var tableViwBgView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    var newMainTableView = UITableView()
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var flashingImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var goButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var qualificationsLabel: UILabel!
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var announceLabel: UILabel!
    
    @IBOutlet weak var announceTipsBottomConstraint: NSLayoutConstraint!
    
    
    var finalColor = "pink"
    
    
    var scrollTimer:Timer?
    var falshTimer:Timer?
    var scrollIndex = 1
    var winningsArray = [ActiveRecord]()
    
    var bigDatas:[[String]] = [[String]]()
    var activeID:Int64 = 0
    var couJianResult:CouJianResult!
    var winningIndexArray = [0,0,0]
    
    
    @IBAction func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goButtonAction(_ sender: UIButton) {
        
        self.actionPickBigWheel(activeID: self.activeID)
        self.goButtonBottomConstraint.constant = 1.18
    }
    
    @objc func goButtonPressed() {
        self.goButtonBottomConstraint.constant = 3.0
    }
    
    private func startSpinning() {
        let seed_0: UInt32 = UInt32(self.bigDatas[0].count)
        let seed_1: UInt32 = UInt32(self.bigDatas[1].count)
        let seed_2: UInt32 = UInt32(self.bigDatas[2].count)
        
        let randomResult_0 = Int(arc4random() % seed_0)
        let randomResult_1 = Int(arc4random() % seed_1)
        let randomResult_2 = Int(arc4random() % seed_2)

        self.winningIndexArray.removeAll()
        self.winningIndexArray.append(randomResult_0)
        self.winningIndexArray.append(randomResult_1)
        self.winningIndexArray.append(randomResult_2)
        
        
        let colorSeed: UInt32 = UInt32(3)
        let randomResult_Color = Int(arc4random() % colorSeed)
        
        var firstColor = "pink"
        if randomResult_Color == 0 {
            firstColor = "blue"
        }else if randomResult_Color == 1 {
            firstColor = "purple"
        }
        
        self.finalColor = firstColor
        
        
        if !isEmptyString(str: self.couJianResult.awardName) {
            
            self.bigDatas[0].insert(self.couJianResult.awardName, at: randomResult_0)
            self.bigDatas[1].insert(self.couJianResult.awardName, at: randomResult_1)
            self.bigDatas[2].insert(self.couJianResult.awardName, at: randomResult_2)
            
            self.pickerView.reloadAllComponents()
            
            print("中奖结果:  \(self.couJianResult.awardName)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.pickerView.selectRow(randomResult_0, inComponent: 0, animated: true)
                }
                
                self.pickerView.selectRow(randomResult_1, inComponent: 1, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.pickerView.selectRow(randomResult_2, inComponent: 2, animated: true)
                }
            }
        }
    }
    
    func createFlashingTimer() -> Void {
        self.falshTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(flashingTimerAction), userInfo: nil, repeats: true)
    }
    
    func createScrollTableTimer() -> Void {
        self.falshTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.05), target: self, selector: #selector(scrollTimerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollTimerAction() {
        
        let pointY = self.newMainTableView.contentOffset.y + 1
        self.newMainTableView.contentOffset = CGPoint.init(x: 0, y: pointY)
        
        // 提前20个cell，开始加载更多数据源
        if (self.newMainTableView.indexPathsForVisibleRows?.contains(IndexPath.init(row: self.winningsArray.count - 1 - 10, section: 0)))! {
            self.winningsArray += self.winningsArray
            self.newMainTableView.reloadData()
        }
    }
    
    
    @objc private func flashingTimerAction() {
        flashingImage.image = UIImage.init(named: self.scrollIndex % 2 == 0 ? "flashingDotBg_1" : "flashingDotBg_2")
        self.scrollIndex += 1
    }
    
    deinit {
        self.scrollTimer?.invalidate()
        self.falshTimer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    
    
    private func setupUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        if glt_iphoneX {
            announceTipsBottomConstraint.constant = 84
        }
        
        createFlashingTimer()
        
        self.goButton.addTarget(self, action: #selector(goButtonPressed), for: .touchDown)
        
        self.title = "大转盘"
        self.mainTableView.alpha = 0
        self.tableViwBgView.addSubview(self.newMainTableView)
        self.newMainTableView.frame = CGRect.init(x: 0, y: 0, width: self.tableViwBgView.width, height: self.tableViwBgView.height)
        self.newMainTableView.separatorStyle = .none
        self.newMainTableView.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.newMainTableView.showsVerticalScrollIndicator = false
        self.newMainTableView.showsHorizontalScrollIndicator = false
        self.newMainTableView.delegate = self
        self.newMainTableView.dataSource = self
        self.newMainTableView.tableFooterView = UIView.init()
        self.newMainTableView.register(NewBigPanWiningCell.self, forCellReuseIdentifier: "newBigPanWiningCell")
        self.newMainTableView.isUserInteractionEnabled = false
        self.newMainTableView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        self.pickerView.isUserInteractionEnabled = false
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.layer.cornerRadius = 3.0
        self.pickerView.layer.masksToBounds = true
    }
    
    private func loadData() {
        loadWebData()
    }
    
    /** 获得大转盘，所有奖项 */
    func loadWebData() -> Void {
        request(frontDialog: true,method: .get, loadTextStr:"获取中...", url:BIG_WHEEL_DATA_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if isEmptyString(str: resultJson){
                        Tool.confirm(title: "溫馨提示", message: "您还没有大转盘抽奖活动，请添加活动后再重试", controller: self)
                        return
                    }
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = BigPanResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let result = result.content else {return}
                            var awardArrayP = result.awardNames
                            self.activeID = Int64(result.activeId)
                            self.upateRules(data: result)
                            self.bigDatas.removeAll()
                            
                            let countNumP = 200
                            if awardArrayP.count < countNumP && awardArrayP.count > 0{
                                let multipleP = Int(countNumP / awardArrayP.count) + 1
                                for _ in 0..<multipleP {
                                    awardArrayP += awardArrayP
                                    if awardArrayP.count >= countNumP {
                                        break
                                    }
                                }
                            }
                            for _ in 0..<3 {
                                self.bigDatas.append(awardArrayP)
                            }
                            self.pickerView.reloadAllComponents()
                            self.actionAwardRecord(activeId: self.activeID)
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
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
    
    private func upateRules(data:BigWheelData?){
        if data == nil{
            return
        }
        if let d = data{
            self.qualificationsLabel.text = d.condition
            self.ruleLabel.text = d.rule
            self.announceLabel.text = d.remark
        }
    }
    
    //MARK: 获取所有奖项
    /**  获取所有奖项 */
    func actionAwardRecord(activeId:Int64) -> Void {
        
        //"activeId":activeId,
        //        let params = ["begin":"2018-01-01 00:00:00","end":getTodayZeroTime()] as [String : Any] as [String : Any]
        let params = ["activeId":activeId] as [String : Any]
        self.request(frontDialog: false,method: .post, url:BIG_WHEEL_AWARD_RECORD_URL,params:params,
                           callback: {(resultJson:String,resultStatus:Bool)->Void in
                            if !resultStatus {
                                return
                            }
                            if let result = AwardRecordWraper.deserialize(from: resultJson){
                                if result.success{
                                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                                    guard let records = result.content else {return}
                                    self.winningsArray = records
                                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                                        
                                        if self.winningsArray.count > 0 {
                                            let nums = 30 // 第一次数据源最小数目
                                            if self.winningsArray.count < nums {
                                                let beishu = nums / self.winningsArray.count + 1
                                                for _ in 0..<beishu {
                                                    self.winningsArray += self.winningsArray
                                                    if self.winningsArray.count >= nums {
                                                        break
                                                    }
                                                }
                                            }
                                            
                                            self.newMainTableView.reloadData()
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                                self.createScrollTableTimer()
                                            })
                                            
                                            
                                        }
                                    })
                                    print("中奖名单: \(records)")
                                }else{
                                    if !isEmptyString(str: result.msg){
                                        showToast(view: self.view, txt: result.msg)
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
    
    //MARK: 获取抽奖结果数据
    /** 获取抽奖结果数据 */
    func actionPickBigWheel(activeID:Int64) -> Void {
        request(frontDialog: true,method: .get, loadTextStr:"抽奖中...", url:BIG_WHEEL_ACTION_URL,params: ["activeId":activeID],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if isEmptyString(str: resultJson){
                        return
                    }
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "抽奖失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = CouJianResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let result = result.content else {return}
                            self.couJianResult = result
                            if self.couJianResult != nil{
                                print(String.init(format: "%@%d", self.couJianResult.awardName,self.couJianResult.index))
                                self.startSpinning()
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "抽奖失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension NewBigPanController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("tableview row = \(winningsArray.count)")
        return self.winningsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newBigPanWiningCell") as? NewBigPanWiningCell else {fatalError("The dequeued cell is not an instance of NewSelectedViewCell.")}
        
        let model = self.winningsArray[indexPath.row]
        cell.winningLable.text = model.username + " " + model.itemName + " " + model.winTime
        cell.winningLable.text = "恭喜用户 " + model.username + "喜中" + model.itemName
//        print("打印cell中显示的数据 \(model.username + " " + model.itemName + " " + model.winTime)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}



extension NewBigPanController:  UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.bigDatas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.bigDatas[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.bigDatas[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let slotMachineView = SlotMachineView.init(frame: CGRect.init(x: 0, y: 0, width: pickerView.width * 0.333, height: pickerView.height))
        
        let seed_0: UInt32 = UInt32(3)
        
        let randomResult_0 = Int(arc4random() % seed_0)
        let randomResult_1 = Int(arc4random() % seed_0)
        let randomResult_2 = Int(arc4random() % seed_0)
        
        var firstColor = "pink"
        if randomResult_0 == 0 {
            firstColor = "blue"
        }else if randomResult_0 == 1 {
            firstColor = "purple"
        }
        
        var secondColor = "pink"
        if randomResult_1 == 0 {
            secondColor = "blue"
        }else if randomResult_1 == 1 {
            secondColor = "purple"
        }
        
        var thirdColor = "pink"
        if randomResult_2 == 0 {
            thirdColor = "blue"
        }else if randomResult_2 == 1 {
            thirdColor = "purple"
        }

        
        if component == 0 {
            slotMachineView.config(title: self.bigDatas[component][row], imgName: "slot_\(firstColor)_left")
        }else if component == 1 {
            slotMachineView.config(title: self.bigDatas[component][row], imgName: "slot_\(secondColor)_mid")
        }else if component == 2 {
            slotMachineView.config(title: self.bigDatas[component][row], imgName: "slot_\(thirdColor)_right")
        }
        
        if component == 0 && row == self.winningIndexArray[0] {
            slotMachineView.config(title: self.bigDatas[component][row], imgName: "slot_\(self.finalColor)_left")
        }
        
        if component == 1 && row == self.winningIndexArray[1] {
            slotMachineView.config(title: self.bigDatas[component][row], imgName: "slot_\(self.finalColor)_mid")
        }
        
        if component == 2 && row == self.winningIndexArray[2] {
            slotMachineView.config(title: self.bigDatas[component][row], imgName: "slot_\(self.finalColor)_right")
        }
        
        
        return slotMachineView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.height
    }

}

class SlotMachineView: UIView {
    
    var img = UIImageView()
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame: frame)
    }
    
    private func setupUI(frame: CGRect) {
        addSubview(img)
        addSubview(label)
        
        img.frame = frame
        label.frame = frame
    }
    
    func config(title: String?,imgName: String?) {
        if let titleP = title {
            self.label.text = titleP
            self.label.textColor = .black
            self.label.textAlignment = .center
            self.backgroundColor = UIColor.white.withAlphaComponent(0.0)
            self.label.font = UIFont.systemFont(ofSize: 14)
        }
        
        if let imageNameP = imgName {
            self.img.image = UIImage.init(named: imageNameP)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




