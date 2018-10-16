//
//  sss.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit


@objc (AllLotteryTypesSubData)
class AllLotteryTypesSubData :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    @objc var czCode: String?
    @objc var status: String?
    @objc var moduleCode: String?
    @objc var groupCode: String?
    @objc var code: String?
    @objc var lotType: String?
    @objc var lotVersion: String?
    @objc var groupName: String?
    @objc var duration: String?
    @objc var ballonNums: String?
    @objc var name: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        czCode            <<<        map["czCode"]
        status            <<<        map["status"]
        moduleCode        <<<        map["moduleCode"]
        groupCode         <<<        map["groupCode"]
        code              <<<        map["code"]
        lotType           <<<        map["lotType"]
        lotVersion        <<<        map["lotVersion"]
        groupName         <<<        map["groupName"]
        duration          <<<        map["duration"]
        ballonNums        <<<        map["ballonNums"]
        name              <<<        map["name"]
        
    }
    
}

@objc (AllLotteryTypesContent)
class AllLotteryTypesContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    @objc var ballonNums: String?
    @objc var czCode: String?
    @objc var lotVersion: String?
    @objc var code: String?
    @objc var subData: [AllLotteryTypesSubData]?
    @objc var groupCode: String?
    @objc var groupName: String?
    @objc var moduleCode: String?
    @objc var lotType: String?
    @objc var duration: String?
    @objc var status: String?
    @objc var name: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        ballonNums        <<<        map["ballonNums"]
        czCode            <<<        map["czCode"]
        lotVersion        <<<        map["lotVersion"]
        code              <<<        map["code"]
        subData           <<<        map["subData"]
        groupCode         <<<        map["groupCode"]
        groupName         <<<        map["groupName"]
        moduleCode        <<<        map["moduleCode"]
        lotType           <<<        map["lotType"]
        duration          <<<        map["duration"]
        status            <<<        map["status"]
        name              <<<        map["name"]
        
    }
    
}

@objc (AllLotteryTypesModel)
class AllLotteryTypesModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    @objc var content: [AllLotteryTypesContent]?
    @objc var success: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        success            <<<        map["success"]
        
    }
    
}

extension AllLotteryTypesModel {
    
    /// 获取去重后的小彩种带Code
    func obtainAllLotteryWithIndex() -> [AllLotteryTypesSubData] {
        var lotterys = [AllLotteryTypesSubData]()
        for item: AllLotteryTypesContent in content! {
            for it: AllLotteryTypesSubData in item.subData! {
                if lotterys.count == 0 { lotterys.append(it) }
                var add: Bool = true
                for lot in lotterys {
                    if lot.code == it.code {
                        add = false
                        continue
                    }
                }
                if add { lotterys.append(it) }
            }
        }
        return lotterys
    }
    
}
