//
//  SpreadContent.swift
//  gameplay
//
//  Created by William on 2018/8/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class SpreadContent: HandyJSON {
    var currentPageNo:Int!
    var hasNext:Bool!
    var hasPre:Bool!
    var nextPage:Int!
    var pageSize:Int!
    var prePage:Int!
    var rows:[DailiModel]?
    var start:Int!
    var total:Int!
    var totalPageCount:Int!
    
    
    required init(){}
}
