//
//  JifenCell.swift
//  gameplay
//
//  Created by William on 2018/8/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class JifenCell: UITableViewCell {

    @IBOutlet weak var biandongtype: UILabel!
    @IBOutlet weak var biandongscore: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var biandongtime: UILabel!
    
    @IBOutlet weak var rightIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupNoPictureAlphaBgView(view: self)
        
        biandongtype.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        biandongscore.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        currentScore.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        biandongtime.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
    }
    
    func setView(index:Int, model:JifenDataRow) {
        if index == 0 {
            contentView.backgroundColor = UIColor.black
            biandongtype.textColor = UIColor.white
            biandongscore.textColor = UIColor.white
            currentScore.textColor = UIColor.white
            biandongtime.textColor = UIColor.white
            rightIcon.isHidden = true
        }else{
            biandongtype.text = getTypeSting(type: model.type)
            biandongscore.text = "\(model.score!)"
            currentScore.text = "\(model.afterScore!)"
           // let mydate = model.createDatetime.components(separatedBy: " ")[0]
            biandongtime.text = model.createDatetime
        }
    }
    
    func getTypeSting(type:Int) -> String {
        switch type {
        case 1:
            return "活动积分扣除"
        case 2:
            return "会员签到"
        case 3:
            return "现金兑换积分"
        case 4:
            return "积分兑换现金"
        case 5:
            return "存款赠送"
        case 6:
            return "人工添加"
        case 7:
            return "人工扣除"
        default:
            return "error"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
