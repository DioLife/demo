//
//  MenuItem.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class MenuItem: UIView,MenuPopWindowDelegate {

    var menuText:UILabel!
    var indictor:UIImageView!
    var isPullDown:Bool = false
    var menuBarDelegate:MenuBarDelegate?
    var popWindow:MenuDownPopWindow!
    var itemTag:String = ""
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
        indictor = UIImageView.init(frame: CGRect.init(x: self.bounds.width-17.5, y: self.bounds.height/2-2, width: 7, height: 4))
        self.addSubview(menuText)
        self.addSubview(indictor)
        
        bottomBar = UIView.init(frame: CGRect.init(x: 0, y: self.bounds.height-3, width: self.bounds.width, height: 3))
//        bottomBar.backgroundColor = UIColor.red
        bottomBar.theme_backgroundColor = "Global.themeColor"
        self.addSubview(bottomBar)
        toggleBottom(show: false)
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(itemClickEvent(reg:)))
        self.addGestureRecognizer(tap)
        
        if popWindow == nil{
            popWindow = Bundle.main.loadNibNamed("record_menu_pop_window", owner: nil, options: nil)?.first as! MenuDownPopWindow
            popWindow.itemClickDelegate = self
        }
    }
    
    func toggleBottom(show:Bool) ->  Void{
        if show{
            bottomBar.isHidden = false
        }else{
            bottomBar.isHidden = true
        }
    }
    
    func showIndector(show:Bool) -> Void {
        self.indictor.isHidden = !show
    }
    
    func bindCustomSelector(target:Any?,selector:Selector?) -> Void {
        let tap = UITapGestureRecognizer.init(target: target, action: selector)
        self.addGestureRecognizer(tap)
    }
    
    @objc func itemClickEvent(reg:UIPanGestureRecognizer) -> Void {
        switchIndictor()
        let item = reg.view as! MenuItem
        switch item.itemTag{
        case "00":
            popWindow.setMenuDataType(menuData: .status)
        case "01":
            popWindow.setMenuDataType(menuData: .time)
        case "02":
            popWindow.setMenuDataType(menuData: .caizhong)
        case "10":
            popWindow.setMenuDataType(menuData: . time)
        case "20":
            popWindow.setMenuDataType(menuData: .sportTime)
        case "21":
            popWindow.setMenuDataType(menuData: .qiuzhong)
        case "30":
            popWindow.setMenuDataType(menuData: .time)
        case "31":
            popWindow.setMenuDataType(menuData: .real_platform)
        case "40":
            popWindow.setMenuDataType(menuData: .time)
        case "41":
            popWindow.setMenuDataType(menuData: .game_platform)
        case "50":
            popWindow.setMenuDataType(menuData: .time)
        case "70":
            popWindow.setMenuDataType(menuData: .goucai)
        default:
            break
        }
        popWindow.show()
    }
    
    func onMenuItemClick(key: String, value: String) {
        print("item name = \(key),value = \(value)")
        if !isEmptyString(str: value){
            self.menuText.text = value
        }
        var keys = key
        if isEmptyString(str: key){
           keys = value
        }
        if let barDelegate = menuBarDelegate{
            barDelegate.onMenuItemClick(key: keys,itemTag: self.itemTag)
        }
    }
    
    func onMenuDismiss() {
        switchIndictor()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

    func switchIndictor() -> Void {
        if isPullDown{
            indictor.image = UIImage.init(named: "pushup")
            menuText.textColor = UIColor.red
        }else{
            indictor.image = UIImage.init(named: "pulldown")
            menuText.textColor = UIColor.init(red: 187/255, green: 187/255, blue: 187/255, alpha: 1)
        }
        isPullDown = !isPullDown
    }
    
}
