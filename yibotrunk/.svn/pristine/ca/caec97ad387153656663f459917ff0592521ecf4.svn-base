//
//  LotteryLogic.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/16.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

/**
 * 根据大小玩法来确定投注面板显示多少行，多少个投注号码，是否显示位数控件，是否显示选号功能便捷控件，
 * 显示的玩法标签文字 等等
 * @param cpVersion  彩票版本号(若彩种是六合彩，则当做是赔率版。此项无效)
 * @param cpCode 彩票代号
 * @param playCode 大玩法code
 * @param ruleCode 小玩法code
 * @return
 */
func calcPaneMessageByPlayRule(cpVersion:String,cpCode:String,
                               playCode:String, ruleCode:String) -> [BallonRules]{
    
    print("cp code = \(cpCode)")
    if isEmptyString(str: playCode) || isEmptyString(str: ruleCode) {
        return []
    }
    let ballonRules = figureOutPlayInfo(cpVersion: cpVersion, cpCode: cpCode, playCode: playCode, ruleCode: ruleCode)
    for br in ballonRules {
        let ballItems:[BallListItemInfo] = convertNumListToEntifyList(numStr: br.nums!, postNums: br.postNums)
        br.ballonsInfo = ballItems
    }
    return ballonRules;
}

/**
 *
 * @param numStr 显示在投注面板上的号码
 * @param postNums 提交后台的号码
 * @return
 */
func convertNumListToEntifyList(numStr:String,postNums:String) -> [BallListItemInfo]{
    let numbersArray = numStr.components(separatedBy: ",")
//    print("after splits numbers = \(numbersArray)")
    var postNumbersArray:[String]=[];
    if !isEmptyString(str: postNums){
        postNumbersArray = postNums.components(separatedBy: ",")
    }
//    print("after splits numbers = \(postNumbersArray)")
    var list = [BallListItemInfo]()
    for index in 0...numbersArray.count-1 {
        let info = BallListItemInfo();
        info.num = numbersArray[index];
        if postNumbersArray.count > 0{
            info.postNum = postNumbersArray[index]
        }
        info.isSelected = false;
        list.append(info)
    }
    return list;
}

func figureOutPeilvPlayInfo(cpVersion:String,cpCode:String,
                            playCode:String,ruleCode:String,
                            pageIndex:Int,pageSize:Int,
                            webResults:[PeilvWebResult]) -> [PeilvData]{
    
    var datas = [PeilvData]()
    if(cpVersion == lottery_identify_V2 || cpVersion == lottery_identify_V4 ||
        cpVersion == lottery_identify_V5){
        
        //时时彩
        if (cpCode == "9") {
            if (playCode == zhenghe){
                datas = LotteryCalculater.calcPeilvZhenhe(webResults: webResults);
            } else if (playCode == wanwei) {
                datas = LotteryCalculater.calcPeilvWeiItem(tagName: "万位",postTagName: "万仟",webResults:webResults);
            }else if (playCode == qianwei) {
                datas = LotteryCalculater.calcPeilvWeiItem(tagName: "千位",postTagName: "仟佰",webResults: webResults);
            }else if (playCode == baiwei) {
                datas = LotteryCalculater.calcPeilvWeiItem(tagName: "百位",postTagName: "佰拾",webResults: webResults);
            }else if (playCode == shiwei) {
                datas = LotteryCalculater.calcPeilvWeiItem(tagName: "十位",postTagName: "拾个",webResults: webResults);
            }else if (playCode == gewei) {
                datas = LotteryCalculater.calcPeilvWeiItem(tagName: "个位",postTagName: "个万",webResults: webResults);
            }else if (playCode == heweishu) {
                datas = LotteryCalculater.calcPeilvHeweishu(webResult: webResults);
            }else if (playCode == longhh) {
                datas = LotteryCalculater.calcPeilvlhd(webResult: webResults);
            }else if (playCode == qipai) {
                if (ruleCode == baijiale) {
                    datas = LotteryCalculater.calcPeilvBaijiale(webResult: webResults);
                } else if (ruleCode == niuniu) {
                    datas = LotteryCalculater.calcPeilvNiuniu(webResult: webResults);
                } else if (ruleCode == dezhoupuke) {
                    datas = LotteryCalculater.calcPeilvdzpk(webResult: webResults);
                } else if (ruleCode == sangong) {
                    datas = LotteryCalculater.calcPeilvSanggong(webResult: webResults);
                }
            }else if (playCode == heshu){
                datas = LotteryCalculater.calcPeilvheshu(webResult: webResults);
            }else if (playCode == yizi) {
                datas = LotteryCalculater.calcPeilvYiZhi(webResult: webResults);
            }else if (playCode == erzi) {
                datas = LotteryCalculater.calcPeilvErSangZhi(webResult: webResults);
            }else if (playCode == sanzi) {
                datas = LotteryCalculater.calcPeilvErSangZhi(webResult: webResults);
            }else if (playCode == erzidingwei) {
                datas = LotteryCalculater.calcPeilvErSangZhiDingWei(webResult: webResults,   max:99);
            }else if (playCode == sanzidingwei) {
                datas = LotteryCalculater.calcPeilvErSangZhiDingWei(webResult: webResults,max:999);
            }else if (playCode == zuxuan_san_peilv) {
                datas = LotteryCalculater.calcPeilvZuxuan(webResult: webResults);
            }else if (playCode == zuxuan_liu_peilv) {
                datas = LotteryCalculater.calcPeilvZuxuan(webResult: webResults);
            }else if (playCode == kuadu) {
                datas = LotteryCalculater.calcFFCKuadu(webResult: webResults);
            }
        //快三
        }else if (cpCode == "10") {
            if (playCode == daxiaoshaibao){
                datas = LotteryCalculater.calcSaibao(webResult: webResults);
            }
        }
        //pc蛋蛋，加拿大28
        else if (cpCode == "11") {
            datas = LotteryCalculater.calcPC28(webResult: webResults);
        }
        //重庆幸运农场,湖南快乐十分,广东快乐十分
        else if (cpCode == "12"){
            if (playCode == danqiu1_8) {
                datas = LotteryCalculater.calcKuaile10Dangqiu18(webResult: webResults);
            }else if (playCode == diyiqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex: "一",webResult: webResults);
            }else if (playCode == dierqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex:"二",webResult:
                    webResults);
            }else if (playCode == disanqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex:"三",webResult:
                    webResults);
            }else if (playCode == disiqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex:"四",webResult:
                    webResults);
            }else if (playCode == diwuqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex:"五",webResult:
                    webResults);
            }else if (playCode == diliuqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex:"六",webResult:
                    webResults);
            }else if (playCode == diqiqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex:"七",webResult:
                    webResults);
            }else if (playCode == dibaqiu){
                datas = LotteryCalculater.calcKuaile10WhichBallon(qiuIndex:"八",webResult:
                    webResults);
            }else if (playCode == lianma_peilv_klsf){
                datas = LotteryCalculater.calcKuaile10Lianma(webResult:webResults);
            }else if (playCode == shuangmianpan){
                datas = LotteryCalculater.calcKuaile10smp(webResult: webResults);
            }
        }
        //极速赛车，北京赛车，幸运飞艇
        else if (cpCode == "8") {
            if (playCode == guan_yajun) {
                datas = LotteryCalculater.calcSaicheGyj(webResult: webResults);
            } else if (playCode == danhao1_10) {
                datas = LotteryCalculater.calcSaicheDanhao110(webResult: webResults);
            } else if (playCode == shuangmianpan) {
                datas = LotteryCalculater.calcSaicheSMP(webResult: webResults);
            }
        }
        //11选5
        if (cpCode == "14") {
            if (playCode == syx5_shuangmianpan) {
                datas = LotteryCalculater.calc11x5smp(webResult: webResults);
            } else if (playCode == syx5_15qiu) {
                datas = LotteryCalculater.calc11x515(webResult: webResults);
            } else if (playCode == syx5_renxuan) {
                datas = LotteryCalculater.calc11x515RenXuan(webResult: webResults);
            } else if (playCode == syx5_zuxuan) {
                datas = LotteryCalculater.calc11x515zuXuan(webResult: webResults);
            } else if (playCode == syx5_zhixuan) {
                datas = LotteryCalculater.calc11x515zhiXuan(webResult: webResults,rcode: ruleCode);
            }
        }
        //福彩3D，排列三
        else if (cpCode == "15") {
            if (playCode == pl3_13qiu) {
                datas = LotteryCalculater.calcPailie3(webResult: webResults);
            } else if (playCode == pl3_zhenghe) {
                datas = LotteryCalculater.calcPailie3zh(webResult: webResults);
            } else if (playCode == pl3_zhushipan) {
                datas = LotteryCalculater.calcpl3_zhushipan(webResult: webResults);
            } else if (playCode == pl3_yizizuhe) {
                datas = LotteryCalculater.calcpl3_yizizuhe(webResult: webResults);
            } else if (playCode == pl3_erzizuhe) {
                datas = LotteryCalculater.calcpl3_erzizuhe(webResult: webResults);
            } else if (playCode == pl3_sanzizuhe) {
                datas = LotteryCalculater.calcpl3_sanzizuhe(webResult: webResults);
            } else if (ruleCode == pl3_baishidingwei) {
                datas = LotteryCalculater.calcpl3_erzhidingwei(webResult: webResults);
            } else if (ruleCode == pl3_baigedingwei) {
                datas = LotteryCalculater.calcpl3_erzhidingwei(webResult: webResults);
            } else if (ruleCode == pl3_shigedingwei) {
                datas = LotteryCalculater.calcpl3_erzhidingwei(webResult: webResults);
            } else if (playCode == pl3_sanzidingwei) {
                datas = LotteryCalculater.calcpl3_sanzhidingwei(webResult: webResults);
            }
            else if (ruleCode == pl3_baishiheshu) {
                datas = LotteryCalculater.calcpl3_er_san_ziheshu(webResult: webResults);
            }else if (ruleCode == pl3_baigeheshu) {
                datas = LotteryCalculater.calcpl3_er_san_ziheshu(webResult: webResults);
            }else if (ruleCode == pl3_shigeheshu) {
                datas = LotteryCalculater.calcpl3_er_san_ziheshu(webResult: webResults);
            }else if (ruleCode == pl3_sanziheshu) {
                datas = LotteryCalculater.calcpl3_er_san_ziheshu(webResult: webResults);
            }else if (ruleCode == pl3_zuxuansan || ruleCode == pl3_zuxuanliu) {
                datas = LotteryCalculater.calcpl3_zuxuan_san_liu(webResult: webResults);
            }
            
        }
        //六合彩，十分六合彩
        else if (cpCode == "6" || cpCode == "66") {
            if (playCode == tema) {
                datas = LotteryCalculater.calcLhcTema(webResult: webResults);
            }else if (playCode == zhentema) {
                datas = LotteryCalculater.calcLhcTema(webResult: webResults);
            }else if (playCode == zhenma) {
                datas = LotteryCalculater.calcLhcZhenma(webResult: webResults);
            }else if (playCode == zm16) {
                datas = LotteryCalculater.calcLhcZhenma16(webResult: webResults);
            }else if (playCode == lianma) {
                datas = LotteryCalculater.calcLhcLianma(webResult: webResults);
            }else if (playCode == bb) {
                datas = LotteryCalculater.calcLhcTemaBB(webResult: webResults);
            }else if (playCode == yixiao_weishu) {
                datas = LotteryCalculater.calcLhcYXWS(webResult: webResults);
            }else if (playCode == txsm) {
                datas = LotteryCalculater.calcLhcTemaShengXiao(webResult: webResults);
            }else if (playCode == lianxiao) {
                datas = LotteryCalculater.calcLhcHexiaoLianXiao(webResult: webResults);
            }else if (playCode == hexiao) {
                datas = LotteryCalculater.calcLhcHexiaoLianXiao(webResult: webResults);
            }else if (playCode == quanbuzhong) {
                datas = LotteryCalculater.calcLhcQbz(webResult: webResults);
            }else if (playCode == weishulian) {
                datas = LotteryCalculater.calcLhcWsl(webResult: webResults);
            }
        }
    }
    
    //分开获取数据，pageIndex 从1 开始
    
    //        if (datas != null ){
    //            List<PeilvData> newDatas = new ArrayList<PeilvData>();
    //            for (int i=0;i<datas.size();i++) {
    //                PeilvData d = datas.get(i);
    //                if (d == null) {
    //                    continue;
    //                }
    //                List<PeilvPlayData> subData = d.getSubData();
    //                if (subData != null) {
    //                    if (pageIndex < 1) {
    //                        throw new IllegalStateException("the page index must start at 1");
    //                    }
    //                    int totalSize = subData.size();
    //                    if (totalSize >= pageIndex*pageSize) {
    //                        subData = subData.subList((pageIndex-1)*pageSize, (pageIndex) * pageSize);
    //                    }else{
    //                        if (totalSize > (pageIndex - 1)*pageSize && totalSize < pageIndex*pageSize){
    //                            subData = subData.subList((pageIndex-1)*pageSize, (totalSize));
    //                        }else{
    //                            subData = new ArrayList<PeilvPlayData>();
    //                        }
    //                    }
    //                    d.setSubData(subData);
    //                }
    //                newDatas.add(d);
    //            }
    //            return newDatas;
    //        }
    return  datas;
    
}

// figure out play ballons info according to cpversion playcode play rule
func figureOutPlayInfo(cpVersion:String,cpCode:String,playCode:String,ruleCode:String) -> [BallonRules] {
    
    if cpVersion == lottery_identify_V1{
        //时时彩
        if (cpCode == "1"||cpCode == "2") {
            if (playCode == dxds) {
                return LotteryCalculater.calPlayDxds(pcode: playCode, rcode: ruleCode);
            }else if (playCode == dwd) {
                return LotteryCalculater.calPlayDwd(pcode: playCode, rcode: ruleCode);
            }else if (playCode == longhh) {
                return LotteryCalculater.calPlayLonghuhe(pcode:playCode, rcode:ruleCode);
            }else if (playCode == rxwf) {
                return LotteryCalculater.calPlayRxwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == exzx) {
                return LotteryCalculater.calPlayExzx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sxzux||playCode == sxzx) {
                return LotteryCalculater.calPlaySxzx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sxwf_var) {
                return LotteryCalculater.calPlaySxwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sixing_wf) {
                return LotteryCalculater.calPlaySixingwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == wuxing_wf) {
                return LotteryCalculater.calPlayWuxinwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == caibaozi) {
                return LotteryCalculater.calPlayCaibaozhi(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw || playCode == bdwd) {
                return LotteryCalculater.calFFCPlayBdw(pcode:playCode, rcode:ruleCode);
            }
            //sai che
        }else if(cpCode == "3"){
            if (playCode == dwd) {
                return LotteryCalculater.calPlaySaicheDwd(pcode:playCode, rcode:ruleCode);
            }else if (playCode == lh){
                return LotteryCalculater.calLonghuChampion(pcode:playCode, rcode:ruleCode);
            }else if (playCode == q1_str){
                return LotteryCalculater.calQianyi(pcode:playCode, rcode:ruleCode);
            }else if (playCode == q2_str){
                return LotteryCalculater.calQianer(pcode:playCode, rcode:ruleCode);
            }else if (playCode == gyh){
                return LotteryCalculater.calGuanYaHe(pcode:playCode, rcode:ruleCode);
            }else if (playCode == q3_str) {
                return LotteryCalculater.calQianShang(pcode:playCode, rcode:ruleCode);
            }
        }
            //福彩3D，排列3
        else if (cpCode == "4") {
            if (playCode == zhi_xuan_str) {
                return LotteryCalculater.calZxfs(pcode:playCode, rcode:ruleCode);
            }else if (playCode == zhuxuan_str){
                return LotteryCalculater.calZhuxuan63(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw_fx3d){
                return LotteryCalculater.calBdw(pcode:playCode, rcode:ruleCode);
            }else if (playCode == er_ma_str){
                return LotteryCalculater.calErma(pcode:playCode, rcode:ruleCode);
            }else if (playCode == dxds) {
                return LotteryCalculater.calFucai3DPlayDxds(pcode:playCode, rcode:ruleCode);
            }else if (playCode == dwd) {
                return LotteryCalculater.calFucai3DPlayDwd(pcode:playCode, rcode:ruleCode);
            }
        }
            //11选5
        else if (cpCode == "5") {
            if (playCode == rxfs) {
                return LotteryCalculater.calRxfs(pcode:playCode, rcode:ruleCode);
            }else if (playCode == dwd) {
                return LotteryCalculater.calPlac11x5Dwd(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw_11x5) {
                return LotteryCalculater.cal11x5Bdw(pcode:playCode, rcode:ruleCode);
            }else if (playCode == er_ma_str) {
                return LotteryCalculater.cal11x5Erma(pcode:playCode, rcode:ruleCode);
            }else if (playCode == shang_ma_str) {
                return LotteryCalculater.cal11x5Shangma(pcode:playCode, rcode:ruleCode);
            }
            //快三
        }else if (cpCode == "100"){
            if (playCode == hz) {
                return LotteryCalculater.calcK3Hezi(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sthtx) {
                return LotteryCalculater.calcK3sthtx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sthdx) {
                return LotteryCalculater.calcK3sthdx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sbtx) {
                return LotteryCalculater.calcK3sbth(pcode:playCode, rcode:ruleCode);
            }else if (playCode == slhtx) {
                return LotteryCalculater.calcK3slhtx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == ethfx) {
                return LotteryCalculater.calcK3Ethfx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == ethdx) {
                return LotteryCalculater.calcK3Ethdx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == ebth) {
                return LotteryCalculater.calcK3Ebth(pcode:playCode, rcode:ruleCode);
            }
        }
        //PC蛋蛋，加拿大28
        else if (cpCode == "7") {
            if (playCode == dwd) {
                return LotteryCalculater.calPlayPCDDDwd(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw) {
                return LotteryCalculater.calpcddBdw(pcode:playCode, rcode:ruleCode);
            }else if (playCode == exwf_str) {
                return LotteryCalculater.calPlayPCDDExwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sxwf_pcegg) {
                return LotteryCalculater.calPlayPCDDSxwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == hz) {
                return LotteryCalculater.calPlayPCDDhezi(pcode:playCode, rcode:ruleCode);
            }
        }
            //六合彩
        else if (cpCode == "6" || cpCode == "66") {
            //跳到赔率版
        }
    }else if cpVersion == lottery_identify_V3{
        //时时彩
        if (cpCode == "51"||cpCode == "52") {
            if (playCode == dxds) {
                return LotteryCalculater.calPlayDxds(pcode: playCode, rcode: ruleCode);
            }else if (playCode == dwd) {
                return LotteryCalculater.calPlayDwd(pcode: playCode, rcode: ruleCode);
            }else if (playCode == longhh) {
                return LotteryCalculater.calPlayLonghuhe(pcode:playCode, rcode:ruleCode);
            }else if (playCode == rxwf) {
                return LotteryCalculater.calPlayRxwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == exzx) {
                return LotteryCalculater.calPlayExzx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sxzux || playCode == sxzx) {
                return LotteryCalculater.calPlaySxzx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sxwf_var) {
                return LotteryCalculater.calPlaySxwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sixing_wf) {
                return LotteryCalculater.calPlaySixingwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == wuxing_wf) {
                return LotteryCalculater.calPlayWuxinwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == caibaozi) {
                return LotteryCalculater.calPlayCaibaozhi(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw || playCode == bdwd) {
                return LotteryCalculater.calFFCPlayBdw(pcode:playCode, rcode:ruleCode);
            }
        //sai che
        }else if(cpCode == "53"){
            if (playCode == dwd) {
                return LotteryCalculater.calPlaySaicheDwd(pcode:playCode, rcode:ruleCode);
            }else if (playCode == lh){
                return LotteryCalculater.calLonghuChampion(pcode:playCode, rcode:ruleCode);
            }else if (playCode == q1_str){
                return LotteryCalculater.calQianyi(pcode:playCode, rcode:ruleCode);
            }else if (playCode == q2_str){
                return LotteryCalculater.calQianer(pcode:playCode, rcode:ruleCode);
            }else if (playCode == gyh){
                return LotteryCalculater.calGuanYaHe(pcode:playCode, rcode:ruleCode);
            }else if (playCode == q3_str) {
                return LotteryCalculater.calQianShang(pcode:playCode, rcode:ruleCode);
            }
        }
        //福彩3D，排列3
        else if (cpCode == "54") {
            if (playCode == zhi_xuan_str) {
                return LotteryCalculater.calZxfs(pcode:playCode, rcode:ruleCode);
            }else if (playCode == zhuxuan_str){
                return LotteryCalculater.calZhuxuan63(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw_fx3d){
                return LotteryCalculater.calBdw(pcode:playCode, rcode:ruleCode);
            }else if (playCode == er_ma_str){
                return LotteryCalculater.calErma(pcode:playCode, rcode:ruleCode);
            }else if (playCode == dxds) {
                return LotteryCalculater.calFucai3DPlayDxds(pcode:playCode, rcode:ruleCode);
            }else if (playCode == dwd) {
                return LotteryCalculater.calFucai3DPlayDwd(pcode:playCode, rcode:ruleCode);
            }
        }
        //11选5
        else if (cpCode == "55") {
            if (playCode == rxfs) {
                return LotteryCalculater.calRxfs(pcode:playCode, rcode:ruleCode);
            }else if (playCode == dwd) {
                return LotteryCalculater.calPlac11x5Dwd(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw_11x5) {
                return LotteryCalculater.cal11x5Bdw(pcode:playCode, rcode:ruleCode);
            }else if (playCode == er_ma_str) {
                return LotteryCalculater.cal11x5Erma(pcode:playCode, rcode:ruleCode);
            }else if (playCode == shang_ma_str) {
                return LotteryCalculater.cal11x5Shangma(pcode:playCode, rcode:ruleCode);
            }
        //快三
        }else if (cpCode == "58"){
            if (playCode == hz) {
                return LotteryCalculater.calcK3Hezi(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sthtx) {
                return LotteryCalculater.calcK3sthtx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sthdx) {
                return LotteryCalculater.calcK3sthdx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sbtx) {
                return LotteryCalculater.calcK3sbth(pcode:playCode, rcode:ruleCode);
            }else if (playCode == slhtx) {
                return LotteryCalculater.calcK3slhtx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == ethfx) {
                return LotteryCalculater.calcK3Ethfx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == ethdx) {
                return LotteryCalculater.calcK3Ethdx(pcode:playCode, rcode:ruleCode);
            }else if (playCode == ebth) {
                return LotteryCalculater.calcK3Ebth(pcode:playCode, rcode:ruleCode);
            }
        }
        //PC蛋蛋，加拿大28
        else if (cpCode == "57") {
            if (playCode == dwd) {
                return LotteryCalculater.calPlayPCDDDwd(pcode:playCode, rcode:ruleCode);
            }else if (playCode == bdw) {
                return LotteryCalculater.calpcddBdw(pcode:playCode, rcode:ruleCode);
            }else if (playCode == exwf_str) {
                return LotteryCalculater.calPlayPCDDExwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == sxwf_pcegg) {
                return LotteryCalculater.calPlayPCDDSxwf(pcode:playCode, rcode:ruleCode);
            }else if (playCode == hz) {
                return LotteryCalculater.calPlayPCDDhezi(pcode:playCode, rcode:ruleCode);
            }
        }
        //六合彩
        else if (cpCode == "6" || cpCode == "66") {
            //跳到赔率版
        }
    }
    
    return []
}


