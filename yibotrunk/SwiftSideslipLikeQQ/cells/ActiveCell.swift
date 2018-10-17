//
//  ActiveCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/12.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class ActiveCell: UITableViewCell {
    
    @IBOutlet weak var activeName:UILabel!
    @IBOutlet weak var activeImg:UIImageView!
//    @IBOutlet weak var activeContent:UILabel!
//    @IBOutlet weak var activeContentView:UIView!
    @IBOutlet weak var activeDuration:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
