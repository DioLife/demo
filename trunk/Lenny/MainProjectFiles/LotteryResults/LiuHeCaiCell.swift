//
//  LiuHeCaiCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/30.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class LiuHeCaiCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setTitle(value: String) { label_Title.text = value }
    func setDate(value: String) { label_Date.text = value }
    
    private let label_Title = UILabel()
    private let label_Date = UILabel()
    private let stackView = WHC_StackView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
//        self.isSkeletonable = true
//        self.contentView.isSkeletonable = true
//        label_Title.isSkeletonable = true
        contentView.addSubview(label_Title)
        label_Title.whc_Top(7).whc_Left(14).whc_Height(10).whc_WidthAuto()
        label_Title.font = UIFont.systemFont(ofSize: 9)
//        label_Title.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_Title.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Title.text = "第2018042期"
        
        contentView.addSubview(label_Date)
//        label_Date.isSkeletonable = true
        label_Date.whc_CenterYEqual(label_Title).whc_Right(11).whc_WidthAuto()
        label_Date.font = UIFont.systemFont(ofSize: 9)
//        label_Date.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_Date.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Date.text = "2018-04-22 21:30"
        
        contentView.addSubview(stackView)
//        stackView.isSkeletonable = true
        stackView.whc_Top(11, toView: label_Title).whc_LeftEqual(label_Title).whc_Height(35).whc_WidthAuto().whc_Bottom(10)
        stackView.whc_Orientation = .horizontal
        stackView.whc_AutoWidth = true
        stackView.whc_SubViewWidth = 25
        stackView.whc_HSpace = 10
        
        
        self.selectionStyle = .none
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    func setValues(values: [String]) {
        
        for value in values {
            let item = LiuHeCaiIetmView()
            item.setCircleText(value: value)
            let value_Int = Int(value)
            if value_Int == 1 || value_Int == 2 || value_Int == 7 || value_Int == 8 || value_Int == 12 || value_Int == 13 || value_Int == 18 || value_Int == 19 || value_Int == 23 || value_Int == 24 || value_Int == 29 || value_Int == 30 || value_Int == 34 || value_Int == 35 || value_Int == 40 || value_Int == 45 || value_Int == 46 {
                item.setCircleBackGroundColor(color: UIColor.mainColor())
            }
            if value_Int == 3 || value_Int == 4 || value_Int == 9 || value_Int == 10 || value_Int == 14 || value_Int == 15 || value_Int == 20 || value_Int == 25 || value_Int == 26 || value_Int == 31 || value_Int == 36 || value_Int == 37 || value_Int == 41 || value_Int == 42 || value_Int == 47 || value_Int == 48 {
                item.setCircleBackGroundColor(color: UIColor.ccolor(with: 90, g: 180, b: 250))
            }
            if value_Int == 5 || value_Int == 6 || value_Int == 11 || value_Int == 16 || value_Int == 17 || value_Int == 21 || value_Int == 22 || value_Int == 27 || value_Int == 28 || value_Int == 32 || value_Int == 33 || value_Int == 38 || value_Int == 39 || value_Int == 43 || value_Int == 44 || value_Int == 49 {
                item.setCircleBackGroundColor(color: UIColor.ccolor(with: 150, g: 230, b: 70))
            }
            
            if value_Int == 22 || value_Int == 46 || value_Int == 34 || value_Int == 10 { item.setLabelText(value: "牛")}
            if value_Int == 11 || value_Int == 23 || value_Int == 47 || value_Int == 35 { item.setLabelText(value: "鼠")}
            if value_Int == 45 || value_Int == 33 || value_Int == 9 || value_Int == 21 { item.setLabelText(value: "虎")}
            if value_Int == 3 || value_Int == 39 || value_Int == 15 || value_Int == 27 { item.setLabelText(value: "猴")}
            if value_Int == 6 || value_Int == 42 || value_Int == 18 || value_Int == 30 { item.setLabelText(value: "蛇")}
            if value_Int == 1 || value_Int == 13 || value_Int == 37 || value_Int == 25 || value_Int == 49 { item.setLabelText(value: "狗")}
            if value_Int == 12 || value_Int == 36 || value_Int == 24 || value_Int == 48 { item.setLabelText(value: "猪")}
            if value_Int == 32 || value_Int == 44 || value_Int == 8 || value_Int == 20 { item.setLabelText(value: "兔")}
            if value_Int == 28 || value_Int == 16 || value_Int == 4 || value_Int == 40 { item.setLabelText(value: "羊")}
            if value_Int == 7 || value_Int == 43 || value_Int == 31 || value_Int == 19 { item.setLabelText(value: "龙")}
            if value_Int == 29 || value_Int == 41 || value_Int == 5 || value_Int == 17 { item.setLabelText(value: "马")}
            if value_Int == 26 || value_Int == 14 || value_Int == 38 || value_Int == 2{ item.setLabelText(value: "鸡")}
            
            stackView.addSubview(item)
        }
        stackView.whc_StartLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
