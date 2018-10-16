//
//  AccountChangeResult.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class AccountChangeResult: HandyJSON {

    required init(){}
    var pageSize = 0;
    var totalCount = 0;
    var results:[AccountRecord] = [];
    
}
