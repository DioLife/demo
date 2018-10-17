//
//  SportOrderDetail.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/25.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

class SportOrderDetail: HandyJSON {

    
    required init(){}
    /**
     1全输 2输一半 3平 4赢一半 5全赢
     */
    public static let RESULT_STATUS_LOST = 1;
    public static let RESULT_STATUS_LOST_HALF = 2;
    public static let RESULT_STATUS_DRAW = 3;
    public static let RESULT_STATUS_WIN_HALF = 4;
    public static let RESULT_STATUS_WIN = 5;
    
    
    var id = 0;
    
    var sportType = 0;
    /**
     1:滚球   2:今日  3:早盘
     */
    var gameTimeType = 0;
    
    /**
     1:独赢 ＆ 让球 ＆ 大小 & 单 / 双
     2：波胆  上半场
     3：波胆  全场
     4：总入球数
     5：全场半场输赢
     6：混合过关      （参照枚举类DataType）
     */
    var dataType = 0;
    
    /**
     1:全场独赢
     2:全场大小球
     3:全场让球盘
     4：全场得分单双
     5：全场波胆
     6：半场波胆
     7：总入球
     8：半场 全场 胜负关系
     9：主队全场分数大小
     10：客队全场分数大小
     */
     var betType = 0;
    
    /**
     1：主胜
     2：主负
     3：平
     4：总得分单
     5：总得分双
     6：总得分大于
     7：总得分小于
     8：让球主队赢
     9：让球主队输
     10：波胆具体比分
     11:波胆其他比分
     12：总入球数 具体分数
     13：全场 半场胜负关系
     */
    var betItemType = 0;
    
    var project = "";
    
    /**
     滚球时使用，主队分数
     */
    var scoreH = 0;
    
    /**
     滚球时使用，客队分数
     */
    var scoreC = 0;
    
    /**
     主队
     */
    var homeTeam = "";
    
    /**
     客队名称
     */
    var guestTeam = "";
    
    /**
     联赛
     */
    var league = "";
    
    /**
     H:亚洲盘  I:印尼盘 E:欧洲盘 M:马来西亚盘
     */
    var plate = "";
    
    /**
     用于前端显示
     */
    var remark = "";
    
    /**
     赔率
     */
    var odds:Float = 0;
    
    /**
     1 待确认
     2：已确认
     3：已取消 (滚球系统自动取消)
     4: 手动取消
     */
    var bettingStatus = 0;
    
    
    
    /**
     1：未结算 2：已结算
     */
    var balance = 1;
    
    /**
     下注时间
     */
    var bettingDate:Int64 = 0;
    
    /**
     投注结果
     */
    var bettingResult:Float = 0;
    
    /**
     结算时间
     */
    var accountDatetime:Int64 = 0;
    
    /**
     * 皇冠赛事ID
     */
    var gid:Int64 = 0;
    
    /**
     1全输 2输一半 3平 4赢一半 5全赢
     */
    var resultStatus = 0;
    
    var stationId = 0;
    
    var memberId = 0;
    
    /**
     * 注单编码
     */
    var bettingCode = "";
    
    /**
     * 投注金额
     */
    var bettingMoney:Float = 0;
    
    /**
     * 注单状态说明，取消注单时写入取消原因
     */
    var statusRemark = "";
    
    /**
     *  1:单注  2：混合过关 主单  3：混合过关子单
     */
    var mix = 0;
    
    var memberName = "";
    
    var stationName = "";
    
    /**
     * 类别名称
     */
    var typeNames = "";
    
    
    /**
     * 赛果，结算的时候回填  只用于页面显示使用
     */
    var result = "";
    
    /**
     * 会员返水状态 （1，还未返水 2，已经返水,还未到账 3，返水已经回滚 ,4 反水已经到账 ）多级表示返点(1，还未返点 2，已经返点 3，返点已经回滚)
     */
    var rollBackStatus = 0;
    
    var rollBackMoney:Float = 0;
}
