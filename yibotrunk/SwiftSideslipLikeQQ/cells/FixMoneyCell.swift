//
//  FixMoneyCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/8/24.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class FixMoneyCell: UICollectionViewCell {
    
    var moneyBtn : UIButton!
    //宽度要减去与两边的我间距20,再减去单元项间距0.5*6
//    let screen_width = UIScreen.main.bounds.size.width - 0.5*6//获取屏幕宽
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //初始化各种控件
        self.backgroundColor = UIColor.white
        moneyBtn = UIButton.init(frame: CGRect.init(x: self.bounds.width/2-30, y: self.bounds.height/2-15,
                                                    width: 60, height: 30))
        self.addSubview(moneyBtn)
    }
    
    func setData(txt:String,isSelect:Bool){
        moneyBtn.setTitle(txt, for: .normal)
        if isSelect{
            moneyBtn.setBackgroundImage(UIImage.init(named: "fast_money_bg_red"), for: .normal)
            moneyBtn.setTitleColor(UIColor.white, for: .normal)
        }else{
            moneyBtn.setBackgroundImage(UIImage.init(named: "fast_money_bg"), for: .normal)
            moneyBtn.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
