//
//  BraveZuiHaoCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/8.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class BraveZuiHaoCell: UITableViewCell {
    
    @IBOutlet weak var jianBtn:UIButton!
    @IBOutlet weak var addBtn:UIButton!
    @IBOutlet weak var beishuInput:CustomFeildText!
    @IBOutlet weak var qihaoUI:UILabel!
    @IBOutlet weak var moneyUI:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
