//
//  RegConfig.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/18.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class RegConfig: HandyJSON {

    var required = 1;//是否必须 2-是，1-否
    var show = 1;//是否显示，1-不显示 2-显示
    var regex = "";
    var name = "";
    var key = "";
    var validate = 0;//是否验证此字段
    var status = 1;//启用状态，1-禁用 2-启用
    var uniqueness = 1;//是否唯一 1-否 2-是
    var inputContent = "";//input register content
    var eleName = "";//服务器返回的注册时提交的参数key字段
    
    required init(){}
}
