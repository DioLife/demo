//
//  JianjinLotteryLogic.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/7.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class JianjinLotteryLogic {

    static func calcWxfs(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules = ["万位","千位","百位","十位","个位"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    static func calcWxzx(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        var rules:[String] = []
        if subCode == "wz5"{
            rules.append("四重号")
            rules.append("单号")
        }else if subCode == "wz10"{
            rules.append("三重号")
            rules.append("二重号")
        }else if subCode == "wz20"{
            rules.append("三重号")
            rules.append("单号")
        }else if (subCode == "wz30" || subCode == "wz60"){
            rules.append("二重号")
            rules.append("单号")
        }else if subCode == "wz120"{
            rules.append("组选120")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //前四直选
    static func calcQszx(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules = ["万位","千位","百位","十位"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //后四直选
    static func calcHszx(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules = ["千位","百位","十位","个位"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //前四组选
    static func calcQszhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        var rules:[String] = []
        if subCode == "qsz4"{
            rules.append("三重号")
            rules.append("单号")
        }else if subCode == "qsz6"{
            rules.append("二重号")
        }else if subCode == "qsz12"{
            rules.append("二重号")
            rules.append("单号")
        }else if subCode == "qsz24"{
            rules.append("组选24")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //后四组选
    static func calcHszhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        var rules:[String] = []
        if subCode == "hsz4"{
            rules.append("三重号")
            rules.append("单号")
        }else if subCode == "hsz6"{
            rules.append("二重号")
        }else if subCode == "hsz12"{
            rules.append("二重号")
            rules.append("单号")
        }else if subCode == "hsz24"{
            rules.append("组选24")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //后三直选
    static func calcHsanzx(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        
        if subCode == "hsanfs"{
            let rules:[String] = ["百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "hsanhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "直选和值";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //后三组选
    static func calcHsanzhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "hsanhez"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选和值";
            ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "hsanzu6"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组六";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "hsanzu3"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组三";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //前三直选
    static func calcQsanzx(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        
        if subCode == "qsanfs"{
            let rules:[String] = ["万位", "千位", "百位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "qsanhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "前三直选和值";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //前三组选
    static func calcQsanzhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "qsanhez"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选和值";
            ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "qsanzu6"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组六";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "qsanzu3"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组三";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //中三直选
    static func calcZsanzx(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        
        if subCode == "zsfs"{
            let rules:[String] = ["千位", "百位", "十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "zshz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "中三直选和值";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //中三组选
    static func calcZsanzhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "zshez"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选和值";
            ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "zszu6"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组六";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "zszu3"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组三";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //二星直选
    static func calcEXZX(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "hehz" || subCode == "qehz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "和值";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "qefs"{
            let rules:[String] = ["万位", "千位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "hefs"{
            let rules:[String] = ["十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    
    //二星组选
    static func calcEXZUX(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "hehzz" || subCode == "qehzz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "和值";
            ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "qefsz" || subCode == "hefsz"{
            let rules:[String] = ["组选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    
    //定位胆
    static func calcDWD(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "dwd" {
            let rules = ["万位", "千位", "百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //calcBDWD不定位胆
    static func calcBDWD(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "dwd" {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "不定胆";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //大小单双
    static func calcDXDS(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        var rules:[String] = []
        if subCode == "qedxds"{
            rules.append("万位")
            rules.append("千位")
        }else if subCode == "hedxds"{
            rules.append("十位")
            rules.append("个位")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "大,小,单,双";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //趣味
    static func calcQuwei(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        var rules:[String] = []
        if subCode == "yffs"{
            rules.append("一帆风顺")
        }else if subCode == "hscs"{
            rules.append("好事成双")
        }else if subCode == "sxbx"{
            rules.append("三星报喜")
        }else if subCode == "sjfc"{
            rules.append("四季发财")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //任二直选
    static func calcREZX(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "rezhixhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "和值";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = true;
            ballonRules.ruleCode = subCode;
            ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            list.append(ballonRules)
        }else if subCode == "rezhixfs"{
            let rules:[String] = ["万位", "千位", "百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //任二组选
    static func calcREZUX(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "rezuxhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = true;
            ballonRules.ruleCode = subCode;
            ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            list.append(ballonRules)
        }else if subCode == "rezuxfs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = true;
            ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    
    //任三直选
    static func calcRsanzhix(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "rszhixhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "直选和值";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = true;
            ballonRules.ruleCode = subCode;
            ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            list.append(ballonRules)
        }else if subCode == "rszhixfs"{
            let rules:[String] = ["万位", "千位", "百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //任三组选
    static func calcRensanzhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "rszuxhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选和值";
            ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = true;
            ballonRules.ruleCode = subCode;
            ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            list.append(ballonRules)
        }else if (subCode == "rszuxl" || subCode == "rszuxs"){
            let ballonRules = BallonRules();
            if subCode == "rszuxl"{
                ballonRules.ruleTxt = "组六"
            }else{
                ballonRules.ruleTxt = "组三"
            }
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = true;
            ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    
    //任四直选
    static func calcRshizhix(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "rsizhixfs"{
            let rules:[String] = ["万位", "千位", "百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    /**
     * 计算码不定位
     * @param rcode
     * @return
     */
    static func calcMbdwd(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "hsymbdwd"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "后三一码不定位";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if (subCode == "qsymbdwd"){
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "前三一码不定位";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if (subCode == "hsembdwd"){
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "后三二码不定位";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if (subCode == "qsembdwd"){
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "前三二码不定位";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //任四组选
    static func calcRenshizhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "zux4"{
            let rules:[String] = ["三重号", "单号"]
            for index in 0...rules.count-1{
                let rule = rules[index]
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                if index == 0{
                    ballonRules.showWeiShuView = true;
                    ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
                }else{
                    ballonRules.showWeiShuView = false;
                }
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if (subCode == "zux6"){
            let rules:[String] = ["二重号"]
            for index in 0...rules.count-1{
                let rule = rules[index]
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = true;
                ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if (subCode == "zux12"){
            let rules:[String] = ["二重号","单号"]
            for index in 0...rules.count-1{
                let rule = rules[index]
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = true;
                ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if (subCode == "zux24"){
            let rules:[String] = ["单号"]
            for index in 0...rules.count-1{
                let rule = rules[index]
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = true;
                ballonRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //猜冠军
    static func calcCaiGuangjun(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let ballonRules = BallonRules();
        ballonRules.ruleTxt = "猜冠军";
        ballonRules.nums = "01,02,03,04,05,06,07,08,09,10";
        ballonRules.showFuncView = true;
        ballonRules.showWeiShuView = false;
        ballonRules.ruleCode = subCode;
        list.append(ballonRules)
        return list;
    }
    
    //猜前二
    static func calcCaiQuaner(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules:[String] = ["冠军", "亚军"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //猜前三
    static func calcCaiQuansan(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules:[String] = ["冠军", "亚军", "季军"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //猜前shi
    static func calcCaiQuanshi(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules:[String] = ["第一", "第二", "第三", "第四"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //猜前五
    static func calcCaiQuanwu(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules:[String] = ["第一", "第二", "第三", "第四", "第五"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //PK拾--定位胆
    static func calcPK10DWD(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules:[String] = ["第一", "第二", "第三", "第四", "第五", "第六", "第七", "第八", "第九", "第十"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //二同号
    static func calcErtonghao(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "k3ethfx"{
            let rules:[String] = ["二同复选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "11,22,33,44,55,66";
                ballonRules.showFuncView = false;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                ballonRules.special = true
                list.append(ballonRules)
            }
        }else if subCode == "k3ethdx"{
            
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "同号";
            ballonRules.nums = "11,22,33,44,55,66";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            ballonRules.special = true
            list.append(ballonRules)
            
            let ballonRules2 = BallonRules();
            ballonRules2.ruleTxt = "不同号";
            ballonRules2.nums = "1,2,3,4,5,6";
            ballonRules2.showFuncView = false;
            ballonRules2.showWeiShuView = false;
            ballonRules2.ruleCode = subCode;
            ballonRules2.special = true
            list.append(ballonRules2)
            
        }
        
        return list;
    }
    
    //三同号
    static func calcSantonghao(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "k3sthfx"{
            let rules:[String] = ["三同复选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "三同号通选";
                ballonRules.showFuncView = false;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                ballonRules.special = true
                list.append(ballonRules)
            }
        }else if subCode == "k3sthdx"{
            
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "三同单选";
            ballonRules.nums = "111,222,333,444,555,666";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            ballonRules.special = true
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //快三-和值
    static func calcTonghaoHz(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "k3hz2"{
            let rules:[String] = ["和值"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                ballonRules.special = true
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //快三-三连号
    static func calcSanlianhao(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "k3slh2"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "三连号";
            ballonRules.nums = "三连号通选";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            ballonRules.special = true
            list.append(ballonRules)
        }
        return list;
    }
    
    //快三-不同号
    static func calcButonghao(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "k3ebth" || subCode == "k3sbth"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "标准";
            ballonRules.nums = "1,2,3,4,5,6";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            ballonRules.special = true
            list.append(ballonRules)
        }
        return list;
    }
    
    //11选5-三码
    static func calc115sanma(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "sanmaqszuxfs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10,11";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "sanmaqszhixfs"{
            let rules:[String] = ["第一位", "第二位", "第三位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //11选5-二码
    static func calc115erma(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "ermaqezuxfs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10,11";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "ermaqezhixfs"{
            let rules:[String] = ["第一位", "第二位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    
    //11选5-不定位胆
    static func calc115bdwd(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "bdwd2"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "前三位";
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10,11";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //11选5-定位胆
    static func calc115dwd(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "dwd2"{
            let rules:[String] = ["第一位", "第二位", "第三位", "第四位", "第五位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //11选5-趣味型
    static func calc115quweixing(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "qwxczw"{
            let rules:[String] = ["猜中位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "03,04,05,06,07,08,09";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "qwxdds"{
            let rules:[String] = ["定单双"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "5单0双,4单1双,3单2双,2单3双,1单4双,0单5双";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.special = true
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //11选5-任选单式
    static func calc115Renxuands(subCode:String) ->[BallonRules]{
        return [];
    }
    
    
    //11选5-任选复式
    static func calc115Renxuanfs(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        
        var rules:[String] = []
        if subCode == "rxfsyzy"{
            rules.append("一中一")
        }else if subCode == "rxfseze"{
            rules.append("二中二")
        }else if subCode == "rxfsszsan"{
            rules.append("三中三")
        }else if subCode == "rxfsszsi"{
            rules.append("四中四")
        }else if subCode == "rxfslzw"{
            rules.append("六中五")
        }else if subCode == "rxfsqzw"{
            rules.append("七中五")
        }else if subCode == "rxfsbzw"{
            rules.append("八中五")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "01,02,03,04,05,06,07,08,09,10,11";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }

    //pc蛋蛋 -- 组选
    static func calcPCEEZhuxuan(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "sanmzuxhz"{
            let rules:[String] = ["组选和值"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "sanmzuxzl"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组六";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "sanmzuxzs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组三";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //pc蛋蛋 -- 直选
    static func calcPCEEZhixuan(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "sanmzhixhz"{
            let rules:[String] = ["直选和值"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27";
                ballonRules.showFuncView = false;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "sanmzhixfs"{
            let rules:[String] = ["百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //pc蛋蛋 -- 不定胆
    static func calcPCEEBDD(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let rules:[String] = ["不定胆"]
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //pc蛋蛋 -- 二码前二
    static func calcPCEEERMAqianer(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "ermaqerzhixfs"{
            let rules = ["百位", "十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "ermaqerzuxfs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        
        return list;
    }
    
    
    //pc蛋蛋 -- 二码后二
    static func calcPCEEERMAhouer(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "ermaherzhixfs"{
            let rules = ["十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }else if subCode == "ermaherzuxfs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //pc蛋蛋--定位胆
    static func calcPCEEDWD(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "dwd2"{
            let rules = ["百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //pc蛋蛋--大小单双
    static func calcPCEEDXDS(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        var rules:[String] = []
        if subCode == "dxdsqer"{
            rules.append("百位")
            rules.append("十位")
        }else if subCode == "dxdsher"{
            rules.append("十位")
            rules.append("个位")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "大,小,单,双";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    
    //低频彩-三码直选
    static func calcDpcSanmaZhix(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "sanmzhixhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "直选和值";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "sanmzhixfs"{
            let rules = ["百位", "十位", "个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //低频彩-三码组选
    static func calcDpcSanmaZhux(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "sanmzuxzs" || subCode == "sanmzuxzl"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = subCode == "sanmzuxzs" ? "组三" : "组六";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "sanmzuxhz"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选和值";
            ballonRules.nums = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    //低频彩-不定位
    static func calcDipincaiBdw(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let ballonRules = BallonRules();
        ballonRules.ruleTxt = "不定胆";
        ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
        ballonRules.showFuncView = true;
        ballonRules.showWeiShuView = false;
        ballonRules.ruleCode = subCode;
        list.append(ballonRules)
        return list;
    }
    
    //低频彩-二码前二
    static func calcDipincaiErmaqianer(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "ermaqerzuxfs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "ermaqerzhixfs"{
            let rules = ["百位", "十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //低频彩-二码后二
    static func calcDipincaiErmaHouer(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "ermaherzuxfs"{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组选";
            ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }else if subCode == "ermaherzhixfs"{
            let rules = ["十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //低频彩-定位胆
    static func calcDipanCaiDWD(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if subCode == "dwd2"{
            let rules = ["百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums = "0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.ruleCode = subCode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    //低频彩-大小单双
    static func calcDipincaiDXDS(subCode:String) ->[BallonRules]{
        var list = [BallonRules]();
        var rules:[String] = []
        if subCode == "dxdsqer"{
            rules.append("百位")
            rules.append("十位")
        }else if subCode == "dxdsher"{
            rules.append("十位")
            rules.append("个位")
        }
        for rule in rules{
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = rule;
            ballonRules.nums = "大,小,单,双";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.ruleCode = subCode;
            list.append(ballonRules)
        }
        return list;
    }
    
    /*
     奖金版随机下注时的注单构建
     @param orderCount 随机肌注
     @param cpcode 彩票类型号
     @param selectedSubCode 小玩法
     @param peilv 玩法对应的赔率
     */
    static func randomBet(orderCount:Int,cpCode:String,selectedSubCode:String,peilv:[PeilvWebResult]) ->[OfficialOrder]{
        var mDatas:[OfficialOrder] = []
        for _ in 0...orderCount-1{
            let orders = jianjinRandomBet(lotType: cpCode, subCode: selectedSubCode, peilvs: peilv)
            mDatas = mDatas + orders
        }
        return mDatas
    }
    
    /**
     * 奖金版随机下注接口
     * @param lotType 彩票类型
     * @param subCode 小玩法编码
     * @param peilvs 小玩法对应的赔率集
     * @return 注单集
     */
    private static func jianjinRandomBet(lotType:String,subCode:String,peilvs:[PeilvWebResult]) -> [OfficialOrder]{
        
        let balls = selectRandomDatas(lotType:lotType,subCode:subCode)
        let orders = LotteryOrderManager.calcOrders(list: balls, rcode: subCode, lotType: Int(lotType)!, rateback: 0, mode: 1, beishu: 1, oddsList: peilvs)
        return orders
    }
    
    /**
     * 随机选择的投注球
     * @param lotType
     * @param subCode
     * @return
     */
    private static func selectRandomDatas(lotType:String,subCode:String) -> [BallonRules]{
        if isEmptyString(str: subCode){
            return []
        }
        //根据彩票版本和玩法确定下注球列表数据
        let ballonRules = form_jianjing_pane_datasources(lotType: lotType, subCode: subCode)
        if ballonRules.isEmpty{
            return []
        }
        for br in ballonRules{
            let ballListItemInfos = convertNumListToEntifyList(numStr: br.nums, postNums: br.postNums)
            br.ballonsInfo = ballListItemInfos
        }
        
        //随机选择的号码数
        //根据玩法获取玩法机选一注要几个随机号码
        let randomBallonCount = getRandomCountFromSubCode(lotType: lotType, rcode: subCode)
        var randomBallonPerLine = randomBallonCount
        let lines = ballonRules.count
        var randomLineIndexs:[Int]!//随机选择时的随机行数索引
        
        //确定每行随机选择的号码数
        if lines == randomBallonCount{
            randomBallonPerLine = 1
        }else if lines == 1{
            randomBallonPerLine = randomBallonCount
        }else if lines > randomBallonCount{
            randomLineIndexs = randomLines(lines: lines, numCount: randomBallonCount, allowRepeat: false)
            randomBallonPerLine = 1
        }else if lines < randomBallonCount{
            randomBallonPerLine = randomBallonCount % lines == 0 ? randomBallonCount/lines : (randomBallonCount/lines+1)
        }
        //遍历投注球列表
        for i in 0...ballonRules.count-1{
            let ballon = ballonRules[i]
            let nums = ballon.nums
            if randomLineIndexs != nil && !randomLineIndexs.isEmpty{
                if randomLineIndexs.contains(i){
                    let randomNums = randomNumbers(numStr: nums!, allowRepeat: false, numCount: randomBallonPerLine, format: ",")
                    selectBallonByRandomNumbers(randomNums: randomNums, ballon: ballon, rcode: subCode)
                }
            }else{
                let randomNums = randomNumbers(numStr: nums!, allowRepeat: false, numCount: randomBallonPerLine, format: ",")
                selectBallonByRandomNumbers(randomNums: randomNums, ballon: ballon, rcode: subCode)
            }
        }
        return ballonRules
    }
    
    private static func selectBallonByRandomNumbers(randomNums:[String],ballon:BallonRules,rcode:String){
        //随机选择球并重新将选择好的球信息更新到ballon中
        if !randomNums.isEmpty{
            var replaces:[BallListItemInfo] = []
            var binfos = ballon.ballonsInfo
            for info in binfos!{
                for number in randomNums{
                    if info.num == number{
                        info.isSelected = true
                        info.clickOn = true
                        break;
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
            var weishuData:[BallListItemInfo] = []
            var weishuList:[BallListItemInfo] = ballon.weishuInfo
            let weishu = getWeishuRandomCount(rcode: rcode)
            for info in weishuList{
                for number in weishu{
                    if info.num == number{
                        info.isSelected = true
                        break;
                    }
                }
                weishuData.append(info)
            }
            weishuList.removeAll()
            weishuList = weishuList + weishuData
            ballon.weishuInfo = weishuList
        }
        
    }
    
    private static let WEISHU_STR = "万,千,百,十,个";
    
    private static func getWeishuRandomCount(rcode:String) -> [String]{
        return randomNumbers(numStr: WEISHU_STR, allowRepeat: false, numCount: 3, format: ",")
    }
    
    public static func randomLines(lines:Int,numCount:Int,allowRepeat:Bool) -> [Int]{
        var maxNum = lines
        var i = 0
        var count = 0
        var numbers = [Int]()
        while count < numCount {
            i = Int(arc4random() % UInt32(maxNum))
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
    
    private static func getRandomCountFromSubCode(lotType:String,rcode:String) -> Int{
        //时时彩,分分彩
        if lotType == "1" || lotType == "2"{
            //五星---------------------
            //五星直选
            if (rcode == "wxfs" || rcode == "wxzh") {
                if (rcode == "wxfs") {
                    return 5;
                }
            } else if (rcode == "wxds") {
                return 0;
            } else if (rcode == "wz5" || rcode == "wz10")
                || rcode == "wz20"
                || rcode == "wz30"
                || rcode == "wz60"
                || rcode == "wz120" {
                if (rcode == "wz5" || rcode == "wz10"){
                    return 2;
                }else if (rcode == "wz20") {
                    return 3;
                }else if (rcode == "wz30") {
                    return 4;
                }else if (rcode == "wz30" || rcode == "wz60") {
                    return 4;
                }else if (rcode == "wz120") {
                    return 5;
                }
            }
                //前四--------------------
                //前四直选
            else if (rcode == "qszh" || rcode == "qsfs" || rcode == "qsds") {
                if (rcode == "qsds") {
                    return 0;
                } else {
                    return 4;
                }
            }
                //前四组选
            else if (rcode == "qsz4" || rcode == "qsz6" ||
                rcode == "qsz12" || rcode == "qsz24") {
                if (rcode == "qsz4" || rcode == "qsz6") {
                    return 2;
                } else if (rcode == "qsz12") {
                    return 3;
                } else if (rcode == "qsz24") {
                    return 4;
                }
            }
                //后四--------------------
                //后四直选
            else if (rcode == "hszh" || rcode == "hsfs" || rcode == "hsds") {
                if (rcode == "hsds") {
                    return 0;
                } else {
                    return 4;
                }
            }
                //后四组选
            else if (rcode == "hsz4" || rcode == "hsz6") {
                return 2;
            } else if (rcode == "hsz12") {
                return 3;
            } else if (rcode == "hsz24") {
                return 4;
            }
                //后三码--------------------
                //后三直选
            else if (rcode == "hsanfs" || rcode == "hsands" || rcode == "hsanhz") {
                if (rcode == "hsands") {
                    return 0;
                }else if (rcode == "hsanfs") {
                    return 3;
                }else if (rcode == "hsanhz") {
                    return 1;
                }
            }
                //后三组选
            else if (rcode == "hsanzu3" || rcode == "hsanzu6" ||
                rcode == "hsanhzu" || rcode == "hsanhez") {
                if (rcode == "hsanhez") {
                    return 1;
                } else if (rcode == "hsanzu6") {
                    return 3;
                } else if (rcode == "hsanzu3") {
                    return 2;
                }else{
                    return 0;
                }
            }
                //前三码--------------------
                //前三直选
            else if (rcode == "qsanfs" || rcode == "qsands" || rcode == "qsanhz") {
                if (rcode == "qsands") {
                    return 0;
                }else if (rcode == "qsanfs") {
                    return 3;
                }else if (rcode == "qsanhz") {
                    return 1;
                }
            }
                //前三组选
            else if (rcode == "qsanzu3" || rcode == "qsanzu6" ||
                rcode == "qsanhzu" || rcode == "qsanhez") {
                if (rcode == "qsanhez") {
                    return 1;
                } else if (rcode == "qsanzu6") {
                    return 3;
                } else if (rcode == "qsanzu3") {
                    return 2;
                }else{
                    return 0;
                }
            }
                //中三码--------------------
                //中三直选
            else if (rcode == "zsfs" || rcode == "zsds" || rcode == "zshz") {
                if (rcode == "zsds") {
                    return 0;
                }else if (rcode == "zsfs") {
                    return 3;
                }else if (rcode == "zshz") {
                    return 1;
                }
            }
                //中三组选
            else if (rcode == "zszu3" || rcode == "zszu6" ||
                rcode == "zshzu" || rcode == "zshez") {
                if (rcode == "zshez") {
                    return 1;
                } else if (rcode == "zszu6") {
                    return 3;
                } else if (rcode == "zszu3") {
                    return 2;
                }else{
                    return 0;
                }
            }
                //二码--------------------
                //二星直选
            else if (rcode == "hefs" || rcode == "qefs" || rcode == "qeds"
                || rcode == "hehz" || rcode == "qehz") {
                if (rcode == "hehz" || rcode == "qehz") {
                    return 1;
                } else {
                    return 2;
                }
            }
                //二星组选
            else if (rcode == "hefsz" || rcode == "hedsz" ||
                rcode == "qefsz" || rcode == "qedsz" ||
                rcode == "hehzz" || rcode == "qehzz") {
                if (rcode == "hefsz" || rcode == "qefsz") {
                    return 2;
                } else if (rcode == "hehzz" || rcode == "qehzz") {
                    return 1;
                }
            }
                //定位胆---------------------
            else if (rcode == "dwd") {
                return 1;
            }
                //不定胆-------------------
            else if (rcode == "hsymbdwd" || rcode == "hsembdwd"
                || rcode == "qsymbdwd" || rcode == "qsembdwd") {
                if (rcode == "hsymbdwd" || rcode == "qsymbdwd") {
                    return 1;
                }else if (rcode == "hsembdwd" || rcode == "qsembdwd"){
                    return 2;
                }
            }
                //大小单双------------------
            else if (rcode == "hedxds" || rcode == "qedxds") {
                return 2;
            }
                //趣味----------------------
            else if (rcode == "yffs" || rcode == "hscs" || rcode == "sxbx" ||
                rcode == "sjfc") {
                return 1;
            }
                //任选二---------------
                //任二直选
            else if (rcode == "rezhixfs" || rcode == "rezhixds" || rcode == "rezhixhz") {
                if (rcode == "rezhixhz") {
                    return 1;
                } else if (rcode == "rezhixfs") {
                    return 2;
                }
            }
                //任二组选
            else if (rcode == "rezuxfs" || rcode == "rezuxds" ||
                rcode == "rezuxhz") {
                if (rcode == "rezuxhz") {
                    return 1;
                } else if (rcode == "rezuxfs") {
                    return 2;
                }
            }
                //任选三--------------------
                //任三直选
            else if (rcode == "rszhixhz" || rcode == "rszhixds" || rcode == "rszhixfs") {
                if (rcode == "rszhixhz") {
                    return 1;
                } else if (rcode == "rszhixfs") {
                    return 3;
                }
            }
                //任三组选
            else if (rcode == "rszuxs" || rcode == "rszuxl" ||
                rcode == "rszuxhz" || rcode == "rszuxhh") {
                
                if (rcode == "rszuxs") {
                    return 2;
                } else if (rcode == "rszuxl") {
                    return 3;
                } else if (rcode == "rszuxhz") {
                    return 1;
                }
            }
                //任选四------------------------
                //任四直选
            else if (rcode == "rsizhixds" || rcode == "rsizhixfs") {
                if (rcode == "rsizhixfs") {
                    return 4;
                }
            }
                //任四组选
            else if (rcode == "zux4" || rcode == "zux6" ||
                rcode == "zux12" || rcode == "zux24") {
                if (rcode == "zux4") {
                    return 2;
                }else if (rcode == "zux6") {
                    return 2;
                }else if (rcode == "zux12") {
                    return 4;
                }else if (rcode == "zux24") {
                    return 4;
                }
            }
        //PK拾
        }else if lotType == "3"{
            //猜冠军
            if (rcode == "cgj2") {
                return 1;
            } else if (rcode == "cqerds" || rcode == "cqerfs") {
                if (rcode == "cqerfs") {
                    return 2;
                }
            } else if (rcode == "cqsanfs" || rcode == "cqsands") {
                if (rcode == "cqsanfs") {
                    return 3;
                }
            } else if (rcode == "cqsifs" || rcode == "cqsids") {
                if (rcode == "cqsifs") {
                    return 4;
                }
            } else if (rcode == "cqwufs" || rcode == "cqwuds") {
                if (rcode == "cqwufs") {
                    return 5;
                }
            } else if (rcode == "dwd2") {
                return 1;
            }
        //快三
        }else if lotType == "4"{
            //同号
            if (rcode == "k3ethdx" || rcode == "k3ethfx" || rcode == "k3sthdx" ||
                rcode == "k3sthfx") {
                //二同号
                if (rcode == "k3ethdx" || rcode == "k3ethfx") {
                    if (rcode == "k3ethfx") {
                        return 1;
                    }else{
                        return 2;
                    }
                    //三同号
                } else if (rcode == "k3sthdx" || rcode == "k3sthfx") {
                    return 1;
                }
                //和值
            } else if (rcode == "k3hz2") {
                return 1;
                //三连号
            } else if (rcode == "k3slh2") {
                return 1;
                //不同号
            } else if (rcode == "k3ebth" || rcode == "k3sbth") {
                if (rcode == "k3ebth") {
                    return 2;
                }else{
                    return 3;
                }
            }
        //11选5
        }else if lotType == "5"{
            //三码--------------------
            if (rcode == "sanmaqszhixfs" || rcode == "sanmaqszhixds" ||
                rcode == "sanmaqszuxfs" || rcode == "sanmaqszuxds") {
                return 3;
                //二码--------------------
            } else if (rcode == "ermaqezhixfs" || rcode == "ermaqezhixds" ||
                rcode == "ermaqezuxfs" || rcode == "ermaqezuxds") {
                return 2;
            }
                //不定位胆----------------
            else if (rcode == "bdwd2") {
                return 1;
                //定位胆-----------------
            } else if (rcode == "dwd2") {
                return 1;
                //趣味型-----------------
            } else if (rcode == "qwxdds" || rcode == "qwxczw") {
                return 1;
            }
                //任选单式----------------
            else if (rcode == "rxdsyzy" || rcode == "rxdseze" || rcode == "rxdsszsan"
                || rcode == "rxdsszsi" || rcode == "rxdslzw" || rcode == "rxdsqzw"
                || rcode == "rxdsbzw") {
                return 0;
                //任选复式----------------
            } else if (rcode == "rxfsyzy" || rcode == "rxfseze" || rcode == "rxfsszsan"
                || rcode == "rxfsszsi" || rcode == "rxfslzw" || rcode == "rxfsqzw"
                || rcode == "rxfsbzw") {
                if (rcode == "rxfsbzw") {
                    return 8;
                }else if (rcode == "rxfsqzw") {
                    return 7;
                }else if (rcode == "rxfslzw") {
                    return 6;
                }else if (rcode == "rxfsszsi") {
                    return 4;
                }else if (rcode == "rxfsszsan") {
                    return 3;
                }else if (rcode == "rxfseze") {
                    return 2;
                }else if (rcode == "rxfsyzy") {
                    return 1;
                }
            }
        //香港彩
        }else if lotType == "6"{
            //..........
        //pc蛋蛋
        }else if lotType == "7"{
            //三码
            if (rcode == "sanmzhixhz" || rcode == "sanmzhixfs" || rcode == "sanmzhixds" ||
                rcode == "sanmzuxzs" || rcode == "sanmzuxzl" || rcode == "sanmzuxhh" ||
                rcode == "sanmzuxhz") {
                //组选
                if (rcode == "sanmzuxzs" || rcode == "sanmzuxzl" || rcode == "sanmzuxhh" ||
                    rcode == "sanmzuxhz") {
                    if (rcode == "sanmzuxhz") {
                        return 1;
                    } else if (rcode == "sanmzuxzl") {
                        return 3;
                    } else if (rcode == "sanmzuxzs") {
                        return 2;
                    }
                    //直选
                } else if (rcode == "sanmzhixhz" || rcode == "sanmzhixfs" || rcode == "sanmzhixds") {
                    if (rcode == "sanmzhixhz") {
                        return 1;
                    } else if (rcode == "sanmzhixfs") {
                        return 3;
                    }
                }
                //不定位
            }else if (rcode == "bdwdym" || rcode == "bdwdem") {
                if (rcode == "bdwdym") {
                    return 1;
                }else{
                    return 2;
                }
            }
                //二码
            else if (rcode == "ermaqerzhixfs" || rcode == "ermaqerzhixds" ||
                rcode == "ermaqerzuxfs" || rcode == "ermaqerzuxds") {
                if (rcode == "ermaqerzhixfs" || rcode == "ermaqerzuxfs"){
                    return 2;
                }
            }else if (rcode == "ermaherzhixfs" || rcode == "ermaherzhixds" ||
                rcode == "ermaherzuxfs" || rcode == "ermaherzuxds") {
                if (rcode == "ermaherzhixfs" || rcode == "ermaherzuxfs") {
                    return 2;
                }
            }
                //定位胆
            else if (rcode == "dwd2") {
                return 1;
            }
                //大小单双
            else if (rcode == "dxdsqer" || rcode == "dxdsher") {
                return 2;
            }
        //低频彩
        }else if lotType == "8"{
            //三码
            //三码直选
            if (rcode == "sanmzhixhz" || rcode == "sanmzhixfs" || rcode == "sanmzhixds") {
                if (rcode == "sanmzhixfs") {
                    return 3;
                } else if (rcode == "sanmzhixhz") {
                    return 1;
                }
            }
                //三码组选
            else if (rcode == "sanmzuxzs" || rcode == "sanmzuxzl" || rcode == "sanmzuxhh" || rcode == "sanmzuxhz") {
                if (rcode == "sanmzuxhz") {
                    return 1;
                } else if (rcode == "sanmzuxzl") {
                    return 3;
                } else if (rcode == "sanmzuxzs") {
                    return 2;
                }
            }
                //不定位
            else if (rcode == "bdwdym" || rcode == "bdwdem") {
                if (rcode == "bdwdym") {
                    return 1;
                }else{
                    return 2;
                }
            }
            //二码
            //前二
            if (rcode == "ermaqerzhixfs" || rcode == "ermaqerzhixds" || rcode == "ermaqerzuxfs" ||
                rcode == "ermaqerzuxds") {
                if (rcode == "ermaqerzuxfs") {
                    return 1;
                } else if (rcode == "ermaqerzhixfs") {
                    return 2;
                }
            }
                //后二
            else if (rcode == "ermaherzhixfs" || rcode == "ermaherzhixds" || rcode == "ermaherzuxfs" || rcode == "ermaherzuxds") {
                if (rcode == "ermaherzhixfs") {
                    return 2;
                } else if (rcode == "ermaherzuxfs") {
                    return 2;
                }
            }
                //定位胆
            else if (rcode == "dwd2") {
                return 1;
            }
                //大小单双
            else if (rcode == "dxdsqer" || rcode == "dxdsher") {
                return 2;
            }
        }
        return 0
    }
    
    
    
    
}
