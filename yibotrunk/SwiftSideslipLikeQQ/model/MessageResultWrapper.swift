//
//  MessageResultWrapper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/19.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class MessageResultWrapper: HandyJSON {
    required init(){}
    var success:Bool = false;
    var msg:String = "";
    var accessToken:String = "";
    var code:Int = 0;
    var content:MessageEntify!;
}
