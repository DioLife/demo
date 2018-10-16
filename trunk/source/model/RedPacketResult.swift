//
//  RedPacketResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/27.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class RedPacketResult: HandyJSON {

    var beginDatetime = 0;
    var betRate = 0;
    var endDatetime = 0;
    var id = 0;
    var ipNumber = 0;
    var minMoney:Float = 0.0;
    var remainMoney:Float = 0.0;
    var remainNumber = 0;
    var status = 0;
    var title = "";
    var totalMoney:Float = 0;
    var totalNumber = 0;
    
    required init(){}
    
}
