//
//  InboxTableViewCell.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private let label_MentionType = UILabel()
    private let label_Day = UILabel()
    private let label_Time = UILabel()
    private let label_Title = UILabel()
    private let icon = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewBackgroundColorTransparent(view: self)
        
        self.accessoryType =  .disclosureIndicator
        self.contentView.addSubview(icon)
        if #available(iOS 11, *) {
            icon.whc_Top(13).whc_Left(12).whc_Width(13).whc_Height(13)
        }else {
            icon.whc_Top(5).whc_Left(12).whc_Width(13).whc_Height(13)
        }
        icon.image = UIImage.init(named: "selected")
        
        contentView.addSubview(label_MentionType)
        label_MentionType.whc_CenterYEqual(icon).whc_Left(10, toView: icon).whc_Height(9).whc_WidthAuto()
        label_MentionType.font = UIFont.systemFont(ofSize: 9)
//        label_MentionType.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
//        label_MentionType.textColor = UIColor.black
        label_MentionType.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_MentionType.text = "支付提醒"
        
        contentView.addSubview(label_Day)
        label_Day.whc_CenterYEqual(icon).whc_Left(20, toView: label_MentionType).whc_WidthAuto().whc_Height(9)
        label_Day.font = UIFont.systemFont(ofSize: 9)
//        label_Day.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_Day.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Day.text = "2018.04.22"
        
        
        contentView.addSubview(label_Time)
        label_Time.whc_CenterYEqual(icon).whc_Left(20, toView: label_Day).whc_WidthAuto().whc_Height(9)
        label_Time.font = UIFont.systemFont(ofSize: 9)
//        label_Time.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_Time.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Time.text = "19:04"
        
        contentView.addSubview(label_Title)
        
        if #available(iOS 11, *) {
            label_Title.whc_LeftEqual(label_MentionType).whc_Top(14, toView: label_MentionType).whc_Height(13).whc_Bottom(15)
        }else {
            label_Title.whc_LeftEqual(label_MentionType).whc_Bottom(8)
        }
        
        label_Title.font = UIFont.systemFont(ofSize: 12)
        label_Title.textColor = UIColor.black
        label_Title.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
//        label_Title.text = "您刚刚充值了一笔金额，点击查看详情"
    }
    
    func setlabel_MentionType(type:Int){
        var text = "系统消息"
        if type == 2{
            text = "消息提醒"
        }
        label_MentionType.text = text
    }
    
    func setlabel_Day(creatTime:String){
        label_Day.text = creatTime
        label_Time.text = ""
    }
    
    func setlabel_Title(title:String){
        label_Title.text = title
    }
    
    func seticon(status:Int){
        icon.image = status == 1 ? UIImage.init(named: "selected") : nil
//        label_MentionType.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
//        label_Title.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_MentionType.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Title.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
