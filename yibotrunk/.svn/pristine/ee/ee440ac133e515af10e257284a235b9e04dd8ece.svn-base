//
//  LotteryPlayLogic.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/26.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class LotteryPlayLogic {
    
    /**
     * 根据用户投注好的球数据来计算投注的号码，号码是按规定的格式生成
     * @param listBeenSelected 用户投注选择好的球数据
     * @param playCode 大玩法代号
     * @param subPlayCode 小玩法代号
     * @return
     */
    
    static func figureOutNumbersAfterUserSelected(listBeenSelected:[BallonRules]?,playCode:String,subPlayCode:String)->String{
        if isEmptyString(str: subPlayCode){
            return ""
        }
        if listBeenSelected == nil || listBeenSelected?.count == 0{
            return ""
        }
        if let selectedData = listBeenSelected{
            //line 投注池行数，若只有一行，则在拼接投注号码时，加逗号
            let line = selectedData.count;
            //某些玩法不需要用逗号分隔的
            let noNeedComma = playCode == dxds || playCode == caibaozi || playCode == longhh ||
            playCode == q1_str || playCode == q2_str || playCode == qiansan ||
            (playCode == hz && subPlayCode == dxds) ||
            subPlayCode == longhu_gunjun || subPlayCode == longhu_jijun || subPlayCode == longhu_yajun ||
            (playCode == gyh && subPlayCode == dxds)
            //是否需要我使用横杆占位空号码
            let needHengan = playCode == dwd || playCode == rxwf
            //是否需要使用@符号来对有带位数选择的玩法进行投注号码和位数分隔
            let needAtFlag = subPlayCode == rxwf_r3zux_zu3 || subPlayCode == rxwf_r3zux_zu6
            //是否使用备选投注号码
            let needSelectSecondHaomao = playCode == caibaozi || subPlayCode == sthtx ||
            subPlayCode == slhtx
            
            var numstr = ""
            
            for info in selectedData{
                var num = ""
                if info.showWeiShuView{
                    let weishuInfo = info.weishuInfo
                    if let weishu = weishuInfo{
                        for bi in weishu{
                            if bi.isSelected{
                                num = num + bi.num + ","
                            }
                        }
                    }
                }
                
                
//                let startIndex = num.index(num.endIndex, offsetBy:-1)
//                print("\(num.substring(from: startIndex))")
                print("before remove = \(num)")
                if (needAtFlag && num.hasSuffix(",")){
                    num.remove(at: num.index(before:num.endIndex))
                    print("after remove = \(num)")
                    num = num + "@"
                }
                
                let ballonsInfo = info.ballonsInfo
                if let ballValues = ballonsInfo{
                    for ball in ballValues{
                        if ball.isSelected{
                            num = num + (needSelectSecondHaomao ? ball.postNum : ball.num)
                            //处理不同玩法下是否拼接逗号
                            if (noNeedComma) {
                                continue;
                            }
                            if (line == 1) {
                                num = num + ","
                            }
                        }
                    }
                }
                
                if (!num.isEmpty && num.hasSuffix(",")){
                    num.remove(at: num.index(before:num.endIndex))
                }
                
                if (isEmptyString(str: num) && needHengan){
                    numstr = numstr + "-" + ","
                }else{
                    if !isEmptyString(str: num){//若没有内容，则不追加","
                        numstr = numstr + num + ","
                    }
                }
            }
            
            if numstr.hasSuffix(","){
                let index = numstr.index(numstr.endIndex, offsetBy:-1)
                numstr = numstr.substring(to: index)
            }
            
            if isEmptyString(str: numstr){
                return ""
            }
            
            print("the figure out touzhu haomao = \(numstr)")
            return numstr
        }
        return ""
    }
    
    /**
     * 随机选择的投注球
     * @param version
     * @param cpCode
     * @param pcode
     * @param rcode
     * @return
     */
    static func selectRandomDatas(cpVersion:String,czCode:String,playCode:String,subCode:String) -> [BallonRules] {
        let datas = figureOutPlayInfo(cpVersion: cpVersion, cpCode: czCode, playCode: playCode, ruleCode: subCode)
        for br in datas{
            let ballListItemInfos = convertNumListToEntifyList(numStr: br.nums, postNums: br.postNums)
            br.ballonsInfo = ballListItemInfos
        }
        if datas.isEmpty{
            return datas
        }
        //随机选择的号码数
        var randomBallonCount = 0;
        let constants = Lotterys.getLotterysByVersion(versionNum: cpVersion)
        if let lotterys = constants.lotterys{
            for ld in lotterys{
                if ld.czCode == czCode{
                    let rules = ld.rules
                    if let rulesValue = rules{
                        for pitem in rulesValue{
                            if pitem.code == playCode{
                                let subRules = pitem.rules
                                for sitem in subRules{
                                    if sitem.code == subCode{
                                        randomBallonCount = sitem.randomCount
                                        break
                                    }
                                }
                                break
                            }
                        }
                    }
                    break
                }
            }
        }

        print("the random count = \(randomBallonCount),in pcode = \(playCode),rcode = \(subCode)")
        var randomBallonPerLine = randomBallonCount
        let lines = datas.count
        var randomLineIndexs:[Int]?;//随机选择时的随机行数索引
        
        if randomBallonCount == lines{
            randomBallonPerLine = 1
        }else if lines == 1{
            randomBallonPerLine = randomBallonCount;
        }else if lines > randomBallonCount{
            randomLineIndexs = randomLines(lines: lines, numCount: randomBallonCount, allRepeat: false)
            randomBallonPerLine = 1;
        }
        //遍历投注球列表
        for index in 0...datas.count-1{
            let ballon = datas[index]
            let nums = ballon.nums
            if let randomLineIndexValue = randomLineIndexs{
                if !randomLineIndexValue.isEmpty{
                    if randomLineIndexValue.contains(index){
                        let randomNums = randomNumbers(numStr: nums!, allowRepeat: false, numCount: randomBallonPerLine, format: ",")
                        selectBallonByRandomNumbers(randomNums: randomNums, ballon: ballon, version: cpVersion, cpCode: czCode, pcode: playCode, rcode: subCode)
                    }
                }else{
                    let randomNums = randomNumbers(numStr: nums!, allowRepeat: false, numCount: randomBallonPerLine, format: ",")
                    selectBallonByRandomNumbers(randomNums: randomNums, ballon: ballon, version: cpVersion, cpCode: czCode, pcode: playCode, rcode: subCode)
                }
            }else{
                let randomNums = randomNumbers(numStr: nums!, allowRepeat: false, numCount: randomBallonPerLine, format: ",")
                selectBallonByRandomNumbers(randomNums: randomNums, ballon: ballon, version: cpVersion, cpCode: czCode, pcode: playCode, rcode: subCode)
            }
            
        }
        return datas
    }
    
    static func selectBallonByRandomNumbers(randomNums:[String],ballon:BallonRules,version:String,cpCode:String,pcode:String,rcode:String)->Void{
        //随机选择球并重新将选择好的球信息更新到ballon中
        if !randomNums.isEmpty{
            var replaces = [BallListItemInfo]()
            var binfos = ballon.ballonsInfo
            for info in binfos!{
                for number in randomNums{
                    if info.num == number{
                        info.isSelected = true
                        info.clickOn = true
                        break
                    }
                }
                replaces.append(info)
            }
            binfos?.removeAll()
            ballon.ballonsInfo = replaces
        }
        
        //是否需要随机选择定位位数球
        if ballon.showWeiShuView{
            //随机选择定位球，并重新将选择好的球信息更新到ballon中
            var weishuData = [BallListItemInfo]()
            var weishuList = ballon.weishuInfo
            let weishu = getWeishuRandomCount(version: version, cpCode: cpCode, pcode: pcode, rcode: rcode)
            for info in weishuList!{
                for number in weishu{
                    if info.num == number{
                        info.isSelected = true
                        break
                    }
                }
                weishuData.append(info)
            }
            weishuList?.removeAll()
            weishuList = weishuList! + weishuData
            ballon.weishuInfo = weishuList
        }
    }
    
    
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

}
