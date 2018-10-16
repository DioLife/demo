//
//  AppDelegate.swift
//  SwiftSideslipLikeQQ
//
//  Created by JohnLui on 15/4/10.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let themeIndex: Int? = YiboPreference.getCurrentThme()
        var themeStr: String
        if let realThemeIndex = themeIndex {
            switch realThemeIndex {
            case 0:
                themeStr = "Red"
            case 1:
                themeStr = "Blue"
            case 2:
                themeStr = "Green"
            case 3:
                themeStr = "FrostedOrange"
            case 4:
                themeStr = "FrostedBlue"
            case 5:
                themeStr = "FrostedPurple"
            case 6:
                themeStr = "FrostedBeautyOne"
            default :
                themeStr = "Red"
                ThemeManager.setTheme(plistName: themeStr, path: .mainBundle)
                YiboPreference.setCurrentThemeByName(value: themeStr as AnyObject)
                YiboPreference.setCurrentTheme(value: 0 as AnyObject)
            }
          ThemeManager.setTheme(plistName: themeStr, path: .mainBundle)
          YiboPreference.setCurrentThemeByName(value: themeStr as AnyObject)
        }else {
            ThemeManager.setTheme(plistName: "Red", path: .mainBundle)
            YiboPreference.setCurrentThemeByName(value: "Red" as AnyObject)
            YiboPreference.setCurrentTheme(value: 0 as AnyObject)
        }
        
        
        
        // 改变 StatusBar 颜色
        UIApplication.shared.theme_setStatusBarStyle("Global.UIStatusBarStyle", animated: true)
        //非主题
//        application.statusBarStyle = UIStatusBarStyle.lightContent
        
        // 改变 navigation bar 的背景色及前景色
        let navigationBarApperance = UINavigationBar.appearance()
        navigationBarApperance.theme_tintColor = "Global.barTextColor" // navBar的文字颜色
        navigationBarApperance.theme_barTintColor = "Global.barTintColor" // bar的背景色
        navigationBarApperance.theme_titleTextAttributes = ThemeDictionaryPicker(keyPath: "Global.barTextColor") {
            value -> [NSAttributedStringKey : AnyObject]? in
            guard let rgba = value as? String else {
                return nil
            }

            let color = UIColor(rgba: rgba)
//            let shadow = NSShadow(); shadow.shadowOffset = CGSize.zero
            let titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: color,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16),
//                NSAttributedStringKey.shadow: shadow
            ]

            return titleTextAttributes
        }
        //非主题
//        let navigationBarAppearace = UINavigationBar.appearance()
//        navigationBarAppearace.isTranslucent = false
//        navigationBarAppearace.barTintColor = UIColor(hex: 0xEC2829)
//        navigationBarAppearace.tintColor = UIColor.white
//        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "Global.themeColor"
        tabbar.theme_barTintColor = "Global.themeColor"
        
        YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        if UserDefaults.standard.bool(forKey: "everLaunch") == false {
            UserDefaults.standard.set(true, forKey: "everLaunch")
            YiboPreference.setPlayTouzhuVolume(value: true as AnyObject)
            YiboPreference.saveShakeTouzhuStatus(value: true as AnyObject)
            YiboPreference.savePwdState(value: true as AnyObject)
            YiboPreference.saveAutoLoginStatus(value: true as AnyObject)
            YiboPreference.saveMallStyle(value: OLD_CLASSIC_STYLE as AnyObject)
            YiboPreference.setYJFMode(value: YUAN_MODE as AnyObject)
        }
        
        //一般在程序启动时开始数据库并建表
//        if SQLiteManager.shareInstance().openDB() {
//            print("开启数据库成功!")
//        }
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = MainNavigationController(rootViewController: MainViewController())
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    


}

