//
//  LotteryTrendChartQianWeiController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/28.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class LotteryTrendChartQianWeiController: LotteryResultsTrendChartBasicController {

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()

        pageIndex = 1
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        refreshTableViewData()
    }
    
    
    

}

