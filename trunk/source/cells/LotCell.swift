//
//  LotCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/13.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Kingfisher

class LotCell: UITableViewCell {
    
    @IBOutlet weak var lotImg:UIImageView!
    @IBOutlet weak var lotName:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(lotData:LotteryData){
        guard let lotCode = lotData.code else {
            lotImg.image = UIImage(named: "default_lottery")
            return
        }
        if isEmptyString(str: lotData.lotteryIcon) {
            // set lottery picture
            if let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + lotCode + ".png"){
                lotImg.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }else {
            if let url = URL.init(string: lotData.lotteryIcon) {
                lotImg.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        lotName.text = lotData.name
    }

}
