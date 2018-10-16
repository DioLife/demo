//
//  TeamOverviewBean.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class TeamOverviewBean: HandyJSON {

    var proxyCount: Int = 0
    var timeCount: Int = 0
    var teamMoney: CGFloat = 0.0
    var memberCount: Int = 0
//    var dailyMoney: DailyMoney?
    var threeNotLoginNum: Int = 0
    var onlineNum: Int = 0
    var dailyMoney:GerenOVContent?
    
    required init() {
        
    }
    
}
