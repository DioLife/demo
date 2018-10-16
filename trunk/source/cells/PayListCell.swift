//
//  PayListCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class PayListCell: UITableViewCell {
    
    @IBOutlet weak var payImg:UIImageView!
    @IBOutlet weak var payText:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(model:Dictionary<String,String>){
        payImg.image = UIImage.init(named: model["img"]!)
        payText.text = model["text"]
    }

}
