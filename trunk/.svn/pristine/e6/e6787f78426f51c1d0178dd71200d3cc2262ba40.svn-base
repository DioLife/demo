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
    static let SAVE_SIGN_DATE = "sign_date"
    static let SAVE_TOUZHU_ORDER_JSON = "order_json"
    static let SAVE_LOTTERYS = "save_lotterys"
    static let ACCOUNT_TYPE = "account_type"
    static let USERNAME = "username"
    static let AUTO_LOGIN_STATUS = "auto_login_status"
    static let MAIN_STYLE_ID = "main_style_id"
    static let SHAKE_TOUZHU = "shake_touzhu"
    static let AUTO_LOGIN = "auto_login"
    static let ASK_BEFORE_ZUIHAO = "ask_before_zuihao"
    static let THEME_CURRENT = "currentTheme"
    static let THEME_CURRENT_BYNAME = "currentTheme_name"
    static let SOUNDEFFECT_CURRENT = "currentSoundEffect"
    static let SHOWALERT_ALLOR_NONE = "showAlert_all"
    static let DEFAULT_BROWER_TYPE = "default_brower_type"
    static let SHOWNEW_FUNCTIONS_TIPSPAG_HOME = "showNewFunctionTipsPage_home"
    static let SHOWNEW_FUNCTIONS_TIPSPAG_BET = "showNewFunctionTipsPage_bet"

    //MARK: - 浮层新功能操作，教学提示
    static func setShowBetNewfunctionTipsPage(value: String) -> Void {
        UserDefaults.standard.set(value, forKey: SHOWNEW_FUNCTIONS_TIPSPAG_BET)
    }
    
    static func getShowBetNewfunctionTipsPage() -> String {
        if let value = UserDefaults.standard.string(forKey: SHOWNEW_FUNCTIONS_TIPSPAG_BET) {
            return value
        }else {
            return ""
        }
    }
    
    static func setShowHomeNewfunctionTipsPage(value: String) -> Void {
        UserDefaults.standard.set(value, forKey: SHOWNEW_FUNCTIONS_TIPSPAG_HOME)
    }
    
    static func getShowHomeNewfunctionTipsPage() -> String {
        if let value = UserDefaults.standard.string(forKey: SHOWNEW_FUNCTIONS_TIPSPAG_HOME) {
            return value
        }else {
            return ""
        }
    }
    
    /** -1：没有有默认浏览器，不需要弹窗；其他 >= 0 的值，表示已有默认浏览器,不需要弹窗 */
    static func getDefault_brower_type() -> Int {
        if let value = UserDefaults.standard.string(forKey: DEFAULT_BROWER_TYPE) {
            return Int(value)!
        }else {
            return -1
        }
    }
    
    static func setDefault_brower_type(value: String) -> Void {
        UserDefaults.standard.set(value, forKey: DEFAULT_BROWER_TYPE)
    }
    
    static func isShouldAlert_isAll() -> String {
        if let value = UserDefaults.standard.string(forKey: SHOWALERT_ALLOR_NONE) {
            return value
        }else {
            return ""
        }
    }

    static func setAlert_isAll(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SHOWALERT_ALLOR_NONE)
    }
  
    static func setCurrentTheme(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: THEME_CURRENT)
    }
    
    static func getCurrentThme() -> Int {
        let value = UserDefaults.standard.integer(forKey: THEME_CURRENT)
        return value
    }
    
    static func setCurrentThemeByName(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: THEME_CURRENT_BYNAME)
    }
    
    static func getCurrentThmeByName() -> String {
        if let value = UserDefaults.standard.string(forKey: THEME_CURRENT_BYNAME) {
            return value
        }
        return ""
    }
    
    static func setCurrentSoundEffect(value: AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SOUNDEFFECT_CURRENT)
    }
    
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
    
    static func setAccountMode(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: ACCOUNT_TYPE)
    }
    
    
    
    static func getCurrentSoundEffect() -> Int {
        let value = UserDefaults.standard.integer(forKey: SOUNDEFFECT_CURRENT)
        return value
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
    
    static func save_signDate(value:AnyObject) -> Void {
        UserDefaults.standard.set(value, forKey: SAVE_SIGN_DATE)
    }
    
    static func getSignDate() -> String {
        let value = UserDefaults.standard.string(forKey: SAVE_SIGN_DATE)
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
    
    static func getYJFMode() -> String {
        var value = UserDefaults.standard.string(forKey: YJF_MODE)
        if isEmptyString(str: value!){
            value = YUAN_MODE
        }
        return value!
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
