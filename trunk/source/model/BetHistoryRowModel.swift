//
//  BetHistoryRowModel.swift
//  gameplay
//
//  Created by admin on 2018/8/18.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class BetHistoryRowModel: HandyJSON {
    
    required init() {
        
    }

    /** 自己加的属性，并非返回的，根据类型拿到的游戏或真人的名称 */
    var typeValueName = ""
    var accountId:Int64 = -1
    var beforeMoney = 0.0
    var betAmountBonus = 0.0
    var bettingContent = ""
    var bettingMoney = 0.0
    var bettingTime: Int64 = -1
    var bettingTimeGmt4: Int64 = -1
    var createDatetime: Int64 = -1
    var gameCategory = 0
    var gameCode = ""
    var gameName = ""
    var gameType = ""
    var id = 0
    var md5Str = ""
    var netAmountBonus = 0.0
    var orderId = ""
    var parentIds = ""
    var platformType = ""
    var playType = ""
    var realBettingMoney = 0.0
    var result = ""
    var round = ""
    var stationId: Int64 = 0
    var tableCode = ""
    var thirdUsername = ""
    var type = 0
    var username = ""
    var winMoney = 0.0
}




