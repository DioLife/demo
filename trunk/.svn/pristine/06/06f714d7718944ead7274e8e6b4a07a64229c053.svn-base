//
//  LiuHeCaiIetmView.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/30.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class LiuHeCaiIetmView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private let label = UILabel()
    private let circle = ShiShiCaiItemView()
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    convenience init() {
        
        self.init(frame: CGRect.zero)
        self.addSubview(circle)
//        circle.isSkeletonable = true
        self.addSubview(label)
//        label.isSkeletonable = true
        label.whc_Top(0, toView: circle).whc_CenterX(0).whc_WidthAuto().whc_Height(10)
        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = UIColor.black
        label.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label.textAlignment = .center
    }
    
    func setCircleBackGroundColor(color: UIColor) {
        circle.backgroundColor = color
    }
    func setCircleText(value: String) {
        circle.text = value
    }
    func setLabelText(value: String) {
        label.text = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
