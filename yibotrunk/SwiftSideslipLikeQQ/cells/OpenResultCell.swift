//
//  OpenResultCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class OpenResultCell: UITableViewCell {
    
    @IBOutlet weak var qishuUI:UILabel!
    @IBOutlet weak var timeUI:UILabel!
    @IBOutlet weak var ballView:BallsView!
    @IBOutlet weak var summaryView:BallsView!
    @IBOutlet weak var summaryHeightConstant:NSLayoutConstraint!
    @IBOutlet weak var totalTV:UILabel!
    @IBOutlet weak var danshuangTV:UILabel!
    @IBOutlet weak var bigsmallTV:UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
