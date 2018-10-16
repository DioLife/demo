//
//  UserListSmallBean.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class UserListSmallBean: HandyJSON {

    required init() {
        
    }
    
    var guest: Bool = false
    var status: Int = 0
    var createDatetime: String = ""
    var lastLoginDatetime: String = ""
    var id: Int64 = 0
    var kickback: CGFloat = 0.0
    var username: String?
    var type: Int = 0
    var onlineStatus: Int = 0
    var money: Int = 0
}
