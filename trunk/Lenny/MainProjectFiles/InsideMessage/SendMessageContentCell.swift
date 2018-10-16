//
//  SendMessageContentCell.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/8.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class SendMessageContentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    let textView = CustomTextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let label = UILabel()
        contentView.addSubview(label)
        label.whc_Top(12).whc_Left(12).whc_Height(12).whc_WidthAuto()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.ccolor(with: 0, g: 0, b: 0)
        label.text = "内容："
        
        contentView.addSubview(textView)
        textView.whc_Top(12).whc_Left(20, toView: label).whc_Right(10).whc_Height(180).whc_Bottom(20)
        textView.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
//        textView.layer.borderWidth = 1
//        textView.layer.borderColor = UIColor.ccolor(with: 224, g: 224, b: 224).cgColor
//        textView.layer.cornerRadius = 5
//        textView.clipsToBounds = true
        
        setupNoPictureAlphaBgView(view: self)
        setViewBackgroundColorTransparent(view: textView)
        
        self.whc_AddBottomLine(1, color: UIColor.ccolor(with: 224, g: 224, b: 224))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
