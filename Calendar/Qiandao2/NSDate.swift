//
//  File.swift
//  Qiandao2
//
//  Created by William on 2018/8/14.
//  Copyright © 2018年 William. All rights reserved.
//

import Foundation

extension NSDate{
    /*
     几年几月 这个月有多少天
     */
    class func getDaysInMonth( year: Int, month: Int) -> Int{
        
        let calendar = NSCalendar.current
        
        let startComps = NSDateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        
        let endComps = NSDateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
        
        let startDate = calendar.date(from: startComps as DateComponents)
        let endDate = calendar.date(from:endComps as DateComponents)!
        
        let diff = calendar.dateComponents([.day], from: startDate!, to: endDate)
        
        return diff.day!;
    }
    
    /*
     几年几月 这个月的第一天是星期几
     */
    class func firstWeekdayInMonth(year: Int, month: Int)->Int{
        
        let calender = NSCalendar.current;
        let startComps = NSDateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calender.date(from: startComps as DateComponents)
        let firstWeekday = calender.ordinality(of: .weekday, in: .weekOfMonth, for: startDate!)
        let week = firstWeekday! - 1;
        
        return week ;
    }
    
    
    /*
     今天是星期几
     */
    func dayOfWeek() -> Int {
        let interval = self.timeIntervalSince1970;
        let days = Int(interval / 86400);// 24*60*60
        return (days - 3) % 7;
    }
    class func getCurrentDay() ->Int { //今天是几日
        
        let com = self.getComponents();
        return com.day!
    }
    
    class func getCurrentMonth() ->Int {//这个月是几月
        
        let com = self.getComponents();
        return com.month!
    }
    
    class func getCurrentYear() ->Int {//这个月是哪一年
        
        let com = self.getComponents();
        return com.year!
    }
    
    class func getComponents()->DateComponents{
        let calendar = NSCalendar.current;
        //这里注意 swift要用[,]这样方式写
        let com = calendar.dateComponents([.year,.month,.day,.hour,.minute], from:Date());
        return com
    }
    
    
    //传入时间戳获取 年 月 日
    class func getYearAndMonthAndDayFromTimestamp(timestamp:TimeInterval) -> [Int] {
        let date = Date(timeIntervalSince1970: (timestamp / 1000))
        let year1 = dateConvertString(date: date, dateFormat: "yyyy")
        let month1 = dateConvertString(date: date, dateFormat: "MM")
        let day1 = dateConvertString(date: date, dateFormat: "dd")
        let year = Int(year1)!
        let month = Int(month1)!
        let day = Int(day1)!
        return [year, month, day]
    }
    
    /// Date类型转化为日期字符串
    /// - Parameters:
    ///   - date: Date类型
    ///   - dateFormat: 格式化样式默认“yyyy-MM-dd”
    /// - Returns: 日期字符串
    class func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
    
}
