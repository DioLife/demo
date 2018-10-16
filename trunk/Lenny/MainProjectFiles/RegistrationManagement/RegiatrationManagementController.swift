//
//  RegiatrationManagementController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class RegistrationManagementController: LennyTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }
    
    override var numberOfSection: Int {
        return 1
    }
    override var numberOfRowsInsection: [Int] {
        return [6]
    }
    override var cells: [UITableViewCell] {
        var array = [UITableViewCell]()
        
        let cell1 = RegistrationManagementTypeSelectCell.init(style: .default, reuseIdentifier: "cell")
        cell1.setTitleLabelText(value: "用户类型")
        array.append(cell1)
        
        let cell2 = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
        cell2.setTitleLabelText(value: "用户昵称:")
        cell2.setPlaceHolder(text: "请输入昵称，2-6字符")
        array.append(cell2)
        
        let cell3 = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
        cell3.setTitleLabelText(value: "登录账户：")
        cell3.setPlaceHolder(text: "账号只能是数字和字母，长度为3-15字符")
        array.append(cell3)
        
        let cell4 = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
        cell4.setTitleLabelText(value: "登录密码:")
        cell4.setPlaceHolder(text: "由字母跟数字组成的6-13个字符")
        array.append(cell4)
        
        let cell5 = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
        cell5.setTitleLabelText(value: "重复密码：")
        cell5.setPlaceHolder(text: "请再次输入密码")
        array.append(cell5)
        
    }
    
    private func setViews() {
        
        self.title = "注册管理"
    }
}
