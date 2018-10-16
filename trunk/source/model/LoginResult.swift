//
//  LoginResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class LoginResult: HandyJSON {

    var accountType:Int!;//用户模式 1-会员 6-游客
    var account:String!;//当前帐号
    var money:Float = 0;//account balance
    required init(){}
}
