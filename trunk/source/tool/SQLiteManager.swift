//
//  SQLiteManager.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/27.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    //MARK: - 创建类的静态实例变量即为单例对象 let-是线程安全的
    static let instance = SQLiteManager()
    //对外提供创建单例对象的接口
    class func shareInstance() -> SQLiteManager {
        return instance
    }
    
    //MARK: - 数据库操作
    //定义数据库变量
    var db : OpaquePointer? = nil
    //打开数据库
    func openDB() -> Bool {
        //数据库文件路径
        let dicumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        let DBPath = (dicumentPath! as NSString).appendingPathComponent("appDB.sqlite")
        let cDBPath = DBPath.cString(using: String.Encoding.utf8)
        //打开数据库
        //第一个参数:数据库文件路径  第二个参数:数据库对象
        //        sqlite3_open(<#T##filename: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>, <#T##ppDb: UnsafeMutablePointer<OpaquePointer?>!##UnsafeMutablePointer<OpaquePointer?>!#>)
        if sqlite3_open(cDBPath, &db) != SQLITE_OK {
            print("数据库打开失败")
        }
        return creatTable();
    }
    //创建表
    func creatTable() -> Bool {
        //建表的SQL语句
        let creatResultsTable = "CREATE TABLE IF NOT EXISTS 't_lottery_results' ( 'ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'key' TEXT,'content' TEXT);"
//        let creatCarTable = "CREATE TABLE IF NOT EXISTS 't_Car' ('ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'type' TEXT,'output' REAL,'master' TEXT);"
        //执行SQL语句-创建表 依然,项目中一般不会只有一个表
        return creatTableExecSQL(SQL_ARR: [creatResultsTable])
    }
    //执行建表SQL语句
    func creatTableExecSQL(SQL_ARR : [String]) -> Bool {
        for item in SQL_ARR {
            if execSQL(SQL: item) == false {
                return false
            }
        }
        return true
    }
    //执行SQL语句
    func execSQL(SQL : String) -> Bool {
        // 1.将sql语句转成c语言字符串
        let cSQL = SQL.cString(using: String.Encoding.utf8)
        //错误信息
        let errmsg : UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil
        if sqlite3_exec(db, cSQL, nil, nil, errmsg) == SQLITE_OK {
            return true
        }else{
//            print("SQL 语句执行出错 -> 错误信息: 一般是SQL语句写错了 \(errmsg)")
            return false
        }
    }
}
