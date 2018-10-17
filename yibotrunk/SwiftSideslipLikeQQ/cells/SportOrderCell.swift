//
//  SportOrderCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/24.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class SportOrderCell: UITableViewCell {
    
    @IBOutlet weak var leagueUI:UILabel!
    @IBOutlet weak var teamUI:UILabel!
    @IBOutlet weak var projectAndPeilv:UILabel!
    @IBOutlet weak var categoryUI:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
