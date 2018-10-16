//
//  JifenDataRow.swift
//  gameplay
//
//  Created by William on 2018/8/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class JifenDataRow: HandyJSON {
    var account:String!
    var accountId:Int!
    var afterScore:Int!
    var beforeScore:Int!
    var createDatetime:String!
    var id:Int!
    var remark:String!
    var score:Int!
    var stationId:Int!
    var type:Int!

    required init(){}
}
