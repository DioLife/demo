//
//  SportData.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/20.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class SportData: HandyJSON {

    required init(){}
    var pageCount = 0;
    var games:[[String]] = [[]];
    var headers:[String] = [];
    var gameCount:SportGameCount?;
}
