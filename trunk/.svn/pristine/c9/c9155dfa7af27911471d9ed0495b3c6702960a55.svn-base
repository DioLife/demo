//
//  TopupTableViewCell.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/2.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class TopupTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var label_Order = UILabel()
    var label_Date = UILabel()
    var label_BankName = UILabel()
    var label_Balance = UILabel()
    var label_Success = UILabel()
    var label_Time = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
        self.contentView.addSubview(label_Order)
        label_Order.whc_Top(20).whc_Left(11).whc_Height(10).whc_WidthAuto()
        label_Order.font = UIFont.systemFont(ofSize: 14)
        label_Order.text = ""
        label_Order.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        
        self.contentView.addSubview(label_Date)
        label_Date.whc_Top(10, toView: label_Order).whc_Left(11).whc_Height(10).whc_WidthAuto()
        label_Date.font = UIFont.systemFont(ofSize: 14)
        label_Date.text = ""
        label_Date.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        
        contentView.addSubview(label_BankName)
        label_BankName.whc_Top(5, toView: label_Date).whc_LeftEqual(label_Date).whc_Height(13).whc_WidthAuto()
        label_BankName.font = UIFont.systemFont(ofSize: 14)
//        label_BankName.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        setThemeLabelTextColorGlassWhiteOtherGray(label: label_BankName)
        label_BankName.text = "暂无银行"
        
        contentView.addSubview(label_Balance)
        label_Balance.whc_CenterY(0, toView: label_Date).whc_Height(10).whc_Right(50).whc_WidthAuto()
        label_Balance.font = UIFont.systemFont(ofSize: 14)
        label_Balance.text = "0元"
        label_Balance.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)

        contentView.addSubview(label_Time)
        label_Time.whc_CenterY(0, toView: label_BankName).whc_RightEqual(label_Balance, offset: 5).whc_Height(10).whc_WidthAuto()
        label_Time.font = UIFont.systemFont(ofSize: 14)
        label_Time.text = ""
        label_Time.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        
        contentView.addSubview(label_Success)
        label_Success.whc_Right(0, toView: label_Time).whc_BottomEqual(label_Time).whc_Height(9).whc_WidthAuto().whc_Top(5, toView: label_Balance)
        label_Success.font = UIFont.systemFont(ofSize: 12)
        label_Success.text = "未处理"
//        label_Success.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        setThemeLabelTextColorGlassWhiteOtherGray(label: label_Success)
        
    }
    
    func setOrder(value:String){
        label_Order.text = !isEmptyString(str: value) ? value : "暂无订单"
    }
    
    func setDate(value:String){
        label_Date.text = !isEmptyString(str: value) ? value : "暂无日期"
    }
    func setBalance(value:String){
        label_Balance.text = !isEmptyString(str: value) ? value : "0元"
    }
    func setStatus(value:Int){
        label_Success.text = convert_status(status: value)
    }
    func setBank(value:String){
        label_BankName.text = !isEmptyString(str: value) ? value : "暂无银行"
    }
    
    private func convert_status(status:Int) -> String{
        if status == 1{
            return "未处理"
        }else if status == 2{
            return "成功"
        }else if status == 3{
            return "失败"
        }else if status == 4{
            return "已过期"
        }
        return "未处理"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
