//
//  SendMessageResultWraper.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/7/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
//发送站内信结果
class SendMessageResultWraper :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    
    var msg: String?
    var success: Bool = false
    var code: Int = 0
    
    public func sexyMap(_ map: [String : Any]) {
        
        msg            <<<        map["msg"]
        success        <<<        map["success"]
        code           <<<        map["code"]
        
    }
    
}

