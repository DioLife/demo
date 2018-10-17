//
//  PayMethodWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/29.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class PayMethodWraper: HandyJSON {

    required init(){}
    var success:Bool=false;
    var msg = "";
    var code = 0
    var accessToken = "";
    var content:PayMethodResult?;
    
}
