//
//  SwitchData.swift
//  Esports
//
//  Created by hello on 2018/12/14.
//  Copyright © 2018 hello. All rights reserved.
//

import UIKit
import HandyJSON

class SwitchData: HandyJSON {
    var openSafariUrl: String? //外部浏览器打开
    var serviceUrl: String? //客服联系方式
    var homeUrl: String? //首页地址
    var headHidden: String? //是否隐藏头部安全区
    var switchOn: String? //开关是否打开
    var functionArr: String? //功能数组,根据需要加载
    var activityUrl: String? //优惠活动地址
    var footColor: String? //底部安全区颜色
    var headColor: String? //头部安全区颜色
    
    required init(){}
}
