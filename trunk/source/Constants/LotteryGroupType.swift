//
//  LotteryGroupType.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

struct LotteryGroupType {
    
    var type:Int!
    var name:String!
    var sortNo:Int64!
    
    init(_ type:Int,_ name:String,_ sortNo:Int64) {
        self.type = type
        self.name = name
        self.sortNo = sortNo
    }

}
