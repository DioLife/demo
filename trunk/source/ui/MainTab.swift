//
//  MenuItem.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol MainTabBarDelegate {
    func onItemClick(tabIndex:Int)
}

class MainTab: UIView {
    
    var menuText:UILabel!
    var mainTabBarDelegate:MainTabBarDelegate?
    var bottomBar:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 206, green: 219, blue: 231, alpha: 1)
        self.layer.borderColor = UIColor.init(red: 187/255, green: 187/255, blue: 187/255, alpha: 1).cgColor
        self.layer.borderWidth = 0.3
        menuText = UILabel.init(frame: CGRect.init(x: 0, y: self.bounds.height/2-12.5, width: self.bounds.width, height: 25))
        menuText?.textColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        menuText.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        menuText.textAlignment = NSTextAlignment.center
        self.addSubview(menuText)
        
        bottomBar = UIView.init(frame: CGRect.init(x: 0, y: self.bounds.height-3, width: self.bounds.width, height: 3))
        bottomBar.backgroundColor = UIColor.red
        self.addSubview(bottomBar)
        toggleBottom(show: false)
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(itemClickEvent(reg:)))
        self.addGestureRecognizer(tap)
    }
    
    func toggleBottom(show:Bool) ->  Void{
        if show{
            bottomBar.isHidden = false
        }else{
            bottomBar.isHidden = true
        }
    }
    
    func bindCustomSelector(target:Any?,selector:Selector?) -> Void {
        let tap = UITapGestureRecognizer.init(target: target, action: selector)
        self.addGestureRecognizer(tap)
    }
    
    @objc func itemClickEvent(reg:UITapGestureRecognizer) -> Void {
        print("item click event ------")
        let tag = reg.view?.tag
        if let barDelegate = mainTabBarDelegate{
            barDelegate.onItemClick(tabIndex: tag!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setSelect(selected:Bool) -> Void {
        if selected{
            menuText.textColor = UIColor.red
        }else{
            menuText?.textColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        }
        toggleBottom(show: selected)
    }
    
}
