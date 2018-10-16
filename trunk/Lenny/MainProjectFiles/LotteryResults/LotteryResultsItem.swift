//
//  LotteryResultsItem.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/9.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class LotteryResultsItem: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private let label_Number = UILabel()
    private let label_Animals = UILabel()
    convenience init() {
        self.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 45))
        
        self.addSubview(label_Number)
        label_Number.whc_Top(0).whc_Left(0).whc_Right(0).whc_Height(25)
        label_Number.backgroundColor = UIColor.mainColor()
        label_Number.layer.cornerRadius = 25 / 2
        label_Number.clipsToBounds = true
        label_Number.textColor = UIColor.white
        label_Number.font = UIFont.systemFont(ofSize: 15)
        label_Number.text = "9"
        label_Number.textAlignment = .center
        self.addSubview(label_Animals)
        label_Animals.whc_Top(6, toView: label_Number).whc_CenterXEqual(label_Number).whc_Width(12).whc_Height(12)
        label_Animals.font = UIFont.systemFont(ofSize: 12)
        label_Animals.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label_Animals.text = "兔"
    }
}
