//
//  SegmentMallContainerController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/14.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import GTMRefresh
import Kingfisher

class SegmentMallContainerController: BaseMainController {
    
    private var titles: [String] = []
    var allDatas = [LotteryData]()//all the game datas
    let leftNaviButtonW: CGFloat = 100
    private var viewControllers: [SubSegmentController] = []
    var header = LZDHeader() //顶部记录常用 模块
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.titleViewBgColor = UIColor.white
        layout.pageBottomLineColor = UIColor(r: 230, g: 230, b: 230)
        layout.isAverage = true
        layout.isColorAnimation = true
        return layout
    }()
    
    private var simpleManager: LTSimpleManager!
    
    override func viewWillAppear(_ animated: Bool) {
        
        //页面出现时刷新 顶部数据
        let allData:[VisitRecords] = WHC_ModelSqlite.query(VisitRecords.self, where: "userName = '\(YiboPreference.getUserName())'", order: "by num desc", limit: "10") as! [VisitRecords]
        simpleManager.header.dataArray = allData;
        simpleManager.header.collectionView.reloadData();
    }
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showNewFunctionTipsPage()
        }
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        //这个通知是顶部点击事件传递
        NotificationCenter.default.addObserver(self, selector: #selector(commonRecords(nofi:)), name: NSNotification.Name(rawValue:"commonUseRecord"), object: nil)
        
//        setViewBackgroundColorTransparent(view: self.view)
//        setupthemeBgView(view: self.view)
        self.automaticallyAdjustsScrollViewInsets = false
        //根据配置决定显示tab个数
        titles = figure_tabs_from_config()
        for _ in titles{
            let vc = UIStoryboard(name: "sub_main_segment_page",bundle:nil).instantiateViewController(withIdentifier: "sub_segment")
            setViewBackgroundColorTransparent(view: vc.view)
            viewControllers.append(vc as! SubSegmentController)
        }
        simpleManager = {
            let Y: CGFloat = glt_iphoneX ? 88.0 : 64
            let H: CGFloat = glt_iphoneX ? (view.bounds.height - Y - 34) : view.bounds.height - Y
            let simpleManager = LTSimpleManager(frame: CGRect(x: 0, y: Y, width: view.bounds.width, height: H), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout)
            simpleManager.delegate = self
            simpleManager.isClickScrollAnimation = true
            setViewBackgroundColorTransparent(view: simpleManager)
            return simpleManager
        }()

        view.addSubview(simpleManager)
        simpleManagerConfig()
        loadGameDatas()
    }
    
    //MARK: - showNewFunctionTipsPage
    private func showNewFunctionTipsPage() {
        let showNewFunctionPage = YiboPreference.getShowHomeNewfunctionTipsPage()
        
        if showNewFunctionPage == "off" {return}
        
        if isEmptyString(str: showNewFunctionPage) {
            let tipsViewButton = self.getNewFunctionTipsPage(image: "homeCommonGame")
            tipsViewButton.tag = 10000 + 101
            tipsViewButton.addTarget(self, action: #selector(showNextTipsView), for: .touchUpInside)
        }
    }
    
    @objc func showNextTipsView(sender: UIButton) {
        if sender.tag == 10000 + 101 {
            sender.isHidden = true
            sender.removeFromSuperview()
            let tipsViewButton = self.getNewFunctionTipsPage(image: "newTheme")
            tipsViewButton.tag = 10000 + 102
            tipsViewButton.addTarget(self, action: #selector(showNextTipsView), for: .touchUpInside)
        }else if sender.tag == 10000 + 102 {
            sender.isHidden = true
            sender.removeFromSuperview()
            YiboPreference.setShowHomeNewfunctionTipsPage(value: "off")
        }
    }
    
    private func getNewFunctionTipsPage(image: String) -> UIButton {
        let tipsViewButton = UIButton()
        tipsViewButton.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(tipsViewButton)
        tipsViewButton.setBackgroundImage(UIImage.init(named: image), for: .normal)
        
        return tipsViewButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print("main page appear ---")
        self.adjustRightBtn()
        self.setupLeftNavigation()
    }
    
    private func setupLeftNavigation() {
        
        let btn = UIButton()
        setViewBackgroundColorTransparent(view: btn)
        updateAppLogo(logo: btn)
    }
    
    private func configLeftBarItem(img: UIImage?,name: String?) {
        self.navigationItem.leftBarButtonItems?.removeAll()
        let leftButton = UIButton()
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.contentMode = .center
        leftButton.layer.masksToBounds = true
        leftButton.backgroundColor = UIColor.white.withAlphaComponent(0)
        leftButton.isUserInteractionEnabled = false
        
        if img != nil {
            leftButton.frame = CGRect.init(x: 0, y: 0, width: leftNaviButtonW, height: 40)
            leftButton.setImage(img, for: .normal)
        }else {
            if let stationName = name {
                leftButton.setImage(nil, for: .normal)
                leftButton.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
                leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
                leftButton.titleLabel?.numberOfLines = 2
                leftButton.titleLabel?.lineBreakMode = .byWordWrapping
                leftButton.setTitle(stationName, for: .normal)
            }else {
                leftButton.setImage(nil, for: .normal)
                leftButton.setTitle(nil, for: .normal)
            }
            
        }
        
        
        let leftBarItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.setLeftBarButton(leftBarItem, animated: false)
    }
    
    func updateAppLogo(logo:UIButton) -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        
        var logoImg = sys.content.lottery_page_logo_url
        if !isEmptyString(str: logoImg){
            logoImg = handleImageURL(logoImgP: logoImg)
            
            let imageURL = URL(string: logoImg)
            
            logo.kf.setImage(with: ImageResource(downloadURL: imageURL!), for: .normal, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cache, url) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    if let imageP = image {
                        let scaleWH =  self.leftNaviButtonW / imageP.size.width
                        let finalImage = imageP.scaleImage(scaleSize: scaleWH)
                        
                        self.configLeftBarItem(img: finalImage, name: "")
                    }
                })
                
            }
        }else {
            let satationName = sys.content.station_name
            if !isEmptyString(str: satationName) {
                self.configLeftBarItem(img: nil, name: satationName)
            }else {
                self.configLeftBarItem(img: nil, name: nil)
            }
        }
        
    }
    
    
    //MARK: 地址可能是相对地址的处理, 应该拿到公共方法里取
    private func handleImageURL(logoImgP: String) -> String{
        var logoImg = logoImgP
        if logoImg.contains("\t"){
            let strs = logoImg.components(separatedBy: "\t")
            if strs.count >= 2{
                logoImg = strs[1]
            }
        }
        logoImg = logoImg.trimmingCharacters(in: .whitespaces)
        if !logoImg.hasPrefix("https://") && !logoImg.hasPrefix("http://"){
            logoImg = String.init(format: "%@/%@", BASE_URL,logoImg)
        }
        
        return logoImg
    }
    
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
            self.navigationItem.rightBarButtonItems = [menuBtn]
        }
    }
    
    func figure_tabs_from_config() -> [String] {
        guard let config = getSystemConfigFromJson() else {return []}
        if config.content != nil{
            var datas:[String] = []
            let version = config.content.lottery_version
            if version == VERSION_V1{
                datas.append("官方")
            }else if version == VERSION_V2{
                datas.append("信用")
            }else if version == VERSION_V1V2{
                datas.append("官方")
                datas.append("信用")
            }
            if !isEmptyString(str: config.content.onoff_zhen_ren_yu_le)&&config.content.onoff_zhen_ren_yu_le=="on"{
                datas.append("真人")
            }
            if !isEmptyString(str: config.content.onoff_sport_switch)&&config.content.onoff_sport_switch=="on"{
                datas.append("体育")
            }
            if !isEmptyString(str: config.content.onoff_dian_zi_you_yi)&&config.content.onoff_dian_zi_you_yi=="on"{
                datas.append("电子")
            }
            return datas
        }
        return []
    }
    
    //加载彩种等所有数据
    func loadGameDatas() {
        request(frontDialog: true, loadTextStr:"获取中...", url:ALL_GAME_DATA_URL,
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
                            self.allDatas.removeAll()
                            self.allDatas = self.allDatas + result.content!
                            
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            YiboPreference.saveLotterys(value: resultJson as AnyObject)
//                            self.reload_when_page_change(index: 0)
                            
                            guard let config = getSystemConfigFromJson() else {return}
                            let version = config.content.lottery_version
                            if version == VERSION_V1V2 {
                                self.simpleManager.scrollToIndex(index: 1)
                                self.reload_when_page_change(index: 1)
                            }else {
                                self.reload_when_page_change(index: 0)
                            }
                            
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
    
    func reload_when_page_change(index:Int){
        if !self.titles.isEmpty{
            if index > self.titles.count || index < 0{
                return
            }
            var datas = self.prepare_data_for_subpage(tabName: self.titles[index])
            let page:SubSegmentController = self.viewControllers[index]
            
            
            datas = datas.sorted{(subDataP1,subDataP2) -> Bool in
                return subDataP1.sortNo > subDataP2.sortNo
            }
            
            page.gameDatas = datas
            page.reload()
        }
    }
        
    func prepare_data_for_subpage(tabName:String) -> [LotteryData]{
        if self.allDatas.isEmpty{
            return []
        }
        var gameDatas:[LotteryData] = []
        for sub in self.allDatas{
            let moduleCode = sub.moduleCode
            let version_str = String.init(format: "%d", sub.lotVersion)
            if tabName == "官方"{
                if moduleCode == CAIPIAO_MODULE_CODE && version_str == VERSION_1{
                    gameDatas = gameDatas + sub.subData
                }
            }else if tabName == "信用"{
                if moduleCode == CAIPIAO_MODULE_CODE && version_str == VERSION_2{
                    gameDatas = gameDatas + sub.subData
                }
            }else if tabName == "真人"{
                if moduleCode == REAL_MODULE_CODE{
                    gameDatas.append(sub)
                }
            }else if tabName == "体育"{
                if moduleCode == SPORT_MODULE_CODE{
                    gameDatas.append(sub)
                }
            }else if tabName == "电子"{
                if moduleCode == GAME_MODULE_CODE{
                    gameDatas.append(sub)
                }
            }
        }
        return gameDatas
    }
}



extension SegmentMallContainerController {
    
    //MARK: 具体使用请参考以下
    private func simpleManagerConfig() {
        
        //MARK: headerView设置
        simpleManager.configHeaderView {[weak self] in
            guard let strongSelf = self else { return nil }
            let headerView = strongSelf.containerHeader()
            return headerView
        }
        
        //MARK: pageView点击事件
        simpleManager.didSelectIndexHandle { (index) in
            print("点击了 \(index) 😆")
            self.reload_when_page_change(index: index)
        }
        //MARK: 控制器刷新事件
        simpleManager.refreshTableViewHandle { (scrollView, index) in
//            scrollView.mj_header = MJRefreshHeader.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 150))
//            scrollView.mj_header.backgroundColor = UIColor.red
//            scrollView.mj_header.endRefreshing()
        }
        
    }
    
    //通知实现跳转
    @objc func commonRecords(nofi:Notification){
        let value = nofi.userInfo!["value"] as! VisitRecords
        if value.cpName == "nodata" {
            let vc = SelectedTBVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let touzhuController = UIStoryboard(name: "touzh_page",bundle:nil).instantiateViewController(withIdentifier: "touzhu")
            let touzhuPage = touzhuController as! TouzhController
            let lotData:LotteryData = LotteryData()
            lotData.name = value.cpName
            lotData.czCode = value.czCode
            lotData.ago = 0
            lotData.code = value.cpBianHao //编码
            lotData.lotType = Int(value.lotType!)!
            lotData.lotVersion = Int(value.lotVersion!)!
            touzhuPage.lotData = lotData
            self.navigationController?.pushViewController(touzhuPage, animated: true)
        }
    }
    
    @objc private func tapLabel(_ gesture: UITapGestureRecognizer)  {
        print("tapLabel☄")
    }
}

extension SegmentMallContainerController: LTSimpleScrollViewDelegate {
    static var recordScroll:[CGFloat] = Array<CGFloat>()
    func glt_scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("offset -> ", scrollView.contentOffset.y)
        GroupMainContainerController.recordScroll.append(scrollView.contentOffset.y)
    }
    
    func glt_scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var lastY:CGFloat = 0.0
        var lastY2:CGFloat = 0.0
        if GroupMainContainerController.recordScroll.count > 10 {
            let last1 = GroupMainContainerController.recordScroll.count - 1
            let last2 = GroupMainContainerController.recordScroll.count - 2
            lastY = GroupMainContainerController.recordScroll[last1]
            lastY2 = GroupMainContainerController.recordScroll[last2]
        }
        
        //下拉到一定程度就弹出(松开了手时触发)
        if   scrollView.contentOffset.y < -40.5 && (lastY < lastY2) {
            scrollView.triggerRefreshing()
        }
        //上滑到一定程度就收回(松开了手时触发) scrollView.contentOffset.y < -60.5  &&
        if scrollView.contentOffset.y > -105 && (lastY > lastY2) {
            scrollView.endRefreshing(isSuccess: true)
        }
    }
}

extension SegmentMallContainerController {
    
    private func containerHeader() -> UIView {
        let headerView = Bundle.main.loadNibNamed("main_header", owner: nil, options: nil)?.first as? MainHeaderView
        headerView?.mainDelegate = self
        headerView?.isUserInteractionEnabled = true
        if let view = headerView {
            view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 230)
            view.didGetNotices = {(hasNotices: Bool) -> Void in
                view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: hasNotices ? 230 : 200)
                self.simpleManager.glt_headerHeight =  hasNotices ? 230 : 200
            }
            //同步主界面头部的数据
            view.syncSomeWebData(controller: self)
        }
        return headerView!
    }
}

extension SegmentMallContainerController : MainViewDelegate{
    func clickFunc(tag: Int) {
        switch tag {
            
        case 100:
            
            if !YiboPreference.getLoginStatus(){
                showToast(view: self.view, txt: "请先登录再使用")
                return
            }
            
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    
                    let str = config.content.mainPageVersion
                    if str == "V1" {
                        if let delegate = self.menuDelegate{
                            delegate.menuEvent(isRight: true)
                        }
                        return
                    }else if str  == "V2" {
                        accountWeb(vcType: 1)
                        return
                    }
                }
            }
            
            if let delegate = self.menuDelegate{
                delegate.menuEvent(isRight: true)
            }
            
        case 101:
            
            if !YiboPreference.getLoginStatus(){
                showToast(view: self.view, txt: "请先登录再使用")
                return
            }
            
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    
                    let str = config.content.mainPageVersion
                    if str == "V1" {
                        if let delegate = self.menuDelegate{
                            delegate.menuEvent(isRight: true)
                        }
                        return
                    }else if str  == "V2" {
                        accountWeb(vcType: 2)
                        return
                    }
                }
            }
            
            if let delegate = self.menuDelegate{
                delegate.menuEvent(isRight: true)
            }
            
        case 102:
            
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    
                    let str = config.content.mainPageVersion
                    if str == "V1" {
                        openAPPDownloadController(controller:self)
                        return
                    }else if str  == "V2" {
                        openActiveController(controller: self)
                        return
                    }
                }
            }
            
            openAPPDownloadController(controller:self)
            
        case 103:
            openContactUs(controller: self)
        default:
            break;
        }
    }
    
    /**
     @vcType: 1表示跳转到存款，2表示提款
     */
    private func accountWeb(vcType: Int) -> Void {
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
                                //                                self.meminfo = memInfo
                                if vcType == 1 {
                                    openChargeMoney(controller: self, meminfo:memInfo)
                                }else if vcType == 2 {
                                    openPickMoney(controller: self, meminfo: memInfo)
                                }
                            }else {
                                showToast(view: self.view, txt: "未获取到账号信息")
                            }
                        }
                    }
        })
    }
}

