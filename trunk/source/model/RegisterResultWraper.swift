//
//  RegisterResultWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/18.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class RegisterResultWraper: HandyJSON {
    
    var success = false;
    var msg:String?;
    var code = 0
    var accessToken:String!;
    var content:RegisterResult?;
    required init(){}
    
}

