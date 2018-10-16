//
//  PlayInfoDataBean.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class PlayInfoDataBean: HandyJSON {

    required init() {
        
    }
    
    var kickback: String?
    var maxOdds: CGFloat = 0.0
    var numName: String?
}
