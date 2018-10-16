//
//  JifenModel.swift
//  gameplay
//
//  Created by William on 2018/8/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class JifenModel: HandyJSON {
    var success = false
    var accessToken:String!
    var content:[JifenRow]?
    
    required init(){}
}
