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
    
    var isNeedLabel:UILabel!//加*号
    @IBOutlet weak var showNeed: UILabel!
    
    var isRequire = 1
    var validate:Bool = false
    var regex = ""
    var regName = ""
    var key = ""
    var showVCode = false

    override func awakeFromNib() {
        super.awakeFromNib()
        inputUI.delegate = self
        
        setupNoPictureAlphaBgView(view: self)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(recongnizer:)))
        vcCodeUI.addGestureRecognizer(tap1)
        inputUI.whc_Left(50).whc_CenterY(0).whc_Top(5).whc_Bottom(5).whc_Right(70)
        
        nameUI.isHidden = true
        imageView?.image = UIImage(named: "zhuce_zhanghao")
//        nameUI.whc_CenterY(0).whc_Left(20).whc_Width(80).whc_Height(20)
//        nameUI.textAlignment = .right
        self.selectionStyle = .none
        
        
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
        
        isNeedLabel = UILabel(lableText: "*")
        isNeedLabel.textColor = UIColor.red
        self.addSubview(isNeedLabel)
        isNeedLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.top.equalTo(10)
            make.width.equalTo(8)
            make.height.equalTo(28)
        }
//        if isRequire == 2 {
//            isNeedLabel.isHidden = false
//        }else{
//            isNeedLabel.isHidden = true
//        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func  layoutSubviews() {
        super.layoutSubviews()

        let centerY = self.height * CGFloat(0.5)
    
        imageView?.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView?.center = CGPoint(x: 20, y: centerY)
        
        if isRequire == 2 {
            isNeedLabel.isHidden = false
        }else{
            isNeedLabel.isHidden = true
        }
    }
    
    
    func fillNameUI(regName:String,index: Int) -> Void {
        self.regName = regName
        nameUI.text = regName
        inputUI.placeholder = String.init(format: "请输入%@", regName)
        
        if index == 0 { inputUI.placeholder = "账号由5-11个数字和字母组成"; imageView?.theme_image = "Global.Login_Register.fieldAccountImg"}
        else if index == 1 { inputUI.placeholder = "密码由6-13个字母数字组成"; imageView?.theme_image = "Global.Login_Register.fieldPwdImg"}
        else if index == 2 { inputUI.placeholder = "再次输入登录密码"; imageView?.theme_image = "Global.Login_Register.fieldPwdImg"}        
        else {
            inputUI.placeholder = "请输入\(regName)";imageView?.theme_image = "Global.Login_Register.fieldFlowerImg"
        }
        
    }

    func fillImage() -> Void {
        let imageURL = URL(string: BASE_URL + PORT + REGISTER_VCODE_IMAGE_URL)
        if let url = imageURL{
            downloadImage(url: url, imageUI: self.vcCodeUI)
        }
    }
    
    @objc func tapEvent(recongnizer: UIPanGestureRecognizer) {
        print("click vccode image")
        fillImage()
    }
}
