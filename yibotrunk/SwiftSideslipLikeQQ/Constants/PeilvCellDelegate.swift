//
//  PeilvCellDelegate.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/14.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol PeilvCellDelegate {
    func onCellSelect(data:PeilvPlayData,cellIndex:Int,row:Int,headerColumns:Int,volume:Bool)
    func callAsyncCalcZhushu()
}
