//
//  CommonRecords.swift
//  gameplay
//
//  Created by William on 2018/8/6.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class CommonRecords: NSObject {
    
    static func updateRecordInDB(record:VisitRecords) {
        let resultArr:[VisitRecords] = WHC_ModelSqlite.query(VisitRecords.self, where: "userName = '\(YiboPreference.getUserName())' and cpBianHao = '\(record.cpBianHao!)' AND lotVersion = '\(record.lotVersion!)'") as! [VisitRecords]
        
        if resultArr.count == 0 { //如果数据库中没有这种玩法的记录,那就添加并置记录数为1
            record.userName = YiboPreference.getUserName()
            record.num = "1"
            WHC_ModelSqlite.insert(record)
        }else{ //如果数据库中有这种玩法的记录,记录数+1
            let recordDB:VisitRecords = resultArr[0]
            var num:Int = Int(recordDB.num!)!
            num += 1
            let num2:String = String(num)
            WHC_ModelSqlite.update(VisitRecords.self, value: "num = '\(num2)'", where: "userName = '\(YiboPreference.getUserName())' and cpBianHao = '\(record.cpBianHao!)' AND lotVersion = '\(record.lotVersion!)'")
        }
    }
    
}
