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
 * 显示的玩法标签文字 等
 * @param lotType 彩票代号
 * @param subCode 小玩法code
 * @return
 */
func form_jianjing_pane_datasources(lotType:String,subCode:String) -> [BallonRules]{
    
    if isEmptyString(str: subCode) {
        return []
    }
    let ballonRules = form_jianjing_datasources(lotType: lotType, rcode: subCode)
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
    var postNumbersArray:[String]=[];
    if !isEmptyString(str: postNums){
        postNumbersArray = postNums.components(separatedBy: ",")
    }
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


//根据彩票代号，小玩法确定玩法面板列表的显示数据源
func form_jianjing_datasources(lotType:String,rcode:String) -> [BallonRules] {
    
    //时时彩,分分彩
    if (lotType == "1"||lotType == "2") {
        
        print("rcode ==== ",rcode)
        //五星---------------------
        //五星直选
        if rcode == "wxfs" || rcode == "wxzh"{
            return JianjinLotteryLogic.calcWxfs(subCode: rcode)
        }else if rcode == "wxds"{
            return []
        }else if (rcode == "wz5" || rcode == "wz10"
            || rcode == "wz20"
            || rcode == "wz30"
            || rcode == "wz60"
            || rcode == "wz120") {
            return JianjinLotteryLogic.calcWxzx(subCode:rcode)
        }
        //前四--------------------
        //前四直选
        else if (rcode == "qszh" || rcode == "qsfs" || rcode == "qsds") {
            if (rcode == "qsds") {
                return [];
            } else {
                return JianjinLotteryLogic.calcQszx(subCode:rcode);
            }
        }
        //前四组选
        else if (rcode == "qsz4" || rcode == "qsz6" ||
            rcode == "qsz12" || rcode == "qsz24") {
            return JianjinLotteryLogic.calcQszhux(subCode:rcode);
        }
        //后四--------------------
        //后四直选
        else if (rcode == "hszh" || rcode == "hsfs" || rcode == "hsds") {
            if (rcode == "hsds") {
                return [];
            } else {
                return JianjinLotteryLogic.calcHszx(subCode:rcode);
            }
        }
        //后四组选
        else if (rcode == "hsz4" || rcode == "hsz6" ||
            rcode == "hsz12" || rcode == "hsz24") {
            return JianjinLotteryLogic.calcHszhux(subCode:rcode);
        }
        //后三码--------------------
        //后三直选
        else if (rcode == "hsanfs" || rcode == "hsands" || rcode == "hsanhz") {
            return JianjinLotteryLogic.calcHsanzx(subCode:rcode);
        }
        //后三组选
        else if (rcode == "hsanzu3" || rcode == "hsanzu6" ||
            rcode == "hsanhzu" || rcode == "hsanhez") {
            return JianjinLotteryLogic.calcHsanzhux(subCode:rcode);
        }
        //前三码--------------------
        //前三直选
        else if (rcode == "qsanfs" || rcode == "qsands" || rcode == "qsanhz") {
            return JianjinLotteryLogic.calcQsanzx(subCode:rcode);
        }
        //前三组选
        else if (rcode == "qsanzu3" || rcode == "qsanzu6" ||
            rcode == "qsanhzu" || rcode == "qsanhez") {
            return JianjinLotteryLogic.calcQsanzhux(subCode:rcode);
        }
        //中三码--------------------
        //中三直选
        else if (rcode == "zsfs" || rcode == "zsds" || rcode == "zshz") {
            return JianjinLotteryLogic.calcZsanzx(subCode:rcode);
        }
        //中三组选
        else if (rcode == "zszu3" || rcode == "zszu6" ||
            rcode == "zshzu" || rcode == "zshez") {
            return JianjinLotteryLogic.calcZsanzhux(subCode:rcode);
        }
        //二码--------------------
        //二星直选
        else if (rcode == "hefs" || rcode == "qefs" || rcode == "qeds"
            || rcode == "hehz" || rcode == "qehz") {
            return JianjinLotteryLogic.calcEXZX(subCode:rcode);
        }
        //二星组选
        else if (rcode == "hefsz" || rcode == "hedsz" ||
            rcode == "qefsz" || rcode == "qedsz" ||
            rcode == "hehzz" || rcode == "qehzz") {
            return JianjinLotteryLogic.calcEXZUX(subCode:rcode);
        }
        //定位胆---------------------
        else if (rcode == "dwd") {
            return JianjinLotteryLogic.calcDWD(subCode:rcode);
        }
        //不定胆-------------------
        else if (rcode == "hsymbdwd" || rcode == "hsembdwd"
            || rcode == "qsymbdwd" || rcode == "qsembdwd") {
//            return JianjinLotteryLogic.calcBDWD(subCode:rcode);
            return JianjinLotteryLogic.calcMbdwd(subCode:rcode);
        }
        //大小单双------------------
        else if (rcode == "hedxds" || rcode == "qedxds") {
            return JianjinLotteryLogic.calcDXDS(subCode:rcode);
        }
        //趣味----------------------
        else if (rcode == "yffs" || rcode == "hscs" || rcode == "sxbx" ||
            rcode == "sjfc") {
            return JianjinLotteryLogic.calcQuwei(subCode:rcode);
        }
        //任选二---------------
        //任二直选
        else if (rcode == "rezhixfs" || rcode == "rezhixds" || rcode == "rezhixhz") {
            return JianjinLotteryLogic.calcREZX(subCode:rcode);
        }
        //任二组选
        else if (rcode == "rezuxfs" || rcode == "rezuxds" ||
            rcode == "rezuxhz") {
            return JianjinLotteryLogic.calcREZUX(subCode:rcode);
        }
        //任选三--------------------
        //任三直选
        else if (rcode == "rszhixhz" || rcode == "rszhixds" || rcode == "rszhixfs") {
            return JianjinLotteryLogic.calcRsanzhix(subCode:rcode);
        }
        //任三组选
        else if (rcode == "rszuxs" || rcode == "rszuxl" ||
            rcode == "rszuxhz" || rcode == "rszuxhh") {
            return JianjinLotteryLogic.calcRensanzhux(subCode:rcode);
        }
        //任选四------------------------
        //任四直选
        else if (rcode == "rsizhixds" || rcode == "rsizhixfs") {
            return JianjinLotteryLogic.calcRshizhix(subCode:rcode);
        }
        //任四组选
        else if (rcode == "zux4" || rcode == "zux6" ||
            rcode == "zux12" || rcode == "zux24") {
            return JianjinLotteryLogic.calcRenshizhux(subCode:rcode);
        }
    //PK师
    }else if lotType == "3"{
        if (rcode == "cgj2") {
            return JianjinLotteryLogic.calcCaiGuangjun(subCode:rcode);
        } else if (rcode == "cqerds" || rcode == "cqerfs") {
            return JianjinLotteryLogic.calcCaiQuaner(subCode:rcode);
        } else if (rcode == "cqsanfs" || rcode == "cqsands") {
            return JianjinLotteryLogic.calcCaiQuansan(subCode:rcode);
        } else if (rcode == "cqsifs" || rcode == "cqsids") {
            return JianjinLotteryLogic.calcCaiQuanshi(subCode:rcode);
        } else if (rcode == "cqwufs" || rcode == "cqwuds") {
            return JianjinLotteryLogic.calcCaiQuanwu(subCode:rcode);
        } else if (rcode == "dwd2") {
            return JianjinLotteryLogic.calcPK10DWD(subCode:rcode);
        }
    //快三
    }else if lotType == "4"{
        //同号
        if (rcode == "k3ethdx" || rcode == "k3ethfx" || rcode == "k3sthdx" ||
            rcode == "k3sthfx") {
            //二同号
            if (rcode == "k3ethdx" || rcode == "k3ethfx") {
                return JianjinLotteryLogic.calcErtonghao(subCode:rcode);
            //三同号
            } else if (rcode == "k3sthdx" || rcode == "k3sthfx") {
                return JianjinLotteryLogic.calcSantonghao(subCode:rcode);
            }
            //和值
        } else if (rcode == "k3hz2") {
            return JianjinLotteryLogic.calcTonghaoHz(subCode:rcode);
            //三连号
        } else if (rcode == "k3slh2") {
            return JianjinLotteryLogic.calcSanlianhao(subCode:rcode);
            //不同号
        } else if (rcode == "k3ebth" || rcode == "k3sbth") {
            return JianjinLotteryLogic.calcButonghao(subCode:rcode);
        }
    //11选5
    }else if lotType == "5"{
        //三码--------------------
        if (rcode == "sanmaqszhixfs" || rcode == "sanmaqszhixds" ||
            rcode == "sanmaqszuxfs" || rcode == "sanmaqszuxds") {
            return JianjinLotteryLogic.calc115sanma(subCode:rcode);
        //二码--------------------
        } else if (rcode == "ermaqezhixfs" || rcode == "ermaqezhixds" ||
            rcode == "ermaqezuxfs" || rcode == "ermaqezuxds") {
            return JianjinLotteryLogic.calc115erma(subCode:rcode);
        }
        //不定位胆----------------
        else if (rcode == "bdwd2") {
            return JianjinLotteryLogic.calc115bdwd(subCode:rcode);
        //定位胆-----------------
        } else if (rcode == "dwd2") {
            return JianjinLotteryLogic.calc115dwd(subCode:rcode);
        //趣味型-----------------
        } else if (rcode == "qwxdds" || rcode == "qwxczw") {
            return JianjinLotteryLogic.calc115quweixing(subCode:rcode);
        }
        //任选单式----------------
        else if (rcode == "rxdsyzy" || rcode == "rxdseze" || rcode == "rxdsszsan"
            || rcode == "rxdsszsi" || rcode == "rxdslzw" || rcode == "rxdsqzw"
            || rcode == "rxdsbzw") {
            return JianjinLotteryLogic.calc115Renxuands(subCode:rcode);
        //任选复式----------------
        } else if (rcode == "rxfsyzy" || rcode == "rxfseze" || rcode == "rxfsszsan"
            || rcode == "rxfsszsi" || rcode == "rxfslzw" || rcode == "rxfsqzw"
            || rcode == "rxfsbzw") {
            return JianjinLotteryLogic.calc115Renxuanfs(subCode:rcode);
        }
    //香港彩
    }else if lotType == "6"{
        //....
    //PC蛋蛋
    }else if lotType == "7"{
        //三码
        if (rcode == "sanmzhixhz" || rcode == "sanmzhixfs" || rcode == "sanmzhixds" ||
            rcode == "sanmzuxzs" || rcode == "sanmzuxzl" || rcode == "sanmzuxhh" ||
            rcode == "sanmzuxhz") {
            //组选
            if (rcode == "sanmzuxzs" || rcode == "sanmzuxzl" || rcode == "sanmzuxhh" ||
                rcode == "sanmzuxhz") {
                return JianjinLotteryLogic.calcPCEEZhuxuan(subCode:rcode);
            //直选
            } else if (rcode == "sanmzhixhz" || rcode == "sanmzhixfs" || rcode == "sanmzhixds") {
                return JianjinLotteryLogic.calcPCEEZhixuan(subCode:rcode);
            }
        //不定位
        }else if (rcode == "bdwdym" || rcode == "bdwdem") {
            return JianjinLotteryLogic.calcPCEEBDD(subCode:rcode);
        }
        //二码
        else if (rcode == "ermaqerzhixfs" || rcode == "ermaqerzhixds" ||
            rcode == "ermaqerzuxfs" || rcode == "ermaqerzuxds") {
            return JianjinLotteryLogic.calcPCEEERMAqianer(subCode:rcode);
        }else if (rcode == "ermaherzhixfs" || rcode == "ermaherzhixds" ||
            rcode == "ermaherzuxfs"||rcode == "ermaherzuxds") {
            return JianjinLotteryLogic.calcPCEEERMAhouer(subCode:rcode);
        }
        //定位胆
        else if (rcode == "dwd2") {
            return JianjinLotteryLogic.calcPCEEDWD(subCode:rcode);
        }
        //大小单双
        else if (rcode == "dxdsqer"||rcode == "dxdsher") {
            return JianjinLotteryLogic.calcPCEEDXDS(subCode:rcode);
        }
    //低频彩
    }else if lotType == "8"{
        //三码
        //三码直选
        if (rcode == "sanmzhixhz" || rcode == "sanmzhixfs" || rcode == "sanmzhixds") {
            return JianjinLotteryLogic.calcDpcSanmaZhix(subCode:rcode);
        }
        //三码组选
        else if (rcode == "sanmzuxzs" || rcode == "sanmzuxzl" || rcode == "sanmzuxhh" || rcode == "sanmzuxhz") {
            return JianjinLotteryLogic.calcDpcSanmaZhux(subCode:rcode);
        }
        //不定位
        else if (rcode == "bdwdym" || rcode == "bdwdem") {
            return JianjinLotteryLogic.calcDipincaiBdw(subCode:rcode);
        }
        //二码
        //前二
        if (rcode == "ermaqerzhixfs" || rcode == "ermaqerzhixds" || rcode == "ermaqerzuxfs" ||
            rcode == "ermaqerzuxds") {
            return JianjinLotteryLogic.calcDipincaiErmaqianer(subCode:rcode);
        }
        //后二
        else if (rcode == "ermaherzhixfs" || rcode == "ermaherzhixds" || rcode == "ermaherzuxfs" || rcode == "ermaherzuxds") {
            return JianjinLotteryLogic.calcDipincaiErmaHouer(subCode:rcode);
        }
        //定位胆
        else if (rcode == "dwd2") {
            return JianjinLotteryLogic.calcDipanCaiDWD(subCode:rcode);
        }
        //大小单双
        else if (rcode == "dxdsqer" || rcode == "dxdsher") {
            return JianjinLotteryLogic.calcDipincaiDXDS(subCode:rcode);
        }
        
    }
    return []
}


