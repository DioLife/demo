//
//  UserListCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {

    @IBOutlet weak var usernameTV:UILabel!
    @IBOutlet weak var balanceTV:UILabel!
    @IBOutlet weak var rebateTV:UILabel!
    @IBOutlet weak var statusTV:UILabel!
    @IBOutlet weak var accountTypeTV:UILabel!
    @IBOutlet weak var teamOverviewBtn:UIButton!
    @IBOutlet weak var accountChangeBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupNoPictureAlphaBgView(view: self)
        
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: usernameTV)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: balanceTV)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: rebateTV)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: statusTV)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: accountTypeTV)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setModel(model:UserListSmallBean?){
        if let bean = model{
            usernameTV.text = bean.username
            balanceTV.text = String.init(format: "%d元", bean.money)
            rebateTV.text = String.init(format: "%.2f", bean.kickback)
            statusTV.text = bean.status == 1 ? "关闭" : "开启"
            accountTypeTV.text = getUserType(t: bean.type)
        }
    }

}
