//
//  SubPayMethodCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Kingfisher

class SubPayMethodCell: UICollectionViewCell {

    //    var indictorLabel : UILabel?//指示label
    var moneyBtn:UIButton!
    var payTV:UILabel!
    //宽度要减去与两边的我间距20,再减去单元项间距0.5*6
    let screen_width = UIScreen.main.bounds.size.width - 0.5*6//获取屏幕宽
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNoPictureAlphaBgView(view: self)
        //初始化各种控件
        moneyBtn = UIButton.init(frame: CGRect.init(x: 10, y: self.bounds.height/2-12.5, width: self.bounds.width - 20, height: 30))
        payTV = UILabel.init(frame: CGRect.init(x: 10, y: self.bounds.height/2-12.5, width: self.bounds.width - 20, height: 30))
//        moneyBtn.setBackgroundImage(UIImage.init(named: "fast_money_normal_bg"), for: .normal)
        moneyBtn.layer.cornerRadius = 3
        moneyBtn.layer.borderWidth = 1.5
        moneyBtn.layer.borderColor = UIColor.lightGray.cgColor
        moneyBtn.isUserInteractionEnabled = false
        payTV.font = UIFont.systemFont(ofSize: 14)
        payTV.textColor = UIColor.black
        payTV.isHidden = true
        self.addSubview(moneyBtn!)
        self.addSubview(payTV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBtn(payName:String){
        if isEmptyString(str: payName){
            moneyBtn.setImage(nil, for: .normal)
            return
        }
        let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + payName + ".png")
        if let url = imageURL{
            payTV.isHidden = true
            moneyBtn.isHidden = false
            moneyBtn.kf.setImage(with: ImageResource(downloadURL: url), for: .normal, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        } else{
            payTV.isHidden = false
            moneyBtn.isHidden = true
            payTV.text = payName
        }
    }

}
