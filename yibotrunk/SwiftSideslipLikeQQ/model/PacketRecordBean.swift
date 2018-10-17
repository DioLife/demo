//
//  PacketRecordBean.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/27.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class PacketRecordBean: HandyJSON {

    required init(){}
    var id = 0;
    var accountId = 0;
    var account = "";
    var money:Float = 0;
    var createDatetime = 0;
    var redPacketId = 0;
    var status = 0;
    var remark = "";
    var redPacketName = "";
    var ip = "";
    
    
}
