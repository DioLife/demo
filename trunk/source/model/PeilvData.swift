//
//  PeilvData.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/23.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class PeilvData: HandyJSON {

    var tagName:String = "";
    var postTagName:String = "";//下注时提交的号码前缀名称
    var appendTag = false;//号码是否要加上tagName
    var subData:[PeilvPlayData] = [];
    required init(){}
}
