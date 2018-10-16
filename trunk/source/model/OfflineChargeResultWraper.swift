//
//  OfflineChargeResultWraper.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/24.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class OfflineChargeResultWraper: HandyJSON {

    required init() {
        
    }
    
    var success: Bool = false
    var accessToken: String = ""
    var code:Int = 0
    var content:String = ""
    var msg:String = ""
    
}
