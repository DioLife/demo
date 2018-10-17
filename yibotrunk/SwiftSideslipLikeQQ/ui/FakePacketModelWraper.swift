//
//  FakePacketModelWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/8/17.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class FakePacketModelWraper: HandyJSON {
    
    var content:[FakePacketModel]?
    var success:Bool!
    var msg:String?
    var code:Int = 0
    var accessToken:String?
    
    required init() {}
    
}
