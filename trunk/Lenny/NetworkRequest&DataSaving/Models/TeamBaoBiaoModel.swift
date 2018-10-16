

/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-07-17 15:16:55
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */



class TeamBaoBiaoModelTotal :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var depositGiftAmount: Int = 0
    var registerGiftAmount: Int = 0
    var withdrawAmount: Int = 0
    var lotteryWinAmount: CGFloat = 0.0
    var activeAwardAmount: Int = 0
    var depositArtificial: Int = 0
    var withdrawArtificial: Int = 0
    var profitAndLossTotal: CGFloat = 0.0
    var proxyRebateAmount: Int = 0
    var lotteryBetAmount: Int = 0
    var depositAmount: Int = 0
    var lotteryRebateAmount: CGFloat = 0.0
    
    public func sexyMap(_ map: [String : Any]) {
        
        depositGiftAmount          <<<        map["depositGiftAmount"]
        registerGiftAmount         <<<        map["registerGiftAmount"]
        withdrawAmount             <<<        map["withdrawAmount"]
        lotteryWinAmount           <<<        map["lotteryWinAmount"]
        activeAwardAmount          <<<        map["activeAwardAmount"]
        depositArtificial          <<<        map["depositArtificial"]
        withdrawArtificial         <<<        map["withdrawArtificial"]
        profitAndLossTotal         <<<        map["profitAndLossTotal"]
        proxyRebateAmount          <<<        map["proxyRebateAmount"]
        lotteryBetAmount           <<<        map["lotteryBetAmount"]
        depositAmount              <<<        map["depositAmount"]
        lotteryRebateAmount        <<<        map["lotteryRebateAmount"]
        
    }
    
}

class TeamBaoBiaoModelRows :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var depositGiftAmount: Int = 0
    var profitAndLoss: CGFloat = 0.0
    var registerGiftAmount: Int = 0
    var withdrawAmount: Int = 0
    var lotteryWinAmount: CGFloat = 0.0
    var activeAwardAmount: Int = 0
    var accountType: Int = 0
    var depositArtificial: Int = 0
    var accountId: Int = 0
    var withdrawArtificial: Int = 0
    var username: String?
    var proxyRebateAmount: Int = 0
    var lotteryBetAmount: Int = 0
    var depositAmount: Int = 0
    var lotteryRebateAmount: CGFloat = 0.0
    
    public func sexyMap(_ map: [String : Any]) {
        
        depositGiftAmount          <<<        map["depositGiftAmount"]
        profitAndLoss              <<<        map["profitAndLoss"]
        registerGiftAmount         <<<        map["registerGiftAmount"]
        withdrawAmount             <<<        map["withdrawAmount"]
        lotteryWinAmount           <<<        map["lotteryWinAmount"]
        activeAwardAmount          <<<        map["activeAwardAmount"]
        accountType                <<<        map["accountType"]
        depositArtificial          <<<        map["depositArtificial"]
        accountId                  <<<        map["accountId"]
        withdrawArtificial         <<<        map["withdrawArtificial"]
        username                   <<<        map["username"]
        proxyRebateAmount          <<<        map["proxyRebateAmount"]
        lotteryBetAmount           <<<        map["lotteryBetAmount"]
        depositAmount              <<<        map["depositAmount"]
        lotteryRebateAmount        <<<        map["lotteryRebateAmount"]
        
    }
    
}

class TeamBaoBiaoModelPage :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var rows: [TeamBaoBiaoModelRows]?
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

class TeamBaoBiaoModelContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var total: TeamBaoBiaoModelTotal?
    var page: TeamBaoBiaoModelPage?
    
    public func sexyMap(_ map: [String : Any]) {
        
        total        <<<        map["total"]
        page         <<<        map["page"]
        
    }
    
}

class TeamBaoBiaoModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: TeamBaoBiaoModelContent?
    var code = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}
