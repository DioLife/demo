//
//  PullMenuBar.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

struct MenuType {
    static var CAIPIAO_RECORD:Int = 0
    static var LIUHE_RECORD:Int = 1
    static var SPORT_RECORD:Int = 2
    static var REAL_MAN_RECORD = 3
    static var GAME_RECORD = 4
    static var ACCOUNT_CHANGE_RECORD = 5
    static var ACCOUNT_MINGXI_RECORD = 6
    static var GOU_CAI_CATEGORY = 7
    static var ZUIHAO_BEISHU_CATEGORY = 8
    static var SBSPORT_RECORD = 8
    static var MAIN_MODULE_TAB = 9
    static var NEW_SPORT_RECORD:Int = 10
}

protocol MenuBarDelegate {
    func onMenuItemClick(key:String,itemTag:String)
}

class PullMenuBar: UIView {
    
    var menuType:MenuType!
    var menuBarDelegate:MenuBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func updateTabs(arr:[String]) -> Void {
        if arr.count != self.subviews.count{
            fatalError("tab array count is not equal to tab view count")
        }
        for index in 0...arr.count-1{
            let menu = self.subviews[index] as! MenuItem
            menu.menuText.text = arr[index]
        }
    }
    
    func stepSubViews(type:Int) -> Void {
        switch type {
        case MenuType.CAIPIAO_RECORD:
            let items = ["状态","时间","彩种"]
            for index in 0...items.count-1{
                let s = CGFloat(index)
                let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
                item.tag = index
                item.itemTag = String.init(format: "%d%d", MenuType.CAIPIAO_RECORD,index)
                item.menuText.text = items[index]
                item.menuBarDelegate = self.menuBarDelegate
                item.switchIndictor()
                self.addSubview(item)
            }
        case MenuType.LIUHE_RECORD:
            let items = ["时间"]
            for index in 0...items.count-1{
                let s = CGFloat(index)
                let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
                item.tag = index
                item.itemTag = String.init(format: "%d%d", MenuType.LIUHE_RECORD,index)
                item.menuText.text = items[index]
                item.menuBarDelegate = self.menuBarDelegate
                item.switchIndictor()
                self.addSubview(item)
            }
        case MenuType.SPORT_RECORD,MenuType.SBSPORT_RECORD,MenuType.NEW_SPORT_RECORD:
            let items = ["时间","球种"]
            for index in 0...items.count-1{
                let s = CGFloat(index)
                let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
                item.tag = index
                item.itemTag = String.init(format: "%d%d", MenuType.SPORT_RECORD,index)
                item.menuText.text = items[index]
                item.menuBarDelegate = self.menuBarDelegate
                item.switchIndictor()
                self.addSubview(item)
            }
        case MenuType.REAL_MAN_RECORD:
            let items = ["时间","平台"]
            for index in 0...items.count-1{
                let s = CGFloat(index)
                let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
                item.tag = index
                item.itemTag = String.init(format: "%d%d", MenuType.REAL_MAN_RECORD,index)
                item.menuText.text = items[index]
                item.menuBarDelegate = self.menuBarDelegate
                item.switchIndictor()
                self.addSubview(item)
            }
        case MenuType.GAME_RECORD:
            let items = ["时间","平台"]
            for index in 0...items.count-1{
                let s = CGFloat(index)
                let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
                item.tag = index
                item.itemTag = String.init(format: "%d%d", MenuType.GAME_RECORD,index)
                item.menuText.text = items[index]
                item.menuBarDelegate = self.menuBarDelegate
                item.switchIndictor()
                self.addSubview(item)
            }
        case MenuType.ACCOUNT_CHANGE_RECORD:
            let items = ["时间"]
            for index in 0...items.count-1{
                let s = CGFloat(index)
                let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
                item.tag = index
                item.itemTag = String.init(format: "%d%d", MenuType.ACCOUNT_CHANGE_RECORD,index)
                item.menuText.text = items[index]
                item.menuBarDelegate = self.menuBarDelegate
                item.switchIndictor()
                self.addSubview(item)
            }
        case MenuType.GOU_CAI_CATEGORY:
            let items = ["彩种分类"]
            for index in 0...items.count-1{
                let s = CGFloat(index)
                let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
                item.tag = index
                item.itemTag = String.init(format: "%d%d", MenuType.GOU_CAI_CATEGORY,index)
                item.menuText.text = items[index]
                item.menuBarDelegate = self.menuBarDelegate
                item.switchIndictor()
                self.addSubview(item)
            }
        default:
            break;
        }
    }
    
    

}
