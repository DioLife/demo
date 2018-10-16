//
//  VisitRecords.swift
//  gameplay
//
//  Created by William on 2018/7/24.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit


@objc (VisitRecords)
class VisitRecords :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    @objc var userName: String? //彩票名字
    @objc var cpName: String? //彩票名字
    @objc var czCode: String? //彩票类型
    @objc var ago: String? //时间差
    @objc var cpBianHao: String? //彩票编号
    @objc var lotType: String? //时间类型
    @objc var lotVersion: String? //彩票版本
    @objc var num: String? //这种彩票总点击次数
    @objc var icon:String? //彩票icon名
    
    @objc public func sexyMap(_ map: [String : Any]) {
        
        userName            <<<        map["userName"]
        cpName            <<<        map["cpName"]
        czCode            <<<        map["czCode"]
        ago            <<<        map["ago"]
        cpBianHao        <<<        map["cpBianHao"]
        lotType            <<<        map["lotType"]
        lotVersion            <<<        map["lotVersion"]
        num            <<<        map["num"]
        icon            <<<        map["icon"]
        
    }
    
}
