//
//  BankSettingCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class BankSettingCell: UITableViewCell,UITextFieldDelegate {
    
    
    @IBOutlet weak var tagUI:UILabel!
    @IBOutlet weak var inputUI:CustomFeildText!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inputUI.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
