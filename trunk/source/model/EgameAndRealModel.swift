//
//  EgameAndRealModel.swift
//  gameplay
//
//  Created by admin on 2018/8/19.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit
import HandyJSON

class EgameAndRealFatherModel: HandyJSON {

    required init(){}
    
    var success = false
    var accessToken = ""
    var msg = ""
    var code = 0
    var content: EgameAndRealModelArray?
}

class EgameAndRealModelArray: HandyJSON {
    required init(){}
    
    var egame: [EgameModel]?
    var real: [RealModel]?
}

class EgameModel: HandyJSON {
    required init(){}
    var name = ""
    var value = ""
}

class RealModel: HandyJSON {
    required init(){}
    var name = ""
    var value = ""
}
