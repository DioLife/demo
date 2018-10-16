//
//  ModifyLoginPasswordController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class ModifyLoginPasswordController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }

    override var hasNavigationBar: Bool {
        return false
    }
    private let textField_OldPassword = UITextField()
    private let textField_NewLoginPassword = UITextField()
    private let textField_AgainNewLoginPassword = UITextField()
    
    private func setViews() {
        
        contentView.addSubview(textField_OldPassword)
        textField_OldPassword.whc_Top(13).whc_Left(10).whc_Right(10).whc_Height(31)
//        textField_OldPassword.placeholder = "输入旧登录密码"
//        textField_OldPassword.font = UIFont.systemFont(ofSize: 9)
        textField_OldPassword.attributedPlaceholder = NSAttributedString.init(string: "输入旧登录密码", attributes: [NSAttributedStringKey.strokeColor: UIColor.ccolor(with: 136, g: 136, b: 136), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
        textField_OldPassword.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        textField_OldPassword.borderStyle = .roundedRect
        
        contentView.addSubview(textField_NewLoginPassword)
        textField_NewLoginPassword.whc_Top(14, toView: textField_OldPassword).whc_Left(10).whc_Right(10).whc_Height(31)
        textField_NewLoginPassword.attributedPlaceholder = NSAttributedString.init(string: "输入新登录密码", attributes: [NSAttributedStringKey.strokeColor: UIColor.ccolor(with: 136, g: 136, b: 136), NSAttributedStringKey
            .font: UIFont.systemFont(ofSize: 9)])
        textField_NewLoginPassword.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        textField_NewLoginPassword.borderStyle = .roundedRect
        textField_NewLoginPassword.isSecureTextEntry = true
        
        let label = UILabel()
        contentView.addSubview(label)
        label.whc_Top(10, toView: textField_NewLoginPassword).whc_LeftEqual(textField_NewLoginPassword).whc_Height(9).whc_WidthAuto()
        label.font = UIFont.systemFont(ofSize: 8)
        label.text = "（由字母或数字组成的6-20个字符）"
        
        contentView.addSubview(textField_AgainNewLoginPassword)
        textField_AgainNewLoginPassword.whc_Top(10, toView: label).whc_Left(10).whc_Right(10).whc_Height(31)
        textField_AgainNewLoginPassword.attributedPlaceholder = NSAttributedString.init(string: "再次输入新登录密码", attributes: [NSAttributedStringKey.strokeColor: UIColor.ccolor(with: 136, g: 136, b: 136), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 9)])
        textField_AgainNewLoginPassword.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        textField_AgainNewLoginPassword.borderStyle = .roundedRect
        textField_AgainNewLoginPassword.isSecureTextEntry = true
        
        let stackView = WHC_StackView()
        contentView.addSubview(stackView)
        stackView.whc_Top(20, toView: textField_AgainNewLoginPassword).whc_LeftEqual(textField_AgainNewLoginPassword, offset: 15).whc_RightEqual(textField_AgainNewLoginPassword, offset: 15)
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
        button_Confirm.addTarget(self, action: #selector(confirm_CommitModify), for: .touchUpInside)
        button_Confirm.backgroundColor = UIColor.ccolor(with: 236, g: 40, b: 40)
        button_Confirm.layer.cornerRadius = 5
        button_Confirm.clipsToBounds = true
        button_Confirm.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button_Confirm.setTitle("确认", for: .normal)
        stackView.addSubview(button_Confirm)
        stackView.whc_StartLayout()
    }
    
    @objc func confirm_CommitModify() -> Void {
        loadNetRequestWithViewSkeleton(animate: true)
    }
    
    override func loadNetRequestWithViewSkeleton(animate: Bool) {
        super.loadNetRequestWithViewSkeleton(animate: true)
        LennyNetworkRequest.commitModifyPwd(oldpwd: textField_OldPassword.text!, newpwd: textField_NewLoginPassword.text!,type:"1"){
            (model) in
            if let model = model{
                self.view.hideSkeleton()
                if model.success{
                    showToast(view: self.view, txt: "修改成功")
                }else{
                    showToast(view: self.view, txt: !isEmptyString(str: model.msg) ? model.msg : "修改密码失败")
                }
            }
        }
    }


}
