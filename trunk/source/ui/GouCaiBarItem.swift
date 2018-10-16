//
//  GouCaiBarItem.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/4/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol CaigouBarDelegate {
    func onBarClick(index:Int)
}

class GouCaiBarItem: UIView {

    var menuText:UILabel!
    var indictor:UIImageView!
    var menuBarDelegate:CaigouBarDelegate?
    var bottomBar:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 206, green: 219, blue: 231, alpha: 1)
        self.layer.borderColor = UIColor.init(red: 187/255, green: 187/255, blue: 187/255, alpha: 1).cgColor
        self.layer.borderWidth = 0.3
        
        indictor = UIImageView.init(frame: CGRect.init(x: self.bounds.width/2-15, y: self.bounds.height/2-25, width: 30, height: 30))
        self.addSubview(indictor)
        
        menuText = UILabel.init(frame: CGRect.init(x: 0, y: self.bounds.height/2+2, width: self.bounds.width, height: 25))
        menuText.textColor = UIColor.init(red: 187/255, green: 187/255, blue: 187/255, alpha: 1)
        menuText.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        menuText.textAlignment = NSTextAlignment.center
        self.addSubview(menuText)
        
        
        bottomBar = UIView.init(frame: CGRect.init(x: 0, y: self.bounds.height-3, width: self.bounds.width, height: 3))
        bottomBar.backgroundColor = UIColor.red
        self.addSubview(bottomBar)
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(itemClickEvent(reg:)))
        self.addGestureRecognizer(tap)
 
    }
    
    @objc func itemClickEvent(reg:UIPanGestureRecognizer) -> Void {
        if let delegate = self.menuBarDelegate{
            delegate.onBarClick(index: reg.view!.tag)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func toggleIndictor(show:Bool) -> Void {
        print("the show == ",show)
        bottomBar.isHidden = show ? false : true
    }
    
    

}
