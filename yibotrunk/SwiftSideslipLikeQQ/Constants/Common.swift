//
//  Common.swift
//  SwiftSideslipLikeQQ
//
//  Created by JohnLui on 15/4/11.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit
import MBProgressHUD
import Kingfisher
import Reachability
import HandyJSON

let lunarInfo = [ 0x04bd8, 0x04ae0, 0x0a570,
    0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
    0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0,
    0x0ada2, 0x095b0, 0x14977, 0x04970, 0x0a4b0, 0x0b4b5, 0x06a50,
    0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970, 0x06566,
    0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0,
    0x1c8d7, 0x0c950, 0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4,
    0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557, 0x06ca0, 0x0b550,
    0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950,
    0x06aa0, 0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260,
    0x0f263, 0x0d950, 0x05b57, 0x056a0, 0x096d0, 0x04dd5, 0x04ad0,
    0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6,
    0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40,
    0x0af46, 0x0ab60, 0x09570, 0x04af5, 0x04970, 0x064b0, 0x074a3,
    0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0, 0x0c960,
    0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0,
    0x092d0, 0x0cab5, 0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9,
    0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930, 0x07954, 0x06aa0,
    0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65,
    0x0d530, 0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0,
    0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, 0x0b5a0, 0x056d0, 0x055b2,
    0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0 ];

struct Common {
    // Swift 中， static let 才是真正可靠好用的单例模式
    static let screenWidth = UIScreen.main.applicationFrame.maxX
    static let screenHeight = UIScreen.main.applicationFrame.maxY
}

//显示文字提示框
func showToast(view:UIView,txt:String) {
    var dialog:MBProgressHUD!
    if let window = view.window{
        dialog = MBProgressHUD.showAdded(to:  window, animated: true)
    }else{
        dialog = MBProgressHUD.showAdded(to: view, animated: true)
    }
//    dialog.label.text = txt
    dialog.detailsLabel.text = txt
    dialog.isSquare = false
    dialog.mode = .text
    dialog.label.textColor = UIColor.white
    dialog.detailsLabel.textColor = UIColor.white
    dialog.bezelView.color = UIColor.black
    dialog.hide(animated: true, afterDelay: 1)
}

//显示加载框
func showLoadingDialog(view:UIView,loadingTxt txt:String) -> MBProgressHUD {
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.label.text = txt
    hud.label.textColor = UIColor.white
    hud.bezelView.color = UIColor.black
    hud.label.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    hud.backgroundView.style = .solidColor
    hud.activityIndicatorColor = UIColor.white
    hud.hide(animated: true, afterDelay: 2)
    return hud
}
//隐藏加载框
func hideLoadingDialog(hud:MBProgressHUD)  {
    hud.hide(animated: true)
}

func convertString(string: String) -> String {
    let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
    return String(bytes: data!, encoding: String.Encoding.utf8)!
}

//clear picture cache
func clearKingFisher() -> Void {
    let cache = KingfisherManager.shared.cache
    // 清理硬盘缓存，这是一个异步的操作
    cache.clearDiskCache()
    // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
    cache.cleanExpiredDiskCache()
}

func isEmptyString(str:String) -> Bool {
    if str.isEmpty{
        return true
    }
    return false
}

func isPurnInt(string: String) -> Bool {
    let scan: Scanner = Scanner(string: string)
    var val:Int = 0
    return scan.scanInt(&val) && scan.isAtEnd
}

func convertPostMode(mode:Int) -> Int {
    if (mode == YUAN_MODE) {
        return 1;
    } else if (mode == JIAO_MODE) {
        return 10;
    } else if (mode == FEN_MODE) {
        return 100;
    }
    return 1;
}

func getShenXiaoFromNumber(number:String) -> String{
    let numbers = getNumbersFromShengXiao()
    if !numbers.isEmpty{
        for s in numbers{
            if s.contains(number){
                let split = s.components(separatedBy: "|")
                if split.count == 2{
                    return split[0]
                }
            }
        }
    }
    return ""
}

func getShengXiaoFromYear() -> String{
    let shenxiao = getChineseYearWithDate()
    print("shenxiao === ",shenxiao)
    return shenxiao
}

func getChineseYearWithDate() -> String {
    
    let chineseYears = ["甲子", "乙丑", "丙寅", "丁卯",  "戊辰",  "己巳",  "庚午",  "辛未",  "壬申",  "癸酉",
                         "甲戌",   "乙亥",  "丙子",  "丁丑", "戊寅",   "己卯",  "庚辰",  "辛巳",  "壬午",  "癸未",
                          "甲申",   "乙酉",  "丙戌",  "丁亥",  "戊子",  "己丑",  "庚寅",  "辛卯",  "壬辰",  "癸巳",
                           "甲午",   "乙未",  "丙申",  "丁酉",  "戊戌",  "己亥",  "庚子",  "辛丑",  "壬寅",  "癸卯",
                            "甲辰",   "乙巳",  "丙午",  "丁未",  "戊申", "己酉",  "庚戌",  "辛亥",  "壬子",  "癸丑",
                             "甲寅",   "乙卯",  "丙辰",  "丁巳",  "戊午",  "己未",  "庚申",  "辛酉",  "壬戌",  "癸亥"]
    let calendar:Calendar = Calendar(identifier: .chinese);
    var comps:DateComponents = DateComponents()
    comps = calendar.dateComponents([.year,.month,.second], from: Date())
    
    let y_str = chineseYears[comps.year! - 1]
    var shenxiao = ""
    if y_str.hasSuffix("子"){
        shenxiao = "鼠"
    }else if y_str.hasSuffix("丑"){
        shenxiao = "牛"
    }else if y_str.hasSuffix("寅"){
        shenxiao = "虎"
    }else if y_str.hasSuffix("卯"){
        shenxiao = "兔"
    }else if y_str.hasSuffix("辰"){
        shenxiao = "龙"
    }else if y_str.hasSuffix("巳"){
        shenxiao = "蛇"
    }else if y_str.hasSuffix("午"){
        shenxiao = "马"
    }else if y_str.hasSuffix("未"){
        shenxiao = "羊"
    }else if y_str.hasSuffix("申"){
        shenxiao = "猴"
    }else if y_str.hasSuffix("酉"){
        shenxiao = "鸡"
    }else if y_str.hasSuffix("戌"){
        shenxiao = "狗"
    }else if y_str.hasSuffix("亥"){
        shenxiao = "猪"
    }
    return shenxiao
}

func getShenxiaoNumbers(startIndex:Int) -> String{
    let maxValue = 49
    var tmp = startIndex
    var sb = ""
    while tmp <= maxValue {
        sb = sb + String.init(format: "%02d,", tmp)
        tmp = tmp + 12
    }
    if sb.count > 0{
        let index = sb.index(sb.endIndex, offsetBy:-1)
        sb = sb.substring(to: index)
    }
    return sb
}

func getNumbersFromShengXiao() -> [String]{
    let shenxiao = getShengXiaoFromYear();
    var results = Array<String>(repeating:"",count:shenxiao_str.count)
    var bmnIndex = 0;
    for i in 0...shenxiao_str.count-1{
        let item = shenxiao_str[i]
        if item == shenxiao{
            bmnIndex = i
            break
        }
    }
    print("bmnindex = ",bmnIndex)
    for i in 0...shenxiao_str.count-1{
        var startNum = 0
        if i <= bmnIndex{
            startNum = bmnIndex - i + 1
        }else{
            startNum = i - bmnIndex - 1
            if startNum == 0{
                startNum = 12
            }
        }
        let numResult = String.init(format: "%@%@%@", shenxiao_str[i],"|",getShenxiaoNumbers(startIndex:startNum))
        results[i] = numResult
    }
//    for (int i=0;i<arr.length;i++) {
//        String item = arr[i];
//        if (item.equals(shenxiao)) {
//            bmnIndex = i;
//            break;
//        }
//    }
//    Utils.LOG("a","bmnindex = "+bmnIndex);
//    for (int i=0;i<arr.length;i++) {
//        int startNum = 0;
//        if (i <= bmnIndex) {
//            startNum =  (bmnIndex-i) + 1;
//        }else{
//            startNum =  (i-bmnIndex) - 1;
//            if (startNum == 0) {
//                startNum = 12;
//            }
//        }
//        String numResult = arr[i]+"|"+getShenxiaoNumbers(startNum);
//        Utils.LOG("aa","the numresult = "+numResult);
//        results[i] = numResult;
//
//    }
    return results;
}

func loginWhenSessionInvalid(controller:UIViewController) -> Void {
    if !(controller.isViewLoaded && (controller.view.window != nil)){
        return
    }
    let loginVC = UIStoryboard(name: "login", bundle: nil).instantiateViewController(withIdentifier: "login_page")
    let loginPage = loginVC as! LoginController
    loginPage.openFromOtherPage = true
    if let nav = controller.navigationController{
        if nav.isKind(of: MainNavController.self){
            loginPage.globalDelagate = nav as! GlobalDelegate
        }
        nav.pushViewController(loginPage, animated: true)
    }
}

func openRegisterPage(controller:UIViewController) -> Void {
    if !(controller.isViewLoaded && (controller.view.window != nil)){
        return
    }
    let loginVC = UIStoryboard(name: "register_page", bundle: nil).instantiateViewController(withIdentifier: "registerController")
    let regPage = loginVC as! RegisterController
    controller.navigationController?.pushViewController(regPage, animated: true)
}

func openLoginPage(controller:UIViewController) -> Void {
    if !(controller.isViewLoaded && (controller.view.window != nil)){
        return
    }
    let loginVC = UIStoryboard(name: "login", bundle: nil).instantiateViewController(withIdentifier: "login_page")
    let loginPage = loginVC as! LoginController
    loginPage.openFromOtherPage = true
    controller.navigationController?.pushViewController(loginPage, animated: true)
}

func openFeedback(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "device_feedback", bundle: nil).instantiateViewController(withIdentifier: "feedback")
    let settingPage = loginVC as! DeviceFeedBackController
    controller.navigationController?.pushViewController(settingPage, animated: true)
}

//func openWebPay(controller:UIViewController,url:String,params:Dictionary<String,Any>) -> Void {
//    let loginVC = UIStoryboard(name: "pay_web", bundle: nil).instantiateViewController(withIdentifier: "payWeb")
//    let page = loginVC as! PayWebController
//    page.url = url
//    page.params = params
//    controller.navigationController?.pushViewController(page, animated: true)
//}

func openSetting(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "app_setting", bundle: nil).instantiateViewController(withIdentifier: "appSetting")
    let settingPage = loginVC as! AppSettingController
    controller.navigationController?.pushViewController(settingPage, animated: true)
}

func openRainController(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "rain_packet", bundle: nil).instantiateViewController(withIdentifier: "rain_page")
    let page = loginVC as! RainPackageController
    controller.navigationController?.pushViewController(page, animated: true)
}

func openConfirmTouzhu(controller:UIViewController,data:OrderDataInfo,lotCode:String,lotName:String,
                       playName:String,playCode:String,subPlayCode:String,subPlayName:String,cpTypeCode:String) -> Void {
    let loginVC = UIStoryboard(name: "touzhu_order_page", bundle: nil).instantiateViewController(withIdentifier: "confirm_order")
    let page = loginVC as! TouzhuOrderController
    page.order = data
    page.cpBianHao = lotCode
    page.cpName = lotName
    page.playName = playName
    page.playCode = playCode
    page.subPlayCode = subPlayCode
    page.subPlayName = subPlayName
    page.cpTypeCode = cpTypeCode
    controller.navigationController?.pushViewController(page, animated: true)
}

func openContactUs(controller:UIViewController) -> Void {
    
    var url:String = ""
    let system = getSystemConfigFromJson()
    if let value = system{
        let datas = value.content
        if let datasValue = datas{
            url = datasValue.customerServiceUrlLink
        }
    }
    if isEmptyString(str: url){
        showToast(view: controller.view, txt: "没有在线客服链接，请检查是否配置")
        return
    }
    url = url.trimmingCharacters(in: .whitespaces)
    UIApplication.shared.openURL(URL.init(string: url)!)
}

func getSystemConfigFromJson() -> SystemWrapper?{
    let configJson = YiboPreference.getConfig()
    if !isEmptyString(str: configJson){
        if let lotWraper = JSONDeserializer<SystemWrapper>.deserializeFrom(json: configJson) {
            if lotWraper.success{
                return lotWraper
            }
        }
    }
    return nil
}

func openTouzhuRecord(controller:UIViewController,title:String,code:String,recordType:Int=MenuType.CAIPIAO_RECORD) -> Void {
    let loginVC = UIStoryboard(name: "touzhu_record", bundle: nil).instantiateViewController(withIdentifier: "touzhuRecord")
    let recordPage = loginVC as! TouzhuRecordController
    recordPage.titleStr = title
    recordPage.cpBianma = code
    recordPage.recordType = recordType
    recordPage.hidesBottomBarWhenPushed = true
    if let nav = controller.navigationController{
        nav.pushViewController(recordPage, animated: true)
    }
}

func openAccountMingxi(controller:UIViewController,whichPage:Int) -> Void {
    let loginVC = UIStoryboard(name: "account_mingxi_page", bundle: nil).instantiateViewController(withIdentifier: "mingxi")
    let recordPage = loginVC as! AccountMingxiController
    recordPage.pageIndex = whichPage
    if let nav = controller.navigationController{
        nav.pushViewController(recordPage, animated: true)
    }
}

func openTouzhuRecordInPresent(controller:UIViewController,title:String,lotCode:String,recordType:Int){
    let loginVC = UIStoryboard(name: "touzhu_record", bundle: nil).instantiateViewController(withIdentifier: "touzhuRecord")
    let recordPage = loginVC as! TouzhuRecordController
    recordPage.titleStr = title
    recordPage.cpBianma = lotCode
    recordPage.recordType = recordType
    
    let nav = UINavigationController.init(rootViewController: recordPage)
    controller.present(nav, animated: true, completion: nil)
}

func openConvertMoneyPage(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "fee_convert", bundle: nil).instantiateViewController(withIdentifier: "feeConvert")
    let recordPage = loginVC as! FeeConvertController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openBigPanPage(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "bigpan", bundle: nil).instantiateViewController(withIdentifier: "big_pan")
    let recordPage = loginVC as! BigPanController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openQRCodePage(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "qrcode_page", bundle: nil).instantiateViewController(withIdentifier: "qrcodeController")
    let recordPage = loginVC as! QrcodeViewController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openNoticePage(controller:BaseController,notices:[String]) -> Void {
    let loginVC = UIStoryboard(name: "notice_page", bundle: nil).instantiateViewController(withIdentifier: "notice_page")
    let recordPage = loginVC as! NoticesPageController
    recordPage.notices = notices
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openPlayIntroduceController(controller:UIViewController,payRule:String,
                                 touzhu:String,winDemo:String) -> Void {
    let loginVC = UIStoryboard(name: "play_rule_introduction", bundle: nil).instantiateViewController(withIdentifier: "playRule")
    let recordPage = loginVC as! PlayRuleController
    recordPage.playRule = payRule
    recordPage.touzhuTxt = touzhu
    recordPage.winDemoTxt = winDemo
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

//根据后台用户选择的模块风格选择风格
func selectMainStyleByModuleID(styleID:String) -> (xibname:String,identifier:String){
    var id = styleID
    if isEmptyString(str: styleID){
        id = "1"
    }
    //15e风格的主题暂不支持，若用户切换到15d风格，则暂时以经典版展现
    if styleID == "3"{
        id = "1"
    }
    return (String.init(format: "custom%@", id),String.init(format: "main_controller_%@", id))
}

func goMainScreen(controller:UIViewController) -> Void {
    let moduleStyle = YiboPreference.getMallStyle()
    print("module style === ",moduleStyle)
    let (xibname,identifier) = selectMainStyleByModuleID(styleID: moduleStyle)
    let mainViewController = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: identifier) as? RootTabBarViewController
    let menuController = UIStoryboard(name: "Main",bundle:nil).instantiateViewController(withIdentifier: "menu_page") as! MenuController
    menuController.useForSlideMenu = true
    
    guard let mainController = mainViewController else{ return }
    let slideContainer = SlideContainerController(centerViewController: mainController, leftViewController: nil, rightViewController: menuController)
    slideContainer.sideMovable = true
    mainController.menuDelegate = slideContainer//将实现了菜单按钮事件delegate的侧滑容器传入主tab界面
    controller.present(slideContainer, animated: true, completion: nil)
}

func isSaiche(lotType:String) -> Bool{
    return lotType == "8" || lotType == "3" || lotType == "53"
}

func is11x5(lotType:String) -> Bool{
    return lotType.contains("11X5")
}

func isKuaiLeCai(lotCode:String) -> Bool{
    if lotCode == "GDKLSF" || lotCode == "HNKLSF" || lotCode == "CQXYNC"{
        return true
    }
    return false
}

func isFFSSCai(lotType:String) -> Bool{
    return lotType == "1" || lotType == "2" || lotType == "9" || lotType == "51" || lotType == "52"
}

func hideChar(str:String,showBackCharCount:Int) -> String{
    if isEmptyString(str: str){
        return ""
    }
    if str.count < showBackCharCount + 1{
        return str
    }
    var aaa = ""
    for _ in 0...(str.count - showBackCharCount - 1){
        aaa = aaa + "*"
    }
    let start = str.index(str.startIndex, offsetBy: (str.count - showBackCharCount))
    let result = str.substring(from: start)
    return String.init(format: "%@%@", aaa,result)
}

func hideTailChar(str:String,showCount:Int) -> String{
    if isEmptyString(str: str){
        return ""
    }
    if showCount >= str.count{
        return str
    }
    var aaa = ""
    for _ in 0...(str.count - showCount - 1){
        aaa = aaa + "*"
    }
    let end = str.index(str.startIndex, offsetBy: (showCount))
    let result = str.substring(to: end)
    return String.init(format: "%@%@", result,aaa)
}

func createFAB(controller:UIViewController) -> ActionButton {
    
    var items:[(title:String,imgname:String,action: (ActionButtonItem) -> Void)] = []
    let redpack = (title:"抢红包",imgname:"icon_real",action: {(item:ActionButtonItem)->Void in
        openRainController(controller: controller)
    })
    
    var bigpan:(title:String,imgname:String,action: (ActionButtonItem) -> Void)?
    if let sys = getSystemConfigFromJson()  {
        if !isEmptyString(str: sys.content.onoff_turnlate) && sys.content.onoff_turnlate == "on"{
            bigpan = (title:"大转盘",imgname:"icon_game",action:{(item:ActionButtonItem)->Void in
                openBigPanPage(controller: controller)
            })
        }
    }
    let scorechange = (title:"积分兑换",imgname:"app_service_icon",action:{(item:ActionButtonItem)->Void in
        openScoreExchangePage(controller: controller)
    })
    let active = (title:"优惠活动",imgname:"app_download_icon",action:{(item:ActionButtonItem)->Void in
        openActiveController(controller: controller)
    })
    let message = (title:"站内信",imgname:"app_record_icon",action:{(item:ActionButtonItem)->Void in
        openMessageCenter(controller: controller)
    })
    let backcomputer = (title:"返回电脑版",imgname:"app_money_icon",action:{(item:ActionButtonItem)->Void in
        openBrower(urlString: BASE_URL)
    })
    
    items.append(backcomputer)
    items.append(message)
    items.append(active)
    items.append(scorechange)
    if bigpan != nil{
        items.append(bigpan!)
    }
    items.append(redpack)
    
    return showFAB(attachView: controller.view, items: items)
}

func openActiveController(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "active_page", bundle: nil).instantiateViewController(withIdentifier: "activePage")
    let recordPage = loginVC as! ActiveController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openAPPDownloadController(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "app_download_page", bundle: nil).instantiateViewController(withIdentifier: "appDownload")
    let recordPage = loginVC as! AppDownloadViewController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openOpenResultController(controller:UIViewController,cpName:String,
                              cpBianMa:String,cpTypeCode:String,lotVersion:String="") -> Void {
    let loginVC = UIStoryboard(name: "lottery_open_result", bundle: nil).instantiateViewController(withIdentifier: "openResultID")
    let recordPage = loginVC as! LotteryOpenResultController
    recordPage.cpName = cpName
    recordPage.cpBianMa = cpBianMa
    recordPage.cpTypeCode = cpTypeCode
    recordPage.lotVersion = lotVersion
    controller.navigationController?.pushViewController(recordPage, animated: true)
}


func openModifyPwd(controller:UIViewController,loginPwd:Bool) -> Void {
    let loginVC = UIStoryboard(name: "pwd_modify", bundle: nil).instantiateViewController(withIdentifier: "modifyPwd")
    let recordPage = loginVC as! ModifyPwdController
    recordPage.isLoginPwdModify = loginPwd
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openChargeMoney(controller:UIViewController) -> Void {
    
    if let config = getSystemConfigFromJson(){
        if config.content != nil{
            let style = config.content.charge_page_style
            if style == "simple" || isEmptyString(str: style){
                let loginVC = UIStoryboard(name: "charge_money", bundle: nil).instantiateViewController(withIdentifier: "chargeMoney")
                let recordPage = loginVC as! ChargeMoneyController
                controller.navigationController?.pushViewController(recordPage, animated: true)
            }else if style == "classic"{
                let loginVC = UIStoryboard(name: "charge_page_classic", bundle: nil).instantiateViewController(withIdentifier: "charge_classic_page")
                let recordPage = loginVC as! ChargeClassicPageController
                controller.navigationController?.pushViewController(recordPage, animated: true)
            }
        }
    }
}

func openPickMoney(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "withdraw_page", bundle: nil).instantiateViewController(withIdentifier: "withDraw")
    let recordPage = loginVC as! WithdrawController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openActiveDetail(controller:UIViewController,title:String,content:String,foreighUrl:String="") -> Void {
    let loginVC = UIStoryboard(name: "active_detail_page", bundle: nil).instantiateViewController(withIdentifier: "activeDetail")
    let recordPage = loginVC as! ActiveDetailController
    recordPage.titleStr = title
    recordPage.htmlContent = content
    recordPage.foreignUrl = foreighUrl
    if controller.navigationController == nil{
        let nav = UINavigationController.init(rootViewController: recordPage)
        controller.present(nav, animated: true, completion: nil)
    }else{
        controller.navigationController?.pushViewController(recordPage, animated: true)
    }
    //    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openBBINDetail(controller:UIViewController,content:String) -> Void {
    let loginVC = UIStoryboard(name: "bbin_page", bundle: nil).instantiateViewController(withIdentifier: "bbin")
    let recordPage = loginVC as! BBinWebContrllerViewController
    recordPage.htmlContent = content
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openUserCenter(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "user_center", bundle: nil).instantiateViewController(withIdentifier: "userCenter")
    let recordPage = loginVC as! UserCenterController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openBankPwdSetting(controller:UIViewController,delegate:BankDelegate){
    let loginVC = UIStoryboard(name: "set_bank_pwd", bundle: nil).instantiateViewController(withIdentifier: "setBankPwd")
    let recordPage = loginVC as! SetBankPwdController
    recordPage.delegate = delegate
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openBankSetting(controller:UIViewController,delegate:BankDelegate,json:String){
    let loginVC = UIStoryboard(name: "bank_setting", bundle: nil).instantiateViewController(withIdentifier: "bankSetting")
    let recordPage = loginVC as! BankSettingController
    recordPage.delegate = delegate
    recordPage.dataJson = json
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openConfirmPay(controller:UIViewController,orderNo:String,accountName:String,chargeMoney:String,payMethodName:String,
                    receiveName:String,receiveAccount:String,dipositor:String,dipositorAccount:String,qrcodeUrl:String,payType:Int,payJson:String){
    let loginVC = UIStoryboard(name: "confirm_pay", bundle: nil).instantiateViewController(withIdentifier: "confirmPay")
    let recordPage = loginVC as! ConfirmPayController
    recordPage.orderno = orderNo
    recordPage.account = accountName
    recordPage.money = chargeMoney
    recordPage.payMethodName = payMethodName
    recordPage.receiveName = receiveName
    recordPage.reeiveAccount = receiveAccount
    recordPage.dipositor = dipositor
    recordPage.dipositorAccount = dipositorAccount
    recordPage.qrcodeUrl = qrcodeUrl
    recordPage.payType = payType
    recordPage.payJson = payJson
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openMessageCenter(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "message_center", bundle: nil).instantiateViewController(withIdentifier: "mc")
    let recordPage = loginVC as! MessageCenterController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openActive(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "active_page", bundle: nil).instantiateViewController(withIdentifier: "activePage")
    let recordPage = loginVC as! ActiveController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openScoreExchangePage(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "score_change_page", bundle: nil).instantiateViewController(withIdentifier: "scoreExchange")
    let recordPage = loginVC as! ScoreExchangeController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openBraveZuiHaoPage(controller:UIViewController,order:[OrderDataInfo],lotCode:String,lotName:String="") -> Void {
    let loginVC = UIStoryboard(name: "brave_zuihao_page", bundle: nil).instantiateViewController(withIdentifier: "braveZuihao")
    let page = loginVC as! BraveZuihaoController
    page.orderInfo = order
    page.cpBianma = lotCode
    page.cpLotName = lotName
    controller.navigationController?.pushViewController(page, animated: true)
}

func openScoreChange(controller:UIViewController) -> Void {
    //    let loginVC = UIStoryboard(name: "lottery_open_result", bundle: nil).instantiateViewController(withIdentifier: "openResultID")
    //    let recordPage = loginVC as! LotteryOpenResultController
    //    recordPage.cpName = cpName
    //    recordPage.cpBianMa = cpBianMa
    //    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openAboutus(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "aboutus", bundle: nil).instantiateViewController(withIdentifier: "aboutus")
    let recordPage = loginVC as! AboutUsController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}
/**
 
 *  获取当前Year
 
 */

func getYear() ->Int {
    let calendar = Calendar.current
    //这里注意 swift要用[,]这样方式写
    let year = calendar.component(.year, from: Date())
    print("current year = \(year)")
    return year
}

func isMatchRegex(text:String,regex:String) -> Bool{
    let words = NSPredicate.init(format: "SELF MATCHES %@", regex)
    let isMatch = words.evaluate(with: text)
    return isMatch
}

func stringToTimeStamp(stringTime:String)->String {
    
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
    let date = dfmatter.date(from: stringTime)
    let dateStamp:TimeInterval = date!.timeIntervalSince1970
    let dateSt:Int = Int(dateStamp)
    return String(dateSt)
    
}

//timeStamp 单位精确到秒
func timeStampToString(timeStamp:Int64)->String {
    var timeLong = timeStamp
    timeLong = timeLong/1000
    let timeStr:TimeInterval = TimeInterval(timeLong)
    let date = Date(timeIntervalSince1970: timeStr)
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
    let str = dfmatter.string(from: date)
    return str
}

func timeStampToString(timeStamp:Int64,format:String)->String {
    var timeLong = timeStamp
    timeLong = timeLong/1000
    let timeStr:TimeInterval = TimeInterval(timeLong)
    let date = Date(timeIntervalSince1970: timeStr)
    let dfmatter = DateFormatter()
    dfmatter.dateFormat=format
    let str = dfmatter.string(from: date)
    return str
}


/// 秒转换成00:00:00格式
///
/// - Parameter secounds: 秒
/// - Returns:
func getFormatTime(secounds:TimeInterval)->String{
    if secounds.isNaN{
        return "00:00"
    }
    var Min = Int(secounds / 60)
    let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
    var Hour = 0
    if Min>=60 {
        Hour = Int(Min / 60)
        Min = Min - Hour*60
        return String(format: "%02d:%02d:%02d", Hour, Min, Sec)
    }
    return String(format: "00:%02d:%02d", Min, Sec)
}

func getVerionName() -> String{
    let infoDictionary = Bundle.main.infoDictionary
    let majorVersion : AnyObject? = infoDictionary! ["CFBundleShortVersionString"] as AnyObject
    let appversion = majorVersion as! String
    return appversion
}

func getDomainUrl() -> String{
    let infoDictionary = Bundle.main.infoDictionary
    let domainUrlValue : AnyObject? = infoDictionary! ["domain_url"] as AnyObject
    let domainUrl = domainUrlValue as! String
    return domainUrl
}

func isInternalTest() -> Bool{
    let infoDictionary = Bundle.main.infoDictionary
    let internalTest : AnyObject? = infoDictionary! ["internal_test"] as AnyObject
    let result = internalTest as! Bool
    return result
}

func getAppName()->String{
    let infoDictionary = Bundle.main.infoDictionary
    let bundleName: AnyObject? = infoDictionary!["CFBundleName"] as AnyObject as AnyObject
    if let bn = bundleName{
        return bn as! String
    }
    return ""
}

func getAPPID()->String{
    let bid = Bundle.main.bundleIdentifier!
    return bid
}

func checkVersion(controller:BaseController, showDialog:Bool,showText:String){
    controller.request(frontDialog: showDialog, method: .post, loadTextStr: showText, url:CHECK_UPDATE_URL,params:["curVersion":getVerionName(),"appID":getAPPID(),"platform":"ios"],
            callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    if resultJson.isEmpty {
                        showToast(view: controller.view, txt: convertString(string: "检测升级失败"))
                    }else{
                        showToast(view: controller.view, txt: resultJson)
                    }
                    return
                }
                if let result = CheckUpdateWraper.deserialize(from: resultJson){
                    if result.success{
                        YiboPreference.setToken(value: result.accessToken as AnyObject)
                        if let content = result.content{
                            if isEmptyString(str: content.url){
                                return
                            }
                            showUpdateDialog(controller: controller, version: content.version, content: content.content, url: content.url)
                        }
                    }else{
//                        if !isEmptyString(str: result.msg){
//                            showToast(view: controller.view, txt: result.msg)
//                        }else{
//                            showToast(view: controller.view, txt: convertString(string: "检测升级失败"))
//                        }
                    }
                }
    })
}

//免费试玩注册
func freeRegister(controller:BaseController,showDialog:Bool,showText:String,delegate:LoginAndRegisterDelegate?){
    controller.request(frontDialog: showDialog, method: .post, loadTextStr: showText, url:REG_GUEST_URL,
                       callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: controller.view, txt: convertString(string: "注册失败"))
                            }else{
                                showToast(view: controller.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = RegisterResultWraper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                YiboPreference.saveLoginStatus(value: true as AnyObject)
                                //获取注册帐户相关信息
                                if let infos = result.content{
                                    YiboPreference.setAccountMode(value: infos.accountType as AnyObject)
                                    YiboPreference.setVersion(value: infos.cpVersion as AnyObject)
                                    //自动登录的情况下，要记住帐号密码
                                    if infos.accountType != ACCOUNT_PLATFORM_TEST_GUEST{
                                        if YiboPreference.getAutoLoginStatus(){
                                            if !isEmptyString(str: infos.account){
                                                YiboPreference.saveUserName(value: infos.account as AnyObject)
                                            }
                                        }
                                    }
                                }
//                                controller.navigationController?.popViewController(animated: true)
                                controller.onBackClick()
                                if let callback = delegate{
                                    callback.fromRegToLogin()
                                }
                            }else{
                                if let errorMsg = result.msg{
                                    showToast(view: controller.view, txt: errorMsg)
                                }else{
                                    showToast(view: controller.view, txt: convertString(string: "注册失败"))
                                }
                            }
                        }
    })
}

func openBrower(urlString:String)->Void{
    let url = URL.init(string:  urlString)
    if let urlValue = url{
        //根据iOS系统版本，分别处理
        if #available(iOS 10, *) {
            UIApplication.shared.open(urlValue, options: [:],
                                      completionHandler: {
                                        (success) in
                                        print("open success")
            })
        } else {
            UIApplication.shared.openURL(urlValue)
        }
    }
}


func showUpdateDialog(controller:BaseController,version:String,content:String,url:String) ->Void{
    let alertController = UIAlertController(title: "发现新版本",
                                            message: content, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "去更新", style: .default, handler: {
        action in
        openBrower(urlString: url)
    })
    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    do{
        var msg = getAppName() + " " + version + "\n\n"
        if !isEmptyString(str: content){
            let split = content.components(separatedBy: ";")
            if !split.isEmpty{
                for item in split{
                    msg = msg + item + "\n"
                }
            }else{
                msg = msg + content
            }
        }
        msg = msg + "\n"
        let attrStr = try NSAttributedString.init(data: msg.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
        alertController.setValue(attrStr, forKey: "attributedMessage")
    }catch{
        print(error)
    }
    controller.present(alertController, animated: true, completion: nil)
}

//根据彩票编码获取所应的玩法数据
func syncLotteryPlaysByCode(controller:BaseController,lotteryCode:String,shakeDelegate:EnterTouzhuDelegate?) -> Void {
    controller.request(frontDialog: true, loadTextStr:"获取玩法中", url:GAME_PLAYS_URL,params:["lotCode":lotteryCode],
            callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    if resultJson.isEmpty {
                        showToast(view: controller.view, txt: convertString(string: "获取失败"))
                    }else{
                        showToast(view: controller.view, txt: resultJson)
                    }
                    return
                }
                
                let jianjinTouzhuViewController = UIStoryboard(name: "touzh_page", bundle:nil).instantiateViewController(withIdentifier: "jianjin_touzhu")
                if let result = LotPlayWraper.deserialize(from: resultJson){
                    if result.success{
                        if let lotteryPlayValue = result.content{
                            let touzhuPage = jianjinTouzhuViewController as! TouzhController
                            //当进入投注页时，将投注页实例回调到viewController页，方便在手机摇一摇的时候可以回调到投注页中的摇动事件函数
                            if let delegate = shakeDelegate{
                                delegate.bindTouzhuPage(controller: touzhuPage)
                            }
                            touzhuPage.lotData = lotteryPlayValue
                            touzhuPage.cpBianHao = lotteryCode
                            controller.navigationController?.pushViewController(touzhuPage, animated: true)
                        }
                        if let token = result.accessToken{
                            YiboPreference.setToken(value: token as AnyObject)
                        }
                    }else{
                        if let errorMsg = result.msg{
                            showToast(view: controller.view, txt: errorMsg)
                        }else{
                            showToast(view: controller.view, txt: convertString(string: "获取失败"))
                        }
                    }
                }
    })
}

//根据数据计算出peilv collectoinview 两行显示几项，最多两项
func figureOutColumnCount(peilvData:PeilvData) -> Int {
    if peilvData.subData.isEmpty{
        return DEFAULT_COLUMNS
    }
    let data = peilvData.subData[0]
    var count = 2
    if !isEmptyString(str: data.helpNumber){
        count = count + 1
    }
    if !isEmptyString(str: data.number){
        count = count + 1
    }
    if !isEmptyString(str: data.peilv){
        count = count + 1
    }
    if count > 4{
        return 1
    }
    return DEFAULT_COLUMNS
}

class NetwordUtil {
    static func isNetworkValid() -> Bool {
        var reachability: Reachability!
        reachability = Reachability.init(hostname: "baidu.com")
        // 检测网络连接状态
        if reachability.isReachable {
            print("网络连接：可用")
        } else {
            print("网络连接：不可用")
        }
        
        // 检测网络类型
        if reachability.isReachableViaWiFi {
            print("网络类型：Wifi")
        } else if reachability.isReachableViaWWAN {
            print("网络类型：移动网络")
        } else {
            print("网络类型：无网络连接")
        }
        return reachability.isReachable
    }
}

func isZuxuan(playCode:String)->Bool{
    if playCode == zuxuan_san_peilv || playCode == zuxuan_liu_peilv{
        return true
    }
    return false
}

func isLianMaOrQuanbuZhong(playCode:String)->Bool{
    if playCode == lianma || playCode == quanbuzhong{
        return true
    }
    return false
}

func isLianMa(playCode:String)->Bool{
    if playCode == lianma{
        return true
    }
    return false
}

func dontShowPeilvWhenTouzhu(playCode:String) -> Bool{
    if playCode == lianxiao || playCode == hexiao || playCode == weishulian{
        return true
    }
    return false
}

func isQuanBuZhong(playCode:String)->Bool{
    if playCode == quanbuzhong{
        return true
    }
    return false
}

func isMulSelectMode(playCode:String) ->Bool {
    if playCode == zuxuan_san_peilv || playCode == zuxuan_liu_peilv ||
        playCode == lianma_peilv_klsf || playCode == hexiao ||
        playCode == quanbuzhong || playCode == weishulian ||
        playCode == lianma ||
        playCode == lianxiao ||
        playCode == syx5_renxuan ||
        playCode == syx5_zuxuan ||
        playCode == syx5_zhixuan{
        return true
    }
    return false
}

//是否六合彩彩种
func isSixMark(lotCode:String) -> Bool{
    if isEmptyString(str: lotCode) {
        return false;
    }
    return lotCode == "LHC" || lotCode == "SFLHC";
}

func getPeilvDataInCommon(lotCode:String,playCode:String,selectCount:Int,data:PeilvPlayData) -> PeilvWebResult?{
    if (isSixMark(lotCode: lotCode)) {
        return getRightDataWhenSixMark(playCode: playCode, data: data)
    }else{
        return getRightData(selectCount: selectCount, allDatas: data.allDatas)
    }
}

/**
 * 六合彩下注，且多选号码时从赔率数据列表中选择合适的赔率数据
 * @param playCode 大玩法代号
 * @param data 用户选择的号码数据集中的第一个号码数据
 * @return
 */
func getRightDataWhenSixMark(playCode:String,data:PeilvPlayData) -> PeilvWebResult?{
    let addDatas = data.allDatas
    if !addDatas.isEmpty{
        for result in addDatas{
            if playCode == hexiao || playCode == lianxiao{
                if result.isNowYear != 1{
                    return result
                }
            }else if playCode == weishulian{
                //尾数连时，不管选择的号码包不包含"0尾"，都选择"0"尾的赔率id;这里所谓的非0尾以赔率数据中isNowYear来区分；
                //如果isNowYear为1，代表是"0尾"赔率项
                if result.isNowYear == 1{
                    return result
                }
            }else{
                return result
            }
        }
    }
    return PeilvWebResult()
}


/**
 * 多选下注的情况下，从所有赔率数据中选择用户选择项数对应的那个赔率数据
 * @param selectCount
 * @param allDatas
 * @return
 */
func getRightData(selectCount:Int,allDatas:[PeilvWebResult]) -> PeilvWebResult?{
    
    var selectData:PeilvWebResult?
    if allDatas.isEmpty{
        return selectData
    }
    if allDatas.count == 1{
        return allDatas[0]
    }
    for data in allDatas{
        if data.name.contains(String.init(describing: selectCount)){
            selectData = data
            break
        }
    }
    return selectData
}

/**
 * 判断是否是选中的号码
 * @param data
 * @return
 */
func isSelectedNumber(data:PeilvPlayData) ->Bool {
    if data.isSelected{
        return true
    }
    return false
}

func getPeilvPostNumbers(data:PeilvPlayData) -> String{
    var postNumber = ""
    if data.appendTag{
        if data.appendTagToTail{
            postNumber = data.number + "--" + data.itemName
        }else{
            postNumber = data.itemName + "--" + data.number
        }
    }else{
        postNumber = data.number
    }
    return postNumber
}

func limitAccount(account:String) -> Bool{
    let pwdRegx = "^[a-zA-Z0-9]{5,11}$";
    if !isMatchRegex(text: account, regex: pwdRegx){
        return false
    }
    if account.count < 5 || account.count > 11{
        return false
    }
    return true
}

func limitPwd(account:String) -> Bool{
//    let pwdRegx = ".*[a-zA-Z].*[0-9]|.*[0-9].*[a-zA-Z]";
//    if !isMatchRegex(text: account, regex: pwdRegx){
//        return false
//    }
    if account.count < 6 || account.count > 16{
        return false
    }
    return true
}

func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    var urlRequest = URLRequest(url: url)
    urlRequest.addValue(String.init(format: "SESSION=%@", YiboPreference.getToken()), forHTTPHeaderField: "Cookie")
    URLSession.shared.dataTask(with: urlRequest) {
        (data, response, error) in
        completion(data, response, error)
        }.resume()
}

//异步下载图片
func downloadImage(url: URL,imageUI:UIImageView) {
    print("Download Started")
    getDataFromUrl(url: url) { (data, response, error)  in
        guard let data = data, error == nil else { return }
        print(response?.suggestedFilename ?? url.lastPathComponent)
        print("Download Finished")
        DispatchQueue.main.async() { () -> Void in
            imageUI.image = UIImage(data: data)
        }
    }
}

func actionOpenGameList(controller:BaseController,gameCode:String,title:String) -> Void{
    let vc = UIStoryboard(name: "innner_game_list", bundle:nil).instantiateViewController(withIdentifier: "gameList")
    let other = vc as! GameListController
    other.gameCode = gameCode
    other.myTitle = title
    controller.navigationController?.pushViewController(other, animated: true)
}

//获取真人转发数据
func forwardReal(controller:BaseController,requestCode:Int,playCode:String) -> Void{
    //获取列表数据
    var url = ""
    var params:Dictionary<String,AnyObject> = [:]
    if playCode == "ag"{//AG真人娱乐
        url = url + REAL_AG_URL
        params["h5"] = 1 as AnyObject
        params["gameType"] = 11 as AnyObject
    }else if playCode == "mg"{//MG真人娱乐
        url = url + REAL_MG_URL
        params["gameId"] = 66936 as AnyObject
        params["gameType"] = 1 as AnyObject
    }else if playCode == "bbin"{//BBIN真人娱乐
        url = url + REAL_BBIN_URL
        params["type"] = "live" as AnyObject
    }else if playCode == "ab"{//ab真人娱乐
        url = url + REAL_AB_URL
    }else if playCode == "og"{//OG真人娱乐
        url = url + REAL_OG_URL
    }else if playCode == "ds"{//ds真人娱乐
        url = url + REAL_DS_URL
    }
    controller.request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:url,
               params: params,
               callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    if resultJson.isEmpty {
                        showToast(view: controller.view, txt: convertString(string: "获取跳转链接失败"))
                    }else{
                        showToast(view: controller.view, txt: resultJson)
                    }
                    return
                }
                if let result = RealPlayWraper.deserialize(from: resultJson){
                    if result.success{
                        //BBIN 返回的是一段html内容
                        if !isEmptyString(str: result.url){
                            openBrower(urlString: result.url)
                        }else if !isEmptyString(str: result.html){
//                            let encodeWord = result.html.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
//                            guard var param = encodeWord else{return}
                            //将特殊字符替换成转义后的编码
//                            param = param.replacingOccurrences(of: "=", with: "%3D")
//                            param = param.replacingOccurrences(of: "&", with: "%26")
//                            let url = String.init(format: "%@%@%@?html=%@", BASE_URL,PORT,BBIN_SAFARI,param)
//                            print("the open url = ",url)
//                            openBrower(urlString: url)
                            openBBINDetail(controller: controller, content: result.html)
                        }
                    }else{
                        if !isEmptyString(str: result.msg){
                            showToast(view: controller.view, txt: result.msg)
                            if result.msg.contains("超时") || result.msg.contains("登陆"){
                                loginWhenSessionInvalid(controller: controller)
                            }
                        }else{
                            showToast(view: controller.view, txt: convertString(string: "获取跳转链接失败"))
                        }
                    }
                }
    })
}

//获取电子游戏跳转链接
func forwardGame(controller:BaseController,playCode:String,gameCodeOrID:String) -> Void{
    //获取列表数据
    var url = ""
    var params:Dictionary<String,AnyObject> = [:]
    if playCode == "pt"{//PT
        url = url + GAME_PT_URL
        params["h5"] = 1 as AnyObject
        params["gameCode"] = gameCodeOrID as AnyObject
    }else if playCode == "mg"{//MG
        url = url + GAME_MG_URL
        params["gameid"] = gameCodeOrID as AnyObject
        params["gameType"] = 3 as AnyObject
    }else if playCode == "nb"{
        url = url + GAME_NB_URL
        params["gameCode"] = gameCodeOrID as AnyObject
    }else if playCode == "qt"{
        url = url + GAME_QT_URL
        params["gameId"] = gameCodeOrID as AnyObject
    }else if playCode == "kyqp"{
        url = url + GAME_KYQP_URL
        params["kindId"] = gameCodeOrID as AnyObject
    }else if playCode == YHC_CODE{
        url = url + GAME_TT_URL
    }
    controller.request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:url,
                       params: params,
                       callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: controller.view, txt: convertString(string: "获取跳转链接失败"))
                            }else{
                                showToast(view: controller.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = RealPlayWraper.deserialize(from: resultJson){
                            if result.success{
                                if !isEmptyString(str: result.url){
                                    openBrower(urlString: result.url)
                                }
                            }else{
                                if !isEmptyString(str: result.msg){
                                    showToast(view: controller.view, txt: result.msg)
                                    if result.msg.contains("登录") || result.msg.contains("登陆"){
                                        loginWhenSessionInvalid(controller: controller)
                                    }
                                }else{
                                    showToast(view: controller.view, txt: convertString(string: "获取跳转链接失败"))
                                }
                            }
                        }
    })
}

func convertSportBallon(ballType:Int) -> String{
    if ballType == ALL_BALL_CONSTANT{
        return "全部"
    }else if ballType == FOOTBALL_CONSTANT{
        return "足球"
    }else if ballType == BASCKETBALL_CONSTANT{
        return "篮球"
    }
    return "全部"
}

func convertResultStatus(status:Int) -> String {
    if (status == BALANCE_ALL_LOST) {
        return "全输";
    }else if (status == BALANCE_HALF_LOST) {
        return "输一半";
    }else if (status == BALANCE_DRAW) {
        return "平局";
    }else if (status == BALANCE_HALF_WIN) {
        return "赢一半";
    }else if (status == BALANCE_ALL_WIN) {
        return "全赢";
    }
    return "等待开奖";
}

/**
 1 待确认
 2：已确认
 3：已取消 (滚球系统自动取消)
 4: 手动取消
 */
func convertSportBettingStatus(status:Int) -> String{
    if (status == 1) {
        return "待确认";
    } else if (status == 2) {
        return "已确认";
    } else if (status == 3) {
        return "已取消";
    } else if (status == 4) {
        return "手动取消";
    }
    return "等待开奖";
}

func convertSportPan(plate:String) -> String{
    if (plate == "H") {
        return "亚洲盘";
    }
    return "亚洲盘";
}

func convertSportRecordStatus(status:Int,betResult:Float) -> String{
    if status == BALANCE_UNDO{
        return "等待开奖"
    }
    if status == BALANCE_CUT_GAME{
        return "赛事取消"
    }
    if status == BALANCE_DONE || status == BALANCE_AGENT_HAND_DONE ||
        status == BALANCE_BFW_DONE{
        if betResult > 0{
            return String.init(format: "派彩:%.2f元", betResult)
        }
        return "未中奖"
    }
    return "等待开奖"
}

//是否优惠活动
func isActiveShowFunc() -> Bool {
    //获取存储在本地preference中的config
    let system = getSystemConfigFromJson()
    if let value = system{
        let datas = value.content
        if let active = datas?.isActive{
            return active
        }
    }
    return false
}

func convertRealMainPlatformValue(platform:String) -> Int {
    switch platform {
    case "AG":
        return AG_INT
    case "MG":
        return MG_INT
    case "BBIN":
        return BBIN_INT
    case "ALLBET":
        return ALLBET_INT
    case "OG":
        return OG_INT
    case "DS":
        return DS_INT
    default:
        return 0
    }
}

func showFAB(attachView:UIView,items:[(title:String,imgname:String,action: (ActionButtonItem) -> Void)]) -> ActionButton {
    var datas:[ActionButtonItem] = []
    for (title,imgName,action) in items{
        print("title and imgname = ",title,imgName)
        let image = UIImage(named: imgName)!
        let item = ActionButtonItem(title: title, image: image)
        
        item.action = action
        datas.append(item)
    }
    let actionButton = ActionButton(attachedToView: attachView, items: datas)
    actionButton.action = { button in button.toggleMenu() }
    actionButton.setTitle("+", forState: UIControlState())
    actionButton.backgroundColor = UIColor.red
    return actionButton
}

func convertEgameValue(platform:String) -> Int {
    switch platform {
    case "PT":
        return PT_INT
    case "QT":
        return QT_INT
    default:
        return 0
    }
}

