//
//  BankCardTransferBalanceCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class BankCardTransferBalanceCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private let label_Balance = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label_Balance)
        label_Balance.whc_CenterX(0).whc_Top(28).whc_Height(20).whc_Bottom(20).whc_WidthAuto()
        label_Balance.font = UIFont.systemFont(ofSize: 24)
        label_Balance.textColor = UIColor.mainColor()
        label_Balance.text = "10000.00"
    }
    
    func setBalance(value: String) {
        label_Balance.text = value
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
