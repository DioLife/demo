//
//  OfficialOrder.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

/**
 * Created by johnson on 2018/5/21.
 * 獎金版下注注單信息
 */

class OfficialOrder :HandyJSON{
    
    required init() {
        
    }
    
    var oddName = "";//赔率名称
    var c = "";//单独一单的号码集
    var i = "";//赔率编码
    var n:Int = 0;//单独一单的注数(后台自动计算，无需手机计算，手机可以计算出来做显示注数时使用)
    var t = 0;//倍数
    var k:Float = 0.0;//用户选择的返水比例
    var m = 0;//模式，元角分
    var a:Float = 0.0;//单独一单总下注金额(后台自动计算，无需手机计算)
    
}
