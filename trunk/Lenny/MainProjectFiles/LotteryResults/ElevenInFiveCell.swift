//
//  ElevenInFiveCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/30.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ElevenInFiveCell: UITableViewCell {

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
            let value_Int = Int(value)
            item.setCircleText(value: String(value_Int!))
            item.setCircleBackGroundColor(color: UIColor.mainColor())
            
//            if value_Int == 10 { item.setLabelText(value: "牛")}
//            if value_Int == 11 { item.setLabelText(value: "鼠")}
//            if value_Int == 9 { item.setLabelText(value: "虎")}
//            if value_Int == 3 || value_Int == 15 { item.setLabelText(value: "猴")}
//            if value_Int == 6 || value_Int == 18 { item.setLabelText(value: "蛇")}
//            if value_Int == 1 || value_Int == 13 { item.setLabelText(value: "狗")}
//            if value_Int == 12 { item.setLabelText(value: "猪")}
//            if value_Int == 8 || value_Int == 20 { item.setLabelText(value: "兔")}
//            if value_Int == 4 || value_Int == 16 { item.setLabelText(value: "羊")}
//            if value_Int == 7 || value_Int == 19 { item.setLabelText(value: "龙")}
//            if value_Int == 5 || value_Int == 17 { item.setLabelText(value: "马")}
//            if value_Int == 2 || value_Int == 14 { item.setLabelText(value: "鸡")}
            
            stackView.addSubview(item)
        }
        stackView.whc_StartLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
