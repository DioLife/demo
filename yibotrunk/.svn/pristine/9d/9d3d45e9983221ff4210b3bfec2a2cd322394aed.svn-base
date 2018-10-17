//
//  GoucaiMallController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/11/20.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON
import Kingfisher

class GoucaiMallController: BaseMainController,UITableViewDataSource,UITableViewDelegate,GoucaiMenuDelegate,LennyPullRefreshDelegate {
    
    
    @IBOutlet weak var categoryBar:GoucaiCategoryView!
    @IBOutlet weak var tableView:UITableView!
    var datas:[GoucaiResult] = []
    var low_datas:[GoucaiResult] = []
    var high_datas:[GoucaiResult] = []
    var lowRatelots:[String] = ["LHC","FC3D","PL3"]//低頻彩彩種編號
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        setupMenuBar()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setLennyPullRefresh(Style: .All, delegate: self)
        loadDatas(pullDown: true,showDialog: true)
    }
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
            self.navigationItem.rightBarButtonItem = menuBtn
            self.navigationItem.rightBarButtonItems = [menuBtn]
        }
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                if !isEmptyString(str: config.content.basic_info_website_name){
                    self.navigationItem.leftBarButtonItems?.removeAll()
                    let webName = UIBarButtonItem.init(title: config.content.basic_info_website_name, style: UIBarButtonItemStyle.plain, target: self, action:nil)
                    self.navigationItem.leftBarButtonItem = webName
                }
            }
        }
    }
    
    func setupMenuBar() -> Void {
        categoryBar.delegate = self
        categoryBar.stepSubViews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datas = self.figureDataByCurrentCategory()
        let lotCode = datas[indexPath.row].lotCode
        syncLotteryPlaysByCode(controller: self, lotteryCode: lotCode, shakeDelegate: self.navigationController as? EnterTouzhuDelegate)
    }
    
    func loadDatas(pullDown down:Bool,showDialog:Bool) -> Void {
        
        let lotterys = YiboPreference.getLotterys()
        if isEmptyString(str: lotterys){
            showToast(view: self.view, txt: "没有彩种代码")
            self.tableView.LennyDidCompletedWithRefreshIs(downPull: down)
            return
        }
        
        var lotteryDatas:[LotteryData] = []
        //获取存储在本地preference中的lotterys
        if let lotWraper = JSONDeserializer<LotterysWraper>.deserializeFrom(json: lotterys) {
            if lotWraper.success{
                if let content = lotWraper.content{
                    lotteryDatas = lotteryDatas + content
                }
            }
        }
        
        var codes = ""
        for item in lotteryDatas{
            if let code = item.code{
                codes = codes + code + ","
            }
        }
        if isEmptyString(str: codes){
            showToast(view: self.view, txt: "没有彩种代码")
            self.tableView.LennyDidCompletedWithRefreshIs(downPull: down)
            return
        }
        
        request(frontDialog: showDialog, loadTextStr:"获取中...",url:ALL_LOTTERYS_COUNTDOWN_URL,params:["lotCodes":codes],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    self.tableView.LennyDidCompletedWithRefreshIs(downPull: down)
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取购彩数据失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = GoucaiResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if let result = result.content{
                                self.datas.removeAll()
                                self.datas = self.datas + result
                                self.tableView.reloadData()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取购彩数据失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func figureDataByCurrentCategory() -> [GoucaiResult] {
        if currentIndex == 0{
            return self.datas
        }else if currentIndex == 1{
            return self.high_datas
        }else if currentIndex == 2{
            return self.low_datas
        }
        return self.datas
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let data = figureDataByCurrentCategory()
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ballWidth:CGFloat = 30
        let datas = figureDataByCurrentCategory()
        let data = datas[indexPath.row]
        let totalBallWidth = ballWidth * CGFloat(data.haoMa.components(separatedBy: ",").count)
        let viewPlaceHoldWidth = kScreenWidth - 60 - 30 - 8
        //如果ballview占位宽度不大于实际号码宽度，则需要换行处理
        if totalBallWidth > viewPlaceHoldWidth{
            return 140
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goucaiCell") as? GouCaiCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        let datas = figureDataByCurrentCategory()
        let data = datas[indexPath.row]
        if !isEmptyString(str: data.lotName){
           cell.czName.text = data.lotName
        }else{
            cell.czName.text = "暂无彩种"
        }
        let cpVersion = YiboPreference.getVersion()
         let viewPlaceHoldWidth = kScreenWidth - 60 - 30 - 8
        if !isEmptyString(str: data.haoMa){
            if data.haoMa.contains(","){
                cell.emptyHaomaUI.isHidden = true
                cell.ballViews.isHidden = false
                
                var ballWidth:CGFloat = 30
                var small = false
                if isSaiche(lotType: data.codeType){
                    ballWidth = 25
                }else if isFFSSCai(lotType: data.codeType){
                    ballWidth = 30
                    small = false
                }
                cell.ballViews.setupBalls(nums: data.haoMa.components(separatedBy: ","), offset: 0,lotTypeCode: data.codeType, cpVersion: cpVersion, viewPlaceHoldWidth: viewPlaceHoldWidth,ballWidth: ballWidth,small: small)
            }else{
                cell.emptyHaomaUI.isHidden = false
                cell.ballViews.isHidden = true
                cell.emptyHaomaUI.text = data.haoMa
            }
        }else{
            cell.emptyHaomaUI.isHidden = false
            cell.ballViews.isHidden = true
            let nums = "等,待,开,奖"
            cell.ballViews.setupBalls(nums: nums.components(separatedBy: ","), offset: 0,lotTypeCode: data.codeType,cpVersion: cpVersion,viewPlaceHoldWidth: viewPlaceHoldWidth)
        }
        if !isEmptyString(str: data.lastQihao){
            cell.lastQihao.text = String.init(format: "第%@期", data.lastQihao)
        }else{
            cell.lastQihao.text = "暂无期号"
        }
        
        let serverTime = data.serverTime;
        let activeTime = data.activeTime;
        let value = abs(activeTime) - abs(serverTime)
        let endBetDuration = Int(abs(value))/1000
        let dealDuration = getFormatTime(secounds: TimeInterval(Int64(endBetDuration)))
        cell.currentQihaoAndTime.text = String.init(format: "%@期投注时间还有:%@",data.qiHao, dealDuration)
        
        if !isEmptyString(str: data.lotCode){
            // set lottery picture
            let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + data.lotCode + ".png")
            cell.icon?.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            cell.icon?.image = UIImage(named: "default_lottery")
        }
        
        return cell
    }
    
    func onMenuClick(index: Int) {
        print("onmenu click,index = ",index)
        reloadDataWithIndex(index:index)
    }
    
    func reloadDataWithIndex(index:Int) -> Void {
        self.currentIndex = index
        if self.datas.isEmpty{
            return
        }
        if index == 0{
            self.tableView.reloadData()
        }else if index == 1{
            if !self.high_datas.isEmpty{
                self.tableView.reloadData()
                return
            }
            self.high_datas.removeAll()
            for item in self.datas{
                if !self.lowRatelots.contains(item.lotCode){
                    high_datas.append(item)
                }
            }
        }else if index == 2{
            if !self.low_datas.isEmpty{
                self.tableView.reloadData()
                return
            }
            self.low_datas.removeAll()
            for item in self.datas{
                if self.lowRatelots.contains(item.lotCode){
                    low_datas.append(item)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func LennyPullUpRequest() {
        loadDatas(pullDown: false,showDialog: false)
    }
    
    func LennyPullDownRequest() {
        loadDatas(pullDown: true,showDialog: false)
    }
    
}
