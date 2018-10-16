//
//  BankCardDisplayCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class BankCardDisplayCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private let label_Content = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.systemFont(ofSize: 12)
        textLabel?.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        contentView.addSubview(label_Content)
        label_Content.whc_CenterY(0).whc_Left(100).whc_Right(20).whc_Height(40).whc_Top(5).whc_Bottom(5)
        label_Content.font = UIFont.systemFont(ofSize: 12)
        label_Content.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)

        whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
    }
    
    func setTitleLabelText(value: String) {
        textLabel?.text = value
    }
    
    func setContent(value: String) {
        label_Content.text = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
