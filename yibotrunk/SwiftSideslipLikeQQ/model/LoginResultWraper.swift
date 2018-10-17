//
//  LoginResultWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class LoginResultWraper: HandyJSON {

    var success = false;
    var msg:String?;
    var accessToken:String!;
    var content:LoginResult?;
    required init(){}
    
}
