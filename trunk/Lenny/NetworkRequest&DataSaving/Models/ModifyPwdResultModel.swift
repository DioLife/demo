//
//  ModifyPwdResultModel.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/6.
//  Copyright © 2018年 yibo. All rights reserved.
//
/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-06 10:50:00
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */

import UIKit
//修改密码model结构体

@objc (ModifyPwdResultModel)
class ModifyPwdResultModel :NSObject, SexyJson, NSCoding, NSCopying {
    
    required init(coder decoder: NSCoder) {
        super.init()
        self.sexy_decode(decoder)
    }
    
    func encode(with aCoder: NSCoder) {
        self.sexy_encode(aCoder)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return self.sexy_copy()
    }
    
    required override init() {}
    
    var success: Bool = false
    var content: Bool = false
    var accessToken: String?
    var msg: String = ""
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        content            <<<        map["content"]
        accessToken        <<<        map["accessToken"]
        msg                <<<        map["msg"]
    }
    
}

