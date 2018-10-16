//
//  BetHistoryModelWraper.swift
//  gameplay
//
//  Created by admin on 2018/8/18.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class BetHistoryModelWraper: HandyJSON {
    
    required init() {
        
    }
    
    var success: Bool = false
    var accessToken: String = ""
    var code:Int = 0
//    var content: BetHistoryModel?
    var content: String = ""
    var msg:String = ""
}
