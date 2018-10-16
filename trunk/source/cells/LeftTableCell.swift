//
//  LeftTableCellTableViewCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/10.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class LeftTableCell: UITableViewCell {
    
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var indictor:UIImageView!
    
    @IBOutlet weak var subTableView:UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupData(data:MenuData){
//        icon.image = UIImage.init(named: data.img)
        
        icon.theme_image = ThemeImagePicker.init(keyPath: data.img)
        
        name.text = data.txt
    }
    
}
