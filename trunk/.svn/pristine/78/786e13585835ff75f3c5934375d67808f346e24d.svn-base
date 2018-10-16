//
//  QueryResultsCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class QueryResultsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private let label_LotteryName = UILabel()
    private let label_Status = UILabel()
    private let label_Haoma = UILabel()
    private let label_BetsType = UILabel()
    private let label_betMoney = UILabel()
    private let label_Date = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
//        self.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(label_LotteryName)
//        label_LotteryName.isSkeletonable = true
        label_LotteryName.whc_Top(14).whc_Left(24).whc_WidthAuto().whc_Height(24)
        label_LotteryName.font = UIFont.systemFont(ofSize: 14)
//        label_LotteryName.textColor = UIColor.cc_51()
        label_LotteryName.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_LotteryName.text = "二分彩"
        contentView.addSubview(label_Status)
//        label_Status.isSkeletonable = true
        label_Status.whc_CenterYEqual(label_LotteryName).whc_Right(10).whc_WidthAuto().whc_Height(24)
        label_Status.font = UIFont.systemFont(ofSize: 14)
        label_Status.textColor = UIColor.cc_51()
        label_Status.text = "未开奖"
        contentView.addSubview(label_Haoma)
//        label_Haoma.isSkeletonable = true
        label_Haoma.whc_Top(14, toView: label_LotteryName).whc_LeftEqual(label_LotteryName).whc_WidthAuto().whc_Height(10)
        label_Haoma.font = UIFont.systemFont(ofSize: 12)
//        label_Haoma.textColor = UIColor.cc_136()
        label_Haoma.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_Haoma.text = "投注号码："
        contentView.addSubview(label_betMoney)
//        label_betMoney.isSkeletonable = true
        label_betMoney.whc_Top(6, toView: label_Haoma).whc_LeftEqual(label_Haoma).whc_WidthAuto().whc_Height(10).whc_Bottom(15)
        label_betMoney.font = UIFont.systemFont(ofSize: 12)
//        label_betMoney.textColor = UIColor.cc_136()
        label_betMoney.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_betMoney.text = "下注金额："
        contentView.addSubview(label_BetsType)
        label_BetsType.isHidden = true
//        label_BetsType.isSkeletonable = true
        label_BetsType.whc_Top(5, toView: label_Status).whc_RightEqual(label_Status).whc_Width(44).whc_Height(24)
        label_BetsType.font = UIFont.systemFont(ofSize: 12)
//        label_BetsType.textColor = UIColor.white
        label_BetsType.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        label_BetsType.layer.cornerRadius = 3
        label_BetsType.clipsToBounds = true
        contentView.addSubview(label_Date)
//        label_Date.isSkeletonable = true
        label_Date.whc_Top(5, toView: label_BetsType).whc_RightEqual(label_BetsType).whc_WidthAuto().whc_Height(10)
        label_Date.font = UIFont.systemFont(ofSize: 12)
//        label_Date.textColor = UIColor.cc_136()
        label_Date.theme_textColor = "FrostedGlass.glassTextWiteOtherBlack"
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLotteryName(value: String) {
        label_LotteryName.text = !isEmptyString(str: value) ? value : "暂无名称"
        label_LotteryName.theme_textColor = "FrostedGlass.normalDarkTextColor"
    }
    func setBetNumbers(value: String){
        label_Haoma.text = !isEmptyString(str: value) ? String.init(format: "投注号码：%@", value) : "暂无号码"
        label_Haoma.theme_textColor = "FrostedGlass.normalDarkTextColor"
    }
    func setStatus(value: String) {
        label_Status.text = statusToStringChar(status: value)
        if value == "1" || value == "3"{
            label_Status.textColor = UIColor.black
        }else if value == "2" {
             label_Status.textColor = UIColor.red
        }
    }
    func setBalance(value: String) {
        label_betMoney.text = String.init(format: "下注金额：%@元", !isEmptyString(str: value) ? value : "0")
        label_betMoney.theme_textColor = "FrostedGlass.normalDarkTextColor"
    }
    func setBetsType(value: String) {
        label_BetsType.text = value
        label_BetsType.theme_textColor = "FrostedGlass.normalDarkTextColor"
    }
    func setPaiJiangBalance(value: String) {
        label_betMoney.text = String.init(format: "派奖金额：%@元", !isEmptyString(str: value) ? value : "0")
        label_betMoney.theme_textColor = "FrostedGlass.normalDarkTextColor"
    }
    func setDate(value: String) {
        label_Date.text = value
        label_Date.theme_textColor = "FrostedGlass.normalDarkTextColor"
    }
    
    //状态标识转换为对应字符串
    //// 1未开奖 2已中奖 3未中奖 4撤单 5派奖回滚成功 6和局
    func statusToStringChar(status:String) -> String {
        switch status {
        case "1":
            return "未开奖"
        case "2":
            return "已中奖"
        case "3":
            return "未中奖"
        case "4":
            return "已撤单"
        case "5":
            return "派奖回滚成功"
        case "6":
            return "和局"
        default:
            return "未开奖"
        }
    }
    
}
