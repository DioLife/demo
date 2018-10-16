//
//  PickMoneyData.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class PickMoneyData: HandyJSON {

    var curWnum = 0;//已提款次数
    var wnum = 0;//今日还可提款几次,-1表示不限制
    var enablePick=true;//是否能取款
    var drawFlag = "";//不可提款的原因，可提款时值为"是"
    var startTime = "";//今日提款有效开始时间
    var endTime = "";//今天提款有效结束时间
    var minPickMoney = "";//最小提现额度
    var maxPickMoney = "";//最大提现额度
    var cardNo = "";//提款卡号
    var userName = "";//提款帐户名
    var validBetMoney:Float = 0;//有效投注金额
    var accountStatus = 0;//帐号启用状态
    var bankAddress = "";//开户行
    var bankName = "";//银行名称
    var accountBalance:Float = 0;//帐户余额
    var checkBetNum = 0;//出款需达到的投注量,-1表示不限投注量
    
    required init(){}
    
}
