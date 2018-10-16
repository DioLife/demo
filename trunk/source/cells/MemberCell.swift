//
//  MemberCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/5.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
//member page cell
class MemberCell: UICollectionViewCell {
    
    var imgView : UIImageView?//lottery 图片
    var titleLabel:UILabel?//lottery title
    //宽度要减去与两边的我间距20,再减去单元项间距0.5*6
    let screen_width = UIScreen.main.bounds.size.width - 0.5*6//获取屏幕宽
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupNoPictureAlphaBgView(view: self)
        
        imgView = UIImageView(frame: CGRect(x: screen_width/6 - 10.5, y: 20, width: 21, height: 21))
        self .addSubview(imgView!)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 51, width: screen_width/3, height: 30))
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel?.textColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        titleLabel?.theme_textColor = "FrostedGlass.normalDarkTextColor"
        titleLabel?.textAlignment = NSTextAlignment.center
        self .addSubview(titleLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data:MemberBean) -> Void {
        imgView?.image = UIImage.init(named: data.iconName)
        imgView?.theme_image = ThemeImagePicker.init(keyPath: data.iconName)
        titleLabel?.text = data.txtName
    }
    
    
}
