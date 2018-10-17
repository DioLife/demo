//
//  PeilvWebResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/23.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class PeilvWebResult: HandyJSON {

    var id:Int = 0;//赔率ID
    var isNowYear:Int = 0;////当为本命年和尾数0时，状态为1，其余状态0
    var markType:String = "";////数字号码或者类型
    var name:String = "";//号码名称
    var odds:Float = 0.0;//赔率
    var maxBetAmmount:Float = 0.0;//最大下注金额
    var minBetAmmount:Float = 0.0;//最小下注金额
    var playCode:String = "";//玩法小类code
    var sortNo:Int = 0;//序号
    var status:Int = 0;//状态
    // 如果是选中按钮时，提供最少选择个数
    var minSelected:Int = 0;
    //反水
    var rakeBack:Float = 0.0;
    var lotType:Int = 0;
    var stationId:Int32 = 0;//站点编号
    
    required init(){}
}
