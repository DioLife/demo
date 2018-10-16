//
//  OrderDataInfo.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class OrderDataInfo:HandyJSON{

    var playName = "";
    var playCode = "";
    var subPlayName = "";
    var subPlayCode = "";
    var beishu = 0;
    var numbers = "";
    var mode = 0;
    var zhushu = 0;
    var money = 0.0;
    var saveTime:Int32 = 0;
    var user = "";
    var orderno = "";
    var lotcode = "";
    var lottype = "";
    var rate = 0.0;
    var cpCode = "";//彩票代码
    var oddsCode:String = "";//赔率编码
    var oddsName:String = "";//下注号码的赔率名称
    var playData:PeilvPlayData?;
    
    required init() {}
}
