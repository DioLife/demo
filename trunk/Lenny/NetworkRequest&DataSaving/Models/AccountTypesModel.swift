//
//  AccountTypesModel.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit



/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-20 14:19:12
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */



class PayType :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var name: String?
    var type: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        name        <<<        map["name"]
        type        <<<        map["type"]
        
    }
    
}

class IncomeType :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var name: String?
    var type: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        name        <<<        map["name"]
        type        <<<        map["type"]
        
    }
    
}

class AccountTypesContentModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var payType: [PayType]?
    var incomeType: [IncomeType]?
    
    public func sexyMap(_ map: [String : Any]) {
        
        payType           <<<        map["payType"]
        incomeType        <<<        map["incomeType"]
        
    }
    
}

class AccountTypesModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var accessToken: String?
    var content: AccountTypesContentModel?
    var code:Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}

