//
//  BcLotteryPlay.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/3.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON
//lottery play model
class BcLotteryPlay: HandyJSON {
    
    required init() {}
    
    var id:Int64 = 0;
    var parentCode:String = ""//父级code，默认为空 ，代表大类，不为空的为小类
    var name:String = "";//play name
    var code:String = "";//play code
    var sortNo:Int64 = 0;//sort no,big no order first
    var status:Int8 = 0;//status 2-on 1-off
    var lotType:Int8 = 0;//彩种类型，1=时时彩，2=北京赛车(快开)，3=快三，4=11选5，5=香港彩，6=PC蛋蛋，7=低频彩，8=快乐十分
    var lotVersion:Int8 = 0;//彩票版本号
    var detailDesc:String = "";//详细介绍
    var winExample:String = "";//中奖范例
    var playMethod:String = "";//玩法介绍
    var maxHaoMaNum:Int8 = 0;
    var playMaxBetAmount:Float = 0;
    var maxBetAmount:Float = 0;
    var minBetAmount:Float = 0;
    
    var peilvs:[PeilvWebResult] = [];//当前玩法对应的赔率列表
    var children:[BcLotteryPlay] = [];//用于递归子结节使用，正常无值
    
    
    
    
    
    

}
