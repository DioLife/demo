//
//  GerenOverViewCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class GerenOverViewCell: UICollectionViewCell {
        
    //    var indictorLabel : UILabel?//指示label
    var labelTV : UILabel?//lottery 图片
    var titleLabel:UILabel?//lottery title
    //宽度要减去与两边的我间距20,再减去单元项间距0.5*6
    let screen_width = UIScreen.main.bounds.size.width - 0.5*6//获取屏幕宽
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化各种控件
        
        setupNoPictureAlphaBgView(view: self)
        
        labelTV = UILabel(frame: CGRect(x: 0, y: 15, width: self.bounds.width, height: 30))
        labelTV?.textAlignment = NSTextAlignment.center
        labelTV?.font = UIFont.systemFont(ofSize: 14)
        self .addSubview(labelTV!)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 15+30, width: screen_width/3, height: 30))
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
//        titleLabel?.textColor = UIColor.red
        titleLabel?.theme_textColor = "Global.themeColor"
        titleLabel?.textAlignment = NSTextAlignment.center
        self .addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data:GerenOverviewBean){
        titleLabel?.text = data.content
        labelTV?.text = data.label
    }
}
