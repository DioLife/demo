//
//  SendMessageTitleCell.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/8.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class SendMessageTitleCell: UITableViewCell,UITextFieldDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let textField = CustomFeildText()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
        let label = UILabel()
        contentView.addSubview(label)
        label.whc_Top(13).whc_Height(12).whc_Left(13).whc_WidthAuto().whc_Bottom(15)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.ccolor(with: 0, g: 0, b: 0)
        label.text = "标题："
        
        contentView.addSubview(textField)
        textField.whc_Width(300).whc_Right(20).whc_Height(30).whc_CenterY(0)
        textField.borderStyle = .none
        textField.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        textField.font = UIFont.systemFont(ofSize: 12)
        
        self.whc_AddBottomLine(1, color: UIColor.ccolor(with: 224, g: 224, b: 224))
        selectionStyle = .none
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
