//
//  LotteryPlayLogic.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/26.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class LotteryPlayLogic {
    
    static func getWeishuRandomCount(version:String,cpCode:String,pcode:String,rcode:String)->[String]{
        if version == "1" || version == "3"{
            if rcode == rxwf_r3zux_zu3 || rcode == rxwf_r3zux_zu6{
                return randomNumbers(numStr: WEISHU_STR, allowRepeat: false, numCount: 3, format: ",")
            }
        }
        return []
    }
    
    static func randomNumbers(numStr:String,allowRepeat:Bool,numCount:Int,format:String) -> [String]{
        var results = numStr.components(separatedBy: format)
        if results.isEmpty{
            return []
        }
        let maxNum = results.count
        var i:Int = 0
        var count:Int = 0
        var numbers = [String]()
        while count < numCount {
            i = Int(arc4random() % UInt32(maxNum)) + 1
            if !allowRepeat{
                if i == maxNum{
                    i = i-1
                }
                if numbers.contains(results[i]){
                    continue
                }
            }
            numbers.append(results[i])
            count = count + 1
        }
        results.removeAll()
        print("random numbers = \(numbers)")
        return numbers
        
    }
    
    static func randomLines(lines:Int,numCount:Int,allRepeat:Bool) -> [Int]{
        let maxNum = lines
        var i:Int = 0
        var count:Int = 0
        var numbers = [Int]()
        while count < numCount {
            i = Int(arc4random() % UInt32((maxNum))) + 1
            if !allRepeat{
                if i == maxNum{
                    i = i-1
                }
                if numbers.contains(i){
                    continue
                }
            }
            numbers.append(i)
            count = count + 1
        }
        print("random numbers = \(numbers)")
        return numbers
    }
    
    static func showCoolMissingPlays(playCode:String) -> Bool{
        let datas = ["wxzh","wxfs","qszh","qsfs","hsfs","hszh","hsanfs","qsanfs","zsfs",
                     "qefs","hefsz","dwd","cgj2","cqerfs","cqsanfs","cqsifs","cqwufs","dwd2","ermaqerzhixfs",
                     "ermaqerzhixfs"]
        if datas.contains(playCode){
            return true
        }
        return false
    }

}
