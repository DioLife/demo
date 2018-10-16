//
//  AliPayTransferController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class AliPayTransferController: LennyTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    override var numberOfSection: Int {
        return 2
    }
    override var numberOfRowsInsection: [Int] {
        return [3,4]
    }
    
    override var cells: [UITableViewCell] {
        var cellss = [UITableViewCell]()
        let cell1 = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
        cell1.setTitleLabelText(value: "选择通道"); cell1.setContent(value: "支付宝转账")
        cellss.append(cell1)
        let cell2 = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
        cell2.setTitleLabelText(value: "收款账号"); cell2.setContent(value: "巴拉巴拉")
        cellss.append(cell2)
        let cell3 = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
        cell3.setTitleLabelText(value: "收款人"); cell3.setContent(value: "巴拉巴拉")
        cellss.append(cell3)
        let cell4 = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
        cell4.setTitleLabelText(value: "收款银行"); cell4.setContent(value: "中国工商银行")
        cellss.append(cell4)
        let cell5 = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
        cell5.setTitleLabelText(value: "订单号"); cell5.setContent(value: "46843156139612")
        cellss.append(cell5)
        let cell6 = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
        cell6.setTitleLabelText(value: "收款账号"); cell6.setPlaceHolder(text: "请输入实际转账金额")
        cellss.append(cell6)
        let cell7 = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
        cell7.setTitleLabelText(value: "附言码"); cell7.setContent(value: "06251")
        cellss.append(cell7)
        return cellss
    }
    
    private func  setViews() {
        
        self.title = "支付宝充值"
    }
    override func tableHeaderViewWith(title: String) -> UIView? {
        return super.tableHeaderViewWith(title: kHeaderViewDesc[1])
    }
    override func tableFooterView() -> UIView {
        let viewFooter = UIView()
        viewFooter.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 80)
        let label = UILabel()
        viewFooter.addSubview(label)
        label.whc_Top(12).whc_Left(16).whc_WidthAuto().whc_Height(10)
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = UIColor.mainColor()
        label.text = "温馨提示：最小金额10，最大金额600000"
        
        let button = UIButton()
        viewFooter.addSubview(button)
        button.whc_Top(21, toView: label).whc_CenterX(0).whc_Height(30).whc_Width(200)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("确认", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.mainColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(confirmToCommit), for: .touchUpInside)
        return viewFooter
    }
    @objc private func confirmToCommit() {
        
    }
}
