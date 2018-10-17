//
//  FakePacketModel.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/8/17.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class FakePacketModel: HandyJSON {

    required init() {
        
    }
    var account = ""//账号，带掩码
    var createDatetime:Int64 = 0//创建时间
    var money:Float = 0.0;//中奖金额
    
    
}
