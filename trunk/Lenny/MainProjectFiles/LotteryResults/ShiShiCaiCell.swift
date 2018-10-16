//
//  ShiShiCaiCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/24.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ShiShiCaiCell: UITableViewCell {

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
    
    var lotType: String = "0"
    private let label_Title = UILabel()
    private let label_Date = UILabel()
    private let stackView = WHC_StackView()
    private let label_Zonghe = UILabel()
    private let label_Daxiao = UILabel()
    private let label_Danshuang = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
//        self.isSkeletonable = true
//        self.contentView.isSkeletonable = true
//        label_Title.isSkeletonable = true
        contentView.addSubview(label_Title)
        label_Title.whc_Top(7).whc_Left(14).whc_Height(10).whc_WidthAuto()
        label_Title.font = UIFont.systemFont(ofSize: 9)
        label_Title.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Title.text = "第0000期"
        
        contentView.addSubview(label_Date)
//        label_Date.isSkeletonable = true
        label_Date.whc_CenterYEqual(label_Title).whc_Right(11).whc_WidthAuto()
        label_Date.font = UIFont.systemFont(ofSize: 9)
        label_Date.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Date.text = "2018-04-22 21:30"
        
        contentView.addSubview(stackView)
//        stackView.isSkeletonable = true
        stackView.whc_Top(11, toView: label_Title).whc_LeftEqual(label_Title).whc_Height(25).whc_WidthAuto()
        stackView.whc_Orientation = .horizontal
        stackView.whc_AutoWidth = true
        stackView.whc_SubViewWidth = 25
        stackView.whc_HSpace = 10

        contentView.addSubview(label_Zonghe)
//        label_Zonghe.isSkeletonable = true
        label_Zonghe.whc_Top(7, toView: stackView).whc_Height(13).whc_WidthAuto().whc_Bottom(6).whc_LeftEqual(stackView)
        label_Zonghe.font = UIFont.systemFont(ofSize: 12)
        label_Zonghe.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Zonghe.text = "总和： "
        
        contentView.addSubview(label_Daxiao)
//        label_Daxiao.isSkeletonable = true
        label_Daxiao.whc_CenterYEqual(label_Zonghe).whc_Height(13).whc_WidthAuto().whc_Left(26, toView: label_Zonghe)
        label_Daxiao.font = UIFont.systemFont(ofSize: 12)
        label_Daxiao.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Daxiao.text = "大小："
        
        contentView.addSubview(label_Danshuang)
//        label_Danshuang.isSkeletonable = true
        label_Danshuang.whc_CenterYEqual(label_Zonghe).whc_Height(13).whc_WidthAuto().whc_Left(27, toView: label_Daxiao)
        label_Danshuang.font = UIFont.systemFont(ofSize: 12)
        label_Danshuang.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Danshuang.text = "单双："
        
        self.selectionStyle = .none
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    func setValues(values: [String]) {
        var total: Int = 0
        for value in values {
            let item = ShiShiCaiItemView()
            item.text = value
            stackView.addSubview(item)
            total += Int(value)!
        }
        stackView.whc_StartLayout()
        let maxTotal = 9*values.count//时时彩，快三，低频彩，PC蛋蛋最大号码为9
        label_Zonghe.text = label_Zonghe.text! + String(total)
        if lotType == "4" {
            var diceResult = "" 
            diceResult = total <= 10 ? "小" : "大"
            label_Daxiao.text = diceResult
        }else if lotType == "7" {
            var diceResult = ""
            diceResult = total >= 14 ? "大" : "小"
            label_Daxiao.text = diceResult
        }else {
            label_Daxiao.text = label_Daxiao.text!  +  (total > maxTotal/2 ? "大" : "小")
        }
        label_Danshuang.text = label_Danshuang.text! +  (total % 2 == 0 ? "双" : "单")
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
