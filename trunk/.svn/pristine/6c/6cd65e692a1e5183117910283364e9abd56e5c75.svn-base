

/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-20 14:51:16
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */



class AccountChangeRowModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var remark: String?
    var typeCn: String?
    var createDatetime: String?
    var afterMoney: Float = 0.0
    var username: String?
    var type: Int = 0
    var add: Bool = false
    var money: Float = 0.0
    
    public func sexyMap(_ map: [String : Any]) {
        
        remark                <<<        map["remark"]
        typeCn                <<<        map["typeCn"]
        createDatetime        <<<        map["createDatetime"]
        afterMoney            <<<        map["afterMoney"]
        username              <<<        map["username"]
        type                  <<<        map["type"]
        add                   <<<        map["add"]
        money                 <<<        map["money"]
        
    }
    
}

class AggsData :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var totalSMoney: Float = 0.0
    var totalZMoney: Float = 0.0
    
    public func sexyMap(_ map: [String : Any]) {
        
        totalSMoney        <<<        map["totalSMoney"]
        totalZMoney        <<<        map["totalZMoney"]
        
    }
    
}

class AccountChangePageModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var rows: [AccountChangeRowModel]?
    var nextPage: Int = 0
    var currentPageNo: Int = 0
    var total: Int = 0
    var prePage: Int = 0
    var aggsData: AggsData?
    
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
        aggsData              <<<        map["aggsData"]
        
    }
    
}

class AccountChangeContentModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var subTotal: Int = 0
    var subTotalZMoney: Int = 0
    var subTotalSMoney: Float = 0.0
    var totalSMoney: Float = 0.0
    var total: Int = 0
    var page: AccountChangePageModel?
    var totalZMoney: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        subTotal              <<<        map["subTotal"]
        subTotalZMoney        <<<        map["subTotalZMoney"]
        subTotalSMoney        <<<        map["subTotalSMoney"]
        totalSMoney           <<<        map["totalSMoney"]
        total                 <<<        map["total"]
        page                  <<<        map["page"]
        totalZMoney           <<<        map["totalZMoney"]
        
    }
    
}

class AccountChangeModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: AccountChangeContentModel?
    var code:Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}
