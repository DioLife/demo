//
//  PayInfoMoneyCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class PayInfoMoneyCell: UICollectionViewCell {
    
    //    var indictorLabel : UILabel?//指示label
    var moneyBtn:UIButton!
    //宽度要减去与两边的我间距20,再减去单元项间距0.5*6
    let screen_width = UIScreen.main.bounds.size.width - 0.5*6//获取屏幕宽
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化各种控件
        setupNoPictureAlphaBgView(view: self)
        moneyBtn = UIButton.init(frame: CGRect.init(x: 10, y: self.bounds.height/2-12.5, width: self.bounds.width - 20, height: 30))
//        moneyBtn.setBackgroundImage(UIImage.init(named: "money_input_bg"), for: .normal)
        moneyBtn.theme_setTitleColor("Global.themeColor", forState: .normal)
        moneyBtn.layer.theme_borderColor = "Global.themeColor"
        moneyBtn.layer.borderWidth = 1
        moneyBtn.layer.cornerRadius = 5
        moneyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        moneyBtn.setTitle("0元", for: .normal)
        moneyBtn.isUserInteractionEnabled = false
        self.addSubview(moneyBtn!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBtn(money:String){
        moneyBtn.setTitle(String.init(format: "%@元", money), for: .normal)
    }

}
