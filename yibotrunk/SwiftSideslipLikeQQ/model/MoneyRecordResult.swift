//
//  MoneyRecordResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class MoneyRecordResult: HandyJSON {

    var recordId = 0;
    var title = "";
    var betdate = "";
    var bettime = "";
    var money:Float = 0;
    var status = 0;
    var opDesc = "";
    
    required init(){}
    
}
