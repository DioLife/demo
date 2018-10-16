//
//  AccountChangeCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class AccountChangeCell: UITableViewCell {
    
    @IBOutlet weak var orderidUI:UILabel!
    @IBOutlet weak var frontMoneyUI:UILabel!
    @IBOutlet weak var afterMoneyUI:UILabel!
    @IBOutlet weak var changeMoneyUI:UILabel!
    @IBOutlet weak var datetimeUI:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
