

/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-24 16:40:26
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */

import UIKit



/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-24 16:43:30
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */



class ReceiveMessageModelContentRow :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var status: Int = 0//已读，未读标识 1-未读 2-已读
    var sendAccount: String?
    var createTime: String?
    var id: Int = 0
    var sendType: Int = 0
    var title: String?
    var levelGroup: Int = 0
    var message: String?
    var receiveMessageId: Int64 = 0
    var stationId: Int = 0
    var receiveType: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        status                  <<<        map["status"]
        sendAccount             <<<        map["sendAccount"]
        createTime              <<<        map["createTime"]
        id                      <<<        map["id"]
        sendType                <<<        map["sendType"]
        title                   <<<        map["title"]
        levelGroup              <<<        map["levelGroup"]
        message                 <<<        map["message"]
        receiveMessageId        <<<        map["receiveMessageId"]
        stationId               <<<        map["stationId"]
        receiveType             <<<        map["receiveType"]
        
    }
    
}

class ReceiveMessageModelContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var rows: [ReceiveMessageModelContentRow]?
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

class ReceiveMessageModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: ReceiveMessageModelContent?
    var code:Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}

