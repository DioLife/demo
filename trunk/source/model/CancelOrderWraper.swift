//
//  CancelOrderWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/5/14.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class CancelOrderWraper: HandyJSON {
    
    var success:Bool = false;
    var msg:String = "";
    var code:Int = 0;
    var content = false
    var accessToken:String = "";
    
    required init(){}
    
}
