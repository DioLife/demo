//
//  PeilvPlayData.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/23.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

protocol Copyable {
    func copy() -> Copyable
}

class PeilvPlayData: HandyJSON,Copyable {

    
    var peilv: String = "";
    var money: Float = 0;
    var number: String = "";
    var itemName: String = "";//所属栏项标签名称，如时时彩-整合玩法中的，万位
    var helpNumber: String = "";//辅助号码
    var checkbox: Bool = false;//是否多选
    var isSelected: Bool = false;//是否被选中了
    var appendTag: Bool = false;//号码是否要加上tagName
    var appendTagToTail = false//号码是否要加上tagName,且添加到尾部
    var filterSpecialSuffix: Bool = false;//是否过滤特殊号码前缀
    var focusDrawable: Int = 0;//选中或未选中的图片
    
    var peilvData:PeilvWebResult = PeilvWebResult();//后台获取的赔率数据
    var allDatas:[PeilvWebResult] = [];//所有赔率数据；当多选时需要根据勾选的号码数从中选择适当的赔率信息
    
    required init(){}
    func copy() -> Copyable {
        let p = PeilvPlayData()
        p.peilv = peilv
        p.money = money
        p.number = number
        p.itemName = itemName
        p.helpNumber = helpNumber
        p.checkbox = checkbox
        p.isSelected = isSelected
        p.appendTag = appendTag
        p.filterSpecialSuffix = filterSpecialSuffix
        p.focusDrawable = focusDrawable
        p.peilvData = peilvData
        p.allDatas = allDatas
        p.appendTagToTail = appendTagToTail
        return p
    }
}
