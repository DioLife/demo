//
//  ActiveRecord.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/28.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class ActiveRecord: HandyJSON {

    required init(){}
    
    var id:Int64 = 0;
    var itemName = "";//商品名称
    var stationId = 0;//站点ID
    var type = 0;//中奖类型
    var username = "";//中奖用户名
    var winMoney:Float = 0.0;//中奖金额
    var winTime = "";//中奖时间
    
}
