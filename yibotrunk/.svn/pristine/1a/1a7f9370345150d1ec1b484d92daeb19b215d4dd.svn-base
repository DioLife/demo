//
//  SportMenuBar.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/20.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol MainTabsBarDelegate {
    func onTabClick(itemTxt:String)
}

class MainTabsBar: UIView {
    
    var menuType:MenuType!
    var menuBarDelegate:MainTabsBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let items = ["彩票","真人","电子","体育"]
        stepSubViews(arr: items)
    }
    
    func stepSubViews(arr:[String]) -> Void {
//        let items = ["彩票","真人","电子","体育"]
        if arr.isEmpty{
            return
        }
        for index in 0...arr.count-1{
            let s = CGFloat(index)
            let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(arr.count)), y: 0, width: kScreenWidth/CGFloat(arr.count), height: self.bounds.height))
            item.tag = index
            if index == 0{
                item.toggleBottom(show: true)
            }else{
                item.toggleBottom(show: false)
            }
//            item.itemTag = String.init(format: "%d%d", MenuType.MAIN_MODULE_TAB,index)
            item.menuText.text = arr[index]
            item.showIndector(show: false)
            item.bindCustomSelector(target: self,selector: #selector(onMenuItemClick(reg:)))
            self.addSubview(item)
        }
    }
    
    func updateTabs(arr:[String]) -> Void {
        
        for view in self.subviews{
            view.removeFromSuperview()
        }
        stepSubViews(arr: arr)
//        if arr.count != self.subviews.count{
//            fatalError("tab array count is not equal to tab view count")
//        }
//        for index in 0...arr.count-1{
//            let menu = self.subviews[index] as! MenuItem
//            menu.menuText.text = arr[index]
//            menu.tag = index
//            if index == 0{
//                menu.toggleBottom(show: true)
//            }else{
//                menu.toggleBottom(show: false)
//            }
//        }
    }
    
    func onMenuItemClick(reg:UIPanGestureRecognizer) -> Void {
        if let view = reg.view{
            let menuItem = view as! MenuItem
            for menu in self.subviews{
                if (menu as! MenuItem).tag == menuItem.tag{
                    (menu as! MenuItem).toggleBottom(show: true)
                }else{
                    (menu as! MenuItem).toggleBottom(show: false)
                }
            }
            if let delegate = menuBarDelegate{
                delegate.onTabClick(itemTxt: menuItem.menuText.text!)
            }
        }
    }
    
    
}
