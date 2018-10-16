//
//  AlertCell.swift
//  Swift_UI
//
//  Created by William on 2018/8/16.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class AlertCell: UITableViewCell {

    @IBOutlet weak var signDate: UILabel!
    @IBOutlet weak var signDays: UILabel!
    @IBOutlet weak var jifen: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
