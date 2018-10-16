

/**
 * Copyright 2018 WHC_DataModelFactory
 * Auto-generated: 2018-06-24 16:40:26
 *
 * @author netyouli (whc)
 * @website http://wuhaichao.com
 * @github https://github.com/netyouli
 */

import UIKit



class ReadMessageModel :NSObject, SexyJson, NSCoding, NSCopying {
    
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
    var code:Int?
    
    public func sexyMap(_ map: [String : Any]) {
        
        success            <<<        map["success"]
        accessToken        <<<        map["accessToken"]
        code               <<<        map["code"]
        
    }
    
}

