//
//  LotteryCalculater.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/17.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class LotteryCalculater {

    static func calPlayDxds(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == dxds_zh) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt="总和";
            ballonRules.nums="大,小,单,双";
            ballonRules.showFuncView=false;
            ballonRules.showWeiShuView=false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        } else if (rcode == dxds_q3) {
            
            let wanRules = BallonRules();
            wanRules.ruleTxt="万位";
            wanRules.nums="大,小,单,双";
            wanRules.showFuncView=false;
            wanRules.showWeiShuView=false;
            wanRules.playCode=pcode;
            wanRules.ruleCode=rcode;
            list.append(wanRules)
            
            let qianRules = BallonRules();
            qianRules.ruleTxt="千位";
            qianRules.nums="大,小,单,双";
            qianRules.showFuncView=false;
            qianRules.showWeiShuView=false;
            qianRules.playCode=pcode;
            qianRules.ruleCode=rcode;
            list.append(qianRules)
            
            let baiRules = BallonRules();
            baiRules.ruleTxt="百位";
            baiRules.nums="大,小,单,双";
            baiRules.showFuncView=false;
            baiRules.showWeiShuView=false;
            baiRules.playCode=pcode;
            baiRules.ruleCode=rcode;
            list.append(baiRules)

        } else if (rcode == dxds_q2) {
        
            let wanRules = BallonRules();
            wanRules.ruleTxt="万位";
            wanRules.nums="大,小,单,双";
            wanRules.showFuncView=false;
            wanRules.showWeiShuView=false;
            wanRules.playCode=pcode;
            wanRules.ruleCode=rcode;
            list.append(wanRules)
            
            let qianRules = BallonRules();
            qianRules.ruleTxt="千位";
            qianRules.nums="大,小,单,双";
            qianRules.showFuncView=false;
            qianRules.showWeiShuView=false;
            qianRules.playCode=pcode;
            qianRules.ruleCode=rcode;
            list.append(qianRules)
            
        } else if (rcode == dxds_h3) {
        
            let baiRules = BallonRules();
            baiRules.ruleTxt="百位";
            baiRules.nums="大,小,单,双";
            baiRules.showFuncView=false;
            baiRules.showWeiShuView=false;
            baiRules.playCode=pcode;
            baiRules.ruleCode=rcode;
            list.append(baiRules)
            
            let shiRules = BallonRules();
            shiRules.ruleTxt="十位";
            shiRules.nums="大,小,单,双";
            shiRules.showFuncView=false;
            shiRules.showWeiShuView=false;
            shiRules.playCode=pcode;
            shiRules.ruleCode=rcode;
            list.append(shiRules)
            
            let geRules = BallonRules();
            geRules.ruleTxt="个位";
            geRules.nums="大,小,单,双";
            geRules.showFuncView=false;
            geRules.showWeiShuView=false;
            geRules.playCode=pcode;
            geRules.ruleCode=rcode;
            list.append(geRules)
            
        } else if (rcode == dxds_h2) {
            let shiRules = BallonRules();
            shiRules.ruleTxt="十位";
            shiRules.nums="大,小,单,双";
            shiRules.showFuncView=false;
            shiRules.showWeiShuView=false;
            shiRules.playCode=pcode;
            shiRules.ruleCode=rcode;
            list.append(shiRules)
            
            let geRules = BallonRules();
            geRules.ruleTxt="个位";
            geRules.nums="大,小,单,双";
            geRules.showFuncView=false;
            geRules.showWeiShuView=false;
            geRules.playCode=pcode;
            geRules.ruleCode=rcode;
            list.append(geRules)
        }
        return list;
    }
    
    static func calPlayDwd(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == dwd) {
            let rules = ["万位","千位","百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list;
    }
    
    static func calPlayLonghuhe(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == longhudou) {
            let shiRules = BallonRules();
            shiRules.ruleTxt="龙虎";
            shiRules.nums="龙,虎";
            shiRules.showFuncView=false;
            shiRules.showWeiShuView=false;
            shiRules.playCode=pcode;
            shiRules.ruleCode=rcode;
            list.append(shiRules)
        }else if (rcode == longhuhe) {
            let geRules = BallonRules();
            geRules.ruleTxt="和";
            geRules.nums="和";
            geRules.showFuncView=false;
            geRules.showWeiShuView=false;
            geRules.playCode=pcode;
            geRules.ruleCode=rcode;
            list.append(geRules)
        }
        return list
    }
    
    static func calPlayRxwf(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == rxwf_r3zux_zu3) {
            let shiRules = BallonRules();
            shiRules.ruleTxt="组三";
            shiRules.nums="0,1,2,3,4,5,6,7,8,9";
            shiRules.showFuncView=true;
            shiRules.showWeiShuView=true;
            shiRules.playCode=pcode;
            shiRules.ruleCode=rcode;
            shiRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            list.append(shiRules)
        }else if (rcode == rxwf_r3zux_zu6) {
            let geRules = BallonRules();
            geRules.ruleTxt="组六";
            geRules.nums="0,1,2,3,4,5,6,7,8,9";
            geRules.showFuncView=true;
            geRules.showWeiShuView=true;
            geRules.playCode=pcode;
            geRules.ruleCode=rcode;
            geRules.weishuInfo = convertNumListToEntifyList(numStr: WEISHU_STR, postNums: "")
            list.append(geRules)
        }else if (rcode == rxwf_r3zx_fs || rcode == rxwf_r4zx_fs ||
            rcode == rxwf_r2zx_fs) {
            let rules = ["万位","千位","百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calPlayExzx(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == q2zx_hz) {
            let shiRules = BallonRules();
            shiRules.ruleTxt="和值";
            shiRules.nums="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,1";
            shiRules.showFuncView=true;
            shiRules.showWeiShuView=false;
            shiRules.playCode=pcode;
            shiRules.ruleCode=rcode;
            list.append(shiRules)
        }else if (rcode == q2zx_fs || rcode == q2zx_ds) {
            let wanRules = BallonRules();
            wanRules.ruleTxt="万位";
            wanRules.nums="0,1,2,3,4,5,6,7,8,9";
            wanRules.showFuncView=true;
            wanRules.showWeiShuView=false;
            wanRules.playCode=pcode;
            wanRules.ruleCode=rcode;
            list.append(wanRules)
            
            let qianRules = BallonRules();
            qianRules.ruleTxt="千位";
            qianRules.nums="0,1,2,3,4,5,6,7,8,9";
            qianRules.showFuncView=true;
            qianRules.showWeiShuView=false;
            qianRules.playCode=pcode;
            qianRules.ruleCode=rcode;
            list.append(qianRules)
        }else if (rcode == h2zx_hz) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "和值";
            ballonRules.nums="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }else if (rcode == h2zx_fs || rcode == h2zx_ds) {
            let shiRules = BallonRules();
            shiRules.ruleTxt = "十位";
            shiRules.nums="0,1,2,3,4,5,6,7,8,9";
            shiRules.showFuncView = true;
            shiRules.showWeiShuView = false;
            shiRules.playCode=pcode;
            shiRules.ruleCode=rcode;
            list.append(shiRules)
            
            let geRules = BallonRules();
            geRules.ruleTxt = "个位";
            geRules.nums="0,1,2,3,4,5,6,7,8,9";
            geRules.showFuncView = true;
            geRules.showWeiShuView = false;
            geRules.playCode=pcode;
            geRules.ruleCode=rcode;
            list.append(geRules)
        }
        return list
    }
    
    static func calPlaySxzx(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let shiRules = BallonRules();
        if (rcode == q3zux_zu3 || rcode == z3zux_zu3 || rcode == h3zux_zu3) {
            shiRules.ruleTxt="组三";
        }else if(rcode == q3zux_zu6||rcode == z3zux_zu6||rcode == h3zux_zu6){
            shiRules.ruleTxt="组六";
        }
        shiRules.nums="0,1,2,3,4,5,6,7,8,9";
        shiRules.showFuncView=true;
        shiRules.showWeiShuView=false;
        shiRules.playCode=pcode;
        shiRules.ruleCode=rcode;
        list.append(shiRules)
        return list
    }
    
    static func calPlaySxwf(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == q3zx_fs || rcode == q3zx_ds) {
            let rules = ["万位","千位","百位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == z3zx_fs || rcode == z3zx_ds) {
            let rules = ["千位","百位","十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == h3zx_fs || rcode == h3zx_ds) {
            let rules = ["百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calPlaySixingwf(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == q4zx_fs || rcode == q4zx_ds) {
            let rules = ["万位","千位","百位","十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == h4zx_fs || rcode == h4zx_ds) {
            let rules = ["千位","百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calPlayWuxinwf(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == wxzx_fs||rcode == wxzx_ds) {
            let rules = ["万位","千位","百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calPlayCaibaozhi(pcode:String,rcode:String)->[BallonRules]{
        var list = [BallonRules]();
        let shiRules = BallonRules();
        if (rcode == baozi) {
            shiRules.ruleTxt="豹子";
        }else if(rcode == shunzi){
            shiRules.ruleTxt="顺子";
        }else if(rcode == duizi){
            shiRules.ruleTxt="对子";
        }else if(rcode == banshun){
            shiRules.ruleTxt="半顺";
        }else if(rcode == zaliu){
            shiRules.ruleTxt="杂六";
        }
        shiRules.nums="前,中,后";
        shiRules.postNums="前三,中三,后三"
        shiRules.showFuncView=false;
        shiRules.showWeiShuView=false;
        shiRules.playCode=pcode;
        shiRules.ruleCode=rcode;
        list.append(shiRules)
        return list
    }
    
    static func calFFCPlayBdw(pcode:String,rcode:String)->[BallonRules]{
        var list = [BallonRules]();
        let shiRules = BallonRules();
        if (rcode == bdw_q31m) {
            shiRules.ruleTxt="前三一码";
        }else if(rcode == bdw_z31m){
            shiRules.ruleTxt="中三一码";
        }else if(rcode == bdw_h31m){
            shiRules.ruleTxt="后三一码";
        }
        shiRules.nums="0,1,2,3,4,5,6,7,8,9";
        shiRules.showFuncView=true;
        shiRules.showWeiShuView=false;
        shiRules.playCode=pcode;
        shiRules.ruleCode=rcode;
        list.append(shiRules)
        return list
    }
    
    static func calPlaySaicheDwd(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == dwd) {
            let rules = ["冠","亚","季","四","五","六","七","八","九","十"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calLonghuChampion(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == longhu_gunjun || rcode == longhu_yajun ||
            rcode == longhu_jijun) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "龙虎";
            ballonRules.nums="龙,虎";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    static func calQianyi(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == q1zx_fs) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "冠";
            ballonRules.nums="01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    static func calQianer(pcode:String,rcode:String) ->[BallonRules]{
        
        var list = [BallonRules]();
        if (rcode == q2zx_fs) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "冠";
            ballonRules.nums="01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
            
            let yajunRule = BallonRules();
            yajunRule.ruleTxt = "亚";
            yajunRule.nums="01,02,03,04,05,06,07,08,09,10";
            yajunRule.showFuncView = true;
            yajunRule.showWeiShuView = false;
            yajunRule.playCode=pcode;
            yajunRule.ruleCode=rcode;
            list.append(yajunRule)
        }
        return list
    }
    
    static func calGuanYaHe(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == dxds) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "大小单双";
            ballonRules.nums="大,小,单,双";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }else if (rcode == gyhz) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "冠亚和值";
            ballonRules.nums="3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    static func calQianShang(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == q3zx_fs) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "冠";
            ballonRules.nums="01,02,03,04,05,06,07,08,09,10";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
            
            let yaRules = BallonRules();
            yaRules.ruleTxt = "亚";
            yaRules.nums="01,02,03,04,05,06,07,08,09,10";
            yaRules.showFuncView = true;
            yaRules.showWeiShuView = false;
            yaRules.playCode=pcode;
            yaRules.ruleCode=rcode;
            list.append(yaRules)
            
            let jiRules = BallonRules();
            jiRules.ruleTxt = "季";
            jiRules.nums="01,02,03,04,05,06,07,08,09,10";
            jiRules.showFuncView = true;
            jiRules.showWeiShuView = false;
            jiRules.playCode=pcode;
            jiRules.ruleCode=rcode;
            list.append(jiRules)
        }
        return list
    }
    
    static func calZxfs(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == zhx_fs) {
            let rules = ["百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calZhuxuan63(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == zux_z6) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组六";
            ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }else if (rcode == zux_z3) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "组三";
            ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    // 不定位胆-一码，二码不定位
    static func calBdw(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == bdw_2m || rcode == bdw_1m) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "不定位";
            ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    static func calErma(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == q2zx_fs) {
            let rules = ["百位","十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == em_q2zux||rcode == em_h2zux) {
            let rules = ["组选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == h2zx_fs) {
            let rules = ["十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    
    //福彩3D，排列3-大小单双
    static func calFucai3DPlayDxds(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == dxds_q2) {
            let rules = ["百位","十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="大,小,单,双";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == dxds_h2) {
            let rules = ["十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="大,小,单,双";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calFucai3DPlayDwd(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == dwd) {
            let rules = ["百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    //11选5-任选复式
    static func calRxfs(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let ballonRules = BallonRules();
        if (rcode == rxfs_rx8z5) {
            ballonRules.ruleTxt = "任八中五";
        }else if (rcode == rxfs_rx7z5) {
            ballonRules.ruleTxt = "任七中五";
        }else if (rcode == rxfs_rx6z5) {
            ballonRules.ruleTxt = "任六中五";
        }else if (rcode == rxfs_rx4z4) {
            ballonRules.ruleTxt = "任四中四";
        }else if (rcode == rxfs_rx3z3) {
            ballonRules.ruleTxt = "任三中三";
        }else if (rcode == rxfs_rx2z2) {
            ballonRules.ruleTxt = "任二中二";
        }else if (rcode == rxfs_rx1z1) {
            ballonRules.ruleTxt = "任一中一";
        }else if (rcode == rxfs_rx5z5) {
            ballonRules.ruleTxt = "任五中五";
        }
        ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
        ballonRules.showFuncView = true;
        ballonRules.showWeiShuView = false;
        ballonRules.playCode=pcode;
        ballonRules.ruleCode=rcode;
        list.append(ballonRules)
        return list
    }
    
    static func calPlac11x5Dwd(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == dwd) {
            let rules = ["万位","千位","百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func cal11x5Bdw(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        let ballonRules = BallonRules();
        if (rcode == bdw_q3) {
            ballonRules.ruleTxt = "前三";
        }else if (rcode == bdw_z3) {
            ballonRules.ruleTxt = "中三";
        }else if (rcode == bdw_h3) {
            ballonRules.ruleTxt = "后三";
        }
        ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
        ballonRules.showFuncView = true;
        ballonRules.showWeiShuView = false;
        ballonRules.playCode=pcode;
        ballonRules.ruleCode=rcode;
        list.append(ballonRules)
        return list
    }
    
    static func cal11x5Erma(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == q2zx_fs) {
            let rules = ["万位","千位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == q2zx || rcode == h2zx) {
            let rules = ["组选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == h2zx_fs) {
            let rules = ["十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func cal11x5Shangma(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == q3zx_fs) {
            let rules = ["万位","千位","百位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == z3zx_fs) {
            let rules = ["千位","百位","十位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == q3zx || rcode == z3zx) {
            let rules = ["组选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == h3zx_fs) {
            let rules = ["百位","十位","个位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="01,02,03,04,05,06,07,08,09,10,11";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    //快三-和值
    static func calcK3Hezi(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == dxds) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "大小单双";
            ballonRules.nums="大,小,单,双";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }else if (rcode == hz) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "直选和值";
            ballonRules.nums="3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    //快三-三同号通选
    static func calcK3sthtx(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == sthtx) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "三同号通选";
            ballonRules.postNums = "三同号通选"
            ballonRules.nums="通";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    //快三-三同号单选
    static func calcK3sthdx(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == sthdx) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "三同号单选";
            ballonRules.nums="111,222,333,444,555,666";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    //快三-三不同号
    static func calcK3sbth(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == sbtx) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "三不同号";
            ballonRules.nums="1,2,3,4,5,6";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    //快三-三连号通选
    static func calcK3slhtx(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == slhtx) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "三连号通选"
            ballonRules.postNums = "三连号通选"
            ballonRules.nums="通";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    //快三-二同号复选
    static func calcK3Ethfx(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == ethfx) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "二同号复选"
            ballonRules.nums="11,22,33,44,55,66";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    //快三-二连通单选
    static func calcK3Ethdx(pcode:String,rcode:String) ->[BallonRules]{
        let list = [BallonRules]();
//        if (rcode == ethfx) {
//            let ballonRules = BallonRules();
//            ballonRules.ruleTxt = "二同号复选"
//            ballonRules.nums="11,22,33,44,55,66";
//            ballonRules.showFuncView = false;
//            ballonRules.showWeiShuView = false;
//            ballonRules.playCode=pcode;
//            ballonRules.ruleCode=rcode;
//            list.append(ballonRules)
//        }
        return list
    }
    
    //快三-二不同号
    static func calcK3Ebth(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == ebth) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "二不同号"
            ballonRules.nums="1,2,3,4,5,6";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    static func calPlayPCDDDwd(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == dwd) {
            let rules = ["一位","二位","三位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calpcddBdw(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == bdw_pcegg) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "不定位";
            ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
            ballonRules.showFuncView = true;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }
        return list
    }
    
    static func calPlayPCDDExwf(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == q2zx_fs) {
            let rules = ["一位","二位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == q2zx) {
            let rules = ["前二组选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == h2zx_fs) {
            let rules = ["二位","三位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == h2zx) {
            let rules = ["后二组选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    static func calPlayPCDDSxwf(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == sxzx) {
            let rules = ["三星组选"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }else if (rcode == sxfs) {
            let rules = ["一位","二位","三位"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    //PC蛋蛋，加拿大28--和值
    static func calPlayPCDDhezi(pcode:String,rcode:String) ->[BallonRules]{
        var list = [BallonRules]();
        if (rcode == dxds) {
            let ballonRules = BallonRules();
            ballonRules.ruleTxt = "大小单双";
            ballonRules.nums="大,小,单,双";
            ballonRules.showFuncView = false;
            ballonRules.showWeiShuView = false;
            ballonRules.playCode=pcode;
            ballonRules.ruleCode=rcode;
            list.append(ballonRules)
        }else if (rcode == hz) {
            let rules = ["直选和值"]
            for rule in rules{
                let ballonRules = BallonRules();
                ballonRules.ruleTxt = rule;
                ballonRules.nums="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17," +
                "18,19,20,21,22,23,24,25,26,27";
                ballonRules.showFuncView = true;
                ballonRules.showWeiShuView = false;
                ballonRules.playCode=pcode;
                ballonRules.ruleCode=rcode;
                list.append(ballonRules)
            }
        }
        return list
    }
    
    
    
    
    ////时时彩-整合
    static func calcPeilvZhenhe(webResults:[PeilvWebResult]?) -> [PeilvData]{
    
        var list = [PeilvData]()
        if (webResults == nil) {
            return list;
        }
        var subZhongHe = [PeilvPlayData]();
        var dxdszh = [PeilvPlayData]();
        var shuzhi = [PeilvPlayData]();
        
        if let webResult = webResults {
            for result in webResult{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "总和大" || name == "总和小" ||
                        name == "总和单" || name == "总和双"){
                        let data = PeilvPlayData();
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        subZhongHe.append(data);
                    }else if (name == "大" || name == "小" ||
                        name == "单" || name == "双" ||
                        name == "质" || name == "合"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dxdszh.append(data)
                    }
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...9{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
        }
        
        //总和项
        let zhongheItem = PeilvData();
        zhongheItem.tagName = "总和";
        zhongheItem.appendTag = false;
        zhongheItem.subData = subZhongHe
        list.append(zhongheItem)
        
        let weis = ["万位","仟位","佰位","拾位","个位"]
        for weiItem in weis{
            let item = PeilvData();
            item.tagName = weiItem;
            item.appendTag = true;
            var wanweiList = [PeilvPlayData]()
            wanweiList = wanweiList + shuzhi
            wanweiList = wanweiList + dxdszh
            let subDatas = wanweiList.map{$0.copy() as! PeilvPlayData}
            item.subData = subDatas
            list.append(item)
        }
        
        return list
    }
    
    static func calcPeilvWeiItem(tagName:String,postTagName:String,webResults:[PeilvWebResult]?) -> [PeilvData]{
        
        var list = [PeilvData]()
        if webResults == nil {
            return list
        }
        var zzzzlhhdxdszh = [PeilvPlayData]()
        var shuzhi = [PeilvPlayData]()
        
        if let webValue = webResults {
            for result in webValue{
                
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "总和大" || name == "总和小" || name == "总和单" ||
                        name == "总和双" || name == "大" || name == "小" ||
                        name == "单" || name == "双" ||
                        name == "质" || name == "合" ||
                        name == "龙" || name == "虎" ||
                        name == "和"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        if (name == "大" || name == "小" ||
                            name == "单" || name == "双" ||
                            name == "质" || name == "合"){
                            data.filterSpecialSuffix = true
                        }
                        zzzzlhhdxdszh.append(data)
                    }
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...9{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
        }
        
        //数字项
        let zhongheItem = PeilvData();
        zhongheItem.tagName = "";
        zhongheItem.appendTag = false;
        zhongheItem.subData = shuzhi;
        //万位
        let wanweiItem = PeilvData();
        wanweiItem.tagName = tagName;
        wanweiItem.postTagName = postTagName;
        wanweiItem.appendTag = true;
        wanweiItem.subData = zzzzlhhdxdszh;
        
        list.append(zhongheItem);
        list.append(wanweiItem);
        return list
    }
    
    static func calcPeilvHeweishu(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var dxdszh = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let array = ["大","小","单","双","质","合"]
                    for item in array{
                        let data = PeilvPlayData()
                        data.number = item
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dxdszh.append(data)
                    }
                }
            }
            
            let tags = ["万仟","万佰","万拾","万个","仟佰","仟拾","仟个","佰拾","佰个","拾个","前三","中三","后三"]
            for tag in tags{
                let item = PeilvData()
                item.tagName = tag
                item.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + dxdszh
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                item.subData = subDatas
                list.append(item)
            }
            return list
        }
        return list
    }
    
    static func calcPeilvlhd(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var lhd = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    lhd.append(data)
                }
            }
            
            let tags = ["万仟","万佰","万拾","万个","仟佰","仟拾","仟个","佰拾","佰个","拾个"]
            for tag in tags{
                let item = PeilvData()
                item.tagName = tag
                item.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + lhd
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                item.subData = subDatas
                list.append(item)
            }
            return list
        }
        return list
    }
    
    static func calcPeilvBaijiale(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var zxhzx = [PeilvPlayData]()
        var dxdszh = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "庄" || name == "闲" || name == "和局" ||
                        name == "庄对" || name == "闲对"){
                        let data = PeilvPlayData()
                        data.number = result.name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        zxhzx.append(data)
                    }else if (name == "大" || name == "小" || name == "单" ||
                        name == "双" || name == "质" || name == "合"){
                        let data = PeilvPlayData()
                        data.number = result.name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dxdszh.append(data)
                    }
                }
            }
            
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = zxhzx
            list.append(firstItem)
            
            let secondItem = PeilvData()
            secondItem.tagName = "庄大"
            secondItem.appendTag = true
            secondItem.subData = dxdszh
            list.append(secondItem)
            
            let xdItem = PeilvData()
            xdItem.tagName = "闲大"
            xdItem.appendTag = true
            var item = [PeilvPlayData]()
            item = item + dxdszh
            let subDatas = item.map{$0.copy() as! PeilvPlayData}
            xdItem.subData = subDatas
            list.append(xdItem)
            
            return list
        }
        return list
    }
    
    //时时彩-棋牌-牛牛
    static func calcPeilvNiuniu(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var niu123456789wn = [PeilvPlayData]()
        var dxds = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "大" || name == "小" || name == "单" ||
                        name == "双"){
                        let data = PeilvPlayData()
                        data.number = result.name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dxds.append(data)
                    }else{
                        let data = PeilvPlayData()
                        data.number = result.name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        niu123456789wn.append(data)
                    }
                }
            }
            
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = niu123456789wn
            list.append(firstItem)
            
            let secondItem = PeilvData()
            secondItem.tagName = ""
            secondItem.appendTag = false
            secondItem.subData = dxds
            list.append(secondItem)
            
            return list
        }
        return list
    }
    
    //时时彩-棋牌-德州扑克
    static func calcPeilvdzpk(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var bshsslyzw = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    bshsslyzw.append(data)
                }
            }
            
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = bshsslyzw
            list.append(firstItem)
            return list
        }
        return list
    }
    
    //时时彩-棋牌-三公
    static func calcPeilvSanggong(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var zyh = [PeilvPlayData]()
        var dxdszh = [PeilvPlayData]()
        
        
        if let webValue = webResult{
            let webResult = webValue[0]
            let arr1 = ["左闲","右闲","和局"]
            for name in arr1{
                let data = PeilvPlayData()
                data.number = name
                data.peilv = String.init(format: "%.3f", webResult.odds)
                data.peilvData = webResult
                zyh.append(data)
            }
            
            let arr2 = ["大","小","单","双","质","合"]
            for name in arr2{
                let data = PeilvPlayData()
                data.number = name
                data.peilv = String.init(format: "%.3f", webResult.odds)
                data.peilvData = webResult
                dxdszh.append(data)
            }
            //第一项
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = zyh
            list.append(firstItem)
            
            //左闲尾大
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "左闲尾大"
            wanweiItem.appendTag = true
            wanweiItem.subData = dxdszh
            list.append(wanweiItem)
            
            //右闲尾大
            let qianweiItem = PeilvData()
            qianweiItem.tagName = "右闲尾大"
            qianweiItem.appendTag = true
            var item = [PeilvPlayData]()
            item = item + dxdszh
            let subDatas = item.map{$0.copy() as! PeilvPlayData}
            qianweiItem.subData = subDatas
            list.append(qianweiItem)
            
            return list
        }
        return list
    }
    
    
    //时时彩-和数-前，中，后三
    static func calcPeilvheshu(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    let data = PeilvPlayData()
                    data.number = name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzi.append(data)
                }
            }
            //数字项
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = shuzi
            list.append(firstItem)
            return list
        }
        return list
    }
    
    //时时彩-一字
    static func calcPeilvYiZhi(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...9{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzi.append(data)
                    }
                }
            }
            //数字项
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = shuzi
            list.append(firstItem)
            return list
        }
        return list
    }
    
    
    //时时彩-二字，三字定位
    static func calcPeilvErSangZhi(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzi.append(data)
                }
            }
            //数字项
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = shuzi
            list.append(firstItem)
            return list
        }
        return list
    }
    
    //时时彩-二字，三字定位
    static func calcPeilvErSangZhiDingWei(webResult:[PeilvWebResult]?,max:Int) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...max{
                        let data = PeilvPlayData()
                        if max == 99{
                            data.number = String.init(format: "%02d", index)
                        }else if max == 999{
                            data.number = String.init(format: "%03d", index)
                        }
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzi.append(data)
                    }
                }
            }
            //数字项
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = shuzi
            list.append(firstItem)
            return list
        }
        return list
    }
    
    //时时彩-组选三，六
    static func calcPeilvZuxuan(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var sub = [PeilvPlayData]()
        if let webValue = webResult{
            for index in 0...9{
                let data = PeilvPlayData()
                data.number = String.init(describing: index)
                data.checkbox = true
                data.peilv = String.init(format: "%.3f", webValue[0].odds)
                data.peilvData = webValue[0]//设置这个是为了每一个号码项都可以拿到基本的投注数据，
                // 如最小勾选数，最大投注金额等
                data.allDatas = webValue
                sub.append(data)
            }
            
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = sub
            list.append(firstItem)
            return list
        }
        return list
    }
    
    
    //时时彩-跨度
    static func calcFFCKuadu(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzhi.append(data)
                }
            }
            
            let firstItem = PeilvData()
            firstItem.tagName = ""
            firstItem.appendTag = false
            firstItem.subData = shuzhi
            list.append(firstItem)
            return list
        }
        return list
    }
    
    //快三--骰宝
    static func calcSaibao(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var sbdx = [PeilvPlayData]()
        var weisai = [PeilvPlayData]()
        var quansai = [PeilvPlayData]()
        var dianshu = [PeilvPlayData]()
        var changpai = [PeilvPlayData]()
        var duanpai = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    
                    let name = result.name
                    if name == "大小骰宝"{
                        let arr = ["1","2","3","4","5","6","大","小","单","双"]
                        for item in arr{
                            let data = PeilvPlayData()
                            data.number = item
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            sbdx.append(data)
                        }
                    }else if name == "围骰"{
                        let arr = ["1-1-1", "2-2-2", "3-3-3", "4-4-4", "5-5-5", "6-6-6"]
                        for item in arr{
                            let data = PeilvPlayData()
                            data.number = item
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            weisai.append(data)
                        }
                    }else if name == "全骰"{
                        let data = PeilvPlayData()
                        data.number = "全骰"
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        quansai.append(data)
                    }else if (name == "4点" || name == "5点" || name == "6点" || name == "7点" || name == "8点" || name == "9点" || name == "10点" || name == "11点" || name == "12点" || name == "13点" || name == "14点" || name == "15点" || name == "16点" || name == "17点"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dianshu.append(data)
                    }else if name == "长牌"{
                        let arr = ["1-2","1-3","1-4","1-5","1-6","2-3","2-4","2-5","2-6",
                                   "3-4","3-5","3-6","4-5","4-6","5-6"]
                        for item in arr{
                            let data = PeilvPlayData()
                            data.number = item
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            changpai.append(data)
                        }
                    }else if name == "短牌"{
                        let arr = ["1-1","2-2","3-3","4-4","5-5","6-6"]
                        for item in arr{
                            let data = PeilvPlayData()
                            data.number = item
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            duanpai.append(data)
                        }
                    }
                }
            }
            //骰宝，大小
            let sbdxItem = PeilvData()
            sbdxItem.tagName = ""
            sbdxItem.appendTag = false
            sbdxItem.subData = sbdx
            list.append(sbdxItem)
            
            //围骰，全骰
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "围骰，全骰"
            wanweiItem.appendTag = false
            var items = [PeilvPlayData]()
            items = items + weisai
            items = items + quansai
            wanweiItem.subData = items
            list.append(wanweiItem)
            
            //点数
            let dianShuItem = PeilvData()
            dianShuItem.tagName = "点数"
            dianShuItem.appendTag = false
            dianShuItem.subData = dianshu
            list.append(dianShuItem)
            
            //长牌
            let changpaiItem = PeilvData()
            changpaiItem.tagName = "长牌"
            changpaiItem.appendTag = false
            changpaiItem.subData = changpai
            list.append(changpaiItem)
            
            //短牌
            let duanpaiItem = PeilvData()
            duanpaiItem.tagName = "短牌"
            duanpaiItem.appendTag = false
            duanpaiItem.subData = duanpai
            list.append(duanpaiItem)
            return list
        }
        return list
    }
    
    //pc 蛋蛋 ，加拿大28
    static func calcPC28(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var hunhe = [PeilvPlayData]()
        var bosebaozi = [PeilvPlayData]()
        var tema = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "大" || name == "小" || name == "单" ||
                        name == "双" || name == "大单" || name == "大双" || name == "小单" ||
                        name == "小双" || name == "极大" || name == "极小"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        hunhe.append(data)
                    }else if (name == "红波" || name == "绿波" || name == "蓝波" ||
                        name == "豹子"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        bosebaozi.append(data)
                    }
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    let name = result.name
                    for index in 0...27{
                        if name == String.init(describing: index){
                            let data = PeilvPlayData()
                            data.number = name
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            tema.append(data)
                        }
                    }
                }
            }
            //混合
            let sbdxItem = PeilvData()
            sbdxItem.tagName = "混合"
            sbdxItem.appendTag = false
            sbdxItem.subData = hunhe
            list.append(sbdxItem)
            
            //波色，豹子
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "波色，豹子"
            wanweiItem.appendTag = false
            wanweiItem.subData = bosebaozi
            list.append(wanweiItem)
            
            //特码
            let dianShuItem = PeilvData()
            dianShuItem.tagName = "特码"
            dianShuItem.appendTag = false
            dianShuItem.subData = tema
            list.append(dianShuItem)
            
            return list
        }
        return list
    }
    
    //快乐十分--单球1-8
    static func calcKuaile10Dangqiu18(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var qiushus = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    for index in 1...20{
                        let data = PeilvPlayData()
                        data.number = String.init(format: "%02d", index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        qiushus.append(data)
                    }
                }
            }
            let arrays = ["一", "二", "三", "四", "五", "六", "七", "八"]
            for item in arrays{
                let data = PeilvData()
                data.tagName = String.init(format: "第%@球", item)
                data.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + qiushus
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                data.subData = subDatas
                list.append(data)
            }
            return list
        }
        return list
    }
    
    //快乐十分--1，2，3，4，5，6，7，8球
    static func calcKuaile10WhichBallon(qiuIndex:String,webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        var shuangmapan = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "大" || name == "小" || name == "单" ||
                        name == "双" || name == "尾大" || name == "尾小" || name == "合单" ||
                        name == "合双" || name == "东" || name == "西" ||
                        name == "南" || name == "北" || name == "中" ||
                        name == "发" || name == "白"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuangmapan.append(data)
                    }
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 1...20{
                        let data = PeilvPlayData()
                        data.number = String.init(format: "%02d", index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
            
            //第几球
            let data = PeilvData()
            data.tagName = String.init(format: "第%@球", qiuIndex)
            data.appendTag = false
            data.subData = shuzhi
            list.append(data)
            
            //双面盘
            let wanweiItem = PeilvData()
            wanweiItem.tagName = String.init(format: "第%@球,双面盘", qiuIndex)
            wanweiItem.appendTag = false
            wanweiItem.subData = shuangmapan
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    
    //快乐十分--连码
    static func calcKuaile10Lianma(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuangmapan = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    for index in 1...20{
                        let data = PeilvPlayData()
                        data.number = String.init(format: "%02d", index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = webValue[0]//设置这个是为了每一个号码项都可以拿到基本的投注数据，
                        // 如最小勾选数，最大投注金额等
                        data.allDatas = webValue
                        data.checkbox = true
                        shuangmapan.append(data)
                    }
                }
            }
            
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shuangmapan
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    
    //快乐十分--双面盘
    static func calcKuaile10smp(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var zhonghe = [PeilvPlayData]()
        var qiuDatas = [PeilvPlayData]()
        
        if let webValue = webResult{
            
            let web = webValue[0]
            let arr = ["总大","总小","总单","总双","总尾大","总尾小"]
            for item in arr{
                let data = PeilvPlayData()
                data.number = item
                data.peilv = String.init(format: "%.3f", web.odds)
                data.peilvData = web
                zhonghe.append(data)
            }
            
            let arr2 = ["大","小","单","双","尾大","尾小","合单","合双"]
            for item in arr2{
                let data = PeilvPlayData()
                data.number = item
                data.peilv = String.init(format: "%.3f", web.odds)
                data.peilvData = web
                qiuDatas.append(data)
            }
            
            //总和
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "总和"
            wanweiItem.appendTag = false
            wanweiItem.subData = zhonghe
            list.append(wanweiItem)
            
            //1~8球
            let arrQiu = ["一","二","三","四","五","六","七","八"]
            for item in arrQiu{
                let data = PeilvData()
                data.tagName = String.init(format: "第%@球", item)
                var subList = [PeilvPlayData]()
                subList = subList + qiuDatas
                data.appendTag = true
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                data.subData = subDatas
                list.append(data)
            }
            
            return list
        }
        return list
    }
    
    //赛车-冠亚军
    static func calcSaicheGyj(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuangmapan = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuangmapan.append(data)
                }
            }
            //总和
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "冠亚和"
            wanweiItem.appendTag = false
            var subList = [PeilvPlayData]()
            subList = subList + shuangmapan
            let subDatas = subList.map{$0.copy() as! PeilvPlayData}
            wanweiItem.subData = subDatas
            list.append(wanweiItem)
            return list
        }
        return list
    }
    
    
    //赛车-单号1-10
    static func calcSaicheDanhao110(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            let web = webValue[0]
            for index in 1...10{
                let data = PeilvPlayData()
                data.number = String.init(describing: index)
                data.peilv = String.init(format: "%.3f", web.odds)
                data.peilvData = web
                shuzhi.append(data)
            }
            
            let arr2 = ["冠军", "亚军", "季军","第四名", "第五名", "第六名","第七名", "第八名","第九名","第十名"]
            for item in arr2{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = item
                wanweiItem.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + shuzhi
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
            
            return list
        }
        return list
    }
    
    //赛车-双面盘
    static func calcSaicheSMP(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var hhhh = [PeilvPlayData]()
        var dxdslh = [PeilvPlayData]()
        var dxds = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "和大" || name == "和小" || name == "和单" ||
                        name == "和双"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        hhhh.append(data)
                    }
                    
                    if (name == "大" || name == "小" || name == "单" ||
                        name == "双"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dxds.append(data)
                        dxdslh.append(data)
                    }
                    
                    if (name == "龙" || name == "虎"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dxdslh.append(data)
                    }
                }
            }
            
            //冠,亚和
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "冠,亚和"
            wanweiItem.appendTag = false
            wanweiItem.subData = hhhh
            list.append(wanweiItem)
            
            let arr2 = ["冠军", "亚军", "季军","第四名", "第五名"]
            for item in arr2{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = item
                wanweiItem.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + dxdslh
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
            
            let arr3 = ["第六名","第七名", "第八名","第九名","第十名"]
            for item in arr3{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = item
                wanweiItem.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + dxds
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
            return list
        }
        return list
    }
    
    
    //十一选5--双面盘
    static func calc11x5smp(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var hhhhwwlh = [PeilvPlayData]()
        var dxds = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "和大" || name == "和小" || name == "和单" ||
                        name == "和双" || name == "尾大" || name == "尾小" || name == "龙" ||
                        name == "虎"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        hhhhwwlh.append(data)
                    }
                    if (name == "大" || name == "小" || name == "单" ||
                        name == "双"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        dxds.append(data)
                    }
                }
            }
            
            //总和
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "总和"
            wanweiItem.appendTag = false
            wanweiItem.subData = hhhhwwlh
            list.append(wanweiItem)
            
            //1~5球
            let balls = ["一","二","三","四","五"]
            for item in balls{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = String.init(format: "第%@球", item)
                wanweiItem.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + dxds
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
            return list
        }
        return list
    }
    
    //11x5 1-5球
    static func calc11x515(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 1...11{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
            
            //1~5球
            let balls = ["一","二","三","四","五"]
            for item in balls{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = String.init(format: "第%@球", item)
                wanweiItem.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + shuzhi
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
            return list
        }
        return list
    }
    
    //11x5 renxuan
    static func calc11x515RenXuan(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                for index in 1...11{
                    let data = PeilvPlayData()
                    data.number = String.init(format:"%02d",index)
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    data.checkbox = true
                    data.allDatas = webValue
                    shuzhi.append(data)
                }
            }
            let wanweiItem = PeilvData()
            var subList = [PeilvPlayData]()
            subList = subList + shuzhi
            let subDatas = subList.map{$0.copy() as! PeilvPlayData}
            wanweiItem.subData = subDatas
            list.append(wanweiItem)
            return list
        }
        return list
    }
    
    //11x5 zuxuan
    static func calc11x515zuXuan(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                for index in 1...11{
                    let data = PeilvPlayData()
                    data.number = String.init(format:"%02d",index)
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    data.checkbox = true
                    data.allDatas = webValue
                    shuzhi.append(data)
                }
            }
            let wanweiItem = PeilvData()
            var subList = [PeilvPlayData]()
            subList = subList + shuzhi
            let subDatas = subList.map{$0.copy() as! PeilvPlayData}
            wanweiItem.subData = subDatas
            list.append(wanweiItem)
            return list
        }
        return list
    }
    
    //11x5 zhixuan
    static func calc11x515zhiXuan(webResult:[PeilvWebResult]?,rcode:String) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    for index in 1...11{
                        let data = PeilvPlayData()
                        data.number = String.init(format:"%02d",index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        data.checkbox = true
                        data.allDatas = webValue
                        shuzhi.append(data)
                    }
                }
            }
            var arrItem = [String]();
            if (rcode == syx5_zhixuan_qianer) {
                arrItem.append("一")
                arrItem.append("二")
            }else if (rcode == syx5_zhixuan_houer) {
                arrItem.append("四")
                arrItem.append("五")
            }else if (rcode == syx5_zhixuan_qiansan) {
                arrItem.append("一")
                arrItem.append("二")
                arrItem.append("三")
            }else if (rcode == syx5_zhixuan_zhongsan) {
                arrItem.append("二")
                arrItem.append("三")
                arrItem.append("四")
            }else if (rcode == syx5_zhixuan_housan) {
                arrItem.append("三")
                arrItem.append("四")
                arrItem.append("五")
            }
            for item in 0...arrItem.count-1{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = String.init(format: "第%@球", arrItem[item])
                var subList = [PeilvPlayData]()
                subList = subList + shuzhi
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
            return list
        }
        return list
    }
    
    //福彩3D,排列3
    static func calcPailie3(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shuzhi = [PeilvPlayData]()
        var dxds = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    dxds.append(data)
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...9{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
            
            //1~3球
            let balls = ["一","二","三"]
            for item in balls{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = String.init(format: "第%@球", item)
                wanweiItem.appendTag = true
                var subList = [PeilvPlayData]()
                subList = subList + shuzhi
                subList = subList + dxds
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
            return list
        }
        return list
    }
    
    ////排列3 注勢盤
    static func calcpl3_zhushipan(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var qitashuzhi = [PeilvPlayData]()
        let numbers:[String] = ["佰","拾","个","佰拾和尾数","佰个和尾数","佰个和尾数","拾个和尾数","佰拾个和尾数","佰拾个和数"]
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    for item in numbers{
                        let data = PeilvPlayData()
                        data.number = item
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        data.appendTag = true
                        data.appendTagToTail = true
                        qitashuzhi.append(data)
                    }
                }
            }
            
            let categorys:[String] = ["大","小","单","双","质","合"]
            for c in categorys{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = c
                wanweiItem.appendTag = true
                wanweiItem.appendTagToTail = true
                var subList = [PeilvPlayData]()
                subList = subList + qitashuzhi
                let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
        }
        return list
    }
    
    
    ////排列3 一字组合
    static func calcpl3_yizizuhe(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var qitashuzhi = [PeilvPlayData]()
        var shuzhi = [PeilvPlayData]()
        
        
        if let webValue = webResult{
            let numbers:[String] = ["大","小","单","双","质","合"]
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    for item in numbers{
                        let data = PeilvPlayData()
                        data.number = item
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        qitashuzhi.append(data)
                    }
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for i in 0...9{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: i)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
            
            let categorys:[String] = ["一字组合","佰","拾","个"]
            for index in 0...categorys.count-1{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = categorys[index]
                if index == 0{
                    wanweiItem.appendTag = false
                    var subList = [PeilvPlayData]()
                    subList = subList + shuzhi
                    let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                    wanweiItem.subData = subDatas
                }else{
                    wanweiItem.appendTag = true
                    var subList = [PeilvPlayData]()
                    subList = subList + qitashuzhi
                    let subDatas = subList.map{$0.copy() as! PeilvPlayData}
                    wanweiItem.subData = subDatas
                }
                list.append(wanweiItem)
            }
        }
        return list
    }
    
    ////排列3 二字组合
    static func calcpl3_erzizuhe(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzhi.append(data)
                }
            }
            let wanweiItem = PeilvData()
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
        }
        return list
    }
    
    ////排列3 三字组合
    static func calcpl3_sanzizuhe(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzhi.append(data)
                }
            }
            let wanweiItem = PeilvData()
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
        }
        return list
    }
    
    ////排列3 百十定位
    static func calcpl3_baishidingwei(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzhi.append(data)
                }
            }
            let wanweiItem = PeilvData()
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
        }
        return list
    }
    
    ////排列3 百十,佰个，拾个定位
    static func calcpl3_erzhidingwei(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...99{
                        let data = PeilvPlayData()
                        data.number = String.init(format:"%02d",index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        data.allDatas = webValue
                        shuzhi.append(data)
                    }
                }
            }
            let wanweiItem = PeilvData()
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
        }
        return list
    }
    
    ////排列3 三字定位
    static func calcpl3_sanzhidingwei(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...999{
                        let data = PeilvPlayData()
                        data.number = String.init(format:"%03d",index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        data.allDatas = webValue
                        shuzhi.append(data)
                    }
                }
            }
            let wanweiItem = PeilvData()
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
        }
        return list
    }
    
    ////排列3 二字三字和数
    static func calcpl3_er_san_ziheshu(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        var qitashuzhi = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    qitashuzhi.append(data)
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for i in 0...9{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: i)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
            
            let wanweiItem = PeilvData()
            wanweiItem.appendTag = true
            wanweiItem.tagName = "尾数"
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
            
            
            let wanweiItem2 = PeilvData()
            wanweiItem2.appendTag = false
            wanweiItem2.tagName = ""
            wanweiItem2.subData = qitashuzhi
            list.append(wanweiItem2)
        }
        return list
    }
    
    ////排列3 组选三，六
    static func calcpl3_zuxuan_san_liu(webResult:[PeilvWebResult]?) -> [PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            let result = webValue[0]
            if result.markType == PeilvParser.MARK_TYPE_QITA{
                for i in 0...9{
                    let data = PeilvPlayData()
                    data.number = String.init(describing: i)
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    data.allDatas = webValue
                    data.checkbox = true
                    shuzhi.append(data)
                }
            }
            let wanweiItem = PeilvData()
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
        }
        return list
    }
    
    //排列3 整合
    static func calcPailie3zh(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shuzhi = [PeilvPlayData]()
        var qitashuzhi = [PeilvPlayData]()
        var zzzzlhh = [PeilvPlayData]()
        var bsdbz = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    if (name == "0" || name == "1" || name == "2" ||
                        name == "3" || name == "4" || name == "5" || name == "6" ||
                        name == "7" || name == "8" || name == "9"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        qitashuzhi.append(data)
                    }else if (name == "总和大" || name == "总和小" || name == "总和单" ||
                        name == "总和双" || name == "龙" || name == "虎" || name == "和"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        zzzzlhh.append(data)
                    }else if (name == "豹子" || name == "顺子" || name == "对子" ||
                        name == "半顺" || name == "杂六"){
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        bsdbz.append(data)
                    }
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 0...9{
                        let data = PeilvPlayData()
                        data.number = String.init(describing: index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        shuzhi.append(data)
                    }
                }
            }
            
            //独胆
            let wanweiItem = PeilvData()
            wanweiItem.tagName = "独胆"
            wanweiItem.appendTag = true
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
            
            //跨度
            let kuaduItem = PeilvData()
            kuaduItem.tagName = "跨度"
            kuaduItem.appendTag = true
            kuaduItem.subData = qitashuzhi
            list.append(kuaduItem)
            
            //总和，龙虎
            let zhlhItem = PeilvData()
            zhlhItem.tagName = "总和，龙虎"
            zhlhItem.appendTag = false
            zhlhItem.subData = zzzzlhh
            list.append(zhlhItem)
            
            //3连
            let slianItem = PeilvData()
            slianItem.tagName = "3连"
            slianItem.appendTag = false
            slianItem.subData = bsdbz
            list.append(slianItem)
            
            return list
        }
        return list
    }
    
    
    
    //六合彩-特码
    static func calcLhcTema(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shuzhi = [PeilvPlayData]()
        var dxdshhhhwwhll = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    let data = PeilvPlayData()
                    data.number = name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    dxdshhhhwwhll.append(data)
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    let name = result.name
                    let data = PeilvPlayData()
                    data.number = name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzhi.append(data)
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
            
            //第二项
            let kuaduItem = PeilvData()
            kuaduItem.tagName = ""
            kuaduItem.appendTag = false
            kuaduItem.subData = dxdshhhhwwhll
            list.append(kuaduItem)
            
            return list
        }
        return list
    }
    
    
    //六合彩-正码
    static func calcLhcZhenma(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shuzhi = [PeilvPlayData]()
        var hhhh = [PeilvPlayData]()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    let data = PeilvPlayData()
                    data.number = name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    hhhh.append(data)
                }else if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    let name = result.name
                    let data = PeilvPlayData()
                    data.number = name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    shuzhi.append(data)
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
            
            //第二项
            let kuaduItem = PeilvData()
            kuaduItem.tagName = ""
            kuaduItem.appendTag = false
            kuaduItem.subData = hhhh
            list.append(kuaduItem)
            
            return list
        }
        return list
    }
    
    //六合彩-正码1-6
    static func calcLhcZhenma16(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        var hhhh = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let name = result.name
                    let data = PeilvPlayData()
                    data.number = name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    hhhh.append(data)
                }
            }
            //第一项
            let array = ["正码一","正码二","正码三","正码四","正码五","正码六"]
            for str in array{
                let wanweiItem = PeilvData()
                wanweiItem.tagName = str
                wanweiItem.appendTag = true
                var wanweiList = [PeilvPlayData]()
                wanweiList = wanweiList + hhhh
                let subDatas = wanweiList.map{$0.copy() as! PeilvPlayData}
                wanweiItem.subData = subDatas
                list.append(wanweiItem)
            }
        }
        return list
    }
    
    
    //六合彩-连码
    static func calcLhcLianma(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 1...49{
                        let name = String.init(format: "%02d", index)
                        let data = PeilvPlayData()
                        data.number = name
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        data.checkbox = true
                        data.allDatas = webValue
                        shuzhi.append(data)
                    }
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    //六合彩-特码半波
    static func calcLhcTemaBB(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_QITA{
                    let data = PeilvPlayData()
                    data.number = result.name
                    data.peilv = String.init(format: "%.3f", result.odds)
                    data.peilvData = result
                    data.allDatas = webValue
                    shuzhi.append(data)
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    
    //六合彩-一肖尾数
    static func calcLhcYXWS(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shengxiaoData = [PeilvPlayData]()
        var weishu0Data = [PeilvPlayData]()
        var weishu19Data = [PeilvPlayData]()
        
//        let year = getYear()
//        let shengxiao = ["鼠|10,22,34,46","牛|09,21,33,45","虎|08,20,32,44","兔|07,19,31,43","龙|06,18,30,42","蛇|05,17,29,41","马|04,16,28,40","羊|03,15,27,39",
//                         "猴|02,14,26,38","鸡|01,13,25,37,49","狗|12,24,36,48","猪|11,23,35,47"]
        let shengxiao = getNumbersFromShengXiao()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHENGXIAO{
                    if result.isNowYear != 1{
                        for item in shengxiao{
                            let  itemValue = item.components(separatedBy: "|")
                            let data = PeilvPlayData()
                            data.number = itemValue[0]
                            data.helpNumber = itemValue[1]
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            shengxiaoData.append(data)
                        }
                    }
                }else if result.markType == PeilvParser.MARK_TYPE_WEISHU{
                    if result.isNowYear == 1{
                        let data = PeilvPlayData()
                        data.number = "0尾"
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        weishu0Data.append(data)
                    }else{
                        for index in 1...9{
                            let data = PeilvPlayData()
                            data.number = String.init(format: "%d尾", index)
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            weishu19Data.append(data)
                        }
                    }
                }
            }
            
            //遍历赔率数据，将十二生肖中本命年的那个生肖赔率调整为本命年生肖的赔率
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHENGXIAO{
                    if (result.isNowYear == 1 && shengxiaoData.count > 0){
                        for index in 0...shengxiaoData.count-1{
                            let shenxiao = shengxiaoData[index]
                            let nowYear = getShengXiaoFromYear()
                            if nowYear == shenxiao.number{
                                let data = PeilvPlayData()
                                data.number = shenxiao.number
                                data.helpNumber = shenxiao.helpNumber
                                data.peilv = String.init(format: "%.3f", result.odds)
                                data.peilvData = result
                                shengxiaoData[index] = data
                            }
                        }
                        break
                    }
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shengxiaoData
            list.append(wanweiItem)
            
            //第er项
            let weishuItem = PeilvData()
            weishuItem.tagName = ""
            weishuItem.appendTag = false
            var weishuData = [PeilvPlayData]()
            weishuData = weishuData + weishu0Data
            weishuData = weishuData + weishu19Data
            weishuItem.subData = weishuData
            list.append(weishuItem)
            
            return list
        }
        return list
    }
    
    //六合彩-一特码生肖
    static func calcLhcTemaShengXiao(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shengxiaoData = [PeilvPlayData]()
//        let year = getYear()
//        let shengxiao = ["鼠|10,22,34,46","牛|09,21,33,45","虎|08,20,32,44","兔|07,19,31,43","龙|06,18,30,42","蛇|05,17,29,41","马|04,16,28,40","羊|03,15,27,39",
//                         "猴|02,14,26,38","鸡|01,13,25,37,49","狗|12,24,36,48","猪|11,23,35,47"]
        let shengxiao = getNumbersFromShengXiao()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHENGXIAO{
                    if result.isNowYear != 1{
                        for item in shengxiao{
                            let  itemValue = item.components(separatedBy: "|")
                            let data = PeilvPlayData()
                            data.number = itemValue[0]
                            data.helpNumber = itemValue[1]
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            shengxiaoData.append(data)
                        }
                    }
                }
            }
            //遍历赔率数据，将十二生肖中本命年的那个生肖赔率调整为本命年生肖的赔率
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHENGXIAO{
                    if (result.isNowYear == 1 && shengxiaoData.count > 0){
                        for index in 0...shengxiaoData.count-1{
                            let shenxiao = shengxiaoData[index]
                            let nowYear = getShengXiaoFromYear()
                            if nowYear == shenxiao.number{
                                let data = PeilvPlayData()
                                data.number = shenxiao.number
                                data.helpNumber = shenxiao.helpNumber
                                data.peilv = String.init(format: "%.3f", result.odds)
                                data.peilvData = result
                                shengxiaoData[index] = data
                            }
                        }
                        break
                    }
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shengxiaoData
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    //六合彩-合肖,连肖
    static func calcLhcHexiaoLianXiao(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shengxiaoData = [PeilvPlayData]()
//        let year = getYear()
//        let shengxiao = ["鼠|10,22,34,46","牛|09,21,33,45","虎|08,20,32,44","兔|07,19,31,43","龙|06,18,30,42","蛇|05,17,29,41","马|04,16,28,40","羊|03,15,27,39",
//                         "猴|02,14,26,38","鸡|01,13,25,37,49","狗|12,24,36,48","猪|11,23,35,47"]
        let shengxiao = getNumbersFromShengXiao()
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHENGXIAO{
                    if result.isNowYear != 1{
                        for item in shengxiao{
                            let  itemValue = item.components(separatedBy: "|")
                            let data = PeilvPlayData()
                            data.number = itemValue[0]
                            data.helpNumber = itemValue[1]
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            data.allDatas = webValue
                            data.checkbox = true
                            shengxiaoData.append(data)
                        }
                    }
                }
            }
            
            //遍历赔率数据，将十二生肖中本命年的那个生肖赔率调整为本命年生肖的赔率
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHENGXIAO{
                    if (result.isNowYear == 1 && shengxiaoData.count > 0){
                        for index in 0...shengxiaoData.count-1{
                            let shenxiao = shengxiaoData[index]
                            let nowYear = getShengXiaoFromYear()
                            if nowYear == shenxiao.number{
                                let data = PeilvPlayData()
                                data.number = shenxiao.number
                                data.helpNumber = shenxiao.helpNumber
                                data.peilv = String.init(format: "%.3f", result.odds)
                                data.peilvData = result
                                data.allDatas = webValue
                                data.checkbox = true
                                shengxiaoData[index] = data
                            }
                        }
                        break
                    }
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shengxiaoData
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    //六合彩-全不中
    static func calcLhcQbz(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var shuzhi = [PeilvPlayData]()
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_SHUZI{
                    for index in 1...49{
                        let data = PeilvPlayData()
                        data.number = String.init(format: "%02d", index)
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        data.allDatas = webValue
                        data.checkbox = true
                        shuzhi.append(data)
                    }
                }
            }
            
            //数字项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            wanweiItem.subData = shuzhi
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    //六合彩-尾数连
    static func calcLhcWsl(webResult:[PeilvWebResult]?) ->[PeilvData]{
        var list = [PeilvData]()
        if webResult == nil{
            return list
        }
        
        var weishu0Data = [PeilvPlayData]()
        var weishu19Data = [PeilvPlayData]()
        
        let weishu = ["10,20,30,40","01,11,21,31,41","02,12,22,32,42","03,13,23,33,43","04,14,24,34,44","05,15,25,35,45","06,16,26,36,46","07,17,27,37,47",
                         "08,18,28,38,48","09,19,29,39,49"]
        
        if let webValue = webResult{
            for result in webValue{
                if result.markType == PeilvParser.MARK_TYPE_WEISHU{
                    
                    if result.isNowYear == 1{
                        let data = PeilvPlayData()
                        data.number = "0尾"
                        data.helpNumber = weishu[0]
                        data.peilv = String.init(format: "%.3f", result.odds)
                        data.peilvData = result
                        data.allDatas = webValue
                        data.checkbox = true
                        weishu0Data.append(data)
                    }else{
                        for index in 1...9{
                            let data = PeilvPlayData()
                            data.number = String.init(format: "%d尾", index)
                            data.peilv = String.init(format: "%.3f", result.odds)
                            data.peilvData = result
                            data.helpNumber = weishu[index]
                            data.allDatas = webValue
                            data.checkbox = true
                            weishu19Data.append(data)
                        }
                    }
                }
            }
            
            //第一项
            let wanweiItem = PeilvData()
            wanweiItem.tagName = ""
            wanweiItem.appendTag = false
            var weishuData = [PeilvPlayData]()
            weishuData = weishuData + weishu0Data
            weishuData = weishuData + weishu19Data
            wanweiItem.subData = weishuData
            list.append(wanweiItem)
            
            return list
        }
        return list
    }
    
    
}
