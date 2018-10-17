//
//  Lotterys.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/7.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class Lotterys {

    public static func getLotterysByVersion(versionNum:String) ->LotteryConstants{
        if (versionNum == "1") {
            return getLotterysInVersion1();
        } else if (versionNum == "2" || versionNum == "5") {
            return getLotterysInVersion2();
        } else if (versionNum == "2-1") {
            return getLotterysInVersion2();
        } else if (versionNum == "3") {
            return getLotterysInVersion3();
        } else if (versionNum == "4") {
            return getLotterysInVersion4();
        }
        let lcs = LotteryConstants();
        lcs.version = versionNum;
        return lcs
    }
    
    
    
    //第一版：奖金模式
    private static func getLotterysInVersion1() -> LotteryConstants{
        
        var lotteryData = [LotteryData]()
        //时时彩
        let sscPlays = getFFCPlays()
        let datas = [["name":"五分彩","ballNum":5,"czCode":"1"],["name":"分分彩","ballNum":5,"czCode":"1"],["name":"二分彩","ballNum":5,"czCode":"1"],["name":"重庆时时彩","ballNum":5,"czCode":"2"],["name":"新疆时时彩","ballNum":5,"czCode":"2"],["name":"天津时时彩","ballNum":5,"czCode":"2"]]
        for item in datas{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = sscPlays
            lotteryData.append(data)
        }
        
        //赛车
        let saiChePlays = getSaiChePlays()
        let datas2 = [["name":"极速赛车","ballNum":10,"czCode":"3"],["name":"北京赛车","ballNum":10,"czCode":"3"],["name":"幸运飞艇","ballNum":10,"czCode":"3"]]
        for item in datas2{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = saiChePlays
            lotteryData.append(data)
        }
        
        //福彩3D
        let fc3DPlays = getFC3DPlays()
        let datas3 = [["name":"福彩3D","ballNum":3,"czCode":"4"],["name":"排列三","ballNum":3,"czCode":"4"]]
        for item in datas3{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = fc3DPlays
            lotteryData.append(data)
        }
        
        //11选5
        let x5Plays = get11x5Plays()
        let datas4 = [["name":"江西11选5","ballNum":5,"czCode":"5"],["name":"广东11选5","ballNum":5,"czCode":"5"],["name":"上海11选5","ballNum":5,"czCode":"5"],["name":"山东11选5","ballNum":5,"czCode":"5"]]
        for item in datas4{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = x5Plays
            lotteryData.append(data)
        }
        
        //六合彩
//        let x5Plays = get11x5Plays()
        let datas5 = [["name":"六合彩","ballNum":7,"czCode":"6"]]
        for item in datas5{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = []
            lotteryData.append(data)
        }
        
        //加拿大28,PC蛋蛋
        let pcEggPlays = getPCEggPlays()
        let datas6 = [["name":"加拿大28","ballNum":3,"czCode":"7"],["name":"PC蛋蛋","ballNum":3,"czCode":"7"]]
        for item in datas6{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = pcEggPlays
            lotteryData.append(data)
        }
        
        //十分六合彩
        let datas7 = [["name":"十分六合彩","ballNum":7,"czCode":"66"]]
        for item in datas7{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = []
            lotteryData.append(data)
        }
        
        //快三
        let kuai3Plays = getKuai3Plays();
        let datas8 = [["name":"安徽快三","ballNum":3,"czCode":"100"],["name":"湖北快三","ballNum":3,"czCode":"100"],["name":"江苏快三","ballNum":3,"czCode":"100"],["name":"广西快三","ballNum":3,"czCode":"100"],["name":"江西快三","ballNum":3,"czCode":"100"],["name":"河北快三","ballNum":3,"czCode":"100"],["name":"北京快三","ballNum":3,"czCode":"100"],["name":"幸运快三","ballNum":3,"czCode":"100"],["name":"极速快三","ballNum":3,"czCode":"100"],["name":"甘肃快三","ballNum":3,"czCode":"100"],["name":"上海快三","ballNum":3,"czCode":"100"]]
        for item in datas8{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = kuai3Plays
            lotteryData.append(data)
        }
        
        
        let lcs = LotteryConstants();
        lcs.version = "1";
        lcs.lotterys = lotteryData;
        
        return lcs
    }
    
    //第二版：赔率模式
    private static func getLotterysInVersion2() -> LotteryConstants{
        
        var lotteryData = [LotteryData]()
        
        //赛车
        let saiChePlays = getPeilvSaiChePlays()
        let datas = [["name":"极速赛车","ballNum":10,"czCode":"8"],["name":"北京赛车","ballNum":10,"czCode":"8"],["name":"幸运飞艇","ballNum":10,"czCode":"8"]]
        for item in datas{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = saiChePlays
            lotteryData.append(data)
        }
        
        //时时彩
        let sscPlays = getPeilvFFCPlays()
        let datas1 = [["name":"五分彩","ballNum":5,"czCode":"9"],["name":"天津时时彩","ballNum":5,"czCode":"9"],["name":"新疆时时彩","ballNum":5,"czCode":"9"],["name":"重庆时时彩","ballNum":5,"czCode":"9"],["name":"分分彩","ballNum":5,"czCode":"9"],["name":"二分彩","ballNum":5,"czCode":"9"]]
        for item in datas1{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = sscPlays
            lotteryData.append(data)
        }
        
        //快三
        let peilvKuai3Plays = getPeilvKuai3Plays();
        let datas2 = [["name":"河北快三","ballNum":3,"czCode":"10"],["name":"甘肃快三","ballNum":3,"czCode":"10"],["name":"极速快三","ballNum":3,"czCode":"10"],["name":"幸运快三","ballNum":3,"czCode":"10"],["name":"上海快三","ballNum":3,"czCode":"10"],["name":"江西快三","ballNum":3,"czCode":"10"],["name":"江苏骰宝(快3)","ballNum":3,"czCode":"10"],["name":"北京快三","ballNum":3,"czCode":"10"],["name":"广西快三","ballNum":3,"czCode":"10"],["name":"安徽快三","ballNum":3,"czCode":"10"],["name":"湖北快三","ballNum":3,"czCode":"10"]]
        for item in datas2{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = peilvKuai3Plays
            lotteryData.append(data)
        }
        
        //加拿大28,PC蛋蛋
        let peilvPC28Plays = getPeilvPC28Plays();
        let datas3 = [["name":"加拿大28","ballNum":3,"czCode":"11"],["name":"PC蛋蛋","ballNum":3,"czCode":"11"]]
        for item in datas3{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = peilvPC28Plays
            lotteryData.append(data)
        }
        
        //快乐十分
        let peilvKuaile10FenPlays = getPeilvKuaile10FenPlays();
        let datas4 = [["name":"重庆幸运农场","ballNum":8,"czCode":"12"],["name":"湖南快乐十分","ballNum":8,"czCode":"12"],["name":"广东快乐十分","ballNum":8,"czCode":"12"]]
        for item in datas4{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = peilvKuaile10FenPlays
            lotteryData.append(data)
        }
        
        //11选5
        let peilv11x5Plays = getPeilv11x5Plays();
        let datas5 = [["name":"江西11选5","ballNum":5,"czCode":"14"],["name":"广东11选5","ballNum":5,"czCode":"14"],["name":"上海11选5","ballNum":5,"czCode":"14"],["name":"山东11选5","ballNum":5,"czCode":"14"]]
        for item in datas5{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = peilv11x5Plays
            lotteryData.append(data)
        }
        
        //福彩3D,排列三
        let fc3DPlays = getPeilvfucai3dPlays()
        let datas6 = [["name":"福彩3D","ballNum":3,"czCode":"15"],["name":"排列三","ballNum":3,"czCode":"15"]]
        for item in datas6{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = fc3DPlays
            lotteryData.append(data)
        }
        
        //十分六合彩
        let peilvLiuHeCaiPlays = getPeilvLiuHeCaiPlays();
        let datas7 = [["name":"十分六合彩","ballNum":7,"czCode":"66"]]
        for item in datas7{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = peilvLiuHeCaiPlays
            lotteryData.append(data)
        }
        
        //六合彩
        let datas8 = [["name":"六合彩","ballNum":7,"czCode":"6"]]
        for item in datas8{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = peilvLiuHeCaiPlays
            lotteryData.append(data)
        }
        
        let lcs = LotteryConstants();
        lcs.version = "2";
        lcs.lotterys = lotteryData;
        
        return lcs
    }
    
    //第四版：赔率模式 赔率模式，对话聊天
    private static func getLotterysInVersion4() -> LotteryConstants{
        
        var lotteryData = [LotteryData]()
        //加拿大28,PC蛋蛋
        let peilvPC28Plays = getPeilvPC28Plays();
        let datas3 = [["name":"加拿大28","ballNum":3,"czCode":"161"],["name":"PC蛋蛋","ballNum":3,"czCode":"161"]]
        for item in datas3{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = peilvPC28Plays
            lotteryData.append(data)
        }
        
        let lcs = LotteryConstants();
        lcs.version = "4";
        lcs.lotterys = lotteryData;
        
        return lcs
    }
    
    //第三版：奖金模式
    private static func getLotterysInVersion3() -> LotteryConstants{
        
        var lotteryData = [LotteryData]()
        //时时彩
        let sscPlays = getFFCPlays()
        let datas = [["name":"五分彩","ballNum":5,"czCode":"51"],["name":"分分彩","ballNum":5,"czCode":"51"],["name":"二分彩","ballNum":5,"czCode":"51"],["name":"重庆时时彩","ballNum":5,"czCode":"52"],["name":"新疆时时彩","ballNum":5,"czCode":"52"],["name":"天津时时彩","ballNum":5,"czCode":"52"]]
        for item in datas{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = sscPlays
            lotteryData.append(data)
        }
        
        //赛车
        let saiChePlays = getSaiChePlays()
        let datas2 = [["name":"极速赛车","ballNum":10,"czCode":"53"],["name":"北京赛车","ballNum":10,"czCode":"53"],["name":"幸运飞艇","ballNum":10,"czCode":"53"]]
        for item in datas2{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = saiChePlays
            lotteryData.append(data)
        }
        
        //福彩3D
        let fc3DPlays = getFC3DPlays()
        let datas3 = [["name":"福彩3D","ballNum":3,"czCode":"54"],["name":"排列三","ballNum":3,"czCode":"54"]]
        for item in datas3{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = fc3DPlays
            lotteryData.append(data)
        }
        
        //11选5
        let x5Plays = get11x5Plays()
        let datas4 = [["name":"江西11选5","ballNum":5,"czCode":"55"],["name":"广东11选5","ballNum":5,"czCode":"55"],["name":"上海11选5","ballNum":5,"czCode":"55"],["name":"山东11选5","ballNum":5,"czCode":"55"]]
        for item in datas4{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = x5Plays
            lotteryData.append(data)
        }
        
        //六合彩
        //        let x5Plays = get11x5Plays()
        let datas5 = [["name":"六合彩","ballNum":7,"czCode":"6"]]
        for item in datas5{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = []
            lotteryData.append(data)
        }
        
        //加拿大28,PC蛋蛋
        let pcEggPlays = getPCEggPlays()
        let datas6 = [["name":"加拿大28","ballNum":3,"czCode":"57"],["name":"PC蛋蛋","ballNum":3,"czCode":"57"]]
        for item in datas6{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = pcEggPlays
            lotteryData.append(data)
        }
        
        //十分六合彩
        let datas7 = [["name":"十分六合彩","ballNum":7,"czCode":"66"]]
        for item in datas7{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = []
            lotteryData.append(data)
        }
        
        //快三
        let kuai3Plays = getKuai3Plays();
        let datas8 = [["name":"安徽快三","ballNum":3,"czCode":"58"],["name":"湖北快三","ballNum":3,"czCode":"58"],["name":"江苏快三","ballNum":3,"czCode":"58"],["name":"广西快三","ballNum":3,"czCode":"58"],["name":"江西快三","ballNum":3,"czCode":"58"],["name":"河北快三","ballNum":3,"czCode":"58"],["name":"北京快三","ballNum":3,"czCode":"58"],["name":"幸运快三","ballNum":3,"czCode":"58"],["name":"极速快三","ballNum":3,"czCode":"58"],["name":"甘肃快三","ballNum":3,"czCode":"58"],["name":"上海快三","ballNum":3,"czCode":"58"]]
        for item in datas8{
            let data = LotteryData()
            data.name = item["name"] as? String
            data.ballonNums = item["ballNum"] as? Int
            data.czCode = item["czCode"] as? String
            data.rules = kuai3Plays
            lotteryData.append(data)
        }
        
        
        let lcs = LotteryConstants();
        lcs.version = "3";
        lcs.lotterys = lotteryData;
        
        return lcs
    }
    
    //福彩3D，排列3
    static func getFC3DPlays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"直选","code":zhi_xuan_str,"rules":[["name":"复式","code":zhx_fs,"randomCount":3]]],
                    ["name":"组选","code":zhuxuan_str,"rules":[["name":"组六","code":zux_z6,"randomCount":3],["name":"组三","code":zux_z3,"randomCount":2]]],
                    ["name":"不定位","code":bdw,"rules":[["name":"二码不定位","code":bdw_2m,"randomCount":2],["name":"一码不定位","code":bdw_1m,"randomCount":1]]],
                    ["name":"二码","code":er_ma_str,"rules":[["name":"前二直选","code":q2zx_fs,"randomCount":2],["name":"前二组选","code":em_q2zux,"randomCount":2],["name":"后二直选","code":h2zx_fs,"randomCount":2],["name":"后二组选","code":em_h2zux,"randomCount":2]]],
                    ["name":"大小单双","code":dxds,"rules":[["name":"前二","code":dxds_q2,"randomCount":2],["name":"后二","code":dxds_h2,"randomCount":2]]],
                    ["name":"定位胆","code":dwd,"rules":[["name":"定位胆","code":dwd,"randomCount":1]]]
        ]
        
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //11选5
    static func get11x5Plays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"任选复式","code":rxfs,"rules":[["name":"任八中五","code":rxfs_rx8z5,"randomCount":8],["name":"任七中五","code":rxfs_rx7z5,"randomCount":7],["name":"任六中五","code":rxfs_rx6z5,"randomCount":6],["name":"任四中四","code":rxfs_rx4z4,"randomCount":4],["name":"任三中三","code":rxfs_rx3z3,"randomCount":3],["name":"任二中二","code":rxfs_rx2z2,"randomCount":2],["name":"任一中一","code":rxfs_rx1z1,"randomCount":1]]],
                    ["name":"定位胆","code":dwd,"rules":[["name":"定位胆","code":dwd,"randomCount":1]]],
                    ["name":"不定位","code":bdw_11x5,"rules":[["name":"前三","code":bdw_q3,"randomCount":1],["name":"中三","code":bdw_z3,"randomCount":1],["name":"后三","code":bdw_h3,"randomCount":1]]],
                    ["name":"二码","code":er_ma_str,"rules":[["name":"前二复式","code":q2zx_fs,"randomCount":2],["name":"前二组选","code":q2zx,"randomCount":2],["name":"后二复式","code":h2zx_fs,"randomCount":2],["name":"后二组选","code":h2zx,"randomCount":2]]],
                    ["name":"三码","code":shang_ma_str,"rules":[["name":"前三复式","code":q3zx_fs,"randomCount":3],["name":"前三组选","code":q3zx,"randomCount":3],["name":"中三复式","code":z3zx_fs,"randomCount":3],["name":"中三组选","code":z3zx,"randomCount":3],["name":"后三复式","code":h3zx_fs,"randomCount":3],["name":"后三组选","code":h3zx,"randomCount":3]]]
        ]
        
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //PC蛋蛋，加拿大28
    static func getPCEggPlays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"定位胆","code":dwd,"rules":[["name":"定位胆","code":dwd,"randomCount":1]]],
                    ["name":"不定胆","code":bdw,"rules":[["name":"不定位胆","code":bdw_pcegg,"randomCount":1]]],
                    ["name":"三星玩法","code":sxwf_pcegg,"rules":[["name":"三星组选","code":sxzx,"randomCount":3],["name":"三星复式","code":sxfs,"randomCount":3]]],
                    ["name":"二星玩法","code":exwf_str,"rules":[["name":"前二复式","code":q2zx_fs,"randomCount":2],["name":"前二组选","code":q2zx,"randomCount":2],["name":"后二复式","code":h2zx_fs,"randomCount":2],["name":"后二组选","code":h2zx,"randomCount":2]]],
                    ["name":"和值","code":hz,"rules":[["name":"大小单双","code":dxds,"randomCount":1],["name":"和值","code":hz,"randomCount":1]]]
        ]
        
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //快三
    static func getKuai3Plays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [
            ["name":"和值","code":hz,"rules":[["name":"和值","code":hz,"randomCount":1],["name":"大小单双","code":dxds,"randomCount":1]]],
                    ["name":"三同号通选","code":sthtx,"rules":[["name":"三同号通选","code":sthtx,"randomCount":1]]],
                    ["name":"三同号单选","code":sthdx,"rules":[["name":"不三同号单选","code":sthdx,"randomCount":1]]],
                    ["name":"三不同号","code":sbtx,"rules":[["name":"三不同号","code":sbtx,"randomCount":3]]],
                    ["name":"三连号通选","code":slhtx,"rules":[["name":"三连号通选","code":slhtx,"randomCount":1]]],
                    ["name":"二同号复选","code":ethfx,"rules":[["name":"二同号复选","code":ethfx,"randomCount":1]]],
                    ["name":"二不同号","code":ebth,"rules":[["name":"二不同号","code":ebth,"randomCount":2]]]
        ]
        
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //赛车玩法
    static func getSaiChePlays() -> [PlayItem]{
        
        var plays = [PlayItem]()
        //定位胆
        let arr1 = [["name":"定位胆","code":dwd_saiche,"rules":[["name":"定位胆","code":dwd_saiche,"randomCount":1]]],
                    ["name":"龙虎","code":lh,"rules":[["name":"冠军","code":longhu_gunjun,"randomCount":1],["name":"亚军","code":longhu_yajun,"randomCount":1],["name":"季军","code":longhu_jijun,"randomCount":1]]],
                    ["name":"前一","code":q1_str,"rules":[["name":"前一复式","code":q1zx_fs,"randomCount":1]]],
                    ["name":"前二","code":q2_str,"rules":[["name":"前二复式","code":q2zx_fs,"randomCount":2]]],
                    ["name":"冠亚和","code":gyh_str,"rules":[["name":"大小单双","code":dxds,"randomCount":1],["name":"冠亚和值","code":gyhz,"randomCount":1]]],
                    ["name":"前三","code":qiansan,"rules":[["name":"前三复式","code":q3zx_fs,"randomCount":3]]]
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //赔率版-赛车玩法
    static func getPeilvSaiChePlays() -> [PlayItem]{
        
        var plays = [PlayItem]()
        let arr1 = [["name":"冠.亚军","code":guan_yajun,"rules":[["name":"冠.亚军","code":guan_yajun,"randomCount":1]]],
                    ["name":"单号1-10","code":danhao1_10,"rules":[["name":"单号1-10","code":danhao1_10,"randomCount":1]]],
                    ["name":"双面盘","code":shuangmianpan,"rules":[["name":"双面盘","code":shuangmianpan,"randomCount":1]]]
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //赔率版-快三
    static func getPeilvKuai3Plays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"骰宝","code":daxiaoshaibao,"rules":[["name":"大小骰宝","code":daxiaoshaibao,"randomCount":1]]]
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //赔率版-pc eggegg,加拿大28
    static func getPeilvPC28Plays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"幸运28","code":xingyun28,"rules":[["name":"幸运28","code":xingyun28,"randomCount":1]]]
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //赔率版--福彩3D,排列3
    static func getPeilvfucai3dPlays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"1~3球","code":pl3_13qiu,"rules":[["name":"1~3球","code":pl3_13qiu,"randomCount":1]]],
                    ["name":"整合","code":pl3_zhenghe,"rules":[["name":"整合","code":pl3_zhenghe,"randomCount":1]]]
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    ////赔率版--十分六合彩，六合彩
    static func getPeilvLiuHeCaiPlays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"特码","code":tema,"rules":[["name":"特码A","code":tm_a,"randomCount":1],["name":"特码B","code":tm_b,"randomCount":1]]],
                    ["name":"正码","code":zhenma,"rules":[["name":"正码A","code":zm_a,"randomCount":1],["name":"正码B","code":zm_b,"randomCount":1]]],
                    ["name":"正特码","code":zhentema,"rules":[["name":"正一特码","code":z1t,"randomCount":1],["name":"正二特码","code":z2t,"randomCount":1],["name":"正三特码","code":z3t,"randomCount":1],["name":"正四特码","code":z4t,"randomCount":1],["name":"正五特码","code":z5t,"randomCount":1],["name":"正六特码","code":z6t,"randomCount":1]]],
                    ["name":"连码","code":lianma,"rules":[["name":"三中二","code":szezze,"randomCount":1],["name":"二全中","code":eqz,"randomCount":1],["name":"二中特之中特","code":eztzzt,"randomCount":1],["name":"二中特之中二","code":eztzze,"randomCount":1],["name":"特串","code":tc,"randomCount":1],["name":"四中一","code":szy,"randomCount":1]]],
                    ["name":"特码半波","code":bb,"rules":[["name":"半波","code":bb,"randomCount":1]]],
                    ["name":"一肖/尾数","code":yixiao_weishu,"rules":[["name":"正特肖/正特尾","code":ztxztw,"randomCount":1]]],
                    ["name":"特码生肖","code":txsm,"rules":[["name":"特码生肖","code":txsm,"randomCount":1]]],
                    ["name":"合肖","code":hexiao,"rules":[["name":"二肖","code":hx_ex,"randomCount":1],["name":"三肖","code":hx_sanx,"randomCount":1],["name":"四肖","code":hx_six,"randomCount":1],["name":"五肖","code":hx_wux,"randomCount":1],["name":"六肖","code":hx_liux,"randomCount":1],["name":"七肖","code":hx_qix,"randomCount":1],["name":"八肖","code":hx_bax,"randomCount":1],["name":"九肖","code":hx_jiux,"randomCount":1],["name":"十肖","code":hx_shix,"randomCount":1],["name":"十一肖","code":hx_syx,"randomCount":1]]],
                    ["name":"全不中","code":quanbuzhong,"rules":[["name":"五不中","code":w_bz,"randomCount":1],["name":"六不中","code":liu_bz,"randomCount":1],["name":"七不中","code":qi_bz,"randomCount":1],["name":"八不中","code":ba_bz,"randomCount":1],["name":"九不中","code":jiu_bz,"randomCount":1],["name":"十不中","code":shi_bz,"randomCount":1],["name":"十一不中","code":shiy_bz,"randomCount":1],["name":"十二不中","code":shie_bz,"randomCount":1]]],
                    ["name":"尾数连","code":weishulian,"rules":[["name":"二尾连中","code":erw_lz,"randomCount":1],["name":"三尾连中","code":sanw_lz,"randomCount":1],["name":"四尾连中","code":siw_lz,"randomCount":1],["name":"二尾连不中","code":erw_lbz,"randomCount":1],["name":"三尾连不中","code":sanw_lbz,"randomCount":1],["name":"四尾连不中","code":siw_lbz,"randomCount":1]]],
                    ["name":"连肖","code":lianxiao,"rules":[["name":"二肖连中","code":erx_lz,"randomCount":1],["name":"三肖连中","code":sanx_lz,"randomCount":1],["name":"四肖连中","code":six_lz,"randomCount":1],["name":"五肖连中","code":wux_lz,"randomCount":1],["name":"二肖连不中","code":erx_lbz,"randomCount":1],["name":"三肖连不中","code":sanx_lbz,"randomCount":1],["name":"四肖连不中","code":six_lbz,"randomCount":1]]]
                    
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //赔率版--11x5
    static func getPeilv11x5Plays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"双面盘","code":syx5_shuangmianpan,"rules":[["name":"双面盘","code":syx5_shuangmianpan,"randomCount":1]]],
                    ["name":"1~5球","code":syx5_15qiu,"rules":[["name":"1~5球","code":syx5_15qiu,"randomCount":1]]]
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //赔率版-快乐十分，重庆幸运农场
    static func getPeilvKuaile10FenPlays() -> [PlayItem]{
        var plays = [PlayItem]()
        let arr1 = [["name":"单球1-8","code":danqiu1_8,"rules":[["name":"单球1-8","code":danqiu1_8,"randomCount":1]]],
                    ["name":"第一球","code":diyiqiu,"rules":[["name":"第一球","code":diyiqiu,"randomCount":1]]],
                    ["name":"第二球","code":dierqiu,"rules":[["name":"第二球","code":dierqiu,"randomCount":1]]],
                    ["name":"第三球","code":disanqiu,"rules":[["name":"第三球","code":disanqiu,"randomCount":1]]],
                    ["name":"第四球","code":disiqiu,"rules":[["name":"第四球","code":disiqiu,"randomCount":1]]],
                    ["name":"第五球","code":diwuqiu,"rules":[["name":"第五球","code":diwuqiu,"randomCount":1]]],
                    ["name":"第六球","code":diliuqiu,"rules":[["name":"第六球","code":diliuqiu,"randomCount":1]]],
                    ["name":"第七球","code":diqiqiu,"rules":[["name":"第七球","code":diqiqiu,"randomCount":1]]],
                    ["name":"第八球","code":dibaqiu,"rules":[["name":"第八球","code":dibaqiu,"randomCount":1]]],
                    ["name":"连码","code":lianma,"rules":[["name":"选二任选","code":xuanerrenxuan,"randomCount":1],["name":"选二连组","code":xuanerlianzu,"randomCount":1],["name":"选二连直","code":xuanerlianzhi,"randomCount":1],["name":"选三任选","code":xuansanrenxuan,"randomCount":1],["name":"选三前组","code":xuansanqianzu,"randomCount":1],["name":"选三前直","code":xuansanqianzhi,"randomCount":1],["name":"选四任选","code":xuansirenxuan,"randomCount":1],["name":"选五任选","code":xuanwurenxuan,"randomCount":1]]]
        ]
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    
    //分分彩玩法-赔率版
    static func getPeilvFFCPlays() -> [PlayItem] {
        var plays = [PlayItem]()
        let arr1 = [["name":"整合","code":zhenghe,"rules":[["name":"整合","code":zhenghe,"randomCount":1]]],
                    ["name":"万位","code":wanwei,"rules":[["name":"万位","code":wanwei,"randomCount":1]]],
                    ["name":"千位","code":qianwei,"rules":[["name":"千位","code":qianwei,"randomCount":1]]],
                    ["name":"百位","code":baiwei,"rules":[["name":"百位","code":baiwei,"randomCount":1]]],
                    ["name":"十位","code":shiwei,"rules":[["name":"十位","code":shiwei,"randomCount":1]]],
                    ["name":"个位","code":gewei,"rules":[["name":"个位","code":gewei,"randomCount":1]]],
                    ["name":"和尾数","code":heweishu,"rules":[["name":"和尾数","code":heweishu,"randomCount":1]]],
                    ["name":"龙虎斗","code":longhudou,"rules":[["name":"龙虎斗","code":longhudou,"randomCount":1]]],
                    ["name":"棋牌","code":qipai,"rules":[["name":"百家乐","code":baijiale,"randomCount":1],["name":"牛牛","code":niuniu,"randomCount":1],["name":"德州扑克","code":dezhoupuke,"randomCount":1],["name":"三公","code":sangong,"randomCount":1]]],
                    ["name":"和数","code":heshu,"rules":[["name":"前三","code":qiansan,"randomCount":1],["name":"中三","code":zhongsan,"randomCount":1],["name":"后三","code":housan,"randomCount":1]]],
                    ["name":"一字","code":yizi,"rules":[["name":"全五","code":yizi_quanwu,"randomCount":1],["name":"前三","code":yizi_qiansan,"randomCount":1],["name":"中三","code":yizi_zhongsan,"randomCount":1],["name":"后三","code":yizi_housan,"randomCount":1]]],
                    ["name":"二字","code":erzi,"rules":[["name":"前三","code":erzi_qiansan,"randomCount":1],["name":"中三","code":erzi_zhongsan,"randomCount":1],["name":"后三","code":erzi_housan,"randomCount":1]]],
                    ["name":"三字","code":sanzi,"rules":[["name":"前三","code":sanzi_qiansan,"randomCount":1],["name":"中三","code":sanzi_zhongsan,"randomCount":1],["name":"后三","code":sanzi_housan,"randomCount":1]]],
                    ["name":"二字定位","code":erzidingwei,"rules":[["name":"万仟","code":wanqian,"randomCount":1],["name":"万佰","code":wanbai,"randomCount":1],["name":"万拾","code":wanshi,"randomCount":1],["name":"万个","code":wange,"randomCount":1],["name":"千佰","code":qianbai,"randomCount":1],["name":"仟拾","code":qianshi,"randomCount":1],["name":"仟个","code":qiange,"randomCount":1],["name":"佰拾","code":baishi,"randomCount":1],["name":"佰个","code":baige,"randomCount":1],["name":"拾个","code":shige,"randomCount":1]]],
                    ["name":"三字定位","code":sanzidingwei,"rules":[["name":"前三","code":sanzidingwei_qiansan,"randomCount":1],["name":"中三","code":sanzidingwei_zhongsan,"randomCount":1],["name":"后三","code":sanzidingwei_housan,"randomCount":1]]],
                    ["name":"组选三","code":zuxuan_san,"rules":[["name":"前三","code":zuxuansan_qiansan,"randomCount":1],["name":"中三","code":zuxuansan_zhongsan,"randomCount":1],["name":"后三","code":zuxuansan_housan,"randomCount":1]]],
                    ["name":"组选六","code":zuxuan_liu,"rules":[["name":"前三","code":zuxuanliu_qiansan,"randomCount":1],["name":"中三","code":zuxuanliu_zhongsan,"randomCount":1],["name":"后三","code":zuxuanliu_housan,"randomCount":1]]],
                    ["name":"跨度","code":kuadu,"rules":[["name":"前三","code":kuadu_qiansan,"randomCount":1],["name":"中三","code":kuadu_zhongsan,"randomCount":1],["name":"后三","code":kuadu_housan,"randomCount":1]]]
        ]
        
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
    //分分彩玩法
    static func getFFCPlays() -> [PlayItem] {
        var plays = [PlayItem]()
        let arr1 = [["name":"大小单双","code":dxds,"rules":[["name":"总和","code":dxds_zh,"randomCount":1],["name":"前三","code":dxds_q3,"randomCount":3],["name":"后三","code":dxds_h3,"randomCount":3],["name":"后二","code":dxds_h2,"randomCount":2],["name":"前二","code":dxds_q2,"randomCount":2]]],
                    ["name":"定位胆","code":dwd,"rules":[["name":"定位胆","code":dwd,"randomCount":1]]],
                    ["name":"不定位胆","code":bdwd,"rules":[["name":"前三一码","code":bdw_q31m,"randomCount":1],["name":"中三一码","code":bdw_z31m,"randomCount":1],["name":"后三一码","code":bdw_h31m,"randomCount":1]]],
                    ["name":"龙虎和","code":longhh,"rules":[["name":"龙虎","code":longhudou,"randomCount":1],["name":"和","code":longhuhe,"randomCount":1]]],
                    ["name":"任选玩法","code":rxwf,"rules":[["name":"任三组三","code":rxwf_r3zux_zu3,"randomCount":2],["name":"任三组六","code":rxwf_r3zux_zu6,"randomCount":3],["name":"任三复式","code":rxwf_r3zx_fs,"randomCount":3],["name":"任四复式","code":rxwf_r4zx_fs,"randomCount":4],["name":"任二复式","code":rxwf_r2zx_fs,"randomCount":2]]],
                    ["name":"二星直选","code":exzx,"rules":[["name":"前二和值","code":q2zx_hz,"randomCount":1],["name":"前二复式","code":q2zx_fs,"randomCount":2],["name":"后二和值","code":h2zx_hz,"randomCount":1],["name":"后二复式","code":h2zx_fs,"randomCount":2]]],
                    ["name":"三星直选","code":sxzx,"rules":[["name":"前三组三","code":q3zux_zu3,"randomCount":2],["name":"前三组六","code":q3zux_zu6,"randomCount":3],["name":"中三组三","code":z3zux_zu3,"randomCount":2],["name":"中三组六","code":z3zux_zu6,"randomCount":3],["name":"后三组三","code":h3zux_zu3,"randomCount":2],["name":"后三组六","code":h3zux_zu6,"randomCount":3]]],
                    ["name":"三星玩法","code":sxwf_var,"rules":[["name":"前三复式","code":q3zx_fs,"randomCount":3],["name":"中三复式","code":z3zx_fs,"randomCount":3],["name":"后三复式","code":h3zx_fs,"randomCount":3]]],
                    ["name":"四星玩法","code":sixing_wf,"rules":[["name":"前四复式","code":q4zx_fs,"randomCount":4],["name":"后四复式","code":h4zx_fs,"randomCount":4]]],
                    ["name":"五星玩法","code":wuxing_wf,"rules":[["name":"五星复式","code":wxzx_fs,"randomCount":5]]],
                    ["name":"猜豹子","code":caibaozi,"rules":[["name":"豹子","code":baozi,"randomCount":1],["name":"顺子","code":shunzi,"randomCount":1],["name":"对子","code":duizi,"randomCount":1],["name":"半顺","code":banshun,"randomCount":1],["name":"杂六","code":zaliu,"randomCount":1]]]
        ]
        
        for item in arr1{
            let playItem = PlayItem()
            var subRule = [SubPlayItem]();
            for rule in (item["rules"] as? [NSDictionary])!{
                let dwd_sub = SubPlayItem();
                dwd_sub.name = (rule["name"] as? String)!
                dwd_sub.code = (rule["code"] as? String)!
                dwd_sub.randomCount = rule["randomCount"] as? Int
                subRule.append(dwd_sub);
            }
            playItem.name = item["name"] as! String
            playItem.code = item["code"] as! String
            playItem.rules = subRule
            plays.append(playItem)
        }
        return plays
    }
    
}
