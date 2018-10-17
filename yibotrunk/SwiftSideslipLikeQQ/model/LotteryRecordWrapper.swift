//
//  LotteryRecordWrapper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class LotteryRecordWrapper: HandyJSON {

    required init(){}
    var success:Bool=false;
    var msg:String="";
    var code:Int = 0;
    var accessToken:String = "";
    var content:GameRecordResult?;
}
