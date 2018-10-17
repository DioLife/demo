//
//  RegisterResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/18.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class RegisterResult: HandyJSON {
    
    var accountType = 0;//用户帐户类型模式 1-会员 6-游客，试玩帐号
    var cpVersion = "";//当前彩票版本号
    var account = "";
    required init(){}
    
}
