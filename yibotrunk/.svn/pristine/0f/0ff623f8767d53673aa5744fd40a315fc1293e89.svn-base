//
//  CPViewCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/12.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class OtherPageCell: UICollectionViewCell {
    
    var imgView : UIImageView?//lottery 图片
    var titleLabel:UILabel?//lottery title
    //宽度要减去与两边的我间距20,再减去单元项间距0.5*6
    let screen_width = UIScreen.main.bounds.size.width - 0.5*6//获取屏幕宽
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //初始化各种控件
        self.backgroundColor = UIColor.white
        imgView = UIImageView(frame: CGRect(x: screen_width/6 - 30, y: 30, width: 60, height: 60))
        self .addSubview(imgView!)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 30+60+10, width: screen_width/3, height: 30))
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel?.textColor = UIColor.lightGray
        titleLabel?.textAlignment = NSTextAlignment.center
        self .addSubview(titleLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

