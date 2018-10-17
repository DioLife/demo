//
//  Tueijian01TableViewCell.swift
//  gameplay
//
//  Created by William on 2018/8/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class Tueijian01TableViewCell: UITableViewCell {
    
    @IBOutlet weak var tueijianAddress: UILabel!
    @IBOutlet weak var mytext: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func myCopy(_ sender: UIButton) {
        UIPasteboard.general.string = mytext.text
        showToast(view: self.contentView, txt: convertString(string: "复制成功"))
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
