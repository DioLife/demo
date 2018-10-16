//
//  QueryResultsCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ZuihaoResultsCell: UITableViewCell {

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
    private let label_Balance = UILabel()
    private let label_BetsType = UILabel()
    private let label_PaijiangBalance = UILabel()
    private let label_Date = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(label_LotteryName)
//        label_LotteryName.isSkeletonable = true
        label_LotteryName.whc_Top(14).whc_Left(24).whc_WidthAuto().whc_Height(24)
        label_LotteryName.font = UIFont.systemFont(ofSize: 14)
        label_LotteryName.textColor = UIColor.cc_51()
        label_LotteryName.text = "二分彩"
        contentView.addSubview(label_Status)
//        label_Status.isSkeletonable = true
        label_Status.whc_CenterYEqual(label_LotteryName).whc_Right(10).whc_WidthAuto().whc_Height(24)
        label_Status.font = UIFont.systemFont(ofSize: 14)
        label_Status.textColor = UIColor.cc_51()
        label_Status.text = "未开奖"
        contentView.addSubview(label_Balance)
//        label_Balance.isSkeletonable = true
        label_Balance.whc_Top(14, toView: label_LotteryName).whc_LeftEqual(label_LotteryName).whc_WidthAuto().whc_Height(10)
        label_Balance.font = UIFont.systemFont(ofSize: 12)
        label_Balance.textColor = UIColor.cc_136()
        label_Balance.text = "投注金额："
        contentView.addSubview(label_PaijiangBalance)
//        label_PaijiangBalance.isSkeletonable = true
        label_PaijiangBalance.whc_Top(6, toView: label_Balance).whc_LeftEqual(label_Balance).whc_WidthAuto().whc_Height(10).whc_Bottom(15)
        label_PaijiangBalance.font = UIFont.systemFont(ofSize: 12)
        label_PaijiangBalance.textColor = UIColor.cc_136()
        label_PaijiangBalance.text = "派奖金额："
        contentView.addSubview(label_BetsType)
        label_BetsType.isHidden = true
//        label_BetsType.isSkeletonable = true
        label_BetsType.whc_Top(5, toView: label_Status).whc_RightEqual(label_Status).whc_Width(44).whc_Height(24)
        label_BetsType.font = UIFont.systemFont(ofSize: 12)
        label_BetsType.textColor = UIColor.white
        label_BetsType.layer.cornerRadius = 3
        label_BetsType.clipsToBounds = true
        label_BetsType.backgroundColor = UIColor.ccolor(with: 153, g: 153, b: 153)
        contentView.addSubview(label_Date)
//        label_Date.isSkeletonable = true
        label_Date.whc_Top(5, toView: label_BetsType).whc_RightEqual(label_BetsType).whc_WidthAuto().whc_Height(10)
        label_Date.font = UIFont.systemFont(ofSize: 12)
        label_Date.textColor = UIColor.cc_136()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLotteryName(value: String) {
        label_LotteryName.text = !isEmptyString(str: value) ? value : "暂无名称"
    }
    func setStatus(value: String) {
        label_Status.text = statusToStringChar(status: value)
        if value == "1" || value == "3"{
            label_Status.textColor = UIColor.red
        }
    }
    func setBalance(value: String) {
        label_Balance.text = String.init(format: "投注金额：%@元", value)
    }
    func setBetsType(value: String) {
        label_BetsType.text = value
    }
    func setPaiJiangBalance(value: String) {
        label_PaijiangBalance.text = String.init(format: "派奖金额：%@元", !isEmptyString(str: value) ? value : "")
    }
    func setDate(value: String) {
        label_Date.text = value
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
            return "撤单"
        case "5":
            return "派奖回滚成功"
        case "6":
            return "和局"
        default:
            return "未开奖"
        }
    }
    
}
