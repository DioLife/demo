//
//  String+Extension.swift
//  Colliers-CFIM
//
//  Created by  ywf on 16/12/19.
//  Copyright © 2016年 yingwf. All rights reserved.
//

import Foundation


extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    func getDateByFormatString(_ str: String) -> Date? {
        
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = str
        dateFormat.locale = Locale.current
        
        return dateFormat.date(from: self)
    }
    
    
    //截取字符串
    func substrfromBegin(length:Int)->String{
        
        let index = self.index(self.startIndex, offsetBy: length)
        
        return self.substring(to: index)
        
    }
    
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    
    func getCommonDateByFormatString() -> Date? {
        return getDateByFormatString("yyyy-MM-dd HH:mm:ss")
    }
    
    
    static func getStringSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        return CGSize.zero
    }
    
    static func getStringWidth(str: String, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getStringSize(str: str, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    
    func positionOf(sub:String, backwards:Bool = false)->Int {
        // 如果没有找到就返回-1
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
  

}
