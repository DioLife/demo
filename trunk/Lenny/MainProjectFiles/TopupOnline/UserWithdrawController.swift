//
//  UserWithdrawController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class UserWithdrawController: LennyTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }

    private func setViews() {
        
        self.title = "提现"
    }
    
    override var sectionHeaderHeight: [CGFloat] {
        return [0,5,5]
    }
    override var sectionHeaderView: [UIView] {
        let view = UIView()
        view.backgroundColor = UIColor.ccolor(with: 224, g: 224, b: 224)
        return [view]
    }
    override var numberOfSection: Int {
        return 3
    }
    override var numberOfRowsInsection: [Int] {
        return [1, 2, 1]
    }
    override var cells: [UITableViewCell] {
        var cell_Array = [UITableViewCell]()
        
        let cell1 = UserWithdrawBalanceCell.init(style: .default, reuseIdentifier: "cell")
        cell_Array.append(cell1)
        let cell2 = UserWithdrawBankSelectCell.init(style: .default, reuseIdentifier: "cell")
        cell2.setTitleLabelText(value: "银行卡：")
        cell_Array.append(cell2)
        let cell3 = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
        cell3.setTitleLabelText(value: "提现金额：")
        cell3.setPlaceHolder(text: "免手续费1000次")
        cell_Array.append(cell3)
        let cell4 = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
        cell4.setTitleLabelText(value: "资金密码：")
        cell4.setPlaceHolder(text: "请输入资金密码")
        cell_Array.append(cell4)
        return cell_Array
    }
    
    override func tableFooterView() -> UIView {
        let viewFooter = UIView.init(frame: CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 100))
        
        let label = UILabel()
        viewFooter.addSubview(label)
        label.whc_Top(12).whc_Left(15).whc_Height(10).whc_WidthAuto()
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = UIColor.mainColor()
        label.text = "温馨提示：出款上限99999999.00元，出款下限0.00元。"
        
        let button = UIButton()
        viewFooter.addSubview(button)
        button.whc_Top(7, toView: label).whc_LeftEqual(label).whc_Width(50).whc_Height(20)
        button.backgroundColor = UIColor.ccolor(with: 1, g: 175, b: 5)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.setTitle("查看流水", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        
        let button_Confirm = UIButton()
        viewFooter.addSubview(button_Confirm)
        button_Confirm.whc_Top(45, toView: label).whc_CenterX(0).whc_Width(200).whc_Height(30)
        button_Confirm.backgroundColor = UIColor.mainColor()
        button_Confirm.layer.cornerRadius = 5
        button_Confirm.clipsToBounds = true
        button_Confirm.setTitle("确认提现", for: .normal)
        button_Confirm.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return viewFooter
    }
}
