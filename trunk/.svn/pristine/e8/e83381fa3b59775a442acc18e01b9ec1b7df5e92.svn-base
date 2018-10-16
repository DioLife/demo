//
//  TopupOnlineController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

private let paymentType = ["微信支付", "银行卡转账支付", "支付宝支付", "在线支付"]
private let paymentImages = ["topup_weixinzhifu", "topup_yinhangkazhifu", "topup_zhifubaozhifu", "topup_zaixianzhifu"]
private let paymentDetails = ["微信支付", "快捷支付", "快捷支付", "快捷支付"]

class TopupOnlineController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    private let mainTableView = UITableView()
    private let label_AccountName = UILabel()
    private let label_Balance = UILabel()
    private let imageView_Avator = UIImageView()
    private func setViews() {
        
        self.title = "在线充值"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.tableHeaderView = tableViewHeader()
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = .none
    }
    
    private func tableViewHeader() -> UIView {
        
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 183))
        
        let imageView = UIImageView()
        headerView.addSubview(imageView)
        imageView.whc_Top(0).whc_Left(0).whc_Right(0).whc_Height(150)
        imageView.image = UIImage(named: "center_header2")
        
        imageView.addSubview(imageView_Avator)
        imageView_Avator.whc_CenterX(0).whc_CenterY(-20).whc_Width(70).whc_Height(70)
        imageView_Avator.layer.cornerRadius = 35
        imageView_Avator.clipsToBounds = true
        imageView_Avator.image = UIImage(named: "center_avatorcai")
        
        imageView.addSubview(label_AccountName)
        label_AccountName.whc_CenterX(0).whc_CenterY(30).whc_WidthAuto().whc_Height(10)
        label_AccountName.font = UIFont.systemFont(ofSize: 12)
        label_AccountName.textColor = UIColor.ccolor(with: 254, g: 254, b: 254)
        label_AccountName.textAlignment = .center
        label_AccountName.text = "13524561324"
        
        let label_BalanceTitle = UILabel()
        imageView.addSubview(label_BalanceTitle)
        label_BalanceTitle.whc_Top(14, toView: label_AccountName).whc_CenterX(-50, toView: label_AccountName).whc_WidthAuto().whc_Height(13)
        label_BalanceTitle.font = UIFont.systemFont(ofSize: 13)
        label_BalanceTitle.textColor = UIColor.ccolor(with: 254, g: 254, b: 254)
        label_BalanceTitle.textAlignment = .center
        label_BalanceTitle.text = "我的余额："
        
        imageView.addSubview(label_Balance)
        label_Balance.whc_TopEqual(label_BalanceTitle).whc_CenterX(20, toView: label_AccountName).whc_WidthAuto().whc_Height(15)
        label_Balance.font = UIFont.systemFont(ofSize: 18)
        label_Balance.textColor = UIColor.ccolor(with: 254, g: 254, b: 254)
        label_Balance.textAlignment = .center
        label_Balance.text = "5000.00"
        
        let view = UIView()
        headerView.addSubview(view)
        view.whc_Top(13, toView: imageView).whc_Left(17).whc_Width(8).whc_Height(8)
        view.backgroundColor = UIColor.mainColor()
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        
        let label = UILabel()
        headerView.addSubview(label)
        label.whc_CenterYEqual(view).whc_Left(37).whc_WidthAuto().whc_Height(13)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label.text = "支付方式"
        headerView.whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
        return headerView
    }
}

extension TopupOnlineController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(WechatTransferController(), animated: true)
        }
        if indexPath.row == 1 {
            self.navigationController?.pushViewController(BankCardTransferController(), animated: true)
        }
        if indexPath.row == 2 {
            self.navigationController?.pushViewController(AliPayTransferController(), animated: true)
        }
    }
}
extension TopupOnlineController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
            cell?.accessoryType = .disclosureIndicator
            cell?.imageView?.image = UIImage(named: paymentImages[indexPath.row])
            cell?.textLabel?.text = paymentType[indexPath.row]
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell?.textLabel?.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
            cell?.detailTextLabel?.text = paymentDetails[indexPath.row]
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 9)
            cell?.detailTextLabel?.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
            cell?.whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.ccolor(with: 224, g: 224, b: 224)
        return view
    }
}


