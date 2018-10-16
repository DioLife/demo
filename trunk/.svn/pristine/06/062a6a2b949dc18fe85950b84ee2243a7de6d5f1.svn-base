//
//  TuanDuiZongLanCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/23.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class TuanDuiZongLanCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private let label_TeamNumbers = UILabel()
    private let label_RegistedNumber = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label_TeamNumbers)
        label_TeamNumbers.whc_Top(16).whc_Bottom(13).whc_Height(12).whc_Left(22).whc_WidthAuto()
        label_TeamNumbers.font = UIFont.systemFont(ofSize: 12)
        label_TeamNumbers.textColor = UIColor.cc_51()
        label_TeamNumbers.text = "团队人数:"
        contentView.addSubview(label_RegistedNumber)
        label_RegistedNumber.whc_Top(16).whc_Bottom(13).whc_Height(12).whc_Left(154).whc_WidthAuto()
        label_RegistedNumber.font = UIFont.systemFont(ofSize: 12)
        label_RegistedNumber.textColor = UIColor.cc_51()
        label_RegistedNumber.text = "注册人数:"
        
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
