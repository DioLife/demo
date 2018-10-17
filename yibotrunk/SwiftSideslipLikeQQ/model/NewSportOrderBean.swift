//
//  NewSportOrderBean.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/9/20.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class NewSportOrderBean: HandyJSON {
    
    required init() {
        
    }
    
    var accountId = 0;
    var balance:Float = 0.0;
    var betItemType = 0;
    var betType = 0;
    var bettingMoney:Float = 0.0;
    var bettingStatus = 0;
    var confirmDatetime:Int64 = 0;
    var createDatetime:Int64 = 0;
    var gameKey:String = "";
    var gid:Int64 = 0;
    var guestTeam = "";
    var homeTeam = "";
    var id:Int64 = 0;
    var itemKey = "";
    var league = "";
    var matchId:Int64 = 0;
    var matchType = 0;
    var mix = 0;
    var odds:Float = 0.0;
    var orderId = "";
    var parentIds = "";
    var plate = "";
    var playType = 0;
    var project = "";
    var proxyRollback = 0;
    var remark = "";
    var sportType = 0;
    var startDatetime:Int64 = 0;
    var stationId = 0;
    var teminalType = 0;
    var timeType = 0;
    var typeNames = "";
    var username = "";
    var resultStatus = 0;
    var winMoney:Float = 0.0;
    var guestScore = 0;
    var homeScore = 0;
    var result = "";

}
