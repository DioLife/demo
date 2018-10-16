//
//  LotteryResultsInstance.swift
//  gameplay
//
//  Created by admin on 2018/8/5.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit
//
//class LotteryResultsInstance: NSObject {
//
//}



class LotteryResultsInstance {
    
    static let shared = LotteryResultsInstance()
    
    var pageNum: Int = 1
    var dataArr:[AllLotteryResultsList] = [AllLotteryResultsList]()
    var codeRands:[AllLotteryResultsCodeRank] = [AllLotteryResultsCodeRank]()
    
    init(){}
    
    func requestForLocation(){
    }
    
}
