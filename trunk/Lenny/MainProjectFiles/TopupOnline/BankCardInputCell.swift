//
//  BankCardInputCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class BankCardInputCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private let textField = CustomFeildText()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.systemFont(ofSize: 12)
        textLabel?.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        contentView.addSubview(textField)
        textField.whc_CenterY(0).whc_Left(100).whc_Right(20).whc_Top(5).whc_Bottom(5).whc_Height(40)
        textField.attributedPlaceholder = NSAttributedString.init(string: "", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.ccolor(with: 212, g: 212, b: 212)])
        
        self.whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
    }
    
    func setTitleLabelText(value: String) {
        textLabel?.text = value
    }
    func setPlaceHolder(text: String) {
        textField.placeholder = text
    }
    
    func getCellContent() -> String {
        return textField.text!
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
