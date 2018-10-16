//
//  LotteryOrderManager.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class LotteryOrderManager {

    
    /**
     * 计算下注注单(针对奖金版本)
     * @param list 用户选择过后的所有球列表数据
     * @param rcode 玩法
     * @param lotType 彩票类型
     * @param rateback 用户选择的返水比例
     * @param mode
     * @param beishu
     * @param oddsList
     * @return
     */
    static func calcOrders(list:[BallonRules],rcode:String,lotType:Int,rateback:Float,mode:Int,
                           beishu:Int,oddsList:[PeilvWebResult]) -> [OfficialOrder]{
        
        //构造下注号吗串，哪一行没有下注则用@符号占位
        let fakeNumber = buildFakeBetNumberFromAllBalls(allBalls:list)
        if isEmptyString(str: fakeNumber){
            return []
        }
        let orders = [OfficialOrder]()
        ////时时彩,分分彩
        if lotType == 1 || lotType == 2{
            //五星---------------------
            //五星直选
            if (rcode == "wxfs" || rcode == "wxzh" || rcode == "wxds" ||
                rcode == "wz5" || rcode == "wz10"
                || rcode == "wz20"
                || rcode == "wz30"
                || rcode == "wz60"
                || rcode == "wz120") {
                
                if rcode == "wxfs"{
                    return calcXfsOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                }else if rcode == "wz5" || rcode == "wz10"{
                    if fakeNumber.contains("@"){
                        let split = fakeNumber.components(separatedBy: "@")
                        if split.count == 2{
                            if split[0].count == split[1].count && split[0] == split[1] && split[0].count == 1{
                                return []
                            }
                        }
                    }
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //前四--------------------
            else if (rcode == "qszh" || rcode == "qsfs" || rcode == "qsds" ||
                rcode == "qsz4" || rcode == "qsz6" ||
                rcode == "qsz12" || rcode == "qsz24") {
                if rcode == "qsfs"{
                    return calcXfsOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                }else if rcode == "qsz4" || rcode == "qsz12"{
                    if fakeNumber.contains("@"){
                        let split = fakeNumber.components(separatedBy: "@")
                        if split.count == 2{
                            if split[0].count == split[1].count && split[0] == split[1] && split[0].count == 1{
                                return []
                            }
                        }
                    }
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //后四--------------------
            else if (rcode == "hszh" || rcode == "hsfs" || rcode == "hsds" ||
                rcode == "hsz4" || rcode == "hsz6" ||
                rcode == "hsz12" || rcode == "hsz24") {
                if rcode == "hsfs"{
                    return calcXfsOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                }else if rcode == "hsz4" || rcode == "hsz4"{
                    if fakeNumber.contains("@"){
                        let split = fakeNumber.components(separatedBy: "@")
                        if split.count == 2{
                            if split[0].count == split[1].count && split[0] == split[1] && split[0].count == 1{
                                return []
                            }
                        }
                    }
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //后三码--------------------
            else if (rcode == "hsanfs" || rcode == "hsands" || rcode == "hsanhz" ||
                rcode == "hsanzu3" || rcode == "hsanzu6" ||
                rcode == "hsanhzu" || rcode == "hsanhez") {
                
                if rcode == "hsanfs"{
                    return calcXfsOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                }
                
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //前三码--------------------
            else if (rcode == "qsanfs" || rcode == "qsands" || rcode == "qsanhz" ||
                rcode == "qsanzu3" || rcode == "qsanzu6" ||
                rcode == "qsanhzu" || rcode == "qsanhez") {
                
                if rcode == "qsanfs"{
                    return calcXfsOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                }
                
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //中三码--------------------
            //中三直选
            else if (rcode == "zsfs" || rcode == "zsds" || rcode == "zshz" ||
                rcode == "zszu3" || rcode == "zszu6" ||
                rcode == "zshzu" || rcode == "zshez") {
                if rcode == "zsfs"{
                    return calcXfsOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //二码--------------------
            //二星直选
            else if (rcode == "hefs" || rcode == "qefs" || rcode == "qeds"
                || rcode == "hehz" || rcode == "qehz" ||
                rcode == "hefsz" || rcode == "hedsz" ||
                rcode == "qefsz" || rcode == "qedsz" ||
                rcode == "hehzz" || rcode == "qehzz") {
                
                if rcode == "hefs" || rcode == "qefs"{
                    return calcXfsOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //定位胆---------------------
            else if (rcode == "dwd") {
                return calcDwdOrder(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList);
            }
            //不定胆-------------------
            else if (rcode == "hsymbdwd" || rcode == "hsembdwd"
                || rcode == "qsymbdwd" || rcode == "qsembdwd") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //大小单双------------------
            else if (rcode == "hedxds" || rcode == "qedxds") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //趣味----------------------
            else if (rcode == "yffs" || rcode == "hscs" || rcode == "sxbx" ||
                rcode == "sjfc") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
            //任选二---------------
            else if (rcode == "rezhixfs" || rcode == "rezhixds" || rcode == "rezhixhz" ||
                rcode == "rezuxfs" || rcode == "rezuxds" ||
                rcode == "rezuxhz" ) {
                return clacRenxuanfs(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, ballonRules: list);
            }
            //任选三--------------------
            //任三直选
            else if (rcode == "rszhixhz" || rcode == "rszhixds" || rcode == "rszhixfs" ||
                rcode == "rszuxs" || rcode == "rszuxl" ||
                rcode == "rszuxhz" || rcode == "rszuxhh") {
                return clacRenxuanfs(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback,
                                     mode: mode, beishu: beishu, oddsList: oddsList, ballonRules: list);
            }
            //任选四------------------------
            //任四直选
            else if (rcode == "rsizhixds" || rcode == "rsizhixfs" ||
                rcode == "zux4" || rcode == "zux6" ||
                rcode == "zux12" || rcode == "zux24") {
                
                if rcode == "zux4" || rcode == "zux12"{
                    if fakeNumber.contains("@"){
                        let split = fakeNumber.components(separatedBy: "@")
                        if split.count == 2{
                            if split[0].count == split[1].count && split[0] == split[1] && split[0].count == 1{
                                return []
                            }
                        }
                    }
                }
                
                return clacRenxuanfs(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback,
                                     mode: mode, beishu: beishu, oddsList: oddsList, ballonRules: list);
            }
        //北京赛车
        }else if lotType == 3{
            if (rcode == "cgj2") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
            } else if (rcode == "cqerfs" ||
                rcode == "cqsanfs" || rcode == "cqsifs" ||
                rcode == "cqwufs") {
                
                if isEmptyString(str: fakeNumber){
                    return []
                }
                let list:[String] = fakeNumber.components(separatedBy: "@");
                if list.isEmpty{
                    return []
                }
                var countOfLineNumbers = 0
                for str in list{
                    if !isEmptyString(str: str) && str != "-"{
                        countOfLineNumbers = countOfLineNumbers + 1
                    }
                }
                
                if (rcode == "cqerfs" && countOfLineNumbers < 2) {
                    return [];
                }
                if (rcode == "cqsanfs" && countOfLineNumbers < 3) {
                    return [];
                }
                if (rcode == "cqsifs" && countOfLineNumbers < 4) {
                    return [];
                }
                if (rcode == "cqwufs" && countOfLineNumbers < 5) {
                    return [];
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            } else if (rcode == "dwd2") {
                return calcSaicheDwdOrder(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList);
            }
        //快三
        }else if lotType == 4{
            //二同号
            if (rcode == "k3ethfx" || rcode == "k3sthdx") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            } else if (rcode == "k3ethdx" || rcode == "k3sthfx") {
                
                if rcode == "k3ethdx"{
                    if fakeNumber.contains("@"){
                        let split = fakeNumber.components(separatedBy: "@")
                        if split.count == 2{
                            if split[0].components(separatedBy: ",").count == split[1].components(separatedBy: ",").count{
                                return []
                            }
                        }
                    }
                }
                
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
                //和值
            } else if (rcode == "k3hz2") {
                var orders:[OfficialOrder] = []
                let numbers = calcSingleLineNumbers(fakeNumber: fakeNumber, singleLineNumsSepratorFormat: "|");
                if (!isEmptyString(str: numbers)) {
                    let nums = numbers.components(separatedBy: "|")
                    if (!nums.isEmpty) {
                        for s in nums {
                            var zhushu = 0;
                            if (!isEmptyString(str: s)) {
                                zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: rcode, haoMa: s, maxHaoMaNum: 0);
                            }
//                            if (zhushu > 0) {
                                let order = OfficialOrder();
                                order.c = s
                                if (!oddsList.isEmpty) {
//                                    order.i = oddsList[0].code
//                                    order.oddName = oddsList[0].numName
                                    let pw = ZhuxuanLogic.findPeilvByOddNameForKuai3Hz(oddName: s, results: oddsList)
                                    order.i = pw != nil ? (pw?.code)! : ""
                                    order.oddName = pw != nil ? (pw?.numName)! : ""
                                }
                                order.n = zhushu
                                order.k = rateback
                                order.m = mode
                                let money = (zhushu * beishu * 2)/mode
                                order.a = Float(money)
                                order.t = beishu
                                orders.append(order);
//                            }
                        }
                        return orders;
                    }
                }
                //三连号
            } else if (rcode == "k3slh2") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            } else if (rcode == "k3ebth" || rcode == "k3sbth") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
        //11选5
        }else if lotType == 5{
            //三码
            //前三直选复式
            if (rcode == "sanmaqszhixfs") {
                if (isEmptyString(str: fakeNumber)) {
                    return [];
                }
                let m:[String] = fakeNumber.components(separatedBy: "@")
                if (m.isEmpty) {
                    return [];
                }
                var countOfLineNumbers = 0;
                for str in m {
                    if (!isEmptyString(str: str) && str != "-") {
                        countOfLineNumbers += 1;
                    }
                }
                if (rcode == "sanmaqszhixfs" && countOfLineNumbers < 3) {
                    return [];
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
                //前三组选复式
            } else if (rcode == "sanmaqszuxfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
                //前二直选复式
            else if (rcode == "ermaqezhixfs") {
                if (isEmptyString(str: fakeNumber)) {
                    return [];
                }
                let m:[String] = fakeNumber.components(separatedBy: "@")
                if (m.isEmpty) {
                    return [];
                }
                var countOfLineNumbers = 0;
                for str in m {
                    if !isEmptyString(str: str) && str != "-" {
                        countOfLineNumbers += 1;
                    }
                }
                
                if (rcode == "ermaqezhixfs" && countOfLineNumbers < 2) {
                    return [];
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
                //前二组选复式
            } else if (rcode == "ermaqezuxfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                //不定位胆
            } else if (rcode == "bdwd2") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                //定位胆
            } else if (rcode == "dwd2") {
                return calc11x5DwdOrder(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList);
            }
                //猜中位
            else if (rcode == "qwxczw") {
                return calc11x5CZWOrder(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList);
                //定单双
            } else if (rcode == "qwxdds") {
                return calc11x5DDSOrder(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList);
                //任选复式
            } else if (rcode == "rxfsyzy" || rcode == "rxfseze" || rcode == "rxfsszsan" ||
                rcode == "rxfsszsi" || rcode == "rxfslzw" || rcode == "rxfsqzw" ||
                rcode == "rxfsbzw") {
                
                var selectNumCount = 0;
                if (!list.isEmpty) {
                    for info in list[0].ballonsInfo {
                        if (info.isSelected) {
                            selectNumCount += 1;
                        }
                    }
                }
                if (rcode == "rxfsyzy" && selectNumCount < 1) {
                    return [];
                }
                if (rcode == "rxfseze" && selectNumCount < 2) {
                    return [];
                }
                if (rcode == "rxfsszsan" && selectNumCount < 3) {
                    return [];
                }
                if (rcode == "rxfsszsi" && selectNumCount < 4) {
                    return [];
                }
                if (rcode == "rxfslzw" && selectNumCount < 6) {
                    return [];
                }
                if (rcode == "rxfsqzw" && selectNumCount < 7) {
                    return [];
                }
                if (rcode == "rxfsbzw" && selectNumCount < 8) {
                    return [];
                }
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
        //pc egg egg
        }else if lotType == 7{
            //三码直选和值，三码直选复式
            if (rcode == "sanmzhixhz" || rcode == "sanmzhixfs" || rcode == "sanmzuxhz" ||
                rcode == "sanmzuxzl" || rcode == "sanmzuxzs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                //不定位
            } else if (rcode == "bdwdem" || rcode == "bdwdym") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                // 二码
                //前二组选复式
            } else if (rcode == "ermaqerzuxfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                //前二直选复式
            } else if (rcode == "ermaqerzhixfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
                //后二组选复式
            } else if (rcode == "ermaherzuxfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                //后二直选复式
            } else if (rcode == "ermaherzhixfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
                //定位胆
            } else if (rcode == "dwd2") {
                return  calcPcddDwdOrder(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList);
                //大小单双
            } else if (rcode == "dxdsqer" || rcode == "dxdsher") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
            }
        //低频彩
        }else if lotType == 8{
            //三码
            if (rcode == "sanmzhixhz") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            } else if (rcode == "sanmzhixfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
            } else if (rcode == "sanmzuxhz" || rcode == "sanmzuxzl" || rcode == "sanmzuxzs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
                //不定胆
            else if (rcode == "bdwdym" || rcode == "bdwdem") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
            }
                // 二码
                //前二组选复式
            else if (rcode == "ermaqerzuxfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                //前二直选复式
            } else if (rcode == "ermaqerzhixfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
                //后二组选复式
            } else if (rcode == "ermaherzuxfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: "|");
                //后二直选复式
            } else if (rcode == "ermaherzhixfs") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
                //定位胆
            } else if (rcode == "dwd2") {
                return calcPcddDwdOrder(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList);
                //大小单双
            } else if (rcode == "dxdsqer" || rcode == "dxdsher") {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: rcode, rataback: rateback, mode: mode, beishu: beishu, oddsList: oddsList, singleLineNumsSepratorFormat: ",");
            }
        }
        return orders;
    }
    
    
    
    //计算11x5定单双玩法下的注单
    private static func calc11x5DDSOrder(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                         beishu:Int,oddsList:[PeilvWebResult]) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var orders:[OfficialOrder] = []
        for linenums in list{
            let singleLineNums:[String] = linenums.components(separatedBy: ",")
            for str in singleLineNums{
                let order = OfficialOrder()
                order.c = str
                if !oddsList.isEmpty{
                    let oddKeyName = str.count == 2 ? (str as NSString).substring(from: 1) : str
                    let pw = ZhuxuanLogic.findPeilvByOddName(oddName: oddKeyName, results: oddsList)
                    order.i = pw != nil ? (pw?.code)! : ""
                    order.oddName = pw != nil ? (pw?.numName)! : ""
                }
                let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: str, maxHaoMaNum: 0)
                if !isEmptyString(str: str){
                    order.n = zhushu
                    order.k = rataback
                    order.m = mode
                    order.t = beishu
                    let money = (zhushu * beishu * 2)/mode
                    order.a = Float(money)
                    orders.append(order)
                }
            }
        }
        return orders
    }
    
    //计算11x5猜中位玩法下的注单
    private static func calc11x5CZWOrder(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                         beishu:Int,oddsList:[PeilvWebResult]) -> [OfficialOrder]{
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var orders:[OfficialOrder] = []
        for linenums in list{
            let singleLineNums:[String] = linenums.components(separatedBy: ",")
            for str in singleLineNums{
                let order = OfficialOrder()
                order.c = str
                if !oddsList.isEmpty{
                    let oddKeyName = str.count == 2 ? (str as NSString).substring(from: 1) : str
                    let pw = ZhuxuanLogic.findPeilvByOddName(oddName: oddKeyName, results: oddsList)
                    order.i = pw != nil ? (pw?.code)! : ""
                    order.oddName = pw != nil ? (pw?.numName)! : ""
                }
                let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: str, maxHaoMaNum: 0)
                if !isEmptyString(str: str) {
                    order.n = zhushu
                    order.k = rataback
                    order.m = mode
                    order.t = beishu
                    let money = (zhushu * beishu * 2)/mode
                    order.a = Float(money)
                    orders.append(order)
                }
            }
        }
        return orders
    }
    
    
    //计算单行的号码
    private static func calcSingleLineNumbers(fakeNumber:String,singleLineNumsSepratorFormat:String) -> String{
        
        if isEmptyString(str: fakeNumber){
            return ""
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return ""
        }
        var countOfLineNumbers = 0
        for str in list{
            if !isEmptyString(str: str) && str != "-" {
                countOfLineNumbers = countOfLineNumbers + 1
            }
        }
        
        var orderNum = ""
        //若只有一行球的情况，则将这行中选择的号码由原来以逗号分隔改为以|线分隔
        if countOfLineNumbers == 1{
            for lineNums in list{
                if !isEmptyString(str: lineNums) && lineNums != "-"{
                    if lineNums.contains(","){
                        let singleLineNums:[String] = lineNums.components(separatedBy: ",")
                        for cell in singleLineNums{
                            orderNum = orderNum + cell
                            orderNum = orderNum + singleLineNumsSepratorFormat
                        }
                    }else{
                        orderNum = orderNum + lineNums
                        orderNum = orderNum + singleLineNumsSepratorFormat
                    }
                }
            }
        }else{
            for lineNums in list {
                if !isEmptyString(str: lineNums) {
                    if lineNums != "-"{
                        orderNum += lineNums + "|";
                    }
                }
            }
        }
        
        if orderNum.hasSuffix("|")||orderNum.hasSuffix(singleLineNumsSepratorFormat){
            orderNum = (orderNum as NSString).substring(to: orderNum.count - 1)
        }
        return orderNum
    }
    
    
    /**
     * 计算北京赛车中的定位胆玩法下的注单
     * @param fakeNumber
     * @param lotType
     * @param playCode
     * @param rateback
     * @param mode
     * @param beishu
     * @return
     */
    private static func calcSaicheDwdOrder(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                                  beishu:Int,oddsList:[PeilvWebResult]) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var orders:[OfficialOrder] = []
        var weiNums:[String] = []
        for i in 0...list.count - 1{
            let str = list[i]
            if !isEmptyString(str: str) && str != "-"{
                switch i {
                case 0:
                    weiNums.append("冠@"+str)
                    break;
                case 1:
                    weiNums.append("亚@"+str)
                    break;
                case 2:
                    weiNums.append("季@"+str)
                    break;
                case 3:
                    weiNums.append("四@"+str)
                    break;
                case 4:
                    weiNums.append("五@"+str)
                    break;
                case 5:
                    weiNums.append("六@"+str)
                    break;
                case 6:
                    weiNums.append("七@"+str)
                    break;
                case 7:
                    weiNums.append("八@"+str)
                    break;
                case 8:
                    weiNums.append("九@"+str)
                    break;
                case 9:
                    weiNums.append("十@"+str)
                    break;
                default:
                    break;
                }
            }
        }
        if weiNums.isEmpty{
            return []
        }
        for realLine in weiNums{
            var keys = ""
            var nums = ""
            let ws:[String] = realLine.components(separatedBy: "@");
            if ws.count == 2{
                keys += ws[0]
                nums += ws[1]
            }
            if !isEmptyString(str: nums){
                let numList:[String] = nums.components(separatedBy: ",");
                nums = ""
                for str in numList{
                    nums += str
                    nums.append("|")
                }
                if nums.hasSuffix("|"){
                    nums = (nums as NSString).substring(to: nums.count - 1)
                }
            }
            
            let order = OfficialOrder()
            order.c = nums
            if !oddsList.isEmpty{
                let pw = ZhuxuanLogic.findPeilvByOddName(oddName: keys, results: oddsList)
                order.i = pw != nil ? (pw?.code)! : ""
                order.oddName = pw != nil ? (pw?.numName)! : ""
            }
            let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: nums, maxHaoMaNum: 0)
            if !isEmptyString(str: nums) {
                order.n = zhushu
                order.k = rataback
                order.m = mode
                order.t = beishu
                let money = (zhushu * beishu * 2)/mode
                order.a = Float(money)
                orders.append(order)
            }
        }
        return orders
        
    }
    
    //计算任选玩法下的注单
    private static func clacRenxuanfs(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                      beishu:Int,oddsList:[PeilvWebResult],ballonRules:[BallonRules]) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var countOfLineNumbers = 0
        for str in list{
            if !isEmptyString(str: str) && str != "-"{
                countOfLineNumbers = countOfLineNumbers + 1
            }
        }
        var orders:[OfficialOrder] = []
        //任二，三，四直选复式
        if (playCode == "rezhixfs" || playCode == "rszhixfs" || playCode == "rsizhixfs") {
            //任二直选复式且只选了两行球时，只有一注
            if ((playCode == "rezhixfs" && countOfLineNumbers == 2) ||
                (playCode == "rszhixfs" && countOfLineNumbers == 3) ||
                (playCode == "rsizhixfs" && countOfLineNumbers == 4)) {
                return calcSingleOrderBetNumbers(fakeNumber: fakeNumber, lotType: lotType, playCode: playCode, rataback: rataback, mode: mode, beishu: beishu, oddsList: oddsList,singleLineNumsSepratorFormat: "|");
            }
            var weiNums:[String] = []
            for i in 0...list.count - 1{
                let str = list[i]
                if !isEmptyString(str: str) && str != "-"{
                    switch i {
                    case 0:
                        weiNums.append("万@"+str)
                        break;
                    case 1:
                        weiNums.append("千@"+str)
                        break;
                    case 2:
                        weiNums.append("百@"+str)
                        break;
                    case 3:
                        weiNums.append("十@"+str)
                        break;
                    case 4:
                        weiNums.append("个@"+str)
                        break;
                    default:
                        break;
                    }
                }
            }
            if weiNums.isEmpty{
                return []
            }
            var xuanCount = 0;
            if (playCode == "rezhixfs") {
                xuanCount = 2;
            } else if (playCode == "rszhixfs") {
                xuanCount = 3;
            } else if (playCode == "rsizhixfs") {
                xuanCount = 4;
            }
            return ZhuxuanLogic.getOrder(weiNums: weiNums, n: xuanCount, results: oddsList,
                                         lotType: lotType, playCode: playCode, rateback: rataback, mode: mode, beishu: beishu);
        }//任二，三，四直选组选
        else if (playCode == "rezuxfs" || playCode == "rszuxs" || playCode == "rszuxl"
            || playCode == "zux4" || playCode == "zux6" || playCode == "zux12" ||
            playCode == "zux24"
            || playCode == "rezhixhz" || playCode == "rezuxhz" || playCode == "rszuxhz"
            || playCode == "rszhixhz" || playCode == "rszuxhz" || playCode == "rszuxs")
            || playCode == "rszuxl"{
            
            //任组选的情况下每单的号码都是一样的，这里选把每单的号码按指定格式拼出来，再算组合下注订单
            if isEmptyString(str: fakeNumber){
                return []
            }
            let mlist = fakeNumber.components(separatedBy: "@")
            if mlist.isEmpty{
                return []
            }
            var countOfNumbers = 0
            for str in mlist{
                if !isEmptyString(str: str) && str != "-"{
                    countOfNumbers += 1
                }
            }
            var orderNum = ""
            //若只有一行球的情况，则将这行中选择的号码由原来以逗号分隔改为以|线分隔
            if countOfLineNumbers == 1{
                for lineNums in list{
                    if !isEmptyString(str: lineNums) && lineNums != "-"{
                        if lineNums.contains(","){
                            let singleLineNums = lineNums.components(separatedBy: ",")
                            if !singleLineNums.isEmpty{
                                for cell in singleLineNums{
                                    orderNum += cell
                                    orderNum.append("|")
                                }
                            }
                        }else{
                            orderNum += orderNum + lineNums
                            orderNum.append("|")
                        }
                    }
                }
            }else{
                for lineNums in list{
                    if !isEmptyString(str: lineNums){
                        if lineNums != "-"{
                            orderNum += lineNums
                            orderNum += "|"
                        }
                    }
                }
            }
            if orderNum.hasSuffix("|"){
                orderNum = (orderNum as NSString).substring(to: orderNum.count - 1)
            }
            var weiNums:[String] = []
            if !ballonRules.isEmpty{
                if ballonRules[0].weishuInfo != nil{
                    let selectedWeishu:[BallListItemInfo] = ballonRules[0].weishuInfo
                    for str in selectedWeishu{
                        if str.isSelected{
                            weiNums.append(str.num)
                        }
                    }
                }
            }
            //最小要从万千百十个五个位时选择几个位
            var minSelectCount = 0;
            if (playCode == "rezuxfs") {
                minSelectCount = 2;
            } else if (playCode == "rszuxs" || playCode == "rszuxl" || playCode == "rszuxhz") {
                minSelectCount = 3;
            } else if (playCode == "zux4" || playCode == "zux6" || playCode == "zux12" || playCode == "zux24") {
                minSelectCount = 4;
            } else if playCode == "rezhixhz"{
                minSelectCount = 2
            } else if playCode == "rszhixhz"{
                minSelectCount = 3
            } else if playCode == "rezuxhz"{
                minSelectCount = 2
            }
            ////如果选择的位数没有达到最小选择位，则直接不构成注单
            if weiNums.count < minSelectCount{
                return []
            }
            return ZhuxuanLogic.getZhuxuanOrder(weiNums: weiNums, orderNumber:orderNum,n: minSelectCount, results: oddsList,
                                         lotType: lotType, playCode: playCode, rateback: rataback, mode: mode, beishu: beishu);
        }
        
        else {
            var orderNum = ""
            //若只有一行球的情况，则将这行中选择的号码由原来以逗号分隔改为以|线分隔
            if countOfLineNumbers == 1{
                for lineNums in list{
                    if !isEmptyString(str: lineNums) && lineNums != "-"{
                        if lineNums.contains(","){
                            let singleLineNums = lineNums.components(separatedBy: ",")
                            if !singleLineNums.isEmpty{
                                for cell in singleLineNums{
                                    orderNum += cell
                                    orderNum.append("|")
                                }
                            }
                        }else{
                            orderNum += orderNum + lineNums
                            orderNum.append("|")
                        }
                    }
                }
            }else{
                for lineNums in list{
                    if !isEmptyString(str: lineNums){
                        if lineNums != "-"{
                            orderNum += lineNums
                            orderNum += "|"
                        }
                    }
                }
            }
            if orderNum.hasSuffix("|"){
                orderNum = (orderNum as NSString).substring(to: orderNum.count - 1)
            }
            let order = OfficialOrder()
            order.c = orderNum
            if !oddsList.isEmpty{
                order.i = oddsList[0].code
                order.oddName = oddsList[0].numName;
            }
            let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: orderNum, maxHaoMaNum: 0)
//            if zhushu > 0{
                order.n = zhushu
                order.k = rataback
                order.m = mode
                order.t = beishu
                orders.append(order)
//            }
        }
        return orders
    }
    
    //计算定位胆玩法下的注单
    private static func calcDwdOrder(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                     beishu:Int,oddsList:[PeilvWebResult]) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var orders:[OfficialOrder] = []
        var weiNums:[String] = []
        for i in 0...list.count - 1{
            let str = list[i]
            if !isEmptyString(str: str) && str != "-"{
                switch i {
                case 0:
                    weiNums.append("万@"+str)
                    break;
                case 1:
                    weiNums.append("千@"+str)
                    break;
                case 2:
                    weiNums.append("百@"+str)
                    break;
                case 3:
                    weiNums.append("十@"+str)
                    break;
                case 4:
                    weiNums.append("个@"+str)
                    break;
                default:
                    break;
                }
            }
        }
        if weiNums.isEmpty{
            return []
        }
        for realLine in weiNums{
            var keys = ""
            var nums = ""
            let ws:[String] = realLine.components(separatedBy: "@");
            if ws.count == 2{
                keys += ws[0]
                nums += ws[1]
            }
            if !isEmptyString(str: nums){
                let numList:[String] = nums.components(separatedBy: ",");
                nums = ""
                for str in numList{
                    nums += str
                    nums.append("|")
                }
                if nums.hasSuffix("|"){
                    nums = (nums as NSString).substring(to: nums.count - 1)
                }
            }
            
            let order = OfficialOrder()
            order.c = nums
            if !oddsList.isEmpty{
                let pw = ZhuxuanLogic.findPeilvByOddName(oddName: keys, results: oddsList)
                order.i = pw != nil ? (pw?.code)! : ""
                order.oddName = pw != nil ? (pw?.numName)! : ""
            }
            let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: nums, maxHaoMaNum: 0)
            if !isEmptyString(str: nums){
                order.n = zhushu
                order.k = rataback
                order.m = mode
                order.t = beishu
                let money = (zhushu * beishu * 2)/mode
                order.a = Float(money)
                orders.append(order)
            }
        }
        return orders
    }
    
    //计算11x5定位胆玩法下的注单
    private static func calc11x5DwdOrder(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                     beishu:Int,oddsList:[PeilvWebResult]) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var orders:[OfficialOrder] = []
        var weiNums:[String] = []
        for i in 0...list.count - 1{
            let str = list[i]
            if !isEmptyString(str: str) && str != "-"{
                switch i {
                case 0:
                    weiNums.append("一@"+str)
                    break;
                case 1:
                    weiNums.append("二@"+str)
                    break;
                case 2:
                    weiNums.append("三@"+str)
                    break;
                case 3:
                    weiNums.append("四@"+str)
                    break;
                case 4:
                    weiNums.append("五@"+str)
                    break;
                default:
                    break;
                }
            }
        }
        if weiNums.isEmpty{
            return []
        }
        for realLine in weiNums{
            var keys = ""
            var nums = ""
            let ws:[String] = realLine.components(separatedBy: "@");
            if ws.count == 2{
                keys += ws[0]
                nums += ws[1]
            }
            if !isEmptyString(str: nums){
                let numList:[String] = nums.components(separatedBy: ",");
                nums = ""
                for str in numList{
                    nums += str
                    nums.append("|")
                }
                if nums.hasSuffix("|"){
                    nums = (nums as NSString).substring(to: nums.count - 1)
                }
            }
            
            let order = OfficialOrder()
            order.c = nums
            if !oddsList.isEmpty{
                let pw = ZhuxuanLogic.findPeilvByOddName(oddName: keys, results: oddsList)
                order.i = pw != nil ? (pw?.code)! : ""
                order.oddName = pw != nil ? (pw?.numName)! : ""
            }
            let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: nums, maxHaoMaNum: 0)
            if !isEmptyString(str: nums){
                order.n = zhushu
                order.k = rataback
                order.m = mode
                order.t = beishu
                let money = (zhushu * beishu * 2)/mode
                order.a = Float(money)
                orders.append(order)
            }
        }
        return orders
    }
    
    //计算pcdd定位胆玩法下的注单
    private static func calcPcddDwdOrder(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                         beishu:Int,oddsList:[PeilvWebResult]) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var orders:[OfficialOrder] = []
        var weiNums:[String] = []
        for i in 0...list.count - 1{
            let str = list[i]
            if !isEmptyString(str: str) && str != "-"{
                switch i {
                case 0:
                    weiNums.append("百位@"+str)
                    break;
                case 1:
                    weiNums.append("十位@"+str)
                    break;
                case 2:
                    weiNums.append("个位@"+str)
                    break;
                default:
                    break;
                }
            }
        }
        if weiNums.isEmpty{
            return []
        }
        for realLine in weiNums{
            var keys = ""
            var nums = ""
            let ws:[String] = realLine.components(separatedBy: "@");
            if ws.count == 2{
                keys += ws[0]
                nums += ws[1]
            }
            if !isEmptyString(str: nums){
                let numList:[String] = nums.components(separatedBy: ",");
                nums = ""
                for str in numList{
                    nums += str
                    nums.append("|")
                }
                if nums.hasSuffix("|"){
                    nums = (nums as NSString).substring(to: nums.count - 1)
                }
            }
            
            let order = OfficialOrder()
            order.c = nums
            if !oddsList.isEmpty{
                let pw = ZhuxuanLogic.findPeilvByOddName(oddName: keys, results: oddsList)
                order.i = pw != nil ? (pw?.code)! : ""
                order.oddName = pw != nil ? (pw?.numName)! : ""
            }
            let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: nums, maxHaoMaNum: 0)
            if !isEmptyString(str: nums){
                order.n = zhushu
                order.k = rataback
                order.m = mode
                order.t = beishu
                let money = (zhushu * beishu * 2)/mode
                order.a = Float(money)
                orders.append(order)
            }
        }
        return orders
    }
    
    
    /**
     * 只有单有玩法赔率情况时的注单情况
     * @param fakeNumber
     * @param lotType
     * @param playCode
     * @param rateback
     * @param mode
     * @param beishu
     * @return
     */
    private static func calcSingleOrderBetNumbers(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                                  beishu:Int,oddsList:[PeilvWebResult],singleLineNumsSepratorFormat:String) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var countOfLineNumbers = 0
        for str in list{
            if !isEmptyString(str: str) && str != "-"{
                countOfLineNumbers = countOfLineNumbers + 1
            }
        }
        var orders:[OfficialOrder] = []
        var orderNum = ""
        //若只有一行球的情况，则将这行中选择的号码由原来以逗号分隔改为以|线分隔
        if countOfLineNumbers == 1{
            for lineNums in list{
                if !isEmptyString(str: lineNums) && lineNums != "-"{
                    if lineNums.contains(","){
                        let singleLineNums:[String] = lineNums.components(separatedBy: ",")
                        for cell in singleLineNums{
                            orderNum = orderNum + cell
                            orderNum = orderNum + singleLineNumsSepratorFormat
                        }
                    }else{
                        orderNum = orderNum + lineNums
                        orderNum = orderNum + singleLineNumsSepratorFormat
                    }
                }
            }
        }else{
            for lineNums in list {
                if !isEmptyString(str: lineNums) {
                    if lineNums != "-"{
                        orderNum += lineNums + "|";
                    }
                }
            }
        }
        
        if orderNum.hasSuffix("|")||orderNum.hasSuffix(singleLineNumsSepratorFormat){
            orderNum = (orderNum as NSString).substring(to: orderNum.count - 1)
        }
        
        var zhushu = 0
        if !isEmptyString(str: orderNum){
            zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: orderNum, maxHaoMaNum: 0)
        }
//        if zhushu > 0{
            let order = OfficialOrder()
            order.c = orderNum
            if !oddsList.isEmpty{
                order.i = oddsList[0].code
                order.oddName = oddsList[0].numName
            }
            print("single order number zhushu = ",zhushu)
            order.n = zhushu
            order.k = rataback
            order.m = mode
            let money = (zhushu * beishu * 2)/mode
            order.a = Float(money)
            order.t = beishu
            orders.append(order)
//        }
        return orders;
    }
    
    private static func calcXfsOrderBetNumbers(fakeNumber:String,lotType:Int,playCode:String,rataback:Float,mode:Int,
                                                  beishu:Int,oddsList:[PeilvWebResult],singleLineNumsSepratorFormat:String) -> [OfficialOrder]{
        
        if isEmptyString(str: fakeNumber){
            return []
        }
        let list:[String] = fakeNumber.components(separatedBy: "@");
        if list.isEmpty{
            return []
        }
        var countOfLineNumbers = 0
        for str in list{
            if !isEmptyString(str: str) && str != "-"{
                countOfLineNumbers = countOfLineNumbers + 1
            }
        }
        var orders:[OfficialOrder] = []
        var orderNum = ""
        //若只有一行球的情况，则将这行中选择的号码由原来以逗号分隔改为以|线分隔
        if countOfLineNumbers == 1{
            for lineNums in list{
                if !isEmptyString(str: lineNums) && lineNums != "-"{
                    if lineNums.contains(","){
                        let singleLineNums:[String] = lineNums.components(separatedBy: ",")
                        for cell in singleLineNums{
                            orderNum = orderNum + cell
                            orderNum = orderNum + ","
                        }
                    }else{
                        orderNum = orderNum + lineNums
                        orderNum = orderNum + singleLineNumsSepratorFormat
                    }
                }
            }
        }else{
            for lineNums in list {
                if !isEmptyString(str: lineNums) {
                    if lineNums != "-"{
                        orderNum += lineNums + "|";
                    }
                }
            }
        }
        
        if orderNum.hasSuffix("|")||orderNum.hasSuffix(",")||orderNum.hasSuffix(singleLineNumsSepratorFormat){
            orderNum = (orderNum as NSString).substring(to: orderNum.count - 1)
        }
        
        var zhushu = 0
        if !isEmptyString(str: orderNum){
            zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: orderNum, maxHaoMaNum: 0)
        }
        //        if zhushu > 0{
        let order = OfficialOrder()
        order.c = orderNum
        if !oddsList.isEmpty{
            order.i = oddsList[0].code
            order.oddName = oddsList[0].numName
        }
        print("single order number zhushu = ",zhushu)
        order.n = zhushu
        order.k = rataback
        order.m = mode
        let money = (zhushu * beishu * 2)/mode
        order.a = Float(money)
        order.t = beishu
        orders.append(order)
        //        }
        return orders;
    }
    
    
    
    static func buildFakeBetNumberFromAllBalls(allBalls:[BallonRules]) -> String{
        //将所有球列表数据按玩法名称分类
//        var item:BallonRules!
//        var map:Dictionary<String,[BallonRules]> = [:]
//        for i in 0...allBalls.count - 1{
//            item = allBalls[i]
//            if map.keys.contains(item.ruleTxt){
//                map[item.ruleTxt]?.append(item)
//            }else{
//                var list:[BallonRules] = []
//                list.append(item)
//                map[item.ruleTxt] = list
//            }
//        }
//
//        let keys = map.keys.sorted()
//        if keys.isEmpty{
//            return ""
//        }
//        var list:[[BallonRules]] = []
//        for key in keys{
//            list.append(map[key]!)
//        }
        return getNumber(list:allBalls)
    }
    
    
    ////计算所有玩法下的下注号码为拼接号码，格式为x,x@-@x@-@x
    //@为占位使用
    static func getNumber(list:[BallonRules]) -> String{
        if list.isEmpty{
            return ""
        }
        var numbers = ""
        for item in list{
            var singleLineNumbers = ""
//            if !item.isEmpty{
//                for single in item{
                    if item.ballonsInfo != nil{
                        for info in item.ballonsInfo{
                            if info.isSelected{
                                singleLineNumbers = singleLineNumbers + info.num
                                singleLineNumbers.append(",")
                            }
                        }
                        //循环判断当前行是否有选择号码之后，若没有号码，则用-占位
                        if isEmptyString(str: singleLineNumbers){
                            singleLineNumbers = "-,"
                        }
                        if singleLineNumbers.hasSuffix(","){
                            singleLineNumbers = (singleLineNumbers as NSString).substring(to: singleLineNumbers.count-1)
                        }
                    }
//                }
                if list.count > 1{
                    numbers =  numbers + singleLineNumbers
                    numbers.append("@")
                }else{
                    numbers += singleLineNumbers
                }
//            }
        }
        if numbers.hasSuffix("@"){
            numbers = (numbers as NSString).substring(to: numbers.count-1)
        }
        if numbers == "-"{
            return ""
        }
        return numbers
    }
    
    
    
    
    
    
    
    
    
}
