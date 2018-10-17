//
//  PeilvOrderCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/16.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class PeilvOrderCell: UITableViewCell {
    
    @IBOutlet weak var playUI:UILabel!
    @IBOutlet weak var numbersUI:UILabel!
    @IBOutlet weak var peilvUI:UILabel!
    @IBOutlet weak var zhuMoneyUI:UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
