//
//  CreateSpreadTBCell.swift
//  gameplay
//
//  Created by William on 2018/8/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class CreateSpreadTBCell: UITableViewCell {

    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var mylabel2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: self)
        setupNoPictureAlphaBgView(view: mylabel2, alpha: 0.4, bgViewColor: "FrostedGlass.subColorImageCoverDarkColorForNotGlass")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
