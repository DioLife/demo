//
//  GouCaiCellTableViewCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/11.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class GouCaiCell: UITableViewCell {
    
    @IBOutlet weak var czName:UILabel!
    @IBOutlet weak var lastQihao:UILabel!
    @IBOutlet weak var ballViews:BallsView!
    @IBOutlet weak var currentQihaoAndTime:UILabel!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var emptyHaomaUI:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
