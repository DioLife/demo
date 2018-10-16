//
//  LotFeeLimitController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import UIKit
import HandyJSON

//彩种限额
class LotFeeLimitController: BaseController {
    
    @IBOutlet weak var secondHeaderFourthLabel: UILabel!
    @IBOutlet weak var secondHeaderThirdLabel: UILabel!
    @IBOutlet weak var secondHeaderSecondLabel: UILabel!
    @IBOutlet weak var secondHeaderFirstLabel: UILabel!
    
    @IBOutlet weak var topHeader: UIView!
    @IBOutlet weak var secondHeader: UIView!
    @IBOutlet weak var lotTypeTV:UILabel!
    @IBOutlet weak var content:UITableView!
    var datas:[LotteryData] = []
    var lotteryDatas:[LotteryData] = []
    var lotterNames:[String] = []
    var currentLotteryIndex = 0
    var currentLotteryId = 0
    var currentLimitInfo:LotLimitBean!
    var isSelect = false
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        setThemeViewNoTransparentDefaultGlassBlackOtherGray(view: topHeader)
        setThemeLabelTextColorGlassWhiteOtherBlack(label: lotTypeTV)
        setupNoPictureAlphaBgView(view: secondHeader,alpha: 0.4)
        
        secondHeaderFourthLabel.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        secondHeaderThirdLabel.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        secondHeaderSecondLabel.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        secondHeaderFirstLabel.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        
        content.delegate = self
        content.dataSource = self
        lotTypeTV.isUserInteractionEnabled = true
        lotTypeTV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onLotSwitch)))
        self.loadAllLotteryDatas(showDialog: true)
    }
    
    
    @objc func onLotSwitch(){
        if (isSelect == false) {
            isSelect = true
            showLotteryListDialog()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
    }
    
    private func showLotteryListDialog(){
        let selectedView = LennySelectView(dataSource: self.lotterNames, viewTitle: "请选择彩种")
        selectedView.selectedIndex = self.currentLotteryIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.currentLotteryIndex = index
            self?.updateLotSwitchInfo(lottery: (self?.lotteryDatas[(self?.currentLotteryIndex)!])!,index: (self?.currentLotteryIndex)!)
            self?.loadData()
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            //            self.setSelected(false, animated: true)
        }
    }
    
    
}

extension LotFeeLimitController {
    
    func loadAllLotteryDatas(showDialog:Bool) -> Void {
        
        var v = ""
        let version = getSystemConfigFromJson()?.content.lottery_version
        if version == VERSION_V1{
            v = VERSION_1
        }else if version == VERSION_V2{
            v = VERSION_2
        }
        let params = ["version":v]
        request(frontDialog: showDialog, method:.get, loadTextStr:"获取中...", url:API_ALL_LOTS,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = LotterysWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if result.content != nil{
                                self.lotteryDatas = result.content!
                                if !self.lotteryDatas.isEmpty{
                                    for lottery in self.lotteryDatas{
                                        var name = lottery.name;
                                        name?.append(lottery.lotVersion == Int(VERSION_1)! ? "(官)" : "(信)")
                                        self.lotterNames.append(name!)
                                    }
                                    self.currentLotteryIndex = 0
                                    self.currentLotteryId = 0
                                    self.updateLotSwitchInfo(lottery: self.lotteryDatas[0],index: self.currentLotteryIndex)
                                    self.loadData()
                                }
                            }
                        }else{
                            if let msg = result.msg{
                                if !isEmptyString(str: msg){
                                    self.print_error_msg(msg: msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                                }
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
                    
        })
    }
    
    func updateLotSwitchInfo(lottery:LotteryData,index:Int){
        if self.lotterNames.isEmpty{
            return
        }
        lotTypeTV.text = self.lotterNames[index]
        self.currentLotteryId = Int(lottery.id)
    }
    
    func loadData() {
        self.datas.removeAll()
        self.request(frontDialog: true, method:.get, loadTextStr:"获取中", url:API_LOTINFO_FROM_TID,params: ["lotteryId":self.currentLotteryId],
                     callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = AllLotLimitInfoWrapper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                if let content = result.content{
                                    if !content.isEmpty{
                                        self.currentLimitInfo = content[0]
                                        self.content.reloadData()
                                    }
                                }
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
    
}

extension LotFeeLimitController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currentLimitInfo != nil{
            if let playInfos = self.currentLimitInfo.playInfo{
                return playInfos.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lotInfoCell") as? LotInfoListCell  else {
            fatalError("The dequeued cell is not an instance of lotInfoCell.")
        }
        cell.selectionStyle = .none
        if self.currentLimitInfo != nil{
            if let playInfos = self.currentLimitInfo.playInfo{
                cell.setMode(limitPlay: playInfos[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
