//
//  SportBean.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/21.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class NewSportBean: HandyJSON {

    required init(){}
    var gid = "";//赛事ID
    var txt = "";//显示结果
    var peilv="";//显示赔率
    var peilvKey="";//赔率KEY
    var mid="";//matchId
    var fakeItem=false;//占位显示项
    var isHeader=false;//是否不及格头部
    var project = "";//結果內容
    
    var lianSaiName = "";//联赛名称
    var teamNames = "";//球队名称
    var gameCategoryName = "";//比赛类型，全场-波胆
    
    var scores = "";//两队比分
    var gameRealTime = "";//比赛进行到的时间，针对足球
    var halfName = "";//上半场，下半场，针对足球
    var nowSession = "";//当前比赛节数，OT代表超时，针对篮球
    
    var scoreH = ""//住产分数，针对滚球
    var scoreC = ""//客产分数，针对滚球
    
    var home = "";
    var client = "";
    var betTeamName = "";//下注时提示的球队名称(主队，客队，和局),波胆时值为比分值
}
