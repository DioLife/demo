//
//  GeRenZongLanController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class GeRenZongLanController: LennyTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        setViews()
    }
    
    private func setViews() {
        
        self.title = "个人总览"
        let button = UIButton(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        button.setImage(UIImage.init(named: "filter"), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
        button.isSelected = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }

    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            if contentView.viewWithTag(101) != nil { return }
            let filterView = LennyFilterView.init(type: .Normal)
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.tag = 101
            contentView.addSubview(filterView)
            filterView.frame = CGRect.init(x: 0, y: -80, width: MainScreen.width, height: 80)
            contentView.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                filterView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 80)
                self.mainTableView.frame = CGRect.init(x: 0, y: 80, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                button.isSelected = true
            }
        }else {
            button.isSelected = false
            let filterView = contentView.viewWithTag(101)
            UIView.animate(withDuration: 0.5, animations: {
                filterView?.alpha = 0
                self.mainTableView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                filterView?.removeFromSuperview()
                button.isSelected = false
            }
        }
    }
    override var numberOfSection: Int {
        return 1
    }
    override var numberOfRowsInsection: [Int] {
        return [3]
    }
    override var cells: [UITableViewCell] {
        var array = [UITableViewCell]()
        let cell1 = GeRenZongLanCell.init(style: .default, reuseIdentifier: "cell")
        cell1.setTitles(titles: ["余额", "充值", "提现"])
        cell1.setValues(values: ["0.00", "0.00", "0.00"])
        array.append(cell1)
        let cell2 = GeRenZongLanCell.init(style: .default, reuseIdentifier: "cell")
        cell2.setTitles(titles: ["投资金额", "净盈利", "中奖金额"])
        cell2.setValues(values: ["0.00", "0.00", "0.00"])
        array.append(cell2)
        let cell3 = GeRenZongLanCell.init(style: .default, reuseIdentifier: "cell")
        cell3.setTitles(titles: ["打和返款", "代理返点", "投注返点"])
        cell3.setValues(values: ["0.00", "0.00", "0.00"])
        array.append(cell3)
        return array
    }
    override func tableHeaderViewWith(title: String) -> UIView? {
        return super.tableHeaderViewWith(title: "个人详情")
    }
}
