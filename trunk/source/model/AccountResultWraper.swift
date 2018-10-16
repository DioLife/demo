//
//  AccountResultWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/2.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import Foundation
import HandyJSON

class AccountResultWraper: HandyJSON {
    
    var content:AccountResult?
    var success:Bool = false
    var msg:String = ""
    var code = 0
    var accessToken:String = ""
    
    required init() {}
}
