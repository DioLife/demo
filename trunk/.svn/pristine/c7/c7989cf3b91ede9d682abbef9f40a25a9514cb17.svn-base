//
//  AllLotteryQueryModel.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/3.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

@objc (AllLotteryQueryModelRows)
class AllLotteryQueryModelRows :NSObject, SexyJson, NSCoding, NSCopying {
    
    @objc  required init(coder decoder: NSCoder) {
        super.init()
        self.sexy_decode(decoder)
    }
    
    @objc func encode(with aCoder: NSCoder) {
        self.sexy_encode(aCoder)
    }
    
    @objc func copy(with zone: NSZone? = nil) -> Any {
        return self.sexy_copy()
    }
    
    @objc  required override init() {}
    
    @objc var orderId: String?
    @objc var buyZhuShu: String?
    @objc var lotVersion: String?
    @objc var status: String?
    @objc var username: String?
    @objc var lotType: String?
    @objc var rollBackStatus: String?
    @objc var multiple: String?
    @objc var buyMoney: String?
    @objc var winMoney: String?
    @objc var zhuiHao: String?
    @objc var zhuiOrderId: String?
    @objc var buyOdds: String?
    @objc var playCode: String?
    @objc var lotCode: String?
    @objc var haoMa: String?
    @objc var id: String?
    @objc var openHaoMa: String?
    @objc var playName: String?
    @objc var lotName: String?
    @objc var closedTime: String?
    @objc var model: String?
    @objc var proxyRollback: String?
    @objc var kickback: String?
    @objc var sellingTime: String?
    @objc var stationId: String?
    @objc var createTime: String?
    @objc var terminalBetType: String?
    @objc var cheat: String?
    @objc var qiHao: String?
    @objc var oddsCode: String?
    @objc var accountId: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        zhuiOrderId            <<<        map["zhuiOrderId"]
        orderId                <<<        map["orderId"]
        buyZhuShu              <<<        map["buyZhuShu"]
        lotVersion             <<<        map["lotVersion"]
        status                 <<<        map["status"]
        username               <<<        map["username"]
        lotType                <<<        map["lotType"]
        rollBackStatus         <<<        map["rollBackStatus"]
        multiple               <<<        map["multiple"]
        buyMoney               <<<        map["buyMoney"]
        winMoney               <<<        map["winMoney"]
        zhuiHao                <<<        map["zhuiHao"]
        buyOdds                <<<        map["buyOdds"]
        playCode               <<<        map["playCode"]
        lotCode                <<<        map["lotCode"]
        haoMa                  <<<        map["haoMa"]
        id                     <<<        map["id"]
        openHaoMa              <<<        map["openHaoMa"]
        playName               <<<        map["playName"]
        lotName                <<<        map["lotName"]
        closedTime             <<<        map["closedTime"]
        model                  <<<        map["model"]
        proxyRollback          <<<        map["proxyRollback"]
        kickback               <<<        map["kickback"]
        sellingTime            <<<        map["sellingTime"]
        stationId              <<<        map["stationId"]
        createTime             <<<        map["createTime"]
        terminalBetType        <<<        map["terminalBetType"]
        cheat                  <<<        map["cheat"]
        qiHao                  <<<        map["qiHao"]
        oddsCode               <<<        map["oddsCode"]
        accountId              <<<        map["accountId"]
        
    }
    
}

@objc (AllLotteryQueryModelContent)
class AllLotteryQueryModelContent :NSObject, SexyJson, NSCoding, NSCopying {
    
    @objc required init(coder decoder: NSCoder) {
        super.init()
        self.sexy_decode(decoder)
    }
    
    @objc func encode(with aCoder: NSCoder) {
        self.sexy_encode(aCoder)
    }
    
    @objc func copy(with zone: NSZone? = nil) -> Any {
        return self.sexy_copy()
    }
    
    @objc required override init() {}
    
    @objc var hasPre: String?
    @objc var pageSize: String?
    @objc var start: String?
    @objc var hasNext: String?
    @objc var totalPageCount: String?
    @objc var rows: [AllLotteryQueryModelRows]?
    @objc var nextPage: String?
    @objc var currentPageNo: String?
    @objc var total: String?
    @objc var prePage: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
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

@objc (AllLotteryQuery)
class AllLotteryQueryModel :NSObject, SexyJson, NSCoding, NSCopying {
    
    @objc required init(coder decoder: NSCoder) {
        super.init()
        self.sexy_decode(decoder)
    }
    
    @objc func encode(with aCoder: NSCoder) {
        self.sexy_encode(aCoder)
    }
    
    @objc func copy(with zone: NSZone? = nil) -> Any {
        return self.sexy_copy()
    }
    
    @objc required override init() {}
    
    @objc var accessToken: String?
    @objc var content: AllLotteryQueryModelContent?
    @objc var success: Bool = false
    var code: Int?
//    @objc var msg: String?
    
    
    @objc public func sexyMap(_ map: [String : Any]) {
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        success            <<<        map["success"]
        code               <<<        map["code"]
//        msg                <<<        map["msg"]
    }
    
}

