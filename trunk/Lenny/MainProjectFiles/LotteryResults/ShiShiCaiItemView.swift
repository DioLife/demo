//
//  ShiShiCaiItemView.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/24.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ShiShiCaiItemView: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    ///视图○的直径
    var diamter: CGFloat = 25 {
        didSet {
            frame = CGRect.init(x: 0, y: 0, width: diamter, height: diamter)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        self.font = UIFont.systemFont(ofSize: 15)
        self.textAlignment = .center
        backgroundColor = UIColor.mainColor()
        textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        frame = CGRect.init(x: 0, y: 0, width: diamter, height: diamter)
        layer.cornerRadius = diamter / 2
        clipsToBounds = true
    }
}
