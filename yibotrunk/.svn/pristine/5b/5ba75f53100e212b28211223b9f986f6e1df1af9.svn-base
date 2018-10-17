//
//  GoucaiCategoryView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/4/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol GoucaiMenuDelegate {
    func onMenuClick(index:Int)
}

class GoucaiCategoryView: UIView,CaigouBarDelegate{
    
    
    var delegate:GoucaiMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func stepSubViews() -> Void {
        if !self.subviews.isEmpty{
            for index in 0...self.subviews.count-1{
                let menu = self.subviews[index] as! GouCaiBarItem
                menu.removeFromSuperview()
            }
        }
        let items = ["全部彩种","高频彩","低频彩"]
        for index in 0...items.count-1{
            let s = CGFloat(index)
            let item = GouCaiBarItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
            item.tag = index
            if index == 0{
                item.indictor.image = UIImage.init(named: "all_lot_icon")
            }else if index == 1{
                item.indictor.image = UIImage.init(named: "high_lot_icon")
            }else if index == 2{
                item.indictor.image = UIImage.init(named: "low_lot_icon")
            }
            item.menuText.text = items[index]
            item.menuBarDelegate = self
            item.toggleIndictor(show: index == 0 ? true : false)
            self.addSubview(item)
        }
    }
    
    func onBarClick(index: Int) {
        print("bar click index === ",index)
        updateTabs(selectIndex: index)
        if let delegate = self.delegate{
            delegate.onMenuClick(index: index)
        }
    }
    
    func updateTabs(selectIndex:Int) -> Void {
        print("select index === ",selectIndex)
        for index in 0...self.subviews.count-1{
            let menu = self.subviews[index] as! GouCaiBarItem
            menu.toggleIndictor(show: selectIndex == index ? true : false)
        }
    }
    
}

