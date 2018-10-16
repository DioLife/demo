//
//  ConvertListCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class ConvertListCell: UITableViewCell {

    @IBOutlet weak var gameNameUI:UILabel!
    @IBOutlet weak var moneyUI:UILabel!
    @IBOutlet weak var enterBtn:UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gameNameUI.theme_textColor = "FrostedGlass.normalDarkTextColor"
        moneyUI.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
    }
    
    

}
