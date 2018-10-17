//
//  RegisterTableCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/17.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class RegisterTableCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var nameUI:UILabel!
    @IBOutlet weak var inputUI:CustomFeildText!
    @IBOutlet weak var star:UIImageView!
    @IBOutlet weak var vcCodeUI:UIImageView!
    
    var isRequire = false
    var validate:Bool = false
    var regex = ""
    var regName = ""
    var key = ""
    var showVCode = false

    override func awakeFromNib() {
        super.awakeFromNib()
        inputUI.delegate = self
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        vcCodeUI.addGestureRecognizer(tap1)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func fillNameUI(regName:String) -> Void {
        self.regName = regName
        nameUI.text = regName
        inputUI.placeholder = String.init(format: "请输入%@", regName)
    }
    
    func fillImage() -> Void {
        let imageURL = URL(string: BASE_URL + PORT + REGISTER_VCODE_IMAGE_URL)
        if let url = imageURL{
            downloadImage(url: url, imageUI: self.vcCodeUI)
        }
    }
    
    func tapEvent(recongnizer: UIPanGestureRecognizer) {
        print("click vccode image")
        fillImage()
    }
    

}
