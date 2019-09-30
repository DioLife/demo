//
//  MyAppDelegate.swift
//  ColorWheel
//
//  Created by Angela Rucci on 7/4/18.
//  Copyright © 2018 Angela Rucci. All rights reserved.
//

import UIKit
import Alamofire
import CoreTelephony

@UIApplicationMain
class MyAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var blockRotation = false
    var num = 1

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Sleep for 1 second and show launch screen 
        usleep(1000000)
        
        /*************** shell ****************/
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        
        //umeng
        self.setupUmeng(launchOptions: launchOptions)
        
        //switch
        let supplier = zz_deviceSupplier()
        if supplier.contains("联通") || supplier.contains("移动") || supplier.contains("电信") || supplier.contains("铁通") {
            judgeNetworking()
        }
//        judgeNetworking()
        
        /*************** shell ****************/
        
        return true
    }

    /*************** shell ***************/
    ///获取运营商
    private func zz_deviceSupplier() -> String {
        let info = CTTelephonyNetworkInfo()
        var supplier:String = ""
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceSubscriberCellularProviders {
                if carriers.keys.count == 0 {
                    return "无手机卡"
                } else { //获取运营商信息
                    for (index, carrier) in carriers.values.enumerated() {
                        guard carrier.carrierName != nil else { return "无手机卡" }
                        //查看运营商信息 通过CTCarrier类
                        if index == 0 {
                            supplier = carrier.carrierName!
                        } else {
                            supplier = supplier + "," + carrier.carrierName!
                        }
                    }
                    return supplier
                }
            } else{
                return "无手机卡"
            }
        } else {
            if let carrier = info.subscriberCellularProvider {
                guard carrier.carrierName != nil else { return "无手机卡" }
                return carrier.carrierName!
            } else{
                return "无手机卡"
            }
        }
    }
    
    //网络判断
    func judgeNetworking() {
        let manager = NetworkReachabilityManager()
        manager?.listener = { status in    // 当网络状态发生改变的时候调用这个closure
            switch status {
            case .unknown:
                EWToast.showCenterWithText(text: "未识别的网络", duration: 2)
            case .notReachable:
                EWToast.showCenterWithText(text: "不可用的网络(未连接)", duration: 2)
            case .reachable:
                if (manager?.isReachableOnWWAN)! {
                    print("2G,3G,4G...的网络")
                } else if (manager?.isReachableOnEthernetOrWiFi)! {
                    print("wifi的网络")
                }
                self.loadData(urlStr: myapi1)
            }
        }
        let isWork = manager?.startListening()
        print("开启监听是否成功:\(isWork!)")
    }
    
    func loadData(urlStr:String) {
        let header = ["d":BUNDLEID, "c":"1"]
        let privateKey = "123456"
        var params = Dictionary<String,Any>()
        params["a"] = APPID
        params["b"] = "2"
        let parameters = changeRequestParams(privateKey: privateKey, dict: params)
        MyHttp.shareManager().request(urlString: urlStr, method: .post, parameters: parameters, headers: header, success: { (response) in
            let result = response as! String
            print(result)
            //HandyJSON 再解析字符串
            let result1 = SwitchModel.deserialize(from: result)
            if result1?.msg == "SUCCESS" {
                let model = result1!.data
                if model?.switchOn == "1" {
                    self.blockRotation = true
                    let vc:HideViewController = HideViewController()
                    let modelT:HideData = HideData()
                    modelT.switchOn = model!.switchOn!
                    modelT.headHidden = model!.headHidden!
                    modelT.headColor = model!.headColor!
                    modelT.homeUrl = model!.homeUrl!
                    modelT.openSafariUrl = model!.openSafariUrl!
                    modelT.activityUrl = model!.activityUrl!
                    modelT.serviceUrl = model!.serviceUrl!
                    modelT.functionArr = model!.functionArr!
                    modelT.footColor = model!.footColor!
                    vc.model = modelT
                    
                    self.window?.rootViewController = vc
                }
            }else{
                //                if let msg = result1?.msg {
                //                    EWToast.showCenterWithText(text: msg, duration: 1.5)
                //                }
                //                if let message = result1?.message {
                //                    EWToast.showCenterWithText(text: message, duration: 1.5)
                //                }
                self.num += 1
                if self.num == 2 {
                    self.loadData(urlStr: myapi2)
                }else if self.num == 3 {
                    self.loadData(urlStr: myapi3)
                }else if self.num == 4 {
                    self.loadData(urlStr: myapi4)
                }
            }
        }) { (error) in
            if let err = error as? String {
                EWToast.showCenterWithText(text: err, duration: 1.5)
            }
            self.num += 1
            if self.num == 2 {
                self.loadData(urlStr: myapi2)
            }else if self.num == 3 {
                self.loadData(urlStr: myapi3)
            }else if self.num == 4 {
                self.loadData(urlStr: myapi4)
            }
        }
    }
    
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if self.blockRotation == false {
            return .portrait
        }else{
            return .all
        }
    }
    
    /** umeng **/
    func setupUmeng(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        /// 友盟初始化
        UMConfigure.initWithAppkey(umengkey, channel:"App Store")
        UMConfigure.setLogEnabled(true)
        
        /// 友盟統計
        MobClick.setScenarioType(eScenarioType.E_UM_NORMAL)
        
        /// iOS 10 以上必須支援
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        
        /// 友盟推送配置
        let entity = UMessageRegisterEntity.init()
        entity.types = Int(UMessageAuthorizationOptions.alert.rawValue) |
            Int(UMessageAuthorizationOptions.badge.rawValue) |
            Int(UMessageAuthorizationOptions.sound.rawValue)
        UMessage.registerForRemoteNotifications(launchOptions: launchOptions, entity: entity) { (granted, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        UMessage.setAutoAlert(true)
    }
    
    /// 拿到 Device Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UMessage.registerDeviceToken(deviceToken)
        
        let device = NSData(data: deviceToken)
        let deviceId = device.description.replacingOccurrences(of:"<", with:"").replacingOccurrences(of:">", with:"").replacingOccurrences(of:" ", with:"")
        print("deviceToken：\(deviceId)")
    }
    
    /// 注册推送失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error:",error.localizedDescription)
    }
    
    /// 接到推送消息
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        UMessage.didReceiveRemoteNotification(userInfo)
    }
    
    /// iOS10 以前接收的方法
    func application(_ application: UIApplication,
                     handleActionWithIdentifier identifier: String?,
                     for notification: UILocalNotification,
                     withResponseInfo responseInfo: [AnyHashable: Any],
                     completionHandler: @escaping () -> Void) {
        /// 这个方法用来做action点击的统计
        UMessage.sendClickReport(forRemoteNotification: responseInfo)
    }
    /**************** shell **************/
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension MyAppDelegate:UNUserNotificationCenterDelegate {
    //iOS10以下使用这两个方法接收通知，
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        //关闭友盟自带的弹出框
        UMessage.setAutoAlert(false)
        
        if  UIDevice.current.systemVersion < "10" {
            UMessage.didReceiveRemoteNotification(userInfo)
            //            self.umUserInfo = userInfo;
            //定制自定的的弹出框
            if UIApplication.shared.applicationState == UIApplication.State.active {
                let alertViewVc = UIAlertController.init(title: "通知标题", message: "Test On ApplicationStateActive", preferredStyle: UIAlertController.Style.alert)
                alertViewVc.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (alertView) in
                    // sure click
                }))
                self.window?.rootViewController?.present(alertViewVc, animated: true, completion: nil)
            }
            completionHandler(UIBackgroundFetchResult.newData)
        }
    }
    
    //iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            //应用处于前台时的远程推送接受
            //关闭友盟自带的弹出框
            UMessage.setAutoAlert(false)
            //必须加这句代码
            UMessage.didReceiveRemoteNotification(userInfo)
        } else {
            //应用处于后台时的本地推送接受
        }
        
        //当应用处于前台时提示设置，需要哪个可以设置哪一个
        completionHandler(UNNotificationPresentationOptions(rawValue: UNNotificationPresentationOptions.RawValue(UInt8(UNNotificationPresentationOptions.sound.rawValue) | UInt8(UNNotificationPresentationOptions.badge.rawValue) | UInt8(UNNotificationPresentationOptions.alert.rawValue))))
    }
    
    //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            //应用处于前台时的远程推送接受
            //关闭友盟自带的弹出框
            UMessage.setAutoAlert(false)
            //必须加这句代码
            UMessage.didReceiveRemoteNotification(userInfo)
        } else {
            //应用处于后台时的本地推送接受
        }
    }
}
