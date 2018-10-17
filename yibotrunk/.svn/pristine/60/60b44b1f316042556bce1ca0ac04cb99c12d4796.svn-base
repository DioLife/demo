//
//  SportTableContainer.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class SportTableContainer {
    
    
    /**
     * 根据体育球类型和大玩法获取小玩法名称
     * @param ballType 体育球类型  0-足球 1-篮球
     * @param playType 玩法 混合过关，波胆等
     * @return
     */
    
    public static func getTableHeaderArray(ballType:Int,playCategory:String) -> [String]{
        if ballType == FOOTBALL_PAGE{
            switch playCategory{
            case FT_MN,FT_MX:
                return ["场次", "独赢", "让球", "大小", "单双"]
            case FT_TI:
                return ["主/客","1:0", "2:0", "2:1", "3:0", "3:1","3:2"]
            case FT_BC:
                return ["0-1", "2-3", "4-6", "7或以上"]
            case FT_HF:
                return ["主/主", "主/和", "主/客", "和/主","和/和","和/客","客/主","客/和","客/客"]
            default:
                break
            }
        }else if ballType == BASKETBALL_PAGE{
            if playCategory == BK_MN || playCategory == BK_MX{
                return ["独赢", "让球", "大小球"]
            }
        }
        return []
    }
    

    //根据球类和玩法计算各寒事表格头部列数
    public static func tableColumnSize(ballType:Int,playCategory:String) -> Int {
        if ballType == FOOTBALL_PAGE{
            switch playCategory{
            case FT_MN,FT_MX:
                return 5
            case FT_TI:
                return 7
            case FT_BC:
                return 4
            case FT_HF:
                return 9
            default:
                break
            }
        }else if ballType == BASKETBALL_PAGE{
            if playCategory == BK_MN || playCategory == BK_MX{
                return 3
            }
        }
        return 0
    }
    
    
    /**
     * 篮球-- 全部
     * @param item 赛事数据
     * @param columns 列数
     * @param categoryType 赛事类型  滚球，今日赛事，早盘
     * @return
     */
    static func fillBasketBallMN(item:Dictionary<String,AnyObject>,columns:Int,gameCategory:String) -> [SportBean] {
        var lists = [SportBean]()
        let gidValue = item.keys.contains(gid) ? item[gid] as! String : ""
        let matchIdValue = item.keys.contains(matchId) ? item[matchId] as! String : ""
        let leagueValue = item.keys.contains(league) ? item[league] as! String : ""
        let homeValue = item.keys.contains(home) ? item[home] as! String : ""
        let guestValue = item.keys.contains(guest) ? item[guest] as! String : ""
        let nowSessionValue = item.keys.contains("nowSession") ? item["nowSession"] as! String : ""
        let scoreHValue = item.keys.contains("scoreH") ? item["scoreH"] as! String : ""
        let scoreCValue = item.keys.contains("scoreC") ? item["scoreC"] as! String : ""
        
        //第一行
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            
            if gameCategory == RB_TYPE{
                if nowSessionValue == "OT"{
                    itemBean.nowSession = "加时"
                }else if nowSessionValue == "1Q"{
                    itemBean.nowSession = "第一节"
                }else if nowSessionValue == "2Q"{
                    itemBean.nowSession = "第二节"
                }else if nowSessionValue == "3Q"{
                    itemBean.nowSession = "第三节"
                }else if nowSessionValue == "4Q"{
                    itemBean.nowSession = "第四节"
                }
                itemBean.scores = String.init(format: "%@-%@", scoreHValue,scoreCValue)
            }
            
            if index == 0{
                itemBean.peilv = item.keys.contains("ior_MH") ? item["ior_MH"] as! String : ""
                itemBean.peilvKey = "ior_MH"
                itemBean.gameCategoryName = "全场-独赢"
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_RH") ? item["ior_RH"] as! String : ""
                itemBean.peilvKey = "ior_RH"
                itemBean.txt = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.project = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.gameCategoryName = "全场-让球"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_OUH") ? item["ior_OUH"] as! String : ""
                itemBean.peilvKey = "ior_OUH"
                itemBean.txt = item.keys.contains("CON_OUH") ? String.init(format: "大%@",  item["CON_OUH"] as! String) : ""
                itemBean.project = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.gameCategoryName = "全场-大小"
            }
            lists.append(itemBean)
        }
        
        //第二行
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            
            if index == 0{
                itemBean.peilv = item.keys.contains("ior_MC") ? item["ior_MC"] as! String : ""
                itemBean.peilvKey = "ior_MC"
                itemBean.gameCategoryName = "全场-独赢"
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_RC") ? item["ior_RC"] as! String : ""
                itemBean.peilvKey = "ior_RC"
                itemBean.txt = item.keys.contains("CON_RC") ? item["CON_RC"] as! String : ""
                itemBean.project = item.keys.contains("CON_RC") ? item["CON_RC"] as! String : ""
                itemBean.gameCategoryName = "全场-让球"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_OUC") ? item["ior_OUC"] as! String : ""
                itemBean.peilvKey = "ior_OUC"
                itemBean.txt = item.keys.contains("CON_OUC") ? String.init(format: "小%@", item["CON_OUC"] as! String) : ""
                itemBean.project = item.keys.contains("CON_OUC") ? item["CON_OUC"] as! String : ""
                itemBean.gameCategoryName = "全场-大小"
            }
            lists.append(itemBean)
        }
        return lists
    }
    
    
    /**
     *
     * @param item 赛事结果数据
     * @param ballType 球类
     * @param playType 玩法
     * @param columns 每行几列
     * @param gameCategory 球赛分类，滚球，今日赛事，早盘
     * @return
     */
    public static func fillSportResultData(item:Dictionary<String,AnyObject>,ballType:Int,playCategory:String,
                                           columns:Int,gameCategory:String) -> [SportBean]{
        if ballType == FOOTBALL_PAGE{
            switch playCategory{
            case FT_MN,FT_MX:
                return fillFootBallMX(item: item, columns: columns, gameCategory: gameCategory)
            case FT_TI:
                return fillFootBallTI(item: item, columns: columns)
            case FT_BC:
                return fillFootBallBC(item: item, columns: columns)
            case FT_HF:
                return fillFootBallHF(item: item, columns: columns)
            default:
                break
            }
        }else if ballType == BASKETBALL_PAGE{
            if playCategory == BK_MN{
                return fillBasketBallMN(item: item, columns: columns, gameCategory: gameCategory)
            }else if playCategory == BK_MX{
                return fillBasketBallMX(item: item, columns: columns, gameCategory: gameCategory)
            }
        }
        return []
    }
    
    /**
     * 篮球-- 混合过关
     * @param item 赛事数据
     * @param columns 列数
     * @param categoryType 赛事类型  滚球，今日赛事，早盘
     * @return
     */
    static func fillBasketBallMX(item:Dictionary<String,AnyObject>,columns:Int,gameCategory:String) -> [SportBean] {
        var lists = [SportBean]()
        let gidValue = item.keys.contains(gid) ? item[gid] as! String : ""
        let matchIdValue = item.keys.contains(matchId) ? item[matchId] as! String : ""
        let leagueValue = item.keys.contains(league) ? item[league] as! String : ""
        let homeValue = item.keys.contains(home) ? item[home] as! String : ""
        let guestValue = item.keys.contains(guest) ? item[guest] as! String : ""
        
        //第一行
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            if index == 0{
                itemBean.peilv = item.keys.contains("ior_MH") ? item["ior_MH"] as! String : ""
                itemBean.peilvKey = "ior_MH"
                itemBean.gameCategoryName = "全场-独赢"
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_RH") ? item["ior_RH"] as! String : ""
                itemBean.peilvKey = "ior_RH"
                itemBean.txt = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.project = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.gameCategoryName = "全场-让球"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_OUH") ? item["ior_OUH"] as! String : ""
                itemBean.peilvKey = "ior_OUH"
                itemBean.txt = item.keys.contains("CON_OUH") ? String.init(format: "大%@",  item["CON_OUH"] as! String) : ""
                itemBean.project = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.gameCategoryName = "全场-大小"
            }
            lists.append(itemBean)
        }
        
        //第二行 全场输
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            
            if index == 0{
                itemBean.peilv = item.keys.contains("ior_MC") ? item["ior_MC"] as! String : ""
                itemBean.peilvKey = "ior_MC"
                itemBean.gameCategoryName = "全场-独赢"
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_RC") ? item["ior_RC"] as! String : ""
                itemBean.peilvKey = "ior_RC"
                itemBean.txt = item.keys.contains("CON_RC") ? item["CON_RC"] as! String : ""
                itemBean.project = item.keys.contains("CON_RC") ? item["CON_RC"] as! String : ""
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_OUC") ? item["ior_OUC"] as! String : ""
                itemBean.peilvKey = "ior_OUC"
                itemBean.txt = item.keys.contains("CON_OUC") ? String.init(format: "小%@", item["CON_OUC"] as! String) : ""
                itemBean.project = item.keys.contains("CON_OUC") ? item["CON_OUC"] as! String : ""
            }
            lists.append(itemBean)
        }
        return lists
    }
    
    /**
     * 足球--半场全场
     * @param item 头部数据
     * @param columns 列数
     * @return
     */
    static func fillFootBallHF(item:Dictionary<String,AnyObject>,columns:Int) -> [SportBean]{
        var lists = [SportBean]()
        let gidValue = item.keys.contains(gid) ? item[gid] as! String : ""
        let matchIdValue = item.keys.contains(matchId) ? item[matchId] as! String : ""
        let leagueValue = item.keys.contains(league) ? item[league] as! String : ""
        let homeValue = item.keys.contains(home) ? item[home] as! String : ""
        let guestValue = item.keys.contains(guest) ? item[guest] as! String : ""
        let scoreHValue = item.keys.contains("scoreH") ? item["scoreH"] as! String : ""
        let scoreCValue = item.keys.contains("scoreC") ? item["scoreC"] as! String : ""
        
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.mid = matchIdValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.gameCategoryName = "半场/全场"
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            
            
            if index == 0{
                itemBean.peilv = item.keys.contains("ior_FHH") ? item["ior_FHH"] as! String : ""
                itemBean.peilvKey = "ior_FHH"
                itemBean.betTeamName = String.init(format: "%@/%@", homeValue,homeValue)
            } else if index == 1{
                itemBean.peilv = item.keys.contains("ior_FHN") ? item["ior_FHN"] as! String : ""
                itemBean.peilvKey = "ior_FHN"
                itemBean.betTeamName = String.init(format: "%@/%@", homeValue,"和局")
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_FHC") ? item["ior_FHC"] as! String : ""
                itemBean.peilvKey = "ior_FHC"
                itemBean.betTeamName = String.init(format: "%@/%@", homeValue,guestValue)
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_FNH") ? item["ior_FNH"] as! String : ""
                itemBean.peilvKey = "ior_FNH"
                itemBean.betTeamName = String.init(format: "%@/%@", "和局",homeValue)
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_FNN") ? item["ior_FNN"] as! String : ""
                itemBean.peilvKey = "ior_FNN"
                itemBean.betTeamName = String.init(format: "%@/%@", homeValue,"和局")
            }else if index == 5{
                itemBean.peilv = item.keys.contains("ior_FNC") ? item["ior_FNC"] as! String : ""
                itemBean.peilvKey = "ior_FNC"
                itemBean.betTeamName = String.init(format: "%@/%@", "和局",guestValue)
            }else if index == 6{
                itemBean.peilv = item.keys.contains("ior_FCH") ? item["ior_FCH"] as! String : ""
                itemBean.peilvKey = "ior_FCH"
                itemBean.betTeamName = String.init(format: "%@/%@", guestValue,homeValue)
            }else if index == 7{
                itemBean.peilv = item.keys.contains("ior_FCN") ? item["ior_FCN"] as! String : ""
                itemBean.peilvKey = "ior_FCN"
                itemBean.betTeamName = String.init(format: "%@/%@", guestValue,"和局")
            }else if index == 8{
                itemBean.peilv = item.keys.contains("ior_FCC") ? item["ior_FCC"] as! String : ""
                itemBean.peilvKey = "ior_FCC"
                itemBean.betTeamName = String.init(format: "%@/%@", guestValue,guestValue)
            }
            lists.append(itemBean)
        }
        return lists
    }
    
    /**
     * 足球--总入球
     * @param item 头部数据
     * @param columns 列数
     * @return
     */
    static func fillFootBallBC(item:Dictionary<String,AnyObject>,columns:Int) -> [SportBean]{
        
        var lists = [SportBean]()
        let gidValue = item.keys.contains(gid) ? item[gid] as! String : ""
        let matchIdValue = item.keys.contains(matchId) ? item[matchId] as! String : ""
        let leagueValue = item.keys.contains(league) ? item[league] as! String : ""
        let homeValue = item.keys.contains(home) ? item[home] as! String : ""
        let guestValue = item.keys.contains(guest) ? item[guest] as! String : ""
        let scoreHValue = item.keys.contains("scoreH") ? item["scoreH"] as! String : ""
        let scoreCValue = item.keys.contains("scoreC") ? item["scoreC"] as! String : ""
        
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.mid = matchIdValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.gameCategoryName = "全场-总入球"
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            
            if index == 0{
                itemBean.peilv = item.keys.contains("ior_T01") ? item["ior_T01"] as! String : ""
                itemBean.peilvKey = "ior_T01"
                itemBean.betTeamName = "0:1"
            } else if index == 1{
                itemBean.peilv = item.keys.contains("ior_T23") ? item["ior_T23"] as! String : ""
                itemBean.peilvKey = "ior_T23"
                itemBean.betTeamName = "2:3"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_T46") ? item["ior_T46"] as! String : ""
                itemBean.peilvKey = "ior_T46"
                itemBean.betTeamName = "4:6"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_OVER") ? item["ior_OVER"] as! String : ""
                itemBean.peilvKey = "ior_OVER"
                itemBean.betTeamName = "7或以上"
            }
            lists.append(itemBean)
        }
        return lists
    }
    
    //足球--波胆
    static func fillFootBallTI(item:Dictionary<String,AnyObject>,columns:Int) -> [SportBean]{
        var lists = [SportBean]()
        let gidValue = item.keys.contains(gid) ? item[gid] as! String : ""
        let matchIdValue = item.keys.contains(matchId) ? item[matchId] as! String : ""
        let leagueValue = item.keys.contains(league) ? item[league] as! String : ""
        let homeValue = item.keys.contains(home) ? item[home] as! String : ""
        let guestValue = item.keys.contains(guest) ? item[guest] as! String : ""
        let scoreHValue = item.keys.contains("scoreH") ? item["scoreH"] as! String : ""
        let scoreCValue = item.keys.contains("scoreC") ? item["scoreC"] as! String : ""
        
        //第一行，主队
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.gameCategoryName = "全场-波胆"
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            
            if index == 0{
                itemBean.txt = "主队"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_H1C0") ? item["ior_H1C0"] as! String : ""
                itemBean.peilvKey = "ior_H1C0"
                itemBean.betTeamName = "1:0"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_H2C0") ? item["ior_H2C0"] as! String : ""
                itemBean.peilvKey = "ior_H2C0"
                itemBean.betTeamName = "2:0"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_H2C1") ? item["ior_H2C1"] as! String : ""
                itemBean.peilvKey = "ior_H2C1"
                itemBean.betTeamName = "2:1"
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_H3C0") ? item["ior_H3C0"] as! String : ""
                itemBean.peilvKey = "ior_H3C0"
                itemBean.betTeamName = "3:0"
            }else if index == 5{
                itemBean.peilv = item.keys.contains("ior_H3C1") ? item["ior_H3C1"] as! String : ""
                itemBean.peilvKey = "ior_H3C1"
                itemBean.betTeamName = "3:1"
            }else if index == 6{
                itemBean.peilv = item.keys.contains("ior_H3C2") ? item["ior_H3C2"] as! String : ""
                itemBean.peilvKey = "ior_H3C2"
                itemBean.betTeamName = "3:2"
            }
            lists.append(itemBean)
        }
        
        //第二行，客队
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.gameCategoryName = "全场-波胆"
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            
            if index == 0{
                itemBean.txt = "客队"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_H0C1") ? item["ior_H0C1"] as! String : ""
                itemBean.peilvKey = "ior_H0C1"
                itemBean.betTeamName = "0:1"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_H0C2") ? item["ior_H0C2"] as! String : ""
                itemBean.peilvKey = "ior_H0C2"
                itemBean.betTeamName = "0:2"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_H1C2") ? item["ior_H1C2"] as! String : ""
                itemBean.peilvKey = "ior_H1C2"
                itemBean.betTeamName = "1:2"
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_H0C3") ? item["ior_H0C3"] as! String : ""
                itemBean.peilvKey = "ior_H0C3"
                itemBean.betTeamName = "0:3"
            }else if index == 5{
                itemBean.peilv = item.keys.contains("ior_H1C3") ? item["ior_H1C3"] as! String : ""
                itemBean.peilvKey = "ior_H1C3"
                itemBean.betTeamName = "1:3"
            }else if index == 6{
                itemBean.peilv = item.keys.contains("ior_H2C3") ? item["ior_H2C3"] as! String : ""
                itemBean.peilvKey = "ior_H2C3"
                itemBean.betTeamName = "2:3"
            }
            lists.append(itemBean)
        }
        
        //第三行，"4:0","4:1","4:2","4:3" 这几个比分另起一行当做表格头部,因为一行不够显示十几个比分项
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.mid = matchIdValue
            itemBean.isHeader = true
            itemBean.fakeItem = true
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            
            if index == 0{
                itemBean.txt = "主/客"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.txt = "4:0"
                itemBean.betTeamName = "4:0"
            }else if index == 2{
                itemBean.txt = "4:1"
                itemBean.betTeamName = "4:1"
            }else if index == 3{
                itemBean.txt = "4:2"
                itemBean.betTeamName = "4:2"
            }else if index == 4{
                itemBean.txt = "4:3"
                itemBean.betTeamName = "4:3"
            }
            lists.append(itemBean)
        }
        
        //第四行，主队（"4:0","4:1","4:2","4:3"）的赔率
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.mid = matchIdValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.gameCategoryName = "全场-波胆"
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            
            if index == 0{
                itemBean.txt = "主队"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_H4C0") ? item["ior_H4C0"] as! String : ""
                itemBean.peilvKey = "ior_H4C0"
                itemBean.betTeamName = "4:0"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_H4C1") ? item["ior_H4C1"] as! String : ""
                itemBean.peilvKey = "ior_H4C1"
                itemBean.betTeamName = "4:1"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_H4C2") ? item["ior_H4C2"] as! String : ""
                itemBean.peilvKey = "ior_H4C2"
                itemBean.betTeamName = "4:2"
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_H4C3") ? item["ior_H4C3"] as! String : ""
                itemBean.peilvKey = "ior_H4C3"
                itemBean.betTeamName = "4:3"
            }
            lists.append(itemBean)
        }
        
        //第五行，客队（"0:4","1:4","2:4","3:4"）的赔率
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.mid = matchIdValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.gameCategoryName = "全场-波胆"
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            
            if index == 0{
                itemBean.txt = "客队"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_H0C4") ? item["ior_H0C4"] as! String : ""
                itemBean.peilvKey = "ior_H0C4"
                itemBean.betTeamName = "0:4"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_H1C4") ? item["ior_H1C4"] as! String : ""
                itemBean.peilvKey = "ior_H1C4"
                itemBean.betTeamName = "1:4"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_H2C4") ? item["ior_H2C4"] as! String : ""
                itemBean.peilvKey = "ior_H2C4"
                itemBean.betTeamName = "2:4"
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_H3C4") ? item["ior_H3C4"] as! String : ""
                itemBean.peilvKey = "ior_H3C4"
                itemBean.betTeamName = "3:4"
            }
            lists.append(itemBean)
        }
        
        //第六行，0：0，1：1，2：2，3：3，4：4,其它，这几个比分另起一行当做表格头部
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.mid = matchIdValue
            itemBean.isHeader = true
            itemBean.fakeItem = true
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
//            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            
            if index == 0{
                itemBean.txt = "主/客"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.txt = "0:0"
                itemBean.betTeamName = "0:0"
            }else if index == 2{
                itemBean.txt = "1:1"
                itemBean.betTeamName = "1:1"
            }else if index == 3{
                itemBean.txt = "2:2"
                itemBean.betTeamName = "2:2"
            }else if index == 4{
                itemBean.txt = "3:3"
                itemBean.betTeamName = "3:3"
            }else if index == 5{
                itemBean.txt = "4:4"
                itemBean.betTeamName = "4:4"
            }else if index == 6{
                itemBean.txt = "其它"
                itemBean.betTeamName = "其它"
            }
            lists.append(itemBean)
        }
        
        //第七行，平分赔率
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.mid = matchIdValue
            itemBean.gameCategoryName = "全场-波胆"
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            if index == 0{
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_H0C0") ? item["ior_H0C0"] as! String : ""
                itemBean.peilvKey = "ior_H0C0"
                itemBean.betTeamName = "0:0"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_H1C1") ? item["ior_H1C1"] as! String : ""
                itemBean.peilvKey = "ior_H1C1"
                 itemBean.betTeamName = "1:1"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_H2C2") ? item["ior_H2C2"] as! String : ""
                itemBean.peilvKey = "ior_H2C2"
                 itemBean.betTeamName = "2:2"
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_H3C3") ? item["ior_H3C3"] as! String : ""
                itemBean.peilvKey = "ior_H3C3"
                 itemBean.betTeamName = "3:3"
            }else if index == 5{
                itemBean.peilv = item.keys.contains("ior_H4C4") ? item["ior_H4C4"] as! String : ""
                itemBean.peilvKey = "ior_H4C4"
                 itemBean.betTeamName = "4:4"
            }else if index == 6{
                itemBean.peilv = item.keys.contains("ior_OVH") ? item["ior_OVH"] as! String : ""
                itemBean.peilvKey = "ior_OVH"
                itemBean.betTeamName = "其它"
            }
            lists.append(itemBean)
        }
        return lists
    }
    
    //足球--混合过关
    /**
     *
     * @param item 赛事数据
     * @param columns 列数
     * @param categoryType 赛事类型  滚球，今日赛事，早盘
     * @return
     */
    static func fillFootBallMX(item:Dictionary<String,AnyObject>,columns:Int,gameCategory:String) -> [SportBean] {
        var lists = [SportBean]()
        let gidValue = item.keys.contains(gid) ? item[gid] as! String : ""
        let matchIdValue = item.keys.contains(matchId) ? item[matchId] as! String : ""
        let leagueValue = item.keys.contains(league) ? item[league] as! String : ""
        let homeValue = item.keys.contains(home) ? item[home] as! String : ""
        let guestValue = item.keys.contains(guest) ? item[guest] as! String : ""
        let retimesetValue = item.keys.contains("retimeset") ? item["retimeset"] as! String : ""
        let scoreHValue = item.keys.contains("scoreH") ? item["scoreH"] as! String : ""
        let scoreCValue = item.keys.contains("scoreC") ? item["scoreC"] as! String : ""
        
        //第一行 全场赢
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            itemBean.betTeamName = homeValue
            
            if gameCategory == RB_TYPE{
                if !isEmptyString(str: retimesetValue) && retimesetValue.contains("^"){
                    let split = retimesetValue.components(separatedBy: ",")
                    if !split.isEmpty && split.count == 2{
                        itemBean.halfName = split[0]=="1H" ? "上半场" : "下半场"
                        itemBean.gameRealTime = split[1]
                    }
                }else if !isEmptyString(str: retimesetValue){
                    itemBean.gameRealTime = "半场"
                }
                itemBean.scores = String.init(format: "%@-%@", scoreHValue,scoreCValue)
            }
            if index == 0{
                itemBean.txt = "全场(主)"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_MH") ? item["ior_MH"] as! String : ""
                itemBean.peilvKey = "ior_MH"
                itemBean.gameCategoryName = "全场-独赢"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_RH") ? item["ior_RH"] as! String : ""
                itemBean.peilvKey = "ior_RH"
                itemBean.txt = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.project = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.gameCategoryName = "全场-让球"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_OUH") ? item["ior_OUH"] as! String : ""
                itemBean.peilvKey = "ior_OUH"
                itemBean.txt = item.keys.contains("CON_OUH") ? String.init(format: "大%@",  item["CON_OUH"] as! String) : ""
                itemBean.project = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.gameCategoryName = "全场-大小"
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_EOO") ? item["ior_EOO"] as! String : ""
                itemBean.peilvKey = "ior_EOO"
                itemBean.txt = ""
                itemBean.project = item.keys.contains("CON_RH") ? item["CON_RH"] as! String : ""
                itemBean.gameCategoryName = "全场-单双"
            }
            lists.append(itemBean)
        }
        
        //第二行 全场输
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            itemBean.betTeamName = guestValue
            
            if index == 0{
                itemBean.txt = "全场(客)"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_MC") ? item["ior_MC"] as! String : ""
                itemBean.peilvKey = "ior_MC"
                itemBean.gameCategoryName = "全场-独赢"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_RC") ? item["ior_RC"] as! String : ""
                itemBean.peilvKey = "ior_RC"
                itemBean.txt = item.keys.contains("CON_RC") ? item["CON_RC"] as! String : ""
                itemBean.project = item.keys.contains("CON_RC") ? item["CON_RC"] as! String : ""
                itemBean.gameCategoryName = "全场-让球"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_OUC") ? item["ior_OUC"] as! String : ""
                itemBean.peilvKey = "ior_OUC"
                itemBean.txt = item.keys.contains("CON_OUC") ? String.init(format: "小%@", item["CON_OUC"] as! String) : ""
                itemBean.project = item.keys.contains("CON_OUC") ? item["CON_OUC"] as! String : ""
                itemBean.gameCategoryName = "全场-大小"
            }else if index == 4{
                itemBean.peilv = item.keys.contains("ior_EOE") ? item["ior_EOE"] as! String : ""
                itemBean.peilvKey = "ior_EOE"
                itemBean.txt = ""
                itemBean.gameCategoryName = "全场-单双"
            }
            lists.append(itemBean)
        }
        
        //第三行 全场和局
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            itemBean.betTeamName = "和局"
            
            if index == 0{
                itemBean.txt = "全场(和)"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_MN") ? item["ior_MN"] as! String : ""
                itemBean.peilvKey = "ior_MN"
                itemBean.gameCategoryName = "全场-独赢"
            }
            lists.append(itemBean)
        }
        
        //第四行 半场赢
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            itemBean.home = homeValue
            itemBean.client = guestValue
            itemBean.betTeamName = homeValue
            
            if index == 0{
                itemBean.txt = "半场(主)"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_HMH") ? item["ior_HMH"] as! String : ""
                itemBean.peilvKey = "ior_HMH"
                itemBean.gameCategoryName = "半场-独赢"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_HRH") ? item["ior_HRH"] as! String : ""
                itemBean.peilvKey = "ior_HRH"
                itemBean.txt = item.keys.contains("CON_HRH") ? item["CON_HRH"] as! String : ""
                itemBean.project = item.keys.contains("CON_HRH") ? item["CON_HRH"] as! String : ""
                itemBean.gameCategoryName = "半场-让球"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_HOUH") ? item["ior_HOUH"] as! String : ""
                itemBean.peilvKey = "ior_HOUH"
                itemBean.txt = item.keys.contains("CON_HOUH") ? String.init(format: "大%@", item["CON_HOUH"] as! String) : ""
                itemBean.project = item.keys.contains("CON_HOUH") ? item["CON_HOUH"] as! String : ""
                itemBean.gameCategoryName = "半场-大小"
            }
            lists.append(itemBean)
        }
        
        //第五行 半场输
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            
            itemBean.home = homeValue
            itemBean.client = guestValue
            itemBean.betTeamName = guestValue
            
            if index == 0{
                itemBean.txt = "半场(客)"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_HMC") ? item["ior_HMC"] as! String : ""
                itemBean.peilvKey = "ior_HMC"
                itemBean.gameCategoryName = "半场-独赢"
            }else if index == 2{
                itemBean.peilv = item.keys.contains("ior_HRC") ? item["ior_HRC"] as! String : ""
                itemBean.peilvKey = "ior_HRC"
                itemBean.txt = item.keys.contains("CON_HRC") ? item["CON_HRC"] as! String : ""
                itemBean.project = item.keys.contains("CON_HRC") ? item["CON_HRC"] as! String : ""
                itemBean.gameCategoryName = "半场-让球"
            }else if index == 3{
                itemBean.peilv = item.keys.contains("ior_HOUC") ? item["ior_HOUC"] as! String : ""
                itemBean.peilvKey = "ior_HOUC"
                itemBean.txt = item.keys.contains("CON_HOUC") ? String.init(format: "小%@", item["CON_HOUC"] as! String) : ""
                itemBean.project = item.keys.contains("CON_HOUC") ? item["CON_HOUC"] as! String : ""
                itemBean.gameCategoryName = "半场-大小"
            }
            lists.append(itemBean)
        }
        
        //第六行 半场和局
        for index in 0...columns-1{
            let itemBean = SportBean()
            itemBean.gid = gidValue
            itemBean.lianSaiName = leagueValue
            itemBean.teamNames = String.init(format: "%@      VS      %@", homeValue,guestValue)
            itemBean.mid = matchIdValue
            itemBean.scoreH = scoreHValue
            itemBean.scoreC = scoreCValue
            
            itemBean.home = homeValue
            itemBean.client = guestValue
            itemBean.betTeamName = "和局"
            
            if index == 0{
                itemBean.txt = "半场(和)"
                itemBean.fakeItem = true
            }else if index == 1{
                itemBean.peilv = item.keys.contains("ior_HMN") ? item["ior_HMN"] as! String : ""
                itemBean.peilvKey = "ior_HMN"
                itemBean.gameCategoryName = "半场-独赢"
            }
            lists.append(itemBean)
        }
        
        return lists
    }
    
    
}
