//
//  BallonRules.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/17.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class BallonRules: HandyJSON {

    var playCode:String!;
    var ruleCode:String!;
    var nums:String!;//号码串
    var postNums:String = "";//投注时提交的号码串
    var showWeiShuView:Bool!;//是否显示位数view
    var showFuncView:Bool!;//是否显示便捷筛选号码view
    var ruleTxt:String!;//玩法显示文字
    var weishuInfo:[BallListItemInfo]!;
    var funcInfo:[BallListItemInfo]!;
    var ballonsInfo:[BallListItemInfo]!;
    
    required init() {
        
    }
    
}
