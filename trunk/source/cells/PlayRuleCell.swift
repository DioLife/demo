//
//  PlayRuleCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/16.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class PlayRuleCell: UITableViewCell {
    
    @IBOutlet weak var descCellLeftLine: UIView!
    @IBOutlet weak var descCellDownline: UIView!
    @IBOutlet weak var descCellRightLine: UIView!
    @IBOutlet weak var playTxt:UILabel!
    @IBOutlet weak var indictor:UIImageView!
    @IBOutlet weak var bgImg:UIImageView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indictor.theme_image = "TouzhOffical.sideNavBox"
        bottomLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        rightLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        leftLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(name:String,isSelected:Bool) -> Void {
        playTxt.text = name
        if isSelected{
            indictor.theme_image = "TouzhOffical.sideNavSelectedBox"
            self.theme_backgroundColor = "FrostedGlass.Touzhu.ruleCellSelectedBGColor"
            playTxt.theme_textColor = "FrostedGlass.Touzhu.ruleCellSelectedTextColor"
        }else{
            indictor.theme_image = "TouzhOffical.sideNavBox"
            playTxt.theme_textColor = "FrostedGlass.Touzhu.ruleCellNormalTextColor"
            self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        }
    }

}
