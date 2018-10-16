//
//  SpreadModel.swift
//  gameplay
//
//  Created by William on 2018/8/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class SpreadModel: HandyJSON {
    var success = false
    var accessToken:String!
    var content:SpreadContent?
    var msg = ""
    
    
    required init(){}
}
