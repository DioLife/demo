//
//  LotteryGroup.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class LotteryGroup {

    // 彩种类型，1=时时彩，2=分分彩，3=北京赛车(快开)，4=快三，5=11选5，6=香港彩，7=PC蛋蛋，8=低频彩，9=快乐十分
    static let ssc = LotteryGroupType(1,"时时彩",100)
    static let ffc = LotteryGroupType(2,"分分彩",95)
    static let pk10 = LotteryGroupType(3,"pk10",90)
    static let k3 = LotteryGroupType(4,"快三",85)
    static let syxw = LotteryGroupType(5,"11选5",80)
    static let six = LotteryGroupType(6,"六合彩",75)
    static let pcdd = LotteryGroupType(7,"PC蛋蛋",70)
    static let dpc = LotteryGroupType(8,"低频彩",65)
    static let klsf = LotteryGroupType(9,"快乐彩",60)
    
    static let groups:[LotteryGroupType] = [ssc,ffc,pk10,k3,syxw,six,pcdd,dpc,klsf]
    
    static func getType(type:Int) -> LotteryGroupType{
        for c in groups{
            if c.type == type{
                return c
            }
        }
        return LotteryGroupType(0,"",0)
    }
    
}
