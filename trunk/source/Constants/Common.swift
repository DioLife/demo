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
import AVFoundation
import AudioToolbox


var audioPlayer: AVAudioPlayer!
func playAlertSound(path:String, isShock:Bool=false) {//播放音频或震动
    let path = Bundle.main.path(forResource: path, ofType: "mp3")
    let pathURL = NSURL(fileURLWithPath: path!)
    
    if isShock {//true 音频带震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: pathURL as URL)
        audioPlayer?.play()
//        audioPlayer?.volume = 80 //调节音量
    } catch {
        audioPlayer = nil
    }
}

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

func convertPostMode(mode:String) -> Int {
    if (mode == YUAN_MODE) {
        return 1;
    } else if (mode == JIAO_MODE) {
        return 10;
    } else if (mode == FEN_MODE) {
        return 100;
    }else {
        return 1;
    }
    
}

func str_from_mode(mode:String) -> String{
    if mode == YUAN_MODE{
        return "元"
    }else if mode == JIAO_MODE{
        return "角"
    }else if mode == FEN_MODE{
        return "分"
    }else {
        return "元"
    }
    
}

func getShengXiaoFromYear() -> String{
    let shenxiao = getChineseYearWithDate()
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

func getNumbersFromShenXiaoName(sx:String) -> [String]{
    let numbers = getNumbersFromShengXiao()
    if !numbers.isEmpty{
        for s in numbers{
            if s.contains(sx){
                let split = s.components(separatedBy: "|")
                if split.count == 2{
                    let fs = split[1].components(separatedBy: ",")
                    return fs
                }
            }
        }
    }
    return []
}
func getNumberStrFromShenXiaoName(sx:String) -> String{
    let numbers = getNumbersFromShengXiao()
    if !numbers.isEmpty{
        for s in numbers{
            if s.contains(sx){
                let split = s.components(separatedBy: "|")
                if split.count == 2{
                    return split[1]
                }
            }
        }
    }
    return ""
}

func getWeishuArrays() -> [String]{
    var list = [String]()
    list.append("1|1,11,21,31,41")
    list.append("2|2,12,22,32,42")
    list.append("3|3,13,23,33,43")
    list.append("4|4,14,24,34,44")
    list.append("5|5,15,25,35,45")
    list.append("6|6,16,26,36,46")
    list.append("7|7,17,27,37,47")
    list.append("8|8,18,28,38,48")
    list.append("9|9,19,29,39,49")
    list.append("0|10,20,30,40")
    return list;
}

func getWeishuFromArrays(index:Int) ->String{
    let array = getWeishuArrays()
    if array.count > 0{
        return array[index]
    }
    return ""
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
    return results;
}

func loginWhenSessionInvalid(controller:UIViewController,canBack:Bool=true) -> Void {

    if !(controller.isViewLoaded) {
        return
    }
    let loginVC = UIStoryboard(name: "login", bundle: nil).instantiateViewController(withIdentifier: "login_page")
    let loginPage = loginVC as! LoginController
    loginPage.openFromOtherPage = true
    loginPage.canBack = canBack
    controller.present(loginPage, animated: true, completion: nil)
}

func openRegisterPage(controller:UIViewController) -> Void {
    if !(controller.isViewLoaded && (controller.view.window != nil)){
        return
    }
    let loginVC = UIStoryboard(name: "register_page", bundle: nil).instantiateViewController(withIdentifier: "registerController")
    let regPage = loginVC as! RegisterController
//    controller.navigationController?.pushViewController(regPage, animated: true)
    controller.present(regPage, animated: true) {
        
    }
}

func openLoginPage(controller:UIViewController) -> Void {
    if !(controller.isViewLoaded && (controller.view.window != nil)){
        return
    }
    let loginVC = UIStoryboard(name: "login", bundle: nil).instantiateViewController(withIdentifier: "login_page")
    let loginPage = loginVC as! LoginController
    loginPage.openFromOtherPage = true
//    controller.navigationController?.pushViewController(loginPage, animated: true)
    controller.present(loginPage, animated: true) {
    }
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


//进入奖金版主单页
func openBetOrderPage(controller:UIViewController,data:[OrderDataInfo],lotCode:String,lotName:String,subPlayCode:String,subPlayName:String,
                      cpTypeCode:String,cpVersion:String,officail_odds:[PeilvWebResult],icon:String="",meminfo:Meminfo?) -> Void {
    let loginVC = UIStoryboard(name: "touzhu_order_page", bundle: nil).instantiateViewController(withIdentifier: "confirm_order")
    let page = loginVC as! TouzhuOrderController
    page.order = data
    page.cpBianHao = lotCode
    page.cpName = lotName
    page.subPlayCode = subPlayCode
    page.subPlayName = subPlayName
    page.cpTypeCode = cpTypeCode
    page.cpVersion = cpVersion
    page.officail_odds = officail_odds
    page.lotteryIcon = icon
    page.meminfo = meminfo
    controller.navigationController?.pushViewController(page, animated: true)
}

//进入赔率版主单页
//func openPeilvBetOrderPage(controller:UIViewController,data:[OrderDataInfo],lotCode:String,lotName:String,subPlayName:String,
//                           cpTypeCode:String,cpVersion:String,playRules:[BcLotteryPlay],odds:[HonestResult],
//                           playCode:String) -> Void {
//    let loginVC = UIStoryboard(name: "peilv_order_page", bundle: nil).instantiateViewController(withIdentifier: "peilv_order")
//    let page = loginVC as! PeilvOrderController
//    controller.navigationController?.pushViewController(page, animated: true)
//}
//

func openPeilvBetOrderPage(controller:UIViewController,order:[OrderDataInfo],
                           peilvs:[BcLotteryPlay],lhcLogic:LHCLogic2,
                           subPlayName:String,subPlayCode:String,
                           cpTypeCode:String,cpBianHao:String,
                           current_rate:Float,cpName:String,cpversion:String="",icon:String="") -> Void {
    let loginVC = UIStoryboard(name: "peilv_order_page", bundle: nil).instantiateViewController(withIdentifier: "peilv_order")
    
    let page = loginVC as! PeilvOrderController
    page.order = order
    page.peilvs = peilvs
    page.lhcLogic = lhcLogic
    
    page.subPlayName = subPlayName
    page.subPlayCode = subPlayCode
    page.cpTypeCode = cpTypeCode
    page.cpBianHao = cpBianHao
    page.current_rate = current_rate
    page.cpName = cpName
    page.cpVersion = cpversion
    page.lotteryicon = icon
    
//    page.onAgainBtnClick = {(shouldClearData: Bool) -> Void in
////        controller.
//    }

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
//    let loginVC = UIStoryboard(name: "bigpan", bundle: nil).instantiateViewController(withIdentifier: "big_pan")
//    let recordPage = loginVC as! BigPanController
//    controller.navigationController?.pushViewController(recordPage, animated: true)
    
    let loginVC = UIStoryboard(name: "NewBigPanController", bundle: nil).instantiateViewController(withIdentifier: "newBigPanController")
    let recordPage = loginVC as! NewBigPanController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openQRCodePage(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "qrcode_page", bundle: nil).instantiateViewController(withIdentifier: "qrcodeController")
    let recordPage = loginVC as! QrcodeViewController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openNoticePage(controller:BaseController,notices:[NoticeBean]) -> Void {
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
    return (String.init(format: "custom%@", id),String.init(format: "main_controller_%@", id))
}

//func setupNavigationBar() {
//    
//}

func goBetPage(controller:UIViewController,lotData:LotteryData?) -> Void{
    let touzhuController = UIStoryboard(name: "touzh_page",bundle:nil).instantiateViewController(withIdentifier: "touzhu")
    let touzhuPage = touzhuController as! TouzhController
    touzhuPage.lotData = lotData
    let lotMenuController = UIStoryboard(name: "lot_menu_page",bundle:nil).instantiateViewController(withIdentifier: "lot_menu") as! LotMenuController
    let slideContainer = SlideContainerController(centerViewController: touzhuPage, leftViewController: lotMenuController, rightViewController: nil)
    //    slideContainer.sideMovable = true
    slideContainer.scaleEnable = false
    touzhuPage.menuDelegate = slideContainer//将实现了菜单按钮事件delegate的侧滑容器传入主tab界面
    controller.navigationController?.pushViewController(slideContainer, animated: true)
    //    controller.present(slideContainer, animated: true, completion: nil)
}

// 是否特殊的玩法球背景，长方形背景，如快三的某些玩法
func isSpeicalOfficalBall(playCode:String,lotType:String) -> Bool{
    if playCode == "qwxdds" && lotType == "5"{
        return true
    }
    return false
}


func goMainScreen(controller:UIViewController) -> Void {
    let moduleStyle = YiboPreference.getMallStyle()
    print("module style === ",moduleStyle)
    let (xibname,identifier) = selectMainStyleByModuleID(styleID: moduleStyle)
    
    let mainViewController = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: identifier) as? RootTabBarViewController
    guard let mainController = mainViewController else{ return }
    
    let menuController = UIStoryboard(name: "menu_page",bundle:nil).instantiateViewController(withIdentifier: "menu_page") as! MenuController
    menuController.useForSlideMenu = true
    
    let slideContainer = SlideContainerController(centerViewController: mainController, leftViewController: nil, rightViewController: menuController)
    slideContainer.sideMovable = true
    
    mainController.menuDelegate = slideContainer//将实现了菜单按钮事件delegate的侧滑容器传入主tab界面
    controller.present(slideContainer, animated: true, completion: nil)
    
}

//普通用户时，是否要过滤代理用户专属的指定项
func needDailiFilterItem(txtName:String) -> Bool{
//    let dailiFilter:[String] = ["团队报表","团队总览","用户列表","注册管理","代理管理","推广管理"]
    let dailiFilter:[String] = ["团队报表","团队总览","代理管理","推广链接"]
    if YiboPreference.getAccountMode() == MEMBER_TYPE || YiboPreference.getAccountMode() == GUEST_TYPE{
        if dailiFilter.contains(txtName){
            return true
        }
    }
    return false
}

//开关控制
func needFilterSystemItem(txtName:String) -> Bool{
    if let sys = getSystemConfigFromJson() {
        if sys.content != nil{
            
            if txtName == "额度转换" {
                let switch_money_change = sys.content.switch_money_change
                if !isEmptyString(str: switch_money_change) && switch_money_change == "on"{
                    return false
                }
            }
        }
    }
    return true
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

/**
 字典转换为JSONString
 
 - parameter dictionary: 字典参数
 
 - returns: JSONString
 */
func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : NSData! = try! JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
    
}

func getUserType(t:Int) -> String{
    if t == AGENT_TYPE{
        return "代理"
    }else if t == MEMBER_TYPE{
        return "会员"
    }else if t == TOP_AGENT_TYPE{
        return "总代理"
    }else if t == GUEST_TYPE{
        return "试玩账号"
    }
    return ""
}

//根据主单列表计算注单
func fromBetOrder(official_orders:[OfficialOrder],subPlayName:String,subPlayCode:String,selectedBeishu:Int,
                  cpTypeCode:String,cpBianHao:String,current_rate:Float,selectMode:String) -> [OrderDataInfo] {
    var orders:[OrderDataInfo] = []
    
//    let mode = official_orders.count > 0 ? official_orders[0].m : 1
    
    for order in official_orders{
        let orderInfo = OrderDataInfo()
        orderInfo.user = YiboPreference.getUserName()
        orderInfo.subPlayName = subPlayName
        orderInfo.subPlayCode = subPlayCode
        orderInfo.beishu = selectedBeishu
        orderInfo.zhushu = order.n
        orderInfo.numbers = order.c
        orderInfo.cpCode = cpTypeCode
        orderInfo.lotcode = cpBianHao
        orderInfo.lottype = cpTypeCode
        orderInfo.rate = Double(current_rate)
        orderInfo.oddsCode = order.i
        orderInfo.oddsName = order.oddName
        orderInfo.mode = convertPostMode(mode: selectMode)
        let total_money = (Float(order.n) * Float(selectedBeishu) * Float(2)) / Float(orderInfo.mode)
        print("total money when enter order page = ",total_money)
        orderInfo.money = Double(total_money)
//        orderInfo.money = Double(order.a)
        orders.append(orderInfo)
    }
    return orders
}

func fromPeilvBetOrder(peilv_orders:[PeilvOrder],subPlayName:String,subPlayCode:String,
                       cpTypeCode:String,cpBianHao:String,current_rate:Float) -> [OrderDataInfo] {
    var orders:[OrderDataInfo] = []
    for order in peilv_orders{
        let orderInfo = OrderDataInfo()
        orderInfo.user = YiboPreference.getUserName()
        orderInfo.subPlayName = subPlayName
        orderInfo.subPlayCode = subPlayCode
        orderInfo.money = Double(order.a)
        orderInfo.numbers = order.c
        orderInfo.cpCode = cpTypeCode
        orderInfo.lotcode = cpBianHao
        orderInfo.lottype = cpTypeCode
        orderInfo.rate = Double(current_rate)
        orderInfo.oddsCode = order.i
        orderInfo.cpCode = order.d
        orderInfo.oddsName = order.oddName
        orders.append(orderInfo)
    }
    return orders
}

/**
 * random generate lottery ballon numbers
 * @param allowRepeat 是否允许重复号码
 * @param numCount 选择几个号码
 * @param format 号码字符串分隔格式
 * @param numStr 被随机选择的字符串
 * @return
 */
func randomNumbers(numStr:String,allowRepeat:Bool,numCount:Int,format:String) -> [String]{
    var results = numStr.components(separatedBy: format)
    if results.isEmpty{
        return []
    }
    let maxNum = results.count
    var i = 0
    var count = 0
    var numbers = [String]()
    while count < numCount {
        i = Int(arc4random() % UInt32(maxNum))
        if !allowRepeat{
            if numbers.contains(results[i]){
                continue
            }
        }
        numbers.append(results[i])
        count += 1
    }
    results.removeAll()
    return numbers

}

//MARK: 地址可能是相对地址的处理
func handleImageURL(urlString: String) -> String{
    
    if isEmptyString(str: urlString) {
        return ""
    }
    
    var logoImg = urlString
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

//MARK: - Theme
func setThemeViewThemeColor(view: UIView) {
    view.theme_backgroundColor = "Global.themeColor"
}

func setThemeViewColorGlassWhiteOtherGray(view: UIView) {
    view.theme_backgroundColor = "FrostedGlass.viewGrayGlassOtherGray"
}

func setThemeTextViewTextColorGlassWhiteOtherRed(textView: UITextView) {
        textView.theme_textColor = "FrostedGlass.textGlassWhiteOtherRed"
}

func setThemeLabelTextColorWithNavTextColor(label: UILabel) {
    label.theme_textColor = "Global.barTextColor"
}

func setThemeLabelTextColorGlassWhiteOtherRed(label: UILabel) {
    label.theme_textColor = "FrostedGlass.textGlassWhiteOtherRed"
}

func setThemeLabelTextColorGlassBlackOtherDarkGray(label: UILabel) {
    label.theme_textColor = "FrostedGlass.normalDarkTextColor"
}

func setThemeButtonTitleColorGlassBlackOtherDarkGray(button: UIButton) {
    button.theme_setTitleColor("FrostedGlass.normalDarkTextColor", forState: .normal)
}

func setThemeLabelTextColorGlassWhiteOtherBlack(label: UILabel) {
    label.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
}

func setThemeButtonTitleColorGlassWhiteOtherBlack(button: UIButton) {
    button.theme_setTitleColor("FrostedGlass.glassTextWiteOtherBlack", forState: .normal)
}

func setThemeLabelTextColorGlassWhiteOtherGray(label: UILabel) {
    label.theme_textColor = "FrostedGlass.textGlassWhiteOtherGray"
}

func setThemeButtonTitleColorGlassWhiteOtherGray(button: UIButton) {
    button.theme_setTitleColor("FrostedGlass.textGlassWhiteOtherGray", forState: .normal)
}

 func setupthemeBgView(view: UIView?,alpha: CGFloat = 0.2) {
    if let viewP = view {
        
        setViewBackgroundColorTransparent(view: viewP)

        let bgImageView = UIImageView()
        viewP.addSubview(bgImageView)
        bgImageView.whc_Top(0).whc_Left(0).whc_Bottom(0).whc_Right(0)
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.theme_image = "FrostedGlass.ColorImage"
        viewP.insertSubview(bgImageView, at: 0)

        var bgView = UIView()
        viewP.addSubview(bgView)
        bgView = bgView.whc_FrameEqual(bgImageView)
        bgView.theme_backgroundColor = "FrostedGlass.ColorImageCoverColor"
        
        if alpha == 0 {
            bgView.theme_alpha = "FrostedGlass.ColorImageCoverAlphZeroForGlass"
        }else {
            bgView.theme_alpha = "FrostedGlass.ColorImageCoverAlpha"
        }
        
        viewP.insertSubview(bgView, at: 1)
    }
}


func setupNoPictureAlphaBgView(view: UIView?,alpha: CGFloat = 0.2,bgViewColor: String = "FrostedGlass.subColorImageCoverColor") {
    
    if let viewP = view {
        setViewBackgroundColorTransparent(view: viewP)
        var bgView = UIView()
        viewP.addSubview(bgView)
        bgView.isUserInteractionEnabled = false
        bgView = bgView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        bgView.theme_backgroundColor = ThemeColorPicker.init(keyPath: bgViewColor)
        
        if alpha > 0.2 {
            bgView.theme_alpha = "FrostedGlass.ColorImageCoverAlphHigerForGlass"
        }else {
            bgView.theme_alpha = "FrostedGlass.ColorImageCoverAlpha"
        }
        
        viewP.insertSubview(bgView, at: 0)
    }
}

func setThemeViewNoTransparentDefaultGlassBlackOtherGray(view: UIView,bgViewColor: String = "FrostedGlass.viewColorGlassBlackOtherGray") {

    setViewBackgroundColorTransparent(view: view)
    var bgView = UIView()
    view.addSubview(bgView)
    bgView.isUserInteractionEnabled = false
    bgView = bgView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
    bgView.theme_backgroundColor = ThemeColorPicker.init(keyPath: bgViewColor)
    
    view.insertSubview(bgView, at: 0)
}

func setViewAlphaWithTheme(view: UIView) {
    view.theme_backgroundColor = "FrostedGlass.ColorImageCoverAlpha"
}

func setViewBackgroundColorTransparent(view: UIView,alpha:CGFloat = 0.0) {
    view.backgroundColor = UIColor.white.withAlphaComponent(alpha)
}

//MARK: 日期转字符串
/** 日期转字符串 */
func getTimeWithDate(date: Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
//    let timeZone = TimeZone.init(identifier: "UTC")
    let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.locale = Locale.init(identifier: "zh_CN")
    formatter.dateFormat = dateFormat
    let date = formatter.string(from: date)
    return date.components(separatedBy: " ").first!
}

//MARK: 字符串转日期
/** 字符串转日期 */
func stringConvertToDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = dateFormat
    let date = dateFormatter.date(from: string)
    return date!
}

func getTodayZeroTime() -> String{
    let date = Date()
    let calendar = NSCalendar.init(identifier: .chinese)
    calendar?.date(bySettingHour: 0, minute: 0, second: 0, of: date, options: .wrapComponents)
    let components = calendar?.components([.year,.month,.day], from: date)
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dformatter.string(from: (calendar?.date(from: components!))!)
}

func getTomorrowNowTime() -> String{
    
    let date = Date()
    let calendar = NSCalendar.init(identifier: .chinese)
    let tomorrow = Date.init(timeInterval: 24*60*60, since: date)
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let components2 = calendar?.components([.year,.month,.day,.hour,.minute,.second], from: tomorrow)
    return dformatter.string(from: (calendar?.date(from: components2!))!)
}


func getLotVersionConfig() ->String{
    guard let config:SystemWrapper = getSystemConfigFromJson() else {return VERSION_V1}
    if let sys = config.content{
        return sys.lottery_version
    }
    return VERSION_V1
}

func trimQihao(currentQihao:String) -> String{
    if isEmptyString(str: currentQihao){
        return currentQihao
    }
    if currentQihao.count > 6{
        let trim = (currentQihao as NSString).substring(from: currentQihao.count - 6)
        return trim
    }
    return currentQihao
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

func numberOfChars(_ str: String) -> Int {
    var number = 0
    guard str.count > 0 else {return 0}
    for i in 0...str.count - 1 {
        let c: unichar = (str as NSString).character(at: i)
        
        if (c >= 0x4E00) {
            number += 2
        }else {
            number += 1
        }
    }
    return number
}

//只能为中文
func onlyInputChineseCharacters(_ string: String) -> Bool {
    let inputString = "[\u{4e00}-\u{9fa5}]+"
    let predicate = NSPredicate(format: "SELF MATCHES %@", inputString)
    let Chinese = predicate.evaluate(with: string)
    return Chinese
}

//只能为数字
func onlyInputTheNumber(_ string: String) -> Bool {
    let numString = "[0-9]*"
    let predicate = NSPredicate(format: "SELF MATCHES %@", numString)
    let number = predicate.evaluate(with: string)
    return number
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
        
//        controller.isAttachInTabBar = false
        //        let vc = UIStoryboard(name: "active_page",bundle:nil).instantiateViewController(withIdentifier: "activePage")
        //        let nav = MainNavController.init(rootViewController: vc)
        //        controller.present(nav, animated: true, completion: nil)
    })
    let message = (title:"站内信",imgname:"app_record_icon",action:{(item:ActionButtonItem)->Void in
        //        openMessageCenter(controller: controller)
        let nav = UINavigationController.init(rootViewController: InsideMessageController())
        controller.present(nav, animated: true, completion: nil)
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
    recordPage.isAttachInTabBar = false
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openAPPDownloadController(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "app_download_page", bundle: nil).instantiateViewController(withIdentifier: "appDownload")
    let recordPage = loginVC as! AppDownloadViewController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openLotteryResultsController(controller:UIViewController) -> Void {
    let moduleStyle = YiboPreference.getMallStyle()
    let (xibname,_) = selectMainStyleByModuleID(styleID: moduleStyle)
    let vc2 = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "notice") as! LotteryResultsController
    vc2.code = "CQSSC"
    vc2.title = "开奖结果"
    controller.navigationController?.pushViewController(vc2, animated: true)
}

func openOpenResultController(controller:UIViewController,cpName:String,
                              cpBianMa:String,cpTypeCode:String) -> Void {
    let loginVC = UIStoryboard(name: "lottery_open_result", bundle: nil).instantiateViewController(withIdentifier: "openResultID")
    let recordPage = loginVC as! LotteryOpenResultController
    recordPage.cpName = cpName
    recordPage.cpBianMa = cpBianMa
    recordPage.cpTypeCode = cpTypeCode
    controller.navigationController?.pushViewController(recordPage, animated: true)
}


func openModifyPwd(controller:UIViewController,loginPwd:Bool) -> Void {
    let loginVC = UIStoryboard(name: "pwd_modify", bundle: nil).instantiateViewController(withIdentifier: "modifyPwd")
    let recordPage = loginVC as! ModifyPwdController
    recordPage.isLoginPwdModify = loginPwd
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openChargeMoney(controller:UIViewController,meminfo:Meminfo?) -> Void {
    let loginVC = UIStoryboard(name: "new_charge_money_page", bundle: nil).instantiateViewController(withIdentifier: "new_charge")
    let recordPage = loginVC as! NewChargeMoneyController
    recordPage.meminfo = meminfo
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openPickMoney(controller:UIViewController,meminfo:Meminfo?) -> Void {
    let loginVC = UIStoryboard(name: "withdraw_page", bundle: nil).instantiateViewController(withIdentifier: "withDraw")
    let recordPage = loginVC as! WithdrawController
    recordPage.meminfo = meminfo
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openActiveDetail(controller:UIViewController,title:String,content:String,foreighUrl:String="") -> Void {
    let loginVC = UIStoryboard(name: "active_detail_page", bundle: nil).instantiateViewController(withIdentifier: "activeDetail")
    let recordPage = loginVC as! ActiveDetailController
    recordPage.titleStr = title
    recordPage.htmlContent = content
    recordPage.foreignUrl = foreighUrl
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

func openConfirmPay(controller:UIViewController,orderNo:String,accountName:String,chargeMoney:String,payMethodName:String, receiveName:String,receiveAccount:String,dipositor:String,dipositorAccount:String,qrcodeUrl:String,payType:Int,payJson:String){
    
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

func openActive(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "active_page", bundle: nil).instantiateViewController(withIdentifier: "activePage")
    let recordPage = loginVC as! ActiveController
    recordPage.isAttachInTabBar = false
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openScoreExchangePage(controller:UIViewController) -> Void {
    let loginVC = UIStoryboard(name: "score_change_page", bundle: nil).instantiateViewController(withIdentifier: "scoreExchange")
    let recordPage = loginVC as! ScoreExchangeController
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

func openBraveZuiHaoPage(controller:UIViewController,order:[OrderDataInfo],lotCode:String,lotName:String="",cpVersion:String,cptype:String="",icon:String="") -> Void {
    let loginVC = UIStoryboard(name: "brave_zuihao_page", bundle: nil).instantiateViewController(withIdentifier: "braveZuihao")
    let page = loginVC as! BraveZuihaoController
    page.orderInfo = order
    page.cpBianma = lotCode
    page.cpLotName = lotName
    page.cpVersion = cpVersion
    page.cptype = cptype
    page.lotteryicon = icon
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


//将指定格式时间字符串转为用户指定的时间格式
func timeStringToFormatString(timeStamp:String,format:String)->String {
    let str = stringToTimeStamp(stringTime: timeStamp)
    var timeLong = Int64(str)!
    timeLong = timeLong/1000
    let timeStr:TimeInterval = TimeInterval(timeLong)
    let date = Date(timeIntervalSince1970: timeStr)
    let dfmatter = DateFormatter()
    dfmatter.dateFormat=format
    return dfmatter.string(from: date)
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
        return "00 : 00"
    }
    var Min = Int(secounds / 60)
    let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
    var Hour = 0
    if Min>=60 {
        Hour = Int(Min / 60)
        Min = Min - Hour*60
        return String(format: "%02d :%02d : %02d", Hour, Min, Sec)
    }
    return String(format: "00 : %02d : %02d", Min, Sec)
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
                                    //自动登录的情况下，要记住帐号密码
//                                    if infos.accountType != GUEST_TYPE{
                                        if YiboPreference.getAutoLoginStatus(){
                                            YiboPreference.saveUserName(value: infos.account as AnyObject)
                                        }
//                                    }
                                }
                                controller.onBackClick()
                                //                                controller.navigationController?.popViewController(animated: true)
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
    let url = URL.init(string: urlString)
    //    print(url)
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

 func shouldShowBrowsersChooseView() -> Bool {
    if let config = getSystemConfigFromJson(){
        if config.content != nil{
            let addCardSwitch = config.content.multi_broswer_switch
            return addCardSwitch == "off" ? false : true
        }
    }

    return false
}


func openInBrowser(url:String,browerType: Int,view: UIView){
    
    if browerType == BROWER_TYPE_UC {
        if UIApplication.shared.canOpenURL(URL.init(string: "ucbrowser://")!){
            let openUrl = String.init(format: "%@%@", "ucbrowser://",url)
            openBrower(urlString: openUrl)
        }else {
            showToast(view: view, txt: "未安装“UC”浏览器")
        }
    }else if browerType == BROWER_TYPE_QQ {
        if UIApplication.shared.canOpenURL(URL.init(string: "mttbrowser://")!){
            let openUrl = String.init(format: "%@url=%@", "mttbrowser://",url)
            openBrower(urlString: openUrl)
        }else {
            showToast(view: view, txt: "未安装“QQ”浏览器")
        }
    }else if browerType == BROWER_TYPE_GOOGLE {
        
        if UIApplication.shared.canOpenURL(URL.init(string: "googlechromes://")!){
            if url.starts(with: "https") {
                let urlString = url.replacingOccurrences(of: "https", with: "googlechromes")
                openBrower(urlString: urlString)
            }else if url.starts(with: "http"){
                let urlFinalString = url.replacingOccurrences(of: "http", with: "googlechrome")
                openBrower(urlString: urlFinalString)
            }else {
                showToast(view: view, txt: "未识别的链接")
            }
        }else {
            showToast(view: view, txt: "未安装“谷歌”浏览器")
        }
    }else if browerType == BROWER_TYPE_SAFARI {
        openBrower(urlString: url)
    }else if browerType == BROWER_TYPE_FIREFOX {
        if UIApplication.shared.canOpenURL(URL.init(string: "firefox://")!){
            let urlP = encodeByAddingPercentEscapes(url)
            openBrower(urlString: "firefox://open-url?url=\(urlP)")
            
//            let urlString = "firefox://open-url=\(url)"
//            openBrower(urlString: urlString)
            
//            let dataStrPosition = url.positionOf(sub: "data=")
//            let dataStr = url.subString(start: (dataStrPosition + 5))
//            let subDataStr = url.subString(start: 0, length: (dataStrPosition + 5))
//            ///////////////////////////
//            let escaped = encodeByAddingPercentEscapes(subDataStr)
//            let stitchingStr = escaped + dataStr
//            let finalUrl = "firefox://open-url?url=\(stitchingStr)"
//            openBrower(urlString: finalUrl)
            
//            let pasteboard = UIPasteboard.general
//            pasteboard.string = url
//            openBrower(urlString: "firefox://")
            
        }else {
            showToast(view: view, txt: "未安装“火狐”浏览器")
        }
    }else {
        
        openBrower(urlString: url)
    }
}

fileprivate func encodeByAddingPercentEscapes(_ input: String) -> String {
    return NSString(string: input).addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]"))!
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
        let attrStr = try NSAttributedString.init(data: msg.description.data(using: String.Encoding.unicode)!, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil)
        alertController.setValue(attrStr, forKey: "attributedMessage")
    }catch{
        print(error)
    }
    controller.present(alertController, animated: true, completion: nil)
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

func isMulSelectMode(subCode:String) ->Bool {
    if subCode == "sze" || subCode == "sqz" ||
        subCode == "eqz" || subCode == "ezt" ||
        subCode == "tc" || subCode == "hxy" ||
        subCode == "hxe" || subCode == "hxs" ||
        subCode == "hxsi" || subCode == "hxw" ||
        subCode == "hxl" || subCode == "hxq" ||
        subCode == "hxb" || subCode == "hxj" ||
        subCode == "hxsh" || subCode == "hxsy" ||
        subCode == "wbz" || subCode == "lbz" ||
        subCode == "qbz" || subCode == "bbz" ||
        subCode == "jbz" || subCode == "sbz" ||
        subCode == "sybz" || subCode == "sebz" ||
        subCode == "wbz" || subCode == "lxex" ||
        subCode == "lxsx" || subCode == "lxsix" ||
        subCode == "lxwx" {
        return true
    }
    return false
}

//是否六合彩彩种
func isSixMark(lotCode:String) -> Bool{
    if isEmptyString(str: lotCode) {
        return false;
    }
    return lotCode == "LHC" || lotCode == "SFLHC" || lotCode == "WFLHC";
}

func isSaiche(lotType:String) -> Bool{
    return lotType == "3"
}

func isKuaiLeShiFeng(lotType: String) -> Bool {
    return lotType == "9"
}

func isKuai3(lotType:String) -> Bool{
    return lotType == "4"
}

func isFFSSCai(lotType:String) -> Bool{
    return lotType == "1" || lotType == "2"
}

func isXYNC(lotType:String) -> Bool{
    return lotType == "9"
}

func isPCEgg(lotType:String) -> Bool{
    return lotType == "7"
}

func isDPC(lotType:String) -> Bool{
    return lotType == "8"
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
        postNumber = data.itemName + "--" + data.number
    }else{
        postNumber = data.number
    }
    return postNumber
}

func limitAccount(account:String) -> Bool{
    let pwdRegx = ".*[a-zA-Z].*[0-9]|.*[0-9].*[a-zA-Z]";
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
    }else if playCode == "mg"{//MG真人娱乐
        url = url + REAL_MG_URL
        params["gameType"] = 1 as AnyObject
    }else if playCode == "bbin"{//BBIN真人娱乐
        url = url + REAL_BBIN_URL
        params["type"] = "live" as AnyObject
    }else if playCode == "ab"{//ab真人娱乐
        url = url + REAL_AB_URL
    }else if playCode == "ogzr" || playCode == "og"{//OG真人娱乐
        url = url + REAL_OG_URL
        params["gameType"] = "mobile" as AnyObject
    }else if playCode == "ds"{//ds真人娱乐
        url = url + REAL_DS_URL
    }
    print("url === ",url)
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
                                }else {
                                    let str = result.html
                                    if !str.isEmpty {
                                        openBBINDetail(controller: controller, content: str)
                                    }else {
                                        showToast(view:controller.view, txt: "获取跳转链接失败")
                                    }
                                }
                            }else{
                                if !isEmptyString(str: result.msg){
                                    showToast(view: controller.view, txt: result.msg)
                                    print("msg kkkk = ",result.msg)
                                    if result.msg.contains("超时") || result.msg.contains("登录"){
                                        loginWhenSessionInvalid(controller: controller)
                                    }
                                }else{
                                    showToast(view: controller.view, txt: convertString(string: "获取跳转链接失败"))
                                }
                            }
                        }
    })
}

func openBBINDetail(controller:UIViewController,content:String) -> Void {
    let loginVC = UIStoryboard(name: "bbin_page", bundle: nil).instantiateViewController(withIdentifier: "bbin")
    let recordPage = loginVC as! BBinWebContrllerViewController
    recordPage.htmlContent = content
    controller.navigationController?.pushViewController(recordPage, animated: true)
}

//获取电子游戏跳转链接
func forwardGame(controller:BaseController,playCode:String,gameCodeOrID:String) -> Void{
    //获取列表数据
    var url = ""
    var params:Dictionary<String,AnyObject> = [:]
    if playCode == "pt"{
        url = url + GAME_PT_URL
        params["h5"] = 0 as AnyObject
        params["gameCode"] = gameCodeOrID as AnyObject
    }else if playCode == "mg"{
        url = url + GAME_MG_URL
        params["gameid"] = gameCodeOrID as AnyObject
        params["gameType"] = 3 as AnyObject
    }else if playCode  == "bydr" {
        url = url + "/third/forwardAg.do?"
        params["h5"] = 0 as AnyObject
        params["gameType"] = 6 as AnyObject
    }else if playCode  == "ag" {
        url = url + REAL_AG_URL
        params["h5"] = 0 as AnyObject
        params["gameType"] = gameCodeOrID as AnyObject
    }else if playCode  == "bbin" {
        url = url + REAL_BBIN_URL
        params["type"] = "live" as AnyObject
    }else if playCode  == "qt" {
        url = url + GAME_QT_URL
        params["gameId"] = gameCodeOrID as AnyObject
    }else if playCode  == "ab" {
        url = url + GAME_AB_URL
        params["egame"] = 1 as AnyObject
    }else if playCode == "nb" {
        url = url + GAME_NB_URL
        params["gameId"] = gameCodeOrID as AnyObject
    }else if playCode == "skywind" {
        url = url + GAME_SKYWIND_URL
        params["gameId"] = gameCodeOrID as AnyObject
    }
    
    print(" url: \(url),params: \(params)")
    
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
                        }else {
                            let str = result.html
                            if !str.isEmpty {
                                openBBINDetail(controller: controller, content: str)
                            }else {
                                showToast(view:controller.view, txt: "获取跳转链接失败")
                            }
                        }

//                        }else {
//                            let str = result.html
//                            if !str.isEmpty && str.contains("action=\'"){
//                                let tempStrLeft = str.positionOf(sub: "action=\'")
//                                let string0 = str.subString(start: (tempStrLeft + 9 - 1))
//
//                                if !string0.isEmpty && string0.contains("\' >") {
//                                    let string1Right = string0.positionOf(sub: "\' >")
//                                    let string1 = string0.subString(start: 0, length: string1Right)
//                                    openBrower(urlString: string1)
//                                }
//                            }
//                        }
                    }else{
                        if !isEmptyString(str: result.msg){
                            showToast(view: controller.view, txt: result.msg)
                        }else{
                            showToast(view: controller.view, txt: convertString(string: "获取跳转链接失败"))
                        }
                    }
                }else{
                    showToast(view: controller.view, txt: convertString(string: "获取跳转链接失败"))
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
//func isActiveShowFunc() -> Bool {
//    //获取存储在本地preference中的config
//    let system = getSystemConfigFromJson()
//    if let value = system{
//        let datas = value.content
//        if let active = datas?.isActive{
//            return active
//        }
//    }
//    return false
//}

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


