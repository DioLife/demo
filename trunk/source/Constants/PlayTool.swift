//
//  PlayTool.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/7.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class PlayTool {
    
    static let official_filter_rules = ["qsds", "hsds", "hsands",
                        "qsands", "zsds", "heds", "qeds", "hedsz", "qedsz", "wxds", "qsds",
                        "heds", "hsds", "hsands", "qsands", "zsds", "qeds",
                        "hedsz", "qedsz", "rezhixds", "rezuxds", "rszhixds", "sanmzhixds",
                        "rsizhixds", "cqerds", "cqsids", "cqwuds", "sanmaqszhixds", "sanmaqszuxds",
                        "ermaqezhixds", "ermaqezuxds", "ermaqerzhixds", "ermaqerzuxds", "ermaherzhixds", "ermaherzuxds",
                        "rezhixds", "rezuxds", "rszhixds", "rsizhixds", "sanmzhixds", "ermaqerzhixds",
                        "ermaqerzuxds", "ermaherzhixds", "ermaherzuxds", "rsizhixds", "sanmzhixds",
                        "ermaqerzhixds","cqsands","hsanhzu","qsanhzu","zshzu","rszuxhh",
                        "rxdsyzy","rxdseze","rxdsszsan","rxdsszsi","rxdslzw","rxdsqzw","rxdsbzw",
                        "sanmzuxhh"]
    
    
    private static func is_filter_play(code:String) -> Bool{
        for rule in official_filter_rules{
            if rule == code{
                return true
            }
        }
        return false
    }

    //获取叶子级子玩法数据集，官方版本
    static func leaf_play_rules(lottery:LotteryData) -> [BcLotteryPlay]{
        var playRules:[BcLotteryPlay] = []
        if lottery.rules.isEmpty{
            return []
        }
        for play in lottery.rules{
            let version = String.init(describing: play.lotVersion)
            if version == VERSION_2{
                //信用玩法两层
                playRules.append(play)
            }else{
                if !play.children.isEmpty{
                    for child in play.children{
                        //官方玩法有三层玩法列表
                        if !child.children.isEmpty{
                            for leaf in child.children{
                                if !is_filter_play(code:leaf.code){
                                    playRules.append(leaf)
                                }
                            }
                        }
                    }
                }
            }
        }
        return playRules
    }
    
}
