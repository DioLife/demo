//
//  PeilvZhushuCalculator.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/15.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

//赔率版注数计算
class PeilvZhushuCalculator {

    public static func buyZhuShuValidate(haoMa:String,minSelected:Int,playCode:String) -> Int{
        let selectedLen = haoMa.components(separatedBy: ",").count
        if selectedLen == 0 {
            //下注信息错误。号码存储失败
            return 0
        }
        var a = 1
        var b = 1
        switch playCode {
        case xuanerlianzhi,xuansanqianzhi:
            var j = selectedLen
            while(j > selectedLen - minSelected){
                b = b*j
                j = j - 1
            }
            return b
        case syx5_zhixuan_houer,syx5_zhixuan_qianer,syx5_zhixuan_qiansan,syx5_zhixuan_zhongsan,syx5_zhixuan_housan:
            return 1
        default:
            var j = selectedLen
            while(j > minSelected){
                b = b*j
                j = j - 1
            }
            // 最大注数计算根据公式(C(6,3)=6*5*4/(3*2*1))
            var i = 1
            while i <= selectedLen - minSelected{
                a = a * i
                i = i + 1
            }
            return b/a
        }
    }
    
}
