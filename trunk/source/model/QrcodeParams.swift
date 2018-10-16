//
//  QrcodeParams.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/30.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class QrcodeParams: HandyJSON {

    required init(){}
    var redirectUrl = ""
    var amount = ""
    var callBackUrl = ""
    var callBackViewUrl = ""
    var clientIP = ""
    var goodsInfo = ""
    var merNo = ""
    var orderNo = ""
    var payNetway = ""
    var random = ""
    var sign = ""
}
