//
//  GeRenBaoBiaoModel.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/19.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-19 16:27:25
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */


@objc (ReportModeRows)
class ReportModeRows :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var lotteryWinAmount: CGFloat = 0
    var profitAndLoss: CGFloat = 0
    var lotteryRebateAmount: CGFloat = 0
    var statDate: String?
    var lotteryBetAmount: CGFloat = 0
    var depositAmount: CGFloat = 0
    var proxyRebateAmount: CGFloat = 0.0
    var activeAwardAmount: CGFloat = 0
    var withdrawAmount: CGFloat = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        lotteryWinAmount           <<<        map["lotteryWinAmount"]
        profitAndLoss              <<<        map["profitAndLoss"]
        lotteryRebateAmount        <<<        map["lotteryRebateAmount"]
        statDate                   <<<        map["statDate"]
        lotteryBetAmount           <<<        map["lotteryBetAmount"]
        depositAmount              <<<        map["depositAmount"]
        proxyRebateAmount          <<<        map["proxyRebateAmount"]
        activeAwardAmount          <<<        map["activeAwardAmount"]
        withdrawAmount             <<<        map["withdrawAmount"]
        
    }
    
}

@objc (PageDataModel)
class PageDataModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var rows: [ReportModeRows]?
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

@objc (ContentModel)
class ContentModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var proxyRebateAmountCount: CGFloat = 0.0
    var profitAndLossTotal: CGFloat = 0.0
    var lotteryBetAmountCount: CGFloat = 0.0
    var lotteryWinAmountCount: CGFloat = 0.0
    var depositAmountCount: Int = 0
    var lotteryRebateAmountCount: CGFloat = 0.0
    var withdrawAmountCount: Int = 0
    var page: PageDataModel?
    var activeAwardAmountCount: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        proxyRebateAmountCount          <<<        map["proxyRebateAmountCount"]
        profitAndLossTotal              <<<        map["profitAndLossTotal"]
        lotteryBetAmountCount           <<<        map["lotteryBetAmountCount"]
        lotteryWinAmountCount           <<<        map["lotteryWinAmountCount"]
        depositAmountCount              <<<        map["depositAmountCount"]
        lotteryRebateAmountCount        <<<        map["lotteryRebateAmountCount"]
        withdrawAmountCount             <<<        map["withdrawAmountCount"]
        page                            <<<        map["page"]
        activeAwardAmountCount          <<<        map["activeAwardAmountCount"]
        
    }
    
}

@objc (GeRenBaoBiaoModel)
class GeRenBaoBiaoModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var content: ContentModel?
    var code: Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        code               <<<        map["code"]
        
    }
    
}


