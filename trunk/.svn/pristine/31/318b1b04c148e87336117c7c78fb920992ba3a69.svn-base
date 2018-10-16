//
//  ZhuShuCalculator.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ZhuShuCalculator{

    //时时彩和值
    static let sscHz:[String] = ["1", "3", "6", "10", "15", "21", "28", "36", "45", "55", "63", "69",
                                 "73", "75", "75", "73", "69", "63", "55", "45", "36", "28", "21", "15", "10", "6", "3", "1"]
    //时时彩混合组选和值
    static let sscHHHz:[String] = ["1", "2", "2", "4", "5", "6", "8", "10", "11", "13", "14", "14",
                                   "15", "15", "14", "14", "13", "11", "10", "8", "6", "5", "4", "2", "2", "1"]
    
    //时时彩二码直选和值
    static let sscEMZHz:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "9", "8", "7",
                                    "6", "5", "4", "3", "2", "1"]
    
    //时时彩二码组选和值
    static let sscEMZUHz = ["1", "1", "2", "2", "3", "3", "4", "4", "5", "4", "4", "3", "3",
                            "2", "2", "1", "1"]
    
    static let syxw6z5 = ["1", "7", "28", "84", "210", "462"]
    static let syxw7z5 = ["1", "8", "36", "120", "330"]
    static let syxw8z5 = ["1", "9", "45", "165"]
    
    static func calc(lotType:Int,playCode:String,haoMa:String,maxHaoMaNum:Int) -> Int{
        
        let t = LotteryGroup.getType(type: lotType)
        if t.type == LotteryGroup.ssc.type || t.type == LotteryGroup.ffc.type{
            return getSscZhushu(playCode:playCode,haoMa:haoMa)
        }else if t.type == LotteryGroup.pk10.type{
            return getPK10Zhushu(playCode:playCode,haoMa:haoMa)
        }else if t.type == LotteryGroup.syxw.type{
            return getSyxwZhushu(playCode:playCode,haoMa:haoMa)
        }else if t.type == LotteryGroup.k3.type{
            return getK3Zhushu(playCode:playCode,haoMa:haoMa)
        }else if t.type == LotteryGroup.dpc.type || t.type == LotteryGroup.pcdd.type{
            return getDpcZhushu(playCode:playCode,haoMa:haoMa)
        }
        return 0
    }
    
    static func syxwRxfs(haoMa:String,balls:Int,syxw:[String],removeNum:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count >= balls{
            for s in split{
                let i = Int(s)!
                if i > 11 || i < 1 {
                    return 0
                }
            }
            if split.count - removeNum > syxw.count{
                return 0
            }
            zs = Int(syxw[split.count - removeNum])!
        }
        return zs
    }
    
    static func syxwZuxFs(haoMa:String,balls:Int) -> Int{
        let split = haoMa.components(separatedBy: "|")
        if split.count >= balls{
            for s in split{
                let i = Int(s)!
                if i > 11 || i < 1 {
                    return 0
                }
            }
        }
        let zs = factorialResult(one:split.count,two: balls)
        return zs
    }
    
    static func syxwDwd(haoMa:String) ->Int{
        let split = haoMa.components(separatedBy: "|")
        for s in split{
            let i = Int(s)!
            if i > 11 || i < 1 {
                return 0
            }
        }
        return split.count
    }
    
    static func k3Ethdx(haoMa:String,balls:Int) -> Int{
        
        var zs = 0
        let split:[String] = haoMa.components(separatedBy: "|")
        if split.count == balls{
            for th in split{
                if isEmptyString(str: th){
                    return 0
                }
            }
            let hmTh = split[0].components(separatedBy: ",")
            let hmBth = split[1].components(separatedBy: ",")
            for th in hmTh{
                if !isMatchRegex(text: th, regex: "^11|22|33|44|55|66$"){
                    return 0
                }
            }
            for bth in hmBth{
                let i = Int(bth)!
                if i > 6 || i < 1 {
                    return 0
                }
            }
            for th in hmTh{
                for bth in hmBth{
                    if th != String(Int(bth)!*11){
                        zs += 1
                    }
                }
            }
        }
        return zs
//        return factorialResult(one: split.count, two: balls)
    }
    
    static func k3Ebth(haoMa:String,balls:Int) -> Int{
        let split:[String] = haoMa.components(separatedBy: "|")
        if split.count >= balls{
            for th in split{
                let i = Int(th)!
                if i > 6 || i < 1 {
                    return 0
                }
            }
        }
        return factorialResult(one: split.count, two: balls)
    }
    
    static func k3Ethfx(haoMa:String) -> Int{
        let split:[String] = haoMa.components(separatedBy: "|")
        for th in split{
            if !isMatchRegex(text: th, regex: "^11|22|33|44|55|66$"){
                return 0
            }
        }
        return split.count
    }
    
    static func k3Sthdx(haoMa:String) -> Int{
        let split:[String] = haoMa.components(separatedBy: "|")
        for th in split{
            if !isMatchRegex(text: th, regex: "^111|222|333|444|555|666$"){
                return 0
            }
        }
        return split.count
    }
    
    private static func getDpcZhushu(playCode:String,haoMa:String) -> Int{
        switch playCode {
        case "sanmzhixfs":
            return one09Nums(haoMa: haoMa, balls: 3);
        case "sanmzhixhz":
            return lotteryThreeHz(haoMa: haoMa, balls: 1, str: sscHz);
        case "sanmzuxzs":
            return lotteryQsz(haoMa: haoMa, balls: 2, flag: true);
        case "sanmzuxzl":
            return lotteryQsz(haoMa: haoMa, balls: 3, flag: false);
        case "sanmzuxhz":
            return lotteryThreeHz(haoMa: haoMa, balls: 1, str: sscHHHz);
        case "bdwdym":
            return lotteryYmBdwd(haoMa: haoMa, balls: 1);
        case "bdwdem":
            return lotteryQsz(haoMa: haoMa, balls: 2, flag: false);
        case "ermaqerzhixfs","ermaherzhixfs":
            return one09Nums(haoMa: haoMa, balls: 2);
        case "ermaqerzuxfs","ermaherzuxfs":
            return lotteryQsz(haoMa: haoMa, balls: 2, flag: false);
        case "dwd2":
            return dwd(haoMa: haoMa);
        case "dxdsqer","dxdsher":
            return lotteryDxds(haoMa: haoMa, balls: 2);
        case "sanmzhixds","sanmzuxhh":
            return lotteryDs(haoMa: haoMa, balls: 3);
        case "ermaqerzhixds","ermaqerzuxds","ermaherzhixds","ermaherzuxds":
            return lotteryDs(haoMa: haoMa, balls: 2);
        default:
            return 0
        }
        return 0;
    }
    
    private static func getK3Zhushu(playCode:String,haoMa:String) -> Int{
        switch playCode {
        case "k3ethdx":
            return k3Ethdx(haoMa: haoMa, balls: 2);
        case "k3ethfx":
            return k3Ethfx(haoMa: haoMa);
        case "k3sthdx":
            return k3Sthdx(haoMa: haoMa);
        case "k3sthfx":
            if (haoMa == "三同号通选") {
                return 1;
            }
            return 0;
        case "k3hz2":
            let i = Int(haoMa)!
            if (i > 18 || i < 3) {
                return 0;
            }
            return 1;
        case "k3slh2":
            if (haoMa == "三连号通选") {
                return 1;
            }
            return 0;
        case "k3ebth":
            return k3Ebth(haoMa: haoMa, balls: 2);
        case "k3sbth":
            return k3Ebth(haoMa: haoMa, balls: 3);
        default:
            return 0
        }
        return 0;
    }
    
    private static func getSyxwZhushu(playCode:String,haoMa:String) -> Int{
        let max = 11;
        switch playCode {
        case "sanmaqszhixfs":
            return pk10Qsfs(haoMa: haoMa, balls: 3, max: max);
        case "sanmaqszuxfs","rxfsszsan":
            return syxwZuxFs(haoMa: haoMa, balls: 3);
        case "ermaqezhixfs":
            return pk10Qsfs(haoMa: haoMa, balls: 2, max: max);
        case "ermaqezuxfs","rxfseze":
            return syxwZuxFs(haoMa: haoMa, balls: 2);
        case "bdwd2","rxfsyzy":
            return syxwZuxFs(haoMa: haoMa, balls: 1);
        case "dwd2":
            return syxwDwd(haoMa: haoMa);
        case "qwxdds":
            if isMatchRegex(text: haoMa, regex: "^5单0双|4单1双|3单2双|2单3双|1单4双|0单5双$"){
                return 1;
            }
            return 0;
        case "qwxczw":
            let i = Int(haoMa)
            if (i! > 9 || i! < 3) {
                return 0;
            }
            return 1;
        case "rxfsszsi":
            return syxwZuxFs(haoMa: haoMa, balls: 4);
        case "rxfslzw":
            return syxwRxfs(haoMa: haoMa, balls: 5, syxw: syxw6z5, removeNum: 6);
        case "rxfsqzw":
            return syxwRxfs(haoMa: haoMa, balls: 5, syxw: syxw7z5, removeNum: 7);
        case "rxfsbzw":
            return syxwRxfs(haoMa: haoMa, balls: 5, syxw: syxw8z5, removeNum: 8);
        case "sanmaqszhixds","sanmaqszuxds","rxdsszsan":
            return syxwDs(haoMa: haoMa, balls: 3);
        case "ermaqezhixds","ermaqezuxds","rxdseze":
            return syxwDs(haoMa: haoMa, balls: 2);
        case "rxdsyzy":
            return syxwDs(haoMa: haoMa, balls: 1);
        case "rxdsszsi":
            return syxwDs(haoMa: haoMa, balls: 4);
        case "rxdslzw":
            return syxwDs(haoMa: haoMa, balls: 6);
        case "rxdsqzw":
            return syxwDs(haoMa: haoMa, balls: 7);
        case "rxdsbzw":
            return syxwDs(haoMa: haoMa, balls: 8);
        default:
            return 0
        }
    }
    
    private static func syxwDs(haoMa:String,balls:Int) -> Int{
        return 1
    }
    
    private static func getPK10Zhushu(playCode:String,haoMa:String) -> Int{
        let max = 10
        switch playCode {
        case "cgj2":
            return pk10cgy(haoMa: haoMa, balls: 1);
        case "cqerfs":
            return pk10Qsfs(haoMa: haoMa, balls: 2, max: max);
        case "cqsanfs":
            return pk10Qsfs(haoMa: haoMa, balls: 3, max: max);
        case "cqsifs":
            return pk10Qsfs(haoMa: haoMa, balls: 4, max: max);
        case "cqwufs":
            return pk10Qsfs(haoMa: haoMa, balls: 5, max: max);
        case "dwd2":
            return pk10Dwd(haoMa:haoMa);
        case "cqerds":
            return pk10Ds(haoMa: haoMa, balls: 2); // 前面必须加0
        case "cqsands":
            return pk10Ds(haoMa: haoMa, balls: 3);
        case "cqsids":
            return pk10Ds(haoMa: haoMa, balls: 4);
        case "cqwuds":
            return pk10Ds(haoMa: haoMa, balls: 5);
        default:
            return 0
        }
    }
    
    static func pk10Dwd(haoMa:String) -> Int{
        let split = haoMa.components(separatedBy: "|")
        for s in split{
            let i = Int(s)!
            if i > 10 || i < 1 {
                return 0
            }
        }
        return split.count
    }
    
    static func pk10Ds(haoMa:String,balls:Int) -> Int{
        return 1
    }
    
    static func pk10Qsfs(haoMa:String, balls:Int,max:Int) -> Int{
        let split = haoMa.components(separatedBy: "|")
        var p:[String] = []
        if split.count == balls{
            for s in split{
                if isEmptyString(str: s){
                    return 0
                }
                p = s.components(separatedBy: ",")
                for str in p{
                    let i = Int(str)!
                    if i > max || i < 1 {
                        return 0
                    }
                }
                
            }
        }
        let result = descartes(list:split)
        return result.count
    }
    
    static func descartes(list:[String]) -> [String]{
        var strs:[[String]] = []
        for i in 0...list.count - 1{
            strs.append(list[i].components(separatedBy: ","))
        }
        var total = 1
        for i in 0...strs.count - 1{
            total *= strs[i].count
        }
        var mysesult:[String] = Array.init(repeating: "", count: total)
        var now = 1
        //每个元素每次循环打印个数
        var itemLoopNum = 1
        //每个元素循环的总次数
        var loopPerItem = 1
        var removeSet:Set<Int> = Set<Int>()
        for i in 0...strs.count-1{
            var temp:[String] = strs[i]
            now = now * temp.count
            //目标数组的索引值
            var index = 0
            let currentSize = temp.count
            itemLoopNum = total / now;
            loopPerItem = total / (itemLoopNum * currentSize);
            var myindex = 0
            for _ in 0...temp.count-1{
                //每个元素循环的总次数
                for _ in 0...loopPerItem-1{
                    if myindex == temp.count{
                        myindex = 0
                    }
                    //每个元素每次循环打印个数
                    for _ in 0...itemLoopNum-1{
                        //记录重复的数组索引index
                        if !isEmptyString(str: mysesult[index]) && mysesult[index].contains(temp[myindex]){
                            if !removeSet.contains(index){
                                removeSet.insert(index)
                            }
                        }
                        mysesult[index] = mysesult[index] + "," + temp[myindex]
                        index += 1
                    }
                    myindex += 1
                }
            }
        }
        var newList:[String] = []
        if !removeSet.isEmpty{
            for pos in removeSet{
                var foundValue = ""
                for j in 0...mysesult.count-1{
                    if j == pos{
                        foundValue = mysesult[j]
                        break;
                    }
                }
                if !isEmptyString(str: foundValue){
                    newList.append(foundValue)
                }
            }
        }
        
        var resultList = [String]()
        for str in mysesult{
            if !newList.contains(str){
               resultList.append(str)
            }
        }
        print("result list count = ",resultList.count)
        return resultList
    }
    
    
    static func pk10cgy(haoMa:String, balls:Int) -> Int{
        let split = haoMa.components(separatedBy: ",")
        if split.count >= balls{
            for s in split{
                let i = Int(s)!
                if i > 10 || i < 1 {
                    return 0
                }
            }
        }
        return split.count
    }
    
    
    //时时彩，分分彩住数计算
    private static func getSscZhushu(playCode:String,haoMa:String) -> Int{
        
        switch playCode {
        case "wxfs":
            return one09Nums(haoMa:haoMa,balls:5);
        case "qsfs","hsfs","rsizhixfs":
            return one09Nums(haoMa:haoMa, balls:4);
        case "hsanfs","qsanfs","zsfs","rszhixfs":
            return one09Nums(haoMa:haoMa, balls:3);
        case "hefs","qefs","rezhixfs":
            return one09Nums(haoMa:haoMa, balls:2);
        case "qedxds","hedxds":
            return lotteryDxds(haoMa:haoMa, balls:2);
        case "dwd":
            return dwd(haoMa:haoMa)
        case "wxzh":
            return lotteryZuHe(haoMa:haoMa, balls:5);
        case "qszh","hszh":
            return lotteryZuHe(haoMa:haoMa, balls:4);
        case "wz120":
            return lotteryWz120(haoMa:haoMa, balls:5);
        case "wz60":
            return lotteryWz60(haoMa:haoMa,balls:2,one:1,two:3)//// 1个二重号，3个单号
        case "wz30":
            return lotteryWz30(haoMa:haoMa, balls:2, one:2, two:1); // 2个二重号，1个单号
        case "wz20","qsz12","hsz12","zux12":
            return lotteryWz60(haoMa: haoMa, balls: 2, one: 1, two: 2); // 1个三重号，2个单号
        case "wz10","wz5","qsz4","hsz4","zux4":
            return lotteryWz60(haoMa: haoMa, balls: 2, one: 1, two: 1); // 1个四重号，1个单号
        case "qsz24","hsz24","zux24":
            return lotteryQsz(haoMa: haoMa, balls: 4, flag: false); // 1个四重号，1个单号
        case "qsz6","hsz6","hefsz","qefsz","hsembdwd","qsembdwd","rezuxfs","zux6":
            return lotteryQsz(haoMa:haoMa, balls:2, flag:false);
        case "hsanzu6","qsanzu6","zszu6","rszuxl":
            return lotteryQsz(haoMa:haoMa, balls:3, flag:false);
        case "hsanhz","qsanhz","zshz","rszhixhz":
            return lotteryThreeHz(haoMa: haoMa, balls: 1, str: sscHz);
        case "hsanzu3","qsanzu3","zszu3","rszuxs":
            return lotteryQsz(haoMa: haoMa, balls: 2, flag: true);
        case "hsanhez","zshez","qsanhez","rszuxhz":
            return lotteryThreeHz(haoMa: haoMa, balls: 1, str: sscHHHz);
        case "hehz","qehz","rezhixhz":
            return lotteryEmHz(haoMa: haoMa, balls: 1, str: sscEMZHz);
        case "hehzz","qehzz","rezuxhz":
            return lotteryEmHz(haoMa: haoMa, balls: 1, str: sscEMZUHz);
        case "hsymbdwd","qsymbdwd","yffs","hscs","sxbx","sjfc":
            return lotteryYmBdwd(haoMa: haoMa, balls: 1);
        case "wxds":
            return lotteryDs(haoMa: haoMa, balls: 5);
        case "qsds","hsds","rsizhixds":
            return lotteryDs(haoMa: haoMa, balls: 4);
        case "hsands","qsands","hsanhzu","qsanhzu","zsds","zshzu","rszhixds","rszuxhh":
            return lotteryDs(haoMa: haoMa, balls: 3);
        case "heds","hedsz","qeds","qedsz","rezuxds","rezhixds":
            return lotteryDs(haoMa: haoMa, balls: 2);
        default:
            return 0
        }
    }
    
    static func lotteryDs(haoMa:String,balls:Int) -> Int{
        let split = haoMa.components(separatedBy: "_")
        for s in split{
            if s.count != balls{
                return 0
            }
            let i = Int32(s)
            if Decimal(i!) > pow(10, balls) || i! < 0{
                return 0
            }
        }
        return split.count
    }
    
    static func lotteryYmBdwd(haoMa:String,balls:Int) -> Int{
        let split = haoMa.components(separatedBy: "|")
        if split.count >= 1{
            for s in split{
                let i = Int(s)!
                if i > 9 || i < 0{
                    return 0
                }
            }
        }
        return split.count
    }
    
    static func lotteryEmHz(haoMa:String,balls:Int,str:[String]) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count >= balls{
            for s in split{
                if isEmptyString(str: s){
                    return 0
                }
                var i = Int(s)!
                if str.count == 17{
                    if i > 17 || i < 1{
                        return 0
                    }
                    i = i - 1
                }
                if str.count == 19 && (i > 18 || i < 0){
                    return 0
                }
                zs += Int(str[i])!
            }
        }
        return zs
    }
    
    static func lotteryQsz(haoMa:String,balls:Int,flag:Bool) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count >= balls{
            for str in split{
                let i = Int(str)!
                if i > 9 || i < 0 {
                    return 0
                }
            }
        }
        zs = factorialResult(one: split.count, two: balls)
        print("zs ==== ",zs);
        if flag{
            zs *= 2
        }
        return zs
    }
    
    static func lotteryThreeHz(haoMa:String,balls:Int,str:[String]) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count >= balls{
            for s in split{
                if isEmptyString(str: s){
                    return 0
                }
                var i = Int(s)!
                if str.count == 28 && (i > 27 || i < 0){
                    return 0
                }
                if str.count == 26{
                    if i > 26 || i < 1{
                        return 0
                    }
                    i = i - 1
                }
                zs += Int(str[i])!
            }
        }
        return zs
    }
    
    static func lotteryWz30(haoMa:String,balls:Int,one:Int,two:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count == balls{
            
            var twoHms:[String] = []
            var oneHms:[String] = []
            var strP:[String] = []
            var reNum = 0
            for sp in split{
                if isEmptyString(str: sp){
                    return 0
                }
                strP = strP + sp.components(separatedBy: ",")
                for oHms in strP{
                    let i = Int(oHms)!
                    if i > 9 || i < 0 {
                        return 0
                    }
                }
            }
            oneHms = oneHms + split[0].components(separatedBy: ",")
            twoHms = twoHms + split[1].components(separatedBy: ",")
            if oneHms.count < one{
                return 0
            }
            if twoHms.count < two{
                return 0
            }
            for o in twoHms{
                if MyTool.binarySearch(array: oneHms, target: o){
                    reNum += 1//// 计算重号个数。
                }
            }
            zs = factorialResult(one: oneHms.count, two: one)
            zs *= twoHms.count - reNum// 先计算不重号的注数
            zs = zs + reNum * factorialResult(one: oneHms.count - 1, two: one)
        }
        return zs
    }
    
    static func lotteryWz60(haoMa:String,balls:Int,one:Int,two:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count == balls{
            
            var twoHms:[String] = []
            var oneHms:[String] = []
            var strP:[String] = []
            var reNum = 0
            for sp in split{
                if isEmptyString(str: sp){
                    return 0
                }
                strP = strP + sp.components(separatedBy: ",")
                for oHms in strP{
                    let i = Int(oHms)!
                    if i > 9 || i < 0 {
                        return 0
                    }
                }
            }
            oneHms = oneHms + split[0].components(separatedBy: ",")
            twoHms = twoHms + split[1].components(separatedBy: ",")
            if oneHms.count < one{
                return 0
            }
            if twoHms.count < two{
                return 0
            }
            for o in oneHms{
                if MyTool.binarySearch(array: twoHms, target: o){
                    reNum += 1//// 计算重号个数。
                }
            }
            zs = factorialResult(one: twoHms.count, two: two)
            zs *= oneHms.count - reNum// 先计算不重号的注数
            zs = zs + reNum * factorialResult(one: twoHms.count - 1, two: two)
        }
        return zs
    }
    
    static func lotteryWz120(haoMa:String,balls:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count >= balls{
            for sss in split{
                if isEmptyString(str: sss){
                    return 0
                }
                let i = Int(sss)!
                if i > 9 || i < 0 {
                    return 0
                }
            }
            zs = factorialResult(one: split.count, two: balls)
        }
        return zs
    }
    
    private static func factorialResult(one:Int,two:Int) -> Int{
        return factorialFunc(i: one) / (factorialFunc(i: two) * factorialFunc(i: one - two))
    }
    
    /**
     * 阶乘
     */
    private static func factorialFunc(i:Int) -> Int{
        var e = 1
        var ii = i
        while ii > 0 {
            e *= ii
            ii -= 1
        }
        return e
    }
    
    static func lotteryZuHe(haoMa:String,balls:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count == balls{
            zs = balls
            var hms:[String] = []
            for sss in split{
                if isEmptyString(str: sss){
                    return 0
                }
                hms = sss.components(separatedBy: ",")
                for hm in hms{
                    let i = Int(hm)!
                    if i > 9 || i < 0 {
                        return 0
                    }
                }
                zs = zs * hms.count
            }
        }
        return zs
    }
    
    static func dwd(haoMa:String) -> Int{
        let hms = haoMa.components(separatedBy: "|")
        for hm in hms{
            let i = Int(hm)!
            if i > 9 || i < 0 {
                return 0
            }
        }
        return hms.count
    }
    
    static func lotteryDxds(haoMa:String,balls:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count == balls{
            zs = 1
            var hms:[String] = []
            for sss in split{
                if isEmptyString(str: sss){
                    return 0
                }
                hms = sss.components(separatedBy: ",")
                let regex = "^[大|小|单|双]$"// 验证投注号码
                for hm in hms{
                    let isMatch = isMatchRegex(text: hm, regex: regex)
                    if !isMatch{
                        return 0
                    }
                }
                zs = zs * hms.count
            }
        }
        return zs
    }
    
    
    /**
     * 一位只要一个号码
     *
     * @param haoMa
     * @param balls
     * @return
     */
    static func one09Nums(haoMa:String,balls:Int) -> Int{
        var zs = 0
        let split = haoMa.components(separatedBy: "|")
        if split.count == balls{
            zs = 1
            var hms:[String] = []
            for sss in split{
                if isEmptyString(str: sss){
                    return 0
                }
                hms = sss.components(separatedBy: ",")
                for hm in hms{
                    let i = Int(hm)!
                    if i > 9 || i < 0 {
                        return 0
                    }
                }
                zs = zs * hms.count
            }
        }
        return zs
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
