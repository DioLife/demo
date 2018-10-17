//
//  Meminfo.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/10.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class Meminfo: HandyJSON {

    required init(){}
    var account:String="";
    var balance:String="";
    var login=false;//是否会员登录状态
    var level = "";//会员等级
    var level_icon = "";//等级图标
    var score:Int64 = 0;
}
