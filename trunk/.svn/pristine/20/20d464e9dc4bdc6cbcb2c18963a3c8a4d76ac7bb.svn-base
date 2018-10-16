//
//  BankCardTransferController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

struct BankCardModel {
    
    var bankName: String!
    var bankNameSubtitle: String!
    var detail: String!
    var bankCardNumber: String!
}

 let bankCardModel = [
                                BankCardModel(bankName: "中国工商银行", bankNameSubtitle: "中国工商银行", detail: "六一儿童节进出口贸易有限公司", bankCardNumber: "1234567891234567898"),
                                BankCardModel(bankName: "中国工商银行", bankNameSubtitle: "中国工商银行", detail: "六一儿童节进出口贸易有限公司", bankCardNumber: "1234567891234567891")
                            ]
 let kHeaderViewDesc = ["请选择入款银行卡", "请填写转账资料", "请确认转账金额"]
private let kFillTableCellTitles = ["订单编号：", "存入金额:", "开户姓名:", "转账类型:"]
private let kFillTableCellPlaceHolders = ["123456789", "请输入转账金额", "请输入中文字符"]
class BankCardTransferController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WHC_KeyboardManager.share.addMonitorViewController(self)
        setViews()
        
    }
    ///第一步，选择银行卡的TableView
    private let mainTableView_SelectBankCard: UITableView = {
       let tabview = UITableView()
        tabview.tag = 0
        return tabview
    }()
    ///第二步， 填写转账资料的TableView
    private let mainTableView_FillInTheForm: UITableView = {
        let tabView = UITableView()
        tabView.tag = 1
        return tabView
    }()
    ///第三步，确认资料
    private let mainTableView_Confirm: UITableView = {
        let tabView = UITableView()
        tabView.tag = 2
        return tabView
    }()
    
    private func setViews() {
        
        contentView.backgroundColor = UIColor.black
        self.title = "银行卡转账"
        mainTableView_SelectBankCard.delegate = self
        mainTableView_SelectBankCard.dataSource = self
        contentView.addSubview(mainTableView_SelectBankCard)
        mainTableView_SelectBankCard.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView_SelectBankCard.rowHeight = UITableViewAutomaticDimension
        mainTableView_SelectBankCard.estimatedRowHeight = 56
        mainTableView_SelectBankCard.tableFooterView = UIView()
        mainTableView_SelectBankCard.separatorStyle = .none
        mainTableView_SelectBankCard.tableHeaderView = tableHeaderView(index: mainTableView_SelectBankCard.tag)
        mainTableView_SelectBankCard.tableFooterView = tableFooterView(index: mainTableView_SelectBankCard.tag)
        
        mainTableView_FillInTheForm.delegate = self
        mainTableView_FillInTheForm.dataSource = self
        contentView.addSubview(mainTableView_FillInTheForm)
        mainTableView_FillInTheForm.frame = CGRect.init(x: 0, y: contentView.height, width: MainScreen.width, height: contentView.height)
        mainTableView_FillInTheForm.isHidden = true
        mainTableView_FillInTheForm.rowHeight = UITableViewAutomaticDimension
        mainTableView_FillInTheForm.estimatedRowHeight = 56
        mainTableView_FillInTheForm.separatorStyle = .none
        mainTableView_FillInTheForm.tableHeaderView = tableHeaderView(index: mainTableView_FillInTheForm.tag)
        mainTableView_FillInTheForm.tableFooterView = tableFooterView(index: mainTableView_FillInTheForm.tag)
        
        mainTableView_Confirm.delegate = self
        mainTableView_Confirm.dataSource = self
        contentView.addSubview(mainTableView_Confirm)
        mainTableView_Confirm.frame = CGRect.init(x: 0, y: contentView.height, width: MainScreen.width, height: contentView.height)
        mainTableView_Confirm.isHidden = true
        mainTableView_Confirm.rowHeight = UITableViewAutomaticDimension
        mainTableView_Confirm.estimatedRowHeight = 56
        mainTableView_Confirm.separatorStyle = .none
        mainTableView_Confirm.tableHeaderView = tableHeaderView(index: mainTableView_Confirm.tag)
        mainTableView_Confirm.tableFooterView = tableFooterView(index: mainTableView_Confirm.tag)
    }
    
    private func tableHeaderView(index: Int) -> UIView {
        
        let viewHeader = UIView(frame: CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 33))
        viewHeader.backgroundColor = UIColor.ccolor(with: 71, g: 71, b: 69)
        
        let view = UIView()
        viewHeader.addSubview(view)
        view.whc_Top(13).whc_Left(17).whc_Width(8).whc_Height(8)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.backgroundColor = UIColor.mainColor()
        
        let label = UILabel()
        viewHeader.addSubview(label)
        label.whc_CenterY(0).whc_Left(35).whc_WidthAuto().whc_Height(13)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.text = kHeaderViewDesc[index]
        
        return viewHeader
    }
    
    private func tableFooterView(index: Int) -> UIView {
        
        let viewFooter = UIView()
        if index == 0 {
            viewFooter.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 50)
            let label = UILabel()
            viewFooter.addSubview(label)
            label.whc_Top(16).whc_Left(15).whc_Right(18).whc_HeightAuto()
            label.font = UIFont.systemFont(ofSize: 9)
            label.textColor = UIColor.ccolor(with: 236, g: 40, b: 41)
            label.numberOfLines = 0
            label.text = "温馨提示：\n以上银行账号限本次存款用，账号不定期更换！每次存款前请依照本页所显示的银行卡账号入款。如入款至已过期账号，无法查收，本公司恕不负责！"
        }
        if index == 1 {
            viewFooter.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 80)
            let label = UILabel()
            viewFooter.addSubview(label)
            label.whc_Top(12).whc_Left(16).whc_WidthAuto().whc_Height(10)
            label.font = UIFont.systemFont(ofSize: 9)
            label.textColor = UIColor.mainColor()
            label.text = "温馨提示：最小金额10元，最大金额600000元。"
            
            let button = UIButton()
            viewFooter.addSubview(button)
            button.whc_Top(21, toView: label).whc_CenterX(0).whc_Height(30).whc_Width(200)
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            button.setTitle("下一步", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.mainColor()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.addTarget(self, action: #selector(nextStepHandle), for: .touchUpInside)
        }
        if index == 2 {
            viewFooter.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 80)
            let label = UILabel()
            viewFooter.addSubview(label)
            label.whc_Top(12).whc_Left(16).whc_WidthAuto().whc_Height(10)
            label.font = UIFont.systemFont(ofSize: 9)
            label.textColor = UIColor.mainColor()
            label.text = "温馨提示：请确认转账成功再点击提交。"
            
            let button = UIButton()
            viewFooter.addSubview(button)
            button.whc_Top(21, toView: label).whc_CenterX(0).whc_Height(30).whc_Width(200)
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            button.setTitle("确认提交", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.mainColor()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.addTarget(self, action: #selector(confirmToCommit), for: .touchUpInside)
        }
        return viewFooter
    }
    
    @objc private func confirmToCommit() {
        
    }
    
    @objc private func nextStepHandle() {
        
        mainTableView_Confirm.isHidden = false
        mainTableView_Confirm.frame = CGRect.init(x: 0, y: self.contentView.height, width: MainScreen.width, height: self.contentView.height)
        UIView.animate(withDuration: 0.5) {
            self.mainTableView_FillInTheForm.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            self.mainTableView_Confirm.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: self.contentView.height)
        }
    }
    
    private var selectedBankIndex: Int!
    
    private var transferType: (Int, String) {
        return (mainTableView_FillInTheForm.cellForRow(at: IndexPath.init(row: 3, section: 1)) as! BankCardTransferTypeCell).cellTransferType()
    }
}

extension BankCardTransferController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        if tableView == mainTableView_SelectBankCard {
            self.mainTableView_FillInTheForm.isHidden = false
            self.mainTableView_FillInTheForm.frame = CGRect.init(x: 0, y: self.contentView.height, width: MainScreen.width, height: self.contentView.height)
            selectedBankIndex = indexPath.row
            UIView.animate(withDuration: 0.5, animations: {
                self.mainTableView_SelectBankCard.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
                
                self.mainTableView_FillInTheForm.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: self.contentView.height)
            }) { (_ ) in
                
            }
        }
    }
}
extension BankCardTransferController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == mainTableView_FillInTheForm {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num_Row = 0
        if tableView == mainTableView_SelectBankCard {
            num_Row = 2
        }
        if tableView == mainTableView_FillInTheForm {
            num_Row = section == 0 ? 1 : 4
        }
        if tableView == mainTableView_Confirm {
            num_Row = 5
        }
        return num_Row
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == mainTableView_FillInTheForm {
            if section == 1 {
                return 5
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == mainTableView_FillInTheForm {
            if section == 1 {
                let view = UIView()
                view.backgroundColor = UIColor.ccolor(with: 224, g: 224, b: 224)
                return view
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            
            if tableView == mainTableView_SelectBankCard {
                cell = BankCardCell.init(style: .default, reuseIdentifier: "cell")
                (cell as! BankCardCell).setModel(model: bankCardModel[indexPath.row])
            }
            if tableView == mainTableView_FillInTheForm {
                if indexPath.section == 0 {
                    cell = BankCardCell.init(style: .default, reuseIdentifier: "cell")
                    (cell as! BankCardCell).setModel(model: bankCardModel[selectedBankIndex])
                }else {
                    cell = BankCardInputCell.init(style: .default, reuseIdentifier: "cell")
                    if indexPath.row == 3 {
                        cell = BankCardTransferTypeCell.init(style: .default, reuseIdentifier: "cell")
                        (cell as! BankCardTransferTypeCell).setTitleLabelText(value: kFillTableCellTitles[indexPath.row])
                    }else {
                        (cell as! BankCardInputCell).setPlaceHolder(text: kFillTableCellPlaceHolders[indexPath.row])
                        (cell as! BankCardInputCell).setTitleLabelText(value: kFillTableCellTitles[indexPath.row])
                    }
                }
            }
            if tableView == mainTableView_Confirm {
                if indexPath.row == 0 {
                    cell = BankCardTransferBalanceCell.init(style: .default, reuseIdentifier: "cell")
                }
                if indexPath.row == 1 {
                    cell = BankCardCell.init(style: .default, reuseIdentifier: "cell")
                    (cell as! BankCardCell).setModel(model: bankCardModel[selectedBankIndex])
                }
                if indexPath.row == 2 {
                    cell = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
                    (cell as! BankCardDisplayCell).setTitleLabelText(value: kFillTableCellTitles[0])
                    (cell as! BankCardDisplayCell).setContent(value: "123456789888")
                }
                if indexPath.row == 3 {
                    cell = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
                    (cell as! BankCardDisplayCell).setTitleLabelText(value: kFillTableCellTitles[2])
                    (cell as! BankCardDisplayCell).setContent(value: "六一")
                }
                if indexPath.row == 4 {
                    cell = BankCardDisplayCell.init(style: .default, reuseIdentifier: "cell")
                    (cell as! BankCardDisplayCell).setTitleLabelText(value: kFillTableCellTitles[3])
                    (cell as! BankCardDisplayCell).setContent(value: transferType.1)
                }
            }
        }
        return cell!
    }
}
