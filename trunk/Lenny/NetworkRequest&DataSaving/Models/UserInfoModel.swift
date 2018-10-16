

/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-20 17:35:36
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */



class UserInfoContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var phone: String?
    var accountId: Int = 0
    var qq: String?
    var realName: String?
    var score: Int = 0
    var wechat: String?
    var email: String?
    var username: String?
    var money: Int = 0
    var stationId: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        phone            <<<        map["phone"]
        accountId        <<<        map["accountId"]
        qq               <<<        map["qq"]
        realName         <<<        map["realName"]
        score            <<<        map["score"]
        wechat           <<<        map["wechat"]
        email            <<<        map["email"]
        username         <<<        map["username"]
        money            <<<        map["money"]
        stationId        <<<        map["stationId"]
        
    }
    
}

class UserInfoModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: UserInfoContent?
    var code:Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}
