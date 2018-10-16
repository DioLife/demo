//
//  GerenReportCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/19.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class TeamReportCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    private let label_User = UILabel()
    private let label_group = UILabel()
    private let label_win_money = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        label_User.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_group.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_win_money.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        
//        self.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(label_User)
//        label_User.isSkeletonable = true
        label_User.whc_Top(10).whc_Left(0).whc_Width(MainScreen.width/3).whc_Height(24)
        label_User.textAlignment = NSTextAlignment.center
        label_User.font = UIFont.systemFont(ofSize: 14)
        label_User.textColor = UIColor.cc_51()
        label_User.text = "-"
        contentView.addSubview(label_User)
        
//        label_group.isSkeletonable = true
        contentView.addSubview(label_group)
        label_group.whc_Left(0,toView:label_User).whc_Width(MainScreen.width/3).whc_Height(24).whc_CenterYEqual(label_User)
        label_group.font = UIFont.systemFont(ofSize: 14)
        label_group.textAlignment = NSTextAlignment.center
        label_group.textColor = UIColor.cc_51()
        label_group.text = "-"
        
//        label_win_money.isSkeletonable = true
        contentView.addSubview(label_win_money)
        label_win_money.whc_Left(0,toView:label_group).whc_Width(MainScreen.width/3).whc_Height(24).whc_CenterYEqual(label_group)
        label_win_money.font = UIFont.systemFont(ofSize: 14)
        label_win_money.textAlignment = NSTextAlignment.center
        label_win_money.textColor = UIColor.cc_51()
        label_win_money.text = "0元"
        
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUser(value: String) {
        label_User.text = value
    }
    
    func setGroupLabel(value:String){
        label_group.text = String.init(format: "%@", isEmptyString(str: value) ? "-" : value)
    }
    func setMoneyLabel(value:String){
        label_win_money.text = String.init(format: "%@", isEmptyString(str: value) ? "0" : value)
    }
    
}
