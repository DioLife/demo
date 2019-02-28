//
//  MyTabBarController.swift
//  MyTabBar
//
//  Created by hello on 2019/1/15.
//  Copyright © 2019 hello. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController,RootTabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myswift = AViewController()
        myswift.title = "热点"
        myswift.tabBarItem.image = UIImage.init(named: "home")
        myswift.tabBarItem.selectedImage = UIImage.init(named: "home_selected")
        let nav1 = MyNavigationController.init(rootViewController: myswift)
        
        let ui = BViewController()
        ui.title = "比赛"
        ui.tabBarItem.image = UIImage.init(named: "message")
        ui.tabBarItem.selectedImage = UIImage.init(named: "message_selected")
        let nav2 = MyNavigationController.init(rootViewController: ui)
        
        let dVC = DViewController()
        dVC.title = "社区"
        dVC.tabBarItem.image = UIImage.init(named: "message")
        dVC.tabBarItem.selectedImage = UIImage.init(named: "message_selected")
        let nav4 = MyNavigationController.init(rootViewController: dVC)
        
        let sdkVC = CViewController()
        sdkVC.title = "我的"
        sdkVC.tabBarItem.image = UIImage.init(named: "profile")
        sdkVC.tabBarItem.selectedImage = UIImage.init(named: "profile_selected")
        let nav3 = MyNavigationController.init(rootViewController: sdkVC)
        
        
        self.viewControllers = [nav1, nav2, nav4,nav3]
        
        
        self.tabBar.barStyle = UIBarStyle.black//tabBar样式
        self.tabBar.isTranslucent = false//tabBar透明与否
        self.tabBar.barTintColor = UIColor.brown//tabBar背景颜色
        self.tabBar.tintColor = UIColor.purple//点击后字体颜色
        
        
        let tab = RootTabBar()
        tab.addDelegate = self
        self.setValue(tab, forKey: "tabBar")
        //        self.tabBar = tab
    }
    
    //上传按钮执行方法
    func addClick() {
        print("add succeed")
    }

}
