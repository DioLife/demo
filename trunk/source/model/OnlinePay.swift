//
//  OnlinePay.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/29.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class OnlinePay: HandyJSON {

    required init(){}
    
    var merchantCode = "";//商户ID
    var payGetway = "";//支付网关
    var maxFee = 0;//最大充值金额
    var minFee = 0;//最小充值金额
    var icon = "";//支付图标地址
    var merchantKey = "";//商户密钥
    var payName = "";//支付名称
    var payAlias = "" //支付别名
    var status = 0;//开关状态
    var id = 0;
    var iconCss = "";//支付css,用于跳转支付地址或支付二维码时使用
    var payType = "";//支付方式,用于确定支付跳转时的支付方式类型
    var fixedAmount:String = "";//固定金额，分割
    var isFixedAmount = 0;//是否开启固定金额 1--禁用 2--启用单一固定金额 3--启用多个固定金额
}
