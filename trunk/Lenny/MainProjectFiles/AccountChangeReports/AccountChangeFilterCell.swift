//
//  AccountChangeCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class AccountChangeFilterCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    private let label_Username = UILabel()
    private let label_earn_money = UILabel()
    private let label_sell_money = UILabel()
    private let label_left_money = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
//        self.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(label_Username)
//        label_Username.isSkeletonable = true
        label_Username.whc_Top(10).whc_Left(0).whc_Width(MainScreen.width/4).whc_Height(24)
        label_Username.textAlignment = NSTextAlignment.center
        label_Username.font = UIFont.systemFont(ofSize: 14)
        label_Username.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Username.text = "-"
        contentView.addSubview(label_Username)
        
//        label_earn_money.isSkeletonable = true
        contentView.addSubview(label_earn_money)
        label_earn_money.whc_Left(0,toView:label_Username).whc_Width(MainScreen.width/4).whc_Height(24).whc_CenterYEqual(label_Username)
        label_earn_money.font = UIFont.systemFont(ofSize: 14)
        label_earn_money.textAlignment = NSTextAlignment.center
        label_earn_money.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_earn_money.text = "-"
        
//        label_sell_money.isSkeletonable = true
        contentView.addSubview(label_sell_money)
        label_sell_money.whc_Left(0,toView:label_earn_money).whc_Width(MainScreen.width/4).whc_Height(24).whc_CenterYEqual(label_earn_money)
        label_sell_money.font = UIFont.systemFont(ofSize: 14)
        label_sell_money.textAlignment = NSTextAlignment.center
        label_sell_money.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_sell_money.text = "-"
        
//        label_left_money.isSkeletonable = true
        contentView.addSubview(label_left_money)
        label_left_money.whc_Left(0,toView:label_sell_money).whc_Width(MainScreen.width/4).whc_Height(24).whc_CenterYEqual(label_sell_money)
        label_left_money.font = UIFont.systemFont(ofSize: 14)
        label_left_money.textAlignment = NSTextAlignment.center
        label_left_money.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_left_money.text = "-"
        
        
//        accessoryType = .disclosureIndicator
        selectionStyle = .none
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUsername(value: String) {
        label_Username.text = value
    }
    
    func setLeftMoney(value: String){
        label_left_money.text = !isEmptyString(str: value) ? value : "-"
    }
    
    func setEarnLabel(value:String){
        label_earn_money.text = String.init(format: "%@", isEmptyString(str: value) ? "-" : value)
    }
    func setSellLabel(value:String){
        label_sell_money.text = String.init(format: "%@", isEmptyString(str: value) ? "-" : value)
    }
    
}
