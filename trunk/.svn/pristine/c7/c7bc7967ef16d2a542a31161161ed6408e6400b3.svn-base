//
//  PeilvLogic.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/10.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class PeilvLogic {
    
    static let redBo = ["01", "02", "07", "08", "12", "13", "18", "19", "23",
    "24", "29", "30", "34", "35", "40", "45", "46"];
    static let blueBo = ["03", "04", "09", "10", "14", "15", "20", "25", "26",
    "31", "36", "37", "41", "42", "47", "48"];
    static let greenBo = ["05", "06", "11", "16", "17", "21", "22", "27", "28", "32", "33",
    "38", "39", "43", "44", "49"];

    
    /**
     * 将小玩法对应的所有号码赔率项插入小玩法对象中
     * @param selectPlay
     * @param odds
     */
    static func insertOddsToPlayDatas(selectPlay:inout BcLotteryPlay?,odds:[HonestResult]) -> Void{
        if selectPlay == nil{
            return
        }
        if !odds.isEmpty{
            for subPlay in (selectPlay?.children)!{
                for result in odds{
                    if subPlay.code == result.code{
                        subPlay.peilvs.removeAll()
                        subPlay.peilvs = subPlay.peilvs + filterSameOdds(list: result.odds)
                        break;
                    }
                }
            }
        }
    }
    
    
    //将重复赔率项号码去重
    static func filterSameOdds(list:[PeilvWebResult]) -> [PeilvWebResult]{
        if list.isEmpty{
            return list
        }
        var result:PeilvWebResult?
        var reals:[PeilvWebResult] = []
        for r in list{
            if result == nil{
                result = r
                reals.append(result!)
            }else{
                if r.numName != result?.numName{
                    result = r
                    reals.append(result!)
                }else{
                    reals[reals.count - 1].secondMaxOdds = r.maxOdds
                    reals[reals.count - 1].secondMinodds = r.minOdds
                }
            }
        }
        return reals
    }
    
    //获取特肖的辅助号码
    static func findtxNumbers(oddName:String) -> [String]{
        let nums = getNumbersFromShenXiaoName(sx: oddName)
        return nums
    }
    
    //获取尾数的辅助号码
    static func findwsNumbers(oddName:String) -> [String]{
        var nums = [String]()
        if isEmptyString(str: oddName){
            return []
        }
        if oddName.count < 2{
            return []
        }
        let r = (oddName as NSString).substring(to:1)
        for red in redBo{
            if red.hasSuffix(r){
                nums.append(red)
            }
        }
        
        for green in greenBo{
            if green.hasSuffix(r){
                nums.append(green)
            }
        }
        
        for blue in blueBo{
            if blue.hasSuffix(r){
                nums.append(blue)
            }
        }
        return nums
    }
    
    public static func selectRandomPeilvDatas(selectPlay:[BcLotteryPlay],randomOrderCount:Int,
                                               minPeilvCount:Int) -> [PeilvWebResult]{
        
        if selectPlay.isEmpty{
            return []
        }
        let gridPoss = randomNumbers(totalSize: selectPlay.count, allowRepeat: false, numCount: 1)
        if gridPoss.isEmpty{
            return []
        }
        let pos = gridPoss[0]
        let play = selectPlay[pos]
        
        var results = [PeilvWebResult]()
        //取随机几行
        if selectPlay.count == 1{
            let peilvs = play.peilvs
            if randomOrderCount < peilvs.count{
                let pos = randomNumbers(totalSize: peilvs.count, allowRepeat: false, numCount: minPeilvCount)
                for j in 0...pos.count-1{
                    let result = peilvs[pos[j]]
                    result.itemName = play.name
                    results.append(result)
                }
            }
        }else{
            for _ in 0...randomOrderCount-1{
                if !play.peilvs.isEmpty{
                    let listPoss = randomNumbers(totalSize: play.peilvs.count, allowRepeat: false, numCount: minPeilvCount)
                    if !listPoss.isEmpty{
                        for k in 0...listPoss.count - 1{
                            let result = play.peilvs[listPoss[k]]
                            result.itemName = play.name
                            results.append(result)
                        }
                    }
                }
            }
        }
        return results
    }
    
    public static func randomNumbers(totalSize:Int,allowRepeat:Bool,numCount:Int) -> [Int]{
        if totalSize == 0{
            return []
        }
        var i = 0
        var count = 0
        var numbers = [Int]()
        while count < numCount {
            i = Int(arc4random() % UInt32(totalSize))
            if !allowRepeat{
                if numbers.contains(i){
                    continue
                }
            }
            numbers.append(i)
            count += 1
        }
        return numbers
    }
    
    
    
}
