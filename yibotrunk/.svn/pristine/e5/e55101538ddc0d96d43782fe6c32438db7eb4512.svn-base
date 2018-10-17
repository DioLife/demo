//
//  MainTabBarController.swift
//  SwiftSideslipLikeQQ
//
//  Created by JohnLui on 15/5/2.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit

// TabBar Controller，主页所有内容的父容器
class MainTabBarController: UITabBarController {
    
    var menuDelegate:MenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
            case 3:
                if !YiboPreference.getLoginStatus(){
                    showToast(view: self.view, txt: "您还未登录,请先登录后再使用噢！")
                    loginWhenSessionInvalid(controller: self)
                    return
                }
            default:
                break
        }
    }

}

