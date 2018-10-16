//
//  SelectedTBCell.swift
//  gameplay
//
//  Created by William on 2018/7/30.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class SelectedTBCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: self)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
