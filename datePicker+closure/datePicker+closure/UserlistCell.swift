//
//  UserlistCell.swift
//  YiboGameIos
//
//  Created by William on 2018/10/18.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class UserlistCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var registerTime: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
