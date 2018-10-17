//
//  SportOrder.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/25.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class SportOrder: HandyJSON {

    required init(){}
    var sportType = 0;//0-全部 1-足球 2-篮球
    var bettingDate:Int64 = 0;//投注时间
    var bettingMoney:Float = 0;//投注金额
    var bettingStatus = 0;//投注状态
    var balance = 0;//结算状态
    var bettingResult:Float = 0;//结算结果
    var id = 0;
}
