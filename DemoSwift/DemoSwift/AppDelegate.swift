//
//  AppDelegate.swift
//  DemoSwift
//
//  Created by hello on 2019/6/18.
//  Copyright © 2019 Dio. All rights reserved.
//

import UIKit
import Alamofire
import CoreTelephony

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var blockRotation = false
    var num = 0;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        let vc = ViewController()
        let rootVC = UINavigationController.init(rootViewController: vc)
        self.window?.rootViewController = rootVC
        
//        judgeNetworking()
        let supplier = zz_deviceSupplier()
        if supplier == "中国联通" || supplier == "中国移动" || supplier == "中国电信" {
            judgeNetworking()
        }
        return true
    }
    
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
                self.loadData()
            }
        }
        let isWork = manager?.startListening()
        print("开启监听是否成功:\(isWork!)")
    }
    
    func loadData() {
        let header = ["d":BUNDLEID, "c":"1"]
        let privateKey = "123456"
        var params = Dictionary<String,Any>()
        params["a"] = APPID
        params["b"] = "2"
        let parameters = changeRequestParams(privateKey: privateKey, dict: params)
        MyHttp.shareManager().request(urlString: myapi, method: .post, parameters: parameters, headers: header, success: { (response) in
            let result = response as! String
            print(result)
            //HandyJSON 再解析字符串
            let result1 = SwitchModel.deserialize(from: result)
            if result1?.msg == "SUCCESS" {
                let model = result1!.data
                if model?.switchOn == "1" {
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
                if let msg = result1?.msg {
                    EWToast.showCenterWithText(text: msg, duration: 1.5)
                }
                if let message = result1?.message {
                    EWToast.showCenterWithText(text: message, duration: 1.5)
                }
            }
        }) { (error) in
            if let err = error as? String {
                EWToast.showCenterWithText(text: err, duration: 1.5)
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if self.blockRotation == false {
            return UIInterfaceOrientationMask.landscapeLeft
        }else{
            if self.num == 0 {
                self.num += 1
                return UIInterfaceOrientationMask.portrait
            }else{
                return .all
            }
        }
    }

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

