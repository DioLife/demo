//
//  SBOrderRealResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class SBOrderRealResult: HandyJSON {

    required init() {
        
    }
    
    var account: String = ""
    var accountBetMoney: Float = 0
    var leagueName: String = ""
    var transId: String = ""
    var betTeamName: String = ""
    var htResultTeam: String = ""
    var transactionTime: Int64 = 0
    var betTypeName: String = ""
    var bjTime: Int = 0
    var betOdds: CGFloat = 0.0
    var resultTeam: String = ""
    var betOddsTypeName: String = ""
    var mix: Int = 0
    var homeHdp: Int = 0
    var awayName: String = ""
    var isLive: Int = 0
    var homeName: String = ""
    var sportTypeName: String = ""
    var awayHdp: Int = 0
    var hdp: Int = 0
    var winLostMoney: Float = 0
    var ticketStatus: String = ""
    var childrens:[SBOrderRealResult] = []
    
}
