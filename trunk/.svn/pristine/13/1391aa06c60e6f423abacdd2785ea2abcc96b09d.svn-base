//
//  SetWithdrawPasswordController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class SetWithdrawPasswordController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    override var hasNavigationBar: Bool {
        return false
    }
    
    private let textField_OldPassword = UITextField()
    private let textField_NewPassword = UITextField()
    private let textField_AgainPassword = UITextField()
    
    private func setViews() {
        
        contentView.addSubview(textField_OldPassword)
        textField_OldPassword.whc_Top(14).whc_Left(10).whc_Right(10).whc_Height(31)
        textField_OldPassword.attributedPlaceholder = NSAttributedString.init(string: "输入旧提款密码", attributes: [NSAttributedStringKey.strokeColor: UIColor.ccolor(with: 136, g: 136, b: 136), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
        textField_OldPassword.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        textField_OldPassword.borderStyle = .roundedRect
        
        contentView.addSubview(textField_NewPassword)
        textField_NewPassword.addTarget(self, action: #selector(textField_NewPasswordChange(npwdField:)), for: .editingChanged)
        textField_NewPassword.whc_Top(10, toView: textField_OldPassword).whc_Left(10).whc_Right(10).whc_Height(31)
        textField_NewPassword.attributedPlaceholder = NSAttributedString.init(string: "输入新提款密码", attributes: [NSAttributedStringKey.strokeColor: UIColor.ccolor(with: 136, g: 136, b: 136), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
        textField_NewPassword.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        textField_NewPassword.borderStyle = .roundedRect
        
        let label = UILabel()
        contentView.addSubview(label)
        label.whc_Top(10, toView: textField_NewPassword).whc_LeftEqual(textField_NewPassword).whc_Height(9).whc_WidthAuto()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label.text = "(由字母和数字组成的4-6个字符)"
        
        contentView.addSubview(textField_AgainPassword)
        textField_AgainPassword.whc_Top(10, toView: label).whc_Left(10).whc_Right(10).whc_Height(31)
        textField_AgainPassword.attributedPlaceholder = NSAttributedString.init(string: "再次输入新提款密码", attributes: [NSAttributedStringKey.strokeColor: UIColor.ccolor(with: 136, g: 136, b: 136), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
        textField_AgainPassword.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        textField_AgainPassword.borderStyle = .roundedRect
        
        let stackView = WHC_StackView()
        contentView.addSubview(stackView)
        stackView.whc_Top(20, toView: textField_AgainPassword).whc_LeftEqual(textField_AgainPassword, offset: 15).whc_RightEqual(textField_AgainPassword, offset: 15)
        stackView.whc_HSpace = 27
        stackView.whc_Column = 2
        stackView.whc_Orientation = .all
        
        let button_Cancel = UIButton()
        button_Cancel.backgroundColor = UIColor.ccolor(with: 191, g: 191, b: 191)
        button_Cancel.layer.cornerRadius = 5
        button_Cancel.clipsToBounds = true
        button_Cancel.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button_Cancel.setTitle("取消", for: .normal)
        stackView.addSubview(button_Cancel)
        let button_Confirm = UIButton()
        button_Confirm.backgroundColor = UIColor.ccolor(with: 236, g: 40, b: 40)
        button_Confirm.layer.cornerRadius = 5
        button_Confirm.clipsToBounds = true
        button_Confirm.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button_Confirm.addTarget(self, action: #selector(confirm_CommitModify), for: .touchUpInside)
        button_Confirm.setTitle("确认", for: .normal)
        stackView.addSubview(button_Confirm)
        stackView.whc_StartLayout()
    }
    
    @objc func textField_NewPasswordChange(npwdField:UITextField){
        if (textField_NewPassword.text?.length)! > 6 {
            showToast(view: self.view, txt: "密码不能超过6位")
            let pwdvalue = textField_NewPassword.text
            let numSubStr = pwdvalue?.subString(start: 0, length: (pwdvalue?.length)! - 1)
            textField_NewPassword.text = numSubStr
        }
    }
    
    @objc func confirm_CommitModify() -> Void {
        
//        let old = textField_OldPassword.text
        let new = textField_NewPassword.text
        let anew = textField_AgainPassword.text
        if new != anew{
            showToast(view: self.view, txt: "两次密码不一致")
            return
        }
        loadNetRequestWithViewSkeleton(animate: true)
    }
    
    override func loadNetRequestWithViewSkeleton(animate: Bool) {
        super.loadNetRequestWithViewSkeleton(animate: true)
        LennyNetworkRequest.commitModifyPwd(oldpwd: textField_OldPassword.text!, newpwd: textField_AgainPassword.text!,type:"2"){
            (model) in
            if let model = model{
                self.view.hideSkeleton()
                if model.success{
                    showToast(view: self.view, txt: "修改成功")
                    self.navigationController?.popViewController(animated: true)
                }else{
                    if model.msg.contains("超时") || model.msg.contains("登录"){
                        loginWhenSessionInvalid(controller: self)
                        return
                    }
                    showToast(view: self.view, txt: !isEmptyString(str: model.msg) ? model.msg : "修改密码失败")
                }
            }
        }
    }

}
