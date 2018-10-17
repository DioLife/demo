//
//  OnlinePayResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/30.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class OnlinePayResult: HandyJSON {

    var account = "";//支付帐号
    var amount = "";//支付金额，元
    var formAction = "";
    var orderId = "";//订单号
    var payReferer = "";//支付源网关域名
    var payType = "";//支付类型
    var formParams:QrcodeParams?;//获取扫码二维码图片的表单请求数据
    
    required init(){}
    
}
