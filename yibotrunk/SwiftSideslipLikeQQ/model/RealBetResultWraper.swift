//
//  RealBetResultWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class RealBetResultWraper: HandyJSON {
    
    required init(){}
    var message = "";
    var sumBet:Float = 0;
    var sumWin:Float = 0;
    var code = 0
    var msg = ""
    var success = false
    var data:[RealBetBean] = []
    
}
