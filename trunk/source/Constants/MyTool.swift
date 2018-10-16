//
//  MyTool.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/9.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class MyTool {

    //二分法查找
    static func binarySearch(array: [String], target: String) -> Bool {
        
        var left = 0
        var right = array.count - 1
        
        while (left <= right) {
            let mid = (left + right) / 2
            let value = array[mid]
            
            if (value == target) {
                return true
            }
            
            if (value < target) {
                left = mid + 1
            }
            
            if (value > target) {
                right = mid - 1
            }
        }
        
        return false
    }
    
}
