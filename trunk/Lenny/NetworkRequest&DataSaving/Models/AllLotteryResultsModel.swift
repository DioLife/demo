//
//  AllLotteryResultsModel.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/23.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit



@objc (AllLotteryResultsList)
class AllLotteryResultsList :NSObject, SexyJson, NSCoding, NSCopying {
    
    @objc required init(coder decoder: NSCoder) {
        super.init()
        self.sexy_decode(decoder)
    }
    
    @objc  func encode(with aCoder: NSCoder) {
        self.sexy_encode(aCoder)
    }
    
    @objc func copy(with zone: NSZone? = nil) -> Any {
        return self.sexy_copy()
    }
    
    @objc required override init() {}
    
    @objc var result: String?
    @objc var id: String?
    @objc var period: String?
    @objc var date: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        result        <<<        map["result"]
        id            <<<        map["id"]
        period        <<<        map["period"]
        date          <<<        map["date"]
        
    }
    
}

extension AllLotteryResultsList {
    
    func results() -> [String] {
        return (result?.components(separatedBy: ","))!
    }
}

@objc (AllLotteryResultsHistory)
class AllLotteryResultsHistory :NSObject, SexyJson, NSCoding, NSCopying {
    
    @objc required init(coder decoder: NSCoder) {
        super.init()
        self.sexy_decode(decoder)
    }
    
    @objc func encode(with aCoder: NSCoder) {
        self.sexy_encode(aCoder)
    }
    
    @objc func  copy(with zone: NSZone? = nil) -> Any {
        return self.sexy_copy()
    }
    
    @objc required override init() {}
    
    @objc var total: String?
    @objc var list: [AllLotteryResultsList]?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        total        <<<        map["total"]
        list         <<<        map["list"]
        
    }
    
}

@objc (AllLotteryResultsCodeNums)
class AllLotteryResultsCodeNums :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    @objc var Code: String?
    @objc var MC: String?
    @objc var AC: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        Code        <<<        map["Code"]
        MC          <<<        map["MC"]
        AC          <<<        map["AC"]
        
    }
    
}

@objc (AllLotteryResultsCodeRank)
class AllLotteryResultsCodeRank :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    @objc var Local: String?
    @objc var CodeNums: [AllLotteryResultsCodeNums]?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        Local           <<<        map["Local"]
        CodeNums        <<<        map["CodeNums"]
        
    }
    
    
}

private var kLastArray = "kLastArray"

extension AllLotteryResultsCodeRank {
    
    
    func obtainDatasBy(pageIndex: Int, rowIndex: Int, codeRankArr:[AllLotteryResultsCodeNums],dataArr:[AllLotteryResultsList]) -> [String] {
        var array_Return = [String]()
        
        if rowIndex == 0 {
            for codenum: AllLotteryResultsCodeNums in codeRankArr { //CodeNums
                array_Return.append(codenum.AC!)
            }
            LennyModel.lastArray = array_Return
            return array_Return
        }
        for i in 0 ..< LennyModel.lastArray!.count {
            var s = Int(LennyModel.lastArray![i])!
            s += 1
            array_Return.append(String(s))
            //            let item = LennyModel.allLotteryResultsModel?.content?.history?.list![19 - rowIndex + 1]
            let item = dataArr[rowIndex]
            let winningNumber = Int(item.results()[pageIndex])!
            if i == winningNumber - 1 {
                array_Return[i] = "1"
            }
        }
        LennyModel.lastArray = array_Return
        return array_Return
    }
    
    func obtainDatas11x5By(pageIndex: Int, rowIndex: Int) -> [String] {
        
        var array_Return = [String]()
        
        if rowIndex == 0 {
            for codenum: AllLotteryResultsCodeNums in CodeNums! {
                array_Return.append(codenum.AC!)
            }
            LennyModel.lastArray = array_Return
            return array_Return
        }
        for i in 0 ..< LennyModel.lastArray!.count {
            var s = Int(LennyModel.lastArray![i])!
            s += 1
            array_Return.append(String(s))
            let item = LennyModel.allLotteryResultsModel?.content?.history?.list![19 - rowIndex + 1]
            let winningNumber = Int(item!.results()[pageIndex])!
            if i == winningNumber - 1 {
                array_Return[i] = "1"
            }
        }
        LennyModel.lastArray = array_Return
        return array_Return
    }
    
    func obtainDatas11X5By(pageIndex: Int, rowIndex: Int, codeRankArr:[AllLotteryResultsCodeNums],dataArr:[AllLotteryResultsList]) -> [String] {
        var array_Return = [String]()
        
        if rowIndex == 0 {
            for codenum: AllLotteryResultsCodeNums in codeRankArr { //CodeNums
                array_Return.append(codenum.AC!)
            }
            LennyModel.lastArray = array_Return
            return array_Return
        }
        for i in 0 ..< LennyModel.lastArray!.count {
            var s = Int(LennyModel.lastArray![i])!
            s += 1
            array_Return.append(String(s))
            //            let item = LennyModel.allLotteryResultsModel?.content?.history?.list![19 - rowIndex + 1]
            let item = dataArr[rowIndex]
            let winningNumber = Int(item.results()[pageIndex])!
            if i == winningNumber - 1 {
                array_Return[i] = "1"
            }
        }
        LennyModel.lastArray = array_Return
        return array_Return
    }
}

@objc (AllLotteryResultsContent)
class AllLotteryResultsContent :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    @objc var history: AllLotteryResultsHistory?
    @objc var codeRank: [AllLotteryResultsCodeRank]?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        history         <<<        map["history"]
        codeRank        <<<        map["codeRank"]
        
    }
    
}

@objc (AllLotteryResultsModel)
class AllLotteryResultsModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    @objc var content: AllLotteryResultsContent?
    @objc var success: String?
    
    @objc var lotteryType: String?
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        accessToken        <<<        map["accessToken"]
        content            <<<        map["content"]
        success            <<<        map["success"]
        
    }
    
}

