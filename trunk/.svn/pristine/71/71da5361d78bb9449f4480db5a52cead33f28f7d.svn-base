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
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        setViews()
    }
    
    override var numberOfSection: Int {
        return 1
    }
    override var numberOfRowsInsection: [Int] {
        return [5]
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
        
        return array
    }
    
    private func setViews() {
        
        self.title = "注册管理"
        WHC_KeyboardManager.share.addMonitorViewController(self).enableHeader = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
    }
    
    override func tableFooterView() -> UIView {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50)
        
        let button = UIButton()
        view.addSubview(button)
        button.whc_Top(0).whc_Width(kScreenWidth-40).whc_Height(50).whc_Left(20)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.mainColor()
        button.setTitle("确认", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(buttonClickHandle), for: .touchUpInside)
        
        return view
    }
    
    @objc private func buttonClickHandle() {
        
    }
}
