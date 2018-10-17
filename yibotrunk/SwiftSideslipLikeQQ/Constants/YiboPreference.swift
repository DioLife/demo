//
//  YiboPreference.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/21.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class YiboPreference {
    
    static let PLAY_TOUZHU_VOLUME:String = "play_touzhu_volume"
    static let CP_VERSION:String = "cpVersion"
    static let TOKEN:String = "token"
    static let CONFIG:String = "config"
    static let YJF_MODE = "yjf_mode"
    static let SAVE_PWD_STATUS = "save_pwd_status"
    static let NOT_TIP_LATER = "not_tip_later"
    static let SAVE_LOGIN_STATUS = "save_login_status"
    static let NOT_TOAST_WHEN_ENDBET = "not_toast_when_endbet"
    static let SAVE_PWD = "save_pwd"
    static let SAVE_TOUZHU_ORDER_JSON = "order_json"
    static let SAVE_LOTTERYS = "save_lotterys"
    static let ACCOUNT_TYPE = "account_type"
    static let DEFAULT_BROWSER_TYPE = "default_browser_type"
    static let USERNAME = "username"
    static let AUTO_LOGIN_STATUS = "auto_login_status"
    static let MAIN_STYLE_ID = "main_style_id"
    static let SHAKE_TOUZHU = "shake_touzhu"
    static let AUTO_LOGIN = "auto_login"
    static let ASK_BEFORE_ZUIHAO = "ask_before_zuihao"

    static func setPlayTouzhuVolume(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: PLAY_TOUZHU_VOLUME)
    }
    
    static func isPlayTouzhuVolume() -> Bool {
        let value = UserDefaults.standard.bool(forKey: PLAY_TOUZHU_VOLUME)
        return value
    }
    
    static func setToken(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: TOKEN)
    }
    
    static func getToken() -> String {
        let value = UserDefaults.standard.string(forKey: TOKEN)
        if let v = value{
            return v
        }
        return ""
    }
    
    static func setDefault_brower_type(value:AnyObject) -> Void{
        UserDefaults.standard.set(value, forKey: DEFAULT_BROWSER_TYPE)
    }
    
    static func getDefault_brower_type() -> Int{
        if let value = UserDefaults.standard.string(forKey: DEFAULT_BROWSER_TYPE) {
            return Int(value)!
        }else {
            return -1
        }
    }
    
    static func setAccountMode(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: ACCOUNT_TYPE)
    }
    
    static func getAccountMode() -> Int {
        let value = UserDefaults.standard.integer(forKey: ACCOUNT_TYPE)
        return value
    }
    
    static func saveUserName(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: USERNAME)
    }
    
    static func getUserName() -> String {
        let value = UserDefaults.standard.string(forKey: USERNAME)
        if let nameValue = value{
            return nameValue
        }
        return ""
    }
    
    static func saveLoginStatus(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SAVE_LOGIN_STATUS)
    }
    
    static func getLoginStatus() -> Bool {
        let value = UserDefaults.standard.bool(forKey: SAVE_LOGIN_STATUS)
        return value
    }
    
    static func setNotToastWhenTouzhuEnd(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: NOT_TOAST_WHEN_ENDBET)
    }
    
    static func getNotToastWhenTouzhuEnd() -> Bool {
        let value = UserDefaults.standard.bool(forKey: NOT_TOAST_WHEN_ENDBET)
        return value
    }
    
    static func saveAutoLoginStatus(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: AUTO_LOGIN_STATUS)
    }
    
    static func getAutoLoginStatus() -> Bool {
        let value = UserDefaults.standard.bool(forKey: AUTO_LOGIN_STATUS)
        return value
    }
    
    static func saveMallStyle(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: MAIN_STYLE_ID)
    }
    
    static func getMallStyle() -> String {
        let value = UserDefaults.standard.string(forKey: MAIN_STYLE_ID)
        return value == "0" ? String.init(format: "%d", OLD_CLASSIC_STYLE) : value!
    }
    
    static func saveShakeTouzhuStatus(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SHAKE_TOUZHU)
    }
    
    static func getShakeTouzhuStatus() -> Bool {
        let value = UserDefaults.standard.bool(forKey: SHAKE_TOUZHU)
        return value
    }
    
    static func savePwdState(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SAVE_PWD_STATUS)
    }
    
    static func getPwdState() -> Bool {
        let value = UserDefaults.standard.bool(forKey: SAVE_PWD_STATUS)
        return value
    }
    
    static func saveNotTipLaterWhenTouzhu(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: NOT_TIP_LATER)
    }
    
    static func getNotTipLaterWhenTouzhu() -> Bool {
        let value = UserDefaults.standard.bool(forKey: NOT_TIP_LATER)
        return value
    }
    
    static func setAskBeforeZuihao(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: ASK_BEFORE_ZUIHAO)
    }
    
    static func getAskBeforeZuihao() -> Bool {
        let value = UserDefaults.standard.bool(forKey: ASK_BEFORE_ZUIHAO)
        return value
    }
    
    static func savePwd(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SAVE_PWD)
    }
    
    static func getPwd() -> String {
        let value = UserDefaults.standard.string(forKey: SAVE_PWD)
        if let v = value{
            return v
        }
        return ""
    }
    
    static func saveTouzhuOrderJson(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SAVE_TOUZHU_ORDER_JSON)
    }
    
    static func getTouzhuOrderJson() -> String {
        let value = UserDefaults.standard.string(forKey: SAVE_TOUZHU_ORDER_JSON)
        if let v = value{
            return v
        }
        return ""
    }
    
    static func saveLotterys(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SAVE_LOTTERYS)
    }
    
    static func getLotterys() -> String {
        let value = UserDefaults.standard.string(forKey: SAVE_LOTTERYS)
        if let v = value{
            return v
        }
        return ""
    }
    static func setYJFMode(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: YJF_MODE)
    }
    
    static func getYJFMode() -> Int {
        var value = UserDefaults.standard.integer(forKey: YJF_MODE)
        if value == 0{
            value = YUAN_MODE
        }
        return value
    }
    
    static func setVersion(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: CP_VERSION)
    }
    
    static func getVersion() -> String {
        let value = UserDefaults.standard.string(forKey: CP_VERSION)
        if let v = value{
            return v
        }
        return ""
    }
    
    static func isPeilvVersion() -> Bool{
        let version = getVersion()
        if version == lottery_identify_V2 || version == lottery_identify_V4 ||
            version == lottery_identify_V5{
            return true
        }
        return false
    }
    
    static func saveConfig(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: CONFIG)
    }
    
    static func getConfig() -> String {
        let value = UserDefaults.standard.string(forKey: CONFIG)
        if let v = value{
            return v
        }
        return ""
    }
    
}
