//
//  SportTableHeader.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//体育每个赛事表格头部
class SportTableHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hex: 0xc8a670, alpha: 1.0)
    }
    
    func setupView(arr:[String]) -> Int {
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let width = kScreenWidth - 30
        for index in 0...arr.count-1{
            let s = CGFloat(index)
            let itemUI = UILabel.init(frame: CGRect.init(x: s*(width/CGFloat(arr.count)), y: 0, width: width/CGFloat(arr.count), height: self.bounds.height))
            itemUI.textAlignment = NSTextAlignment.center
            itemUI.font = UIFont.systemFont(ofSize: 14)
            itemUI.textColor = UIColor.black
            itemUI.text = arr[index]
            self.addSubview(itemUI)
        }
        return arr.count
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
