

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



class SendMessageModelContentRow :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var status: Int = 0
    var createTime: String?
    var id: Int = 0
    var message: String?
    var receiveAccount:String?
    //接收类型 1 个人 2群发 3层级 4上级 5 下级
    var receiveType:String?
    //发送人
    var sendAccount: String?
    var sendId:String?
    //发送方类型 1.租户后台 2，会员
    var sendType:String?;
    var stationId: Int = 0
    var title: String?
    
    public func sexyMap(_ map: [String : Any]) {
        
        status                  <<<        map["status"]
        createTime              <<<        map["createTime"]
        id                      <<<        map["id"]
        message                 <<<        map["message"]
        receiveAccount          <<<        map["receiveAccount"]
        receiveType             <<<        map["receiveType"]
        sendAccount             <<<        map["sendAccount"]
        sendId                  <<<        map["sendId"]
        sendType                <<<        map["sendType"]
        stationId               <<<        map["stationId"]
        title                   <<<        map["title"]
        
    }
    
}

class SendMessageModelContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var rows: [SendMessageModelContentRow]?
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

class SendMessageModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: SendMessageModelContent?
    var code:Int?
    var msg:String?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        msg                <<<        map["msg"]
        
    }
    
}

