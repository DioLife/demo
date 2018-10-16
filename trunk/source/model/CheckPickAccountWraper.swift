//
//  CheckPickAccountWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/31.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class CheckPickAccountWraper: HandyJSON {
    
    required init(){}
    var success:Bool=false;
    var msg = "";
    var code = 0;
    var accessToken = "";
    var content:PickBankAccount?;
    
}
