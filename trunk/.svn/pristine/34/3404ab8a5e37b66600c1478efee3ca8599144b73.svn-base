

/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-20 19:26:25
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */



class BankCardListContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var realName: String?
    var bankCode: String?
    var id: Int = 0
    var status: Int = 0
    var cardNoSc: String?
    var bankAddress: String?
    var createTime: String?
    
    public func sexyMap(_ map: [String : Any]) {
        
        cardNo             <<<        map["cardNo"]
        bankName           <<<        map["bankName"]
        realName           <<<        map["realName"]
        bankCode           <<<        map["bankCode"]
        id                 <<<        map["id"]
        status             <<<        map["status"]
        cardNoSc           <<<        map["cardNoSc"]
        bankAddress        <<<        map["bankAddress"]
        createTime         <<<        map["createTime"]
        
    }
    
}

class BankCardListModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: [BankCardListContent]?
    var code:Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}
