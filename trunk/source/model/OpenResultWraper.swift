//
//  OpenResultWraper.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/11.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class OpenResultWraper: HandyJSON{
    
    required init(){}
    var success=false;
    var msg = "";
    var code = 0;
    var accessToken = "";
    var content:[KaijianEntify]?;

}
