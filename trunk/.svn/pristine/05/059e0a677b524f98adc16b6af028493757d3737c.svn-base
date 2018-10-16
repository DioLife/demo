//
//  WithdrawModel.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit



/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-20 00:29:19
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */



class WithdrawRows :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var cardNo: String?
    var bankName: String?
    var orderId: String?
    var createDatetime: String?
    var remark: String?
    var drawMoney: Float = 0
    var status: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        cardNo                <<<        map["cardNo"]
        bankName              <<<        map["bankName"]
        orderId               <<<        map["orderId"]
        createDatetime        <<<        map["createDatetime"]
        remark                <<<        map["remark"]
        drawMoney             <<<        map["drawMoney"]
        status                <<<        map["status"]
        
    }
    
}

class WithdrawContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var hasPre: Bool = false
    var pageSize: Int = 0
    var start: Int = 0
    var hasNext: Bool = false
    var totalPageCount: Int = 0
    var rows: [WithdrawRows]?
    var nextPage: Int = 0
    var currentPageNo: Int = 0
    var total: Int = 0
    var prePage: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        hasPre                <<<        map["hasPre"]
        pageSize              <<<        map["pageSize"]
        start                 <<<        map["start"]
        hasNext               <<<        map["hasNext"]
        totalPageCount        <<<        map["totalPageCount"]
        rows                  <<<        map["rows"]
        nextPage              <<<        map["nextPage"]
        currentPageNo         <<<        map["currentPageNo"]
        total                 <<<        map["total"]
        prePage               <<<        map["prePage"]
        
    }
    
}

class WithdrawModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: WithdrawContent?
    var code:Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}

