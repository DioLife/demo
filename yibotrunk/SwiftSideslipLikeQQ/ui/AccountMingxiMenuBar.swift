//
//  AccountMingxiMenuBar.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//


import UIKit

protocol MingxiBarDelegate {
    func onMenuItemClick(itemTag:Int)
}

class AccountMingxiMenuBar: UIView {
    
    var menuType:MenuType!
    var delegate:MingxiBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        stepSubViews()
    }
    
    func stepSubViews() -> Void {
        let items = ["充值记录","取款记录"]
        for index in 0...items.count-1{
            let s = CGFloat(index)
            let item = MenuItem.init(frame: CGRect.init(x: s*(kScreenWidth/CGFloat(items.count)), y: 0, width: kScreenWidth/CGFloat(items.count), height: self.bounds.height))
            item.tag = index
            item.itemTag = String.init(format: "%d%d", MenuType.ACCOUNT_MINGXI_RECORD,index)
            item.menuText.text = items[index]
            item.showIndector(show: false)
            item.bindCustomSelector(target: self,selector: #selector(onMenuItemClick(reg:)))
            self.addSubview(item)
        }
    }
    
    func onMenuItemClick(reg:UIPanGestureRecognizer) -> Void {
        if let view = reg.view{
            if let delegate = self.delegate{
                delegate.onMenuItemClick(itemTag: view.tag)
            }
        }
    }
    
    
}

