//
//  SubChargeCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class SubChargeCell: UITableViewCell {
    
    @IBOutlet weak var nameUI:UILabel!
    @IBOutlet weak var contentUI:UILabel!
    @IBOutlet weak var inputUI:CustomFeildText!
    @IBOutlet weak var copyBtn:UIButton!
    
    func setupData(data:ChargPayBean?){
        if let d = data{
            nameUI.text = d.title
            contentUI.text = d.content
            if d.input{
                inputUI.isHidden = false
                if !isEmptyString(str: d.holderText){
                    inputUI.placeholder = d.holderText
                }else{
                    inputUI.placeholder = String.init(format: "请输入%@", d.title)
                }
            }else{
                inputUI.isHidden = true
            }
        }
    }
}
