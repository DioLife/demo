//
//  BankPay.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/29.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class BankPay: HandyJSON {

    required init(){}
    
    var bankCard = "";//银行帐号
    var maxFee = 0;//最大支付金额
    var minFee = 0;//最小支付金额
    var icon = "";//支付图标地址
    var bankAddress = "";//开户地址
    var payName = "";//支付名称
    var payBankName = "";//银行名称
    var status = 0;//开关状态
    var receiveName = "";//收款人姓名
    var id = 0;//银行ID
    var iconCss = "";//支付css,用于跳转支付地址或支付二维码时使用
    var payType = "";
    
}
