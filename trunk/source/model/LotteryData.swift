//
//  LotteryData.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/13.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class LotteryData: HandyJSON {

    var czCode:String?;//彩票类型代号
    var name:String?;
    var ballonNums:Int!;
    var duration:Int64!;
    var isSys:Bool!;
    var pinLv:String?;
    var ago:Int64 = 0;
    var id:Int64 = 0
    /**
     * 状态，1=关闭，2=开启
     */
    var status:Int!;
    var code:String?;//彩票编码
    var lotVersion:Int = 1;
    var groupName:String = ""
    var nameCn:String = ""
    var lotteryIcon = "";//
    var lotType:Int = 0;
    var sortNo:Int64 = 0;
    var subData:[LotteryData] = []
    
    
    var imgUrl = "";//体育，真人，电子的图标相对地址
    var moduleCode = 3;//彩票，体育，真人，电子模块代号,3代表彩票
    var rules:[BcLotteryPlay] = [];//玩法列表
    
    var needShowSecondClassification = false;//是否展现子彩种；分组模式下使用
    
    required init() {}
}
