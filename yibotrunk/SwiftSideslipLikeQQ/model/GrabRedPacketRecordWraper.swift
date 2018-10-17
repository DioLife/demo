//
//  GrabRedPacketRecordWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/27.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class GrabRedPacketRecordWraper: HandyJSON {

    var content:[PacketRecordBean]?
    var success:Bool!
    var msg:String?
    var code:Int = 0
    var accessToken:String?
    
    required init() {}
    
}
