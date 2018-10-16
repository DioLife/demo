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
    
    private let textField_NewPassword = UITextField()
    private let textField_AgainPassword = UITextField()
    
    private func setViews() {
        
        contentView.addSubview(textField_NewPassword)
        textField_NewPassword.whc_Top(14).whc_Left(10).whc_Right(10).whc_Height(31)
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
        button_Confirm.setTitle("确认", for: .normal)
        stackView.addSubview(button_Confirm)
        stackView.whc_StartLayout()
    }

}
