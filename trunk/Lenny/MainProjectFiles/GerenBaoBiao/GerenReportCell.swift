//
//  GerenReportCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/19.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class GerenReportCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    private let label_Date = UILabel()
    private let label_bet_money = UILabel()
    private let label_win_money = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
//        self.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(label_Date)
//        label_Date.isSkeletonable = true
        label_Date.whc_Top(10).whc_Left(0).whc_Width(MainScreen.width/3).whc_Height(24)
        label_Date.textAlignment = NSTextAlignment.center
        label_Date.font = UIFont.systemFont(ofSize: 14)
//        label_Date.textColor = UIColor.cc_51()
        label_Date.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Date.text = "2018-09-09"
        contentView.addSubview(label_Date)
        
//        label_bet_money.isSkeletonable = true
        contentView.addSubview(label_bet_money)
        label_bet_money.whc_Left(0,toView:label_Date).whc_Width(MainScreen.width/3).whc_Height(24).whc_CenterYEqual(label_Date)
        label_bet_money.font = UIFont.systemFont(ofSize: 14)
        label_bet_money.textAlignment = NSTextAlignment.center
//        label_bet_money.textColor = UIColor.cc_51()
        label_bet_money.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_bet_money.text = "0元"
        
//        label_win_money.isSkeletonable = true
        contentView.addSubview(label_win_money)
        label_win_money.whc_Left(0,toView:label_bet_money).whc_Width(MainScreen.width/3).whc_Height(24).whc_CenterYEqual(label_bet_money)
        label_win_money.font = UIFont.systemFont(ofSize: 14)
        label_win_money.textAlignment = NSTextAlignment.center
//        label_win_money.textColor = UIColor.cc_51()
        label_win_money.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_win_money.text = "0元"
        
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDate(value: String) {
        label_Date.text = value
    }
    
    func setBetLabel(value:String){
        label_bet_money.text = String.init(format: "%@", isEmptyString(str: value) ? "0" : value)
    }
    func setWinLabel(value:String){
        label_win_money.text = String.init(format: "%@", isEmptyString(str: value) ? "0" : value)
    }

}
