//
//  AddBankTableCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class AddBankTableCell: UITableViewCell{
    
    @IBOutlet weak var textTV:UILabel!
    @IBOutlet weak var inputTV:CustomFeildText!
    @IBOutlet weak var valueTV:UILabel!
    @IBOutlet weak var copyBtn:UIButton!
    

    func setModel(model:FakeBankBean,row:Int){
        if row == 0{
            accessoryType = .disclosureIndicator
            inputTV.isHidden = true
            valueTV.isHidden = false
            valueTV.text = model.value
        }else{
            inputTV.isHidden = false
            valueTV.isHidden = true
            accessoryType = .none
            inputTV.text = model.value
            inputTV.placeholder = String.init(format: "请输入%@", model.text)
        }
        textTV.text = model.text
    }
    

}
