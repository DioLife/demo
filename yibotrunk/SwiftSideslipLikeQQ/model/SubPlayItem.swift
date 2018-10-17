//
//  SubPlayItem.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/13.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class SubPlayItem: HandyJSON {

    var name:String = "";
    var code:String = "";
    var randomCount:Int!;
    var lotType:Int!;//彩种类型
    var status:Int!;//开关状态
    var detailDesc:String = "";//详细介绍
    var winExample:String = "";//中奖示例
    var playMethod:String = "";//玩法介绍
    var palyId:Int8!;
    
    var maxBounsOdds:Float!;//最大中奖金额
    var minBonusOdds:Float!;//最小中奖金额
    var minRakeback:Float!;//最低返水
    var maxNumber:Int!;//最高注数
    var maxRakeback:Float!;//最高返水
    
    required init(){}
}
