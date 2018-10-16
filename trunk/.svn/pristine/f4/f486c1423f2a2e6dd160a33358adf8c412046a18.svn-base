//
//  UserWithdrawBalanceCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class UserWithdrawBalanceCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private let label_CanWithdrawAmount = UILabel()
    private let label_ServiceCharge = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = WHC_StackView()
        contentView.addSubview(stackView)
        stackView.whc_Height(66).whc_Top(0).whc_Bottom(0).whc_Left(0).whc_Right(0)
        stackView.whc_Column = 2
        stackView.whc_Orientation = .all
        stackView.whc_Edge = UIEdgeInsetsMake(10, 0, 10, 0)
        let label_AmountTitle = UILabel()
        label_AmountTitle.font = UIFont.systemFont(ofSize: 12)
        label_AmountTitle.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label_AmountTitle.text = "可提现金额（元）"
        label_AmountTitle.textAlignment = .center
        stackView.addSubview(label_AmountTitle)
        
        let label_ServiceTitle = UILabel()
        label_ServiceTitle.font = UIFont.systemFont(ofSize: 12)
        label_ServiceTitle.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label_ServiceTitle.text = "手续费（元）"
        label_ServiceTitle.textAlignment = .center
        stackView.addSubview(label_ServiceTitle)
        
        label_CanWithdrawAmount.font = UIFont.systemFont(ofSize: 15)
        label_CanWithdrawAmount.textColor = UIColor.mainColor()
        label_CanWithdrawAmount.textAlignment = .center
        label_CanWithdrawAmount.text = "5000.00"
        stackView.addSubview(label_CanWithdrawAmount)
        
        label_ServiceCharge.font = UIFont.systemFont(ofSize: 15)
        label_ServiceCharge.textColor = UIColor.mainColor()
        label_ServiceCharge.textAlignment = .center
        label_ServiceCharge.text = "0.00"
        stackView.addSubview(label_ServiceCharge)
        
        stackView.whc_StartLayout()
    }
    
    func setWithdrawAmount(value: String) {
        label_CanWithdrawAmount.text = value
    }
    func setServiceCharge(value: String) {
        label_ServiceCharge.text = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
