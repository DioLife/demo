//
//  ZhuxuanLogic.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ZhuxuanLogic {

    
    /**
     * 根据玩法赔率名称模糊获取其中一个赔率项
     * @param oddName
     * @param results
     * @return
     */
    static func findPeilvByOddName(oddName:String,results:[PeilvWebResult]) -> PeilvWebResult?{
        for result in results{
            if result.numName.contains(oddName){
                return result
            }
        }
        return PeilvWebResult()
    }
    
    /**
     * 根据玩法赔率名称模糊获取其中一个赔率项---针对快三和值
     * @param oddName
     * @param results
     * @return
     */
    static func findPeilvByOddNameForKuai3Hz(oddName:String,results:[PeilvWebResult]) -> PeilvWebResult?{
        for result in results{
            if oddName.count > 1{
                if result.numName.contains(oddName){
                    return result
                }
            }else{
                if result.numName.starts(with: oddName){
                    return result
                }
            }
        }
        return PeilvWebResult()
    }
    
    /**
     *
     * @param weiNums 生成组选订单
     * @param n 选几行
     * @param results 赔率列表
     * @return
     */
    static func getZhuxuanOrder(weiNums:[String],orderNumber:String,n:Int,results:[PeilvWebResult],lotType:Int,playCode:String,rateback:Float,mode:Int,beishu:Int) -> [OfficialOrder]{
        
        if weiNums.isEmpty{
            return []
        }
        let loop = n;
        var arr = Array<String>(repeating: "", count: weiNums.count)
        for i in 0...weiNums.count - 1{
            arr[i] = weiNums[i]
        }
        var comboResult:[String] = []
        combination(ia: arr, n: loop, results: &comboResult,format:"")
        
        var orders = [OfficialOrder]()
        for result in comboResult{
            
            let order = OfficialOrder()
            order.c = orderNumber
            var zhushu = 0
            if !isEmptyString(str: orderNumber){
                zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: orderNumber, maxHaoMaNum: 0)
            }
            order.n = zhushu
            order.k = rateback
            order.m = mode
            order.t = beishu
            let money = (zhushu * beishu * 2)/mode
            order.a = Float(money)
            if !results.isEmpty{
                let pw = ZhuxuanLogic.findPeilvByOddName(oddName: result, results: results)
                order.i = pw != nil ? (pw?.code)! : ""
                order.oddName = pw != nil ? (pw?.numName)! : ""
            }
            orders.append(order)
        }
        return orders
    }
    
    /**
     *
     * @param weiNums 所有选择的行的号码列表
     * @param n 选几行
     * @param results 赔率列表
     * @return
     */
    static func getOrder(weiNums:[String],n:Int,results:[PeilvWebResult],lotType:Int,playCode:String,rateback:Float,mode:Int,beishu:Int) -> [OfficialOrder]{
        
        if weiNums.isEmpty{
            return []
        }
        let loop = n;
        var arr = Array<String>(repeating: "", count: weiNums.count)
        for i in 0...weiNums.count - 1{
            arr[i] = weiNums[i]
        }
        var comboResult:[String] = []
        combination(ia: arr, n: loop, results: &comboResult)
        
        var orders = [OfficialOrder]()
        for result in comboResult{
            var keys = ""
            var nums = ""
            let keyValue:[String] = result.components(separatedBy: "|");
            for kv in keyValue{
                let ws:[String] = kv.components(separatedBy: "@")
                if ws.count == 2{
                    keys += ws[0]
                    nums += ws[1]
                    nums += "|"
                }
            }
            if nums.hasSuffix("|"){
                nums = (nums as NSString).substring(to: nums.count - 1)
            }
            let order = OfficialOrder()
            order.c = nums
            let zhushu = ZhuShuCalculator.calc(lotType: lotType, playCode: playCode, haoMa: nums, maxHaoMaNum: 0)
//            if zhushu > 0{
                order.n = zhushu
                order.k = rateback
                order.m = mode
                order.t = beishu
                let money = (zhushu * beishu * 2)/mode
                order.a = Float(money)
                if !results.isEmpty{
                    let pw = ZhuxuanLogic.findPeilvByOddName(oddName: keys, results: results)
                    order.i = pw != nil ? (pw?.code)! : ""
                    order.oddName = pw != nil ? (pw?.numName)! : ""
                }
                orders.append(order)
//            }
        }
        return orders
    }
    
    public static func combination(ia:[String],n:Int,results: inout [String]) -> Void{
        combination(s: "", ia: ia, n: n, results: &results, format: "|")
    }
    
    public static func combination(ia:[String],n:Int,results: inout [String],format:String) -> Void{
        combination(s: "", ia: ia, n: n, results: &results, format: format)
    }
    
    
    /**
     * 计算组合结果
     * @param s
     * @param ia 源数据
     * @param n 组合次数
     * @param format 号码分隔符格式
     * @param results
     */
    public static func combination(s:String,ia:[String],n:Int, results:inout [String],format:String) -> Void{
        
        if n == 1{
            for i in 0...ia.count - 1{
                results.append(s + ia[i])
            }
        }else {
            if (ia.count - (n - 1)) > 0{
                for i in 0...(ia.count - (n - 1) - 1){
                    var ss = ""
                    ss = s + ia[i] + format
                    //建立从i开始的子数组
                    var ii = Array<String>(repeating: "", count: ia.count - i - 1)
                    for j in 0...(ia.count - i - 1 - 1){
                        ii[j] = ia[i+j+1]
                    }
                    combination(s: ss, ia: ii, n: n-1, results: &results, format: format)
                }
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
