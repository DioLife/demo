//
//  GameMallOneController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/20.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//


import UIKit
import Kingfisher
import GTMRefresh

//import "BHBPopView.h"

//经典版风格界面代码
class GameMallOneController: BaseMainController,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MainViewDelegate {
    
    @IBOutlet weak var gridview:UICollectionView!
    var gameDatas = [LotteryData]()
    var bindShakeDelegate:EnterTouzhuDelegate?
    var headerView:MainHeaderView?
//    var actionButton: ActionButton!//悬浮按钮
    var leftLogo:UIImageView!
    var isTabMode = false//是否分栏模式
    var adatas:[LotteryData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        gridview.delegate = self
        gridview.dataSource = self
        gridview.register(CPViewCell.self, forCellWithReuseIdentifier:"cell")
        gridview.showsVerticalScrollIndicator = false
        //添加头视图
        gridview.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
//        actionButton = createFAB(controller:self)
        //加载数据
        loadGameDatas()
        
        gridview.gtm_addRefreshHeaderView {
            print("go here!! ==== hi")
//            self.gridview.endRefreshing(isSuccess: true)
            self.loadGameDatas()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        adjustRightBtn()
    }

    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
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
    
    func updateAppLogo(img:UIImageView) -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        let logoImg = sys.content.lottery_page_logo_url
        if !isEmptyString(str: logoImg){
            //这里的logo地址是相对地址
            let url = String.init(format: "%@/%@", BASE_URL,logoImg)
            downloadImage(url: URL.init(string: url)!, imageUI: img)
        }
    }
    
    func doMenu() -> Void {
        if let delegate = menuDelegate{
            delegate.menuEvent(isRight: true)
        }
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
                        self.gridview.endRefreshing(isSuccess: true)
                        return
                    }
                    if let result = LotterysWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            //save system config to user default
                            YiboPreference.saveLotterys(value: resultJson as AnyObject)
                            //更新scrollview的contentSize大小
                            if let lotterysValue = result.content{
                                self.adatas.removeAll()
                                self.adatas = self.adatas + lotterysValue
                                self.updateScrollHeight(datas: self.adatas)
                            }
                           // self.gridview.endRefreshing(isSuccess: true)
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            self.gridview.endRefreshing(isSuccess: true)
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                            self.gridview.endRefreshing(isSuccess: true)
                        }
                    }
        })
        
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //创建头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            //添加头部视图
            header.addSubview(self.addHeaderContent())
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: kScreenWidth, height: isTabMode ? 310 : 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth-0.5*6)/3, height: 130)
    }
    
    func isTabsMode() -> Bool{
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let mode = config.content.mobileIndex
                return mode == "v4"
            }
        }
        return false
    }
    
    func getTabArray() -> [String]{
        var arr:[String] = ["彩票"]
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let zhenren = config.content.onoff_zhen_ren_yu_le
                if zhenren == "on"{
                    arr.append("真人")
                }
                let dianzhi = config.content.onoff_dian_zi_you_yi
                if dianzhi == "on"{
                    arr.append("电子")
                }
                let hgsport = config.content.onoff_sports_game
                let sbsport = config.content.onoff_shaba_sports_game
                if hgsport == "on" || sbsport == "on"{
                    arr.append("体育")
                }
                let chessSwitch = config.content.nbchess_showin_mainpage
                if chessSwitch == "on"{
                    arr.append("棋牌")
                }
            }
        }
        return arr
    }
    
    func addHeaderContent() -> UIView {
        if headerView == nil{
            headerView = Bundle.main.loadNibNamed("main_header", owner: nil, options: nil)?.first as? MainHeaderView
            headerView?.mainDelegate = self
            headerView?.controller = self
            if let view = headerView{
                isTabMode = isTabsMode()
                view.toggleMainTabs(show: isTabMode)
                if self.isTabMode{
                    view.mainTabs.menuBarDelegate = self
                    view.mainTabs.updateTabs(arr:getTabArray())
                }
                view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: isTabMode ? 310 : 260)
                //同步主界面头部的数据
                view.syncSomeWebData(controller: self)
                //根据后台配置切换优惠活动还是app下载
                view.updateFuncBtn()
            }
        }
        return headerView!
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameDatas.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CPViewCell
        if let lotName = self.gameDatas[indexPath.row].name{
            cell.titleLabel?.text = lotName
        }else{
            cell.titleLabel?.text = "暂无名称"
        }
        let data = self.gameDatas[indexPath.row]
        if data.moduleCode == CAIPIAO_MODULE_CODE{
            guard let lotCode = data.code else {
                cell.imgView?.image = UIImage(named: "default_lottery")
                return cell
            }
            // set lottery picture
            var name = lotCode
            if lotCode == YHC_CODE{
                name = "native_" + lotCode
            }
            let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + name + ".png")
            cell.imgView?.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            let imgUrl = data.imgUrl
            if !isEmptyString(str: imgUrl) {
                let imageURL = URL(string: BASE_URL + PORT + imgUrl)
                if let url = imageURL{
                    downloadImage(url: url, imageUI: cell.imgView!)
                }
            }else{
                var defaultIcon = UIImage.init(named: "icon_ft")
                if data.moduleCode == SPORT_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_ft")
                } else if data.moduleCode == REAL_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_real")
                } else if data.moduleCode == GAME_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_game")
                }
                cell.imgView?.image = defaultIcon
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lotData = self.gameDatas[indexPath.row]
//        let data = self.gameDatas[indexPath.row]
        if lotData.moduleCode == CAIPIAO_MODULE_CODE{
            guard let code = lotData.code else {return}
            if code == YHC_CODE{
                forwardGame(playCode: code)
                return
            }
            syncLotteryPlaysByCode(controller: self, lotteryCode: code, shakeDelegate: self.bindShakeDelegate)
        }else{
            guard let dCode = lotData.czCode else {return}
            if lotData.moduleCode == SPORT_MODULE_CODE{
                if !YiboPreference.getLoginStatus(){
                    showToast(view: self.view, txt: "您还没有登陆，请登陆后重试")
                    loginWhenSessionInvalid(controller: self)
                    return
                }
                if dCode == "hgty"{
                    let vc = UIStoryboard(name: "sport_page", bundle:nil).instantiateViewController(withIdentifier: "sport")
                    let sport = vc as! SportController
                    self.navigationController?.pushViewController(sport, animated: true)
                }else if dCode == "sbty"{
                    //跳转到第三方链接
//                    let vc = UIStoryboard(name: "sport_page", bundle:nil).instantiateViewController(withIdentifier: "sport")
//                    let sport = vc as! SportController
//                    self.navigationController?.pushViewController(sport, animated: true)
                    requestSbSportUrl()
                }
            }else if lotData.moduleCode == REAL_MODULE_CODE{
                forwardReal(controller: self, requestCode: 0, playCode: dCode)
            }else if lotData.moduleCode == GAME_MODULE_CODE || lotData.moduleCode == CHESS_MODULE_CODE{
                forwardGame(playCode: dCode)
            }
        }
    }
    
    func requestSbSportUrl(){
        request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:SPSPORT_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SBSportForwardWrapper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.content){
                                openBrower(urlString: result.content)
                            }else{
                                showToast(view: self.view, txt: "没有链接，无法打开")
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                                if result.msg == "超时" || result.msg == "登录"{
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                            }
                        }
                    }
        })
    }
    
    //获取电子游戏转发数据
    func forwardGame(playCode:String) -> Void {
        var url = ""
        var params:Dictionary<String,AnyObject> = [:]
        if playCode == "ag"{
            url = url + REAL_AG_URL
            params["h5"] = 0 as AnyObject
//            params["gameType"] = 6 as AnyObject
        }else if playCode == "mg" || playCode == "pt" || playCode == "nb" || playCode == "qt" || playCode == "kyqp"{
            //MG,PT电子是先在自已应用内部展示游戏列表，点列表项再请求数据
            var name = ""
            if playCode == "mg"{
                name = "MG电子游戏"
            }else if playCode == "pt"{
                name = "PT电子游戏"
            }else if playCode == "nb"{
                name = "NB棋牌"
            }else if playCode == "qt"{
                name = "QT电子"
            }else if playCode == "kyqp"{
                name = "开元棋牌"
            }
            actionOpenGameList(controller: self,gameCode: playCode,title: name)
        }else if playCode == "qt"{//BBIN真人娱乐
            showToast(view: self.view, txt: "即将开放")
            return;
        }else if playCode == "bydr"{
            url = url + "/forwardAg.do"
            params["h5"] = 0 as AnyObject
            params["gameType"] = 6 as AnyObject
        }else if playCode == YHC_CODE{
            url = url + GAME_TT_URL
        }
        request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:url,
                params: params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = RealPlayWraper.deserialize(from: resultJson){
                        if result.success{
                            //AG,MG,AB,OG,DS都返回跳转链接
                            //BBIN 返回的是一段html内容
                            if !isEmptyString(str: result.url){
                                openBrower(urlString: result.url)
                            }else if !isEmptyString(str: result.html){
//                                openBrower(urlString: result.html)
//                                let encodeWord = result.html.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
//                                guard var param = encodeWord else{return}
                                //将特殊字符替换成转义后的编码
//                                param = param.replacingOccurrences(of: "=", with: "%3D")
//                                param = param.replacingOccurrences(of: "&", with: "%26")
//                                let url = String.init(format: "%@%@%@?html=%@", BASE_URL,PORT,BBIN_SAFARI,param)
//                                print("the open url = ",url)
//                                openBrower(urlString: url)
                                openBBINDetail(controller: self, content: result.html)
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                                if result.msg == "超时" || result.msg == "其他"{
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                            }
                        }
                    }
        })
    }
    
    func updateScrollHeight(datas:[LotteryData],tabName:String="") -> Void {
        
        var cp:[LotteryData] = []
        var sport:[LotteryData] = []
        var zhenren:[LotteryData] = []
        var dianzi:[LotteryData] = []
        var chess:[LotteryData] = []
        
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                for data in datas{
                    if data.moduleCode == CAIPIAO_MODULE_CODE{
                        cp.append(data)
                    }else if data.moduleCode == REAL_MODULE_CODE{
                        zhenren.append(data)
                    }else if data.moduleCode == GAME_MODULE_CODE{
                        dianzi.append(data)
                    }else if data.moduleCode == SPORT_MODULE_CODE{
                        sport.append(data)
                    }else if data.moduleCode == CHESS_MODULE_CODE{
                        chess.append(data)
                    }
                }
                self.gameDatas.removeAll()
                let mobileIndex = config.content.mobileIndex
                if mobileIndex == "v1"{
                    self.gameDatas = self.gameDatas + cp
                    self.gameDatas = self.gameDatas + sport
                    self.gameDatas = self.gameDatas + zhenren
                    self.gameDatas = self.gameDatas + dianzi
                }else if mobileIndex == "v2"{
                    self.gameDatas = self.gameDatas + zhenren
                    self.gameDatas = self.gameDatas + dianzi
                    self.gameDatas = self.gameDatas + cp
                    self.gameDatas = self.gameDatas + sport
                }else if mobileIndex == "v3"{
                    self.gameDatas = self.gameDatas + sport
                    self.gameDatas = self.gameDatas + cp
                    self.gameDatas = self.gameDatas + zhenren
                    self.gameDatas = self.gameDatas + dianzi
                }else if mobileIndex == "v4"{
                    if tabName == "彩票"{
                        self.gameDatas = self.gameDatas + cp
                    }else if tabName == "真人"{
                        self.gameDatas = self.gameDatas + zhenren
                    }else if tabName == "电子"{
                        self.gameDatas = self.gameDatas + dianzi
                    }else if tabName == "体育"{
                        self.gameDatas = self.gameDatas + sport
                    }else if tabName == "棋牌"{
                        self.gameDatas = self.gameDatas + chess
                    }else{
                        self.gameDatas = self.gameDatas + cp
                    }
                }else{
                    self.gameDatas = self.gameDatas + cp
                    self.gameDatas = self.gameDatas + sport
                    self.gameDatas = self.gameDatas + zhenren
                    self.gameDatas = self.gameDatas + dianzi
                }
            }
        }
        
        self.gridview.reloadData()
        self.gridview.endRefreshing(isSuccess: true)
        self.gridview.collectionViewLayout.invalidateLayout()
    }
    
    func clickFunc(tag: Int) {
        switch tag {
        case 100,101:
            if let delegate = self.menuDelegate{
                delegate.menuEvent(isRight: true)
            }
        case 102:
            if isActiveShowFunc(){
                openActiveController(controller: self)
            }else{
                openAPPDownloadController(controller:self)
            }
        case 103:
            openContactUs(controller: self)
        default:
            break;
        }
    }
    
}

extension GameMallOneController : MainTabsBarDelegate{
    func onTabClick(itemTxt: String) {
        self.updateScrollHeight(datas: self.adatas,tabName: itemTxt)
    }
}

