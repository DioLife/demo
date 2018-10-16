//
//  OutBoxTableViewCell.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/8.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class OutBoxTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private let label_Receiver = UILabel()
    private let label_Date = UILabel()
    private let label_ContentDesc = UILabel()
    private let label_Type = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewBackgroundColorTransparent(view: self)
        
        contentView.addSubview(label_Receiver)
        label_Receiver.whc_Top(12).whc_Left(12).whc_WidthAuto().whc_Height(15)
        label_Receiver.font = UIFont.systemFont(ofSize: 12)
//        label_Receiver.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label_Receiver.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Receiver.text = "收件人：小虫子"
        
        contentView.addSubview(label_Date)
        label_Date.whc_CenterYEqual(label_Receiver).whc_Right(20).whc_WidthAuto().whc_Height(15)
        label_Date.font = UIFont.systemFont(ofSize: 12)
//        label_Date.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_Date.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Date.text = "2018-04-22 15:00"
        
        contentView.addSubview(label_ContentDesc)
        label_ContentDesc.whc_LeftEqual(label_Receiver).whc_Top(10, toView: label_Receiver).whc_WidthAuto().whc_Height(15).whc_Bottom(12)
        label_ContentDesc.font = UIFont.systemFont(ofSize: 12)
//        label_ContentDesc.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_ContentDesc.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_ContentDesc.text = "你昨天买的是什么号码"
        
        contentView.addSubview(label_Type)
        label_Type.whc_CenterYEqual(label_ContentDesc).whc_Right(20).whc_WidthAuto().whc_Height(15)
        label_Type.font = UIFont.systemFont(ofSize: 12)
//        label_Type.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label_Type.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Type.text = "下级"
        
    }
    
    func setlabel_Receiver(receiver:String){
        label_Receiver.text = receiver
    }
    
    func setlabel_Date(creatTime:String){
        label_Date.text = creatTime
    }
    
    func setlabel_ContentDesc(content:String){
        label_ContentDesc.text = content
    }
    
    func setlabel_Type(receiveType:String){
        var typetxt = "个人"
        if receiveType == "1"{
            typetxt = "个人"
        }else if receiveType == "2"{
            typetxt = "群发"
        }else if receiveType == "3"{
            typetxt = "层级"
        }else if receiveType == "4"{
            typetxt = "上级"
        }else if receiveType == "5"{
            typetxt = "下级"
        }
        label_Type.text = typetxt
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
