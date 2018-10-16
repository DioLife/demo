//
//  ExchangeConfig.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class ExchangeConfig: HandyJSON {

    required init(){}
    
    var numerator:Float = 0;//兑换比例中的分子数
    var denominator:Float = 0;//兑换比例中的分母数
    var maxVal:Float = 0;//最大兑换值
    var minVal:Float = 0;//最小兑换值
    var status = 0;//禁用与否的状态
    var id = 0;
    var type = 0;//兑换类型 1--现金换积分 2-积分换现金
    
}
