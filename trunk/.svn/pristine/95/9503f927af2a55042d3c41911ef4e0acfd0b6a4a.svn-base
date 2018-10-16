//
//  BankCardListController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/20.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class BankCardListController: LennyBasicViewController {

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        setViews()
        if !YiboPreference.getLoginStatus() {
            loginWhenSessionInvalid(controller: self)
        }
    }

    var fromWithDrawVC = false
    var model:BankCardListModel!
    private let mainTableView = UITableView()
    private func setViews() {
        
        self.title = "银行卡列表"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        setViewBackgroundColorTransparent(view: mainTableView)
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 60)
//        mainTableView.tableFooterView = UIView()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 56
        mainTableView.separatorStyle = .none
//        mainTableView.tableFooterView = tableViewFooter()
        
        if let footer = tableViewFooter(){
            self.view.addSubview(footer)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
    }
    
    override func loadNetRequestWithViewSkeleton(animate: Bool) {
        super.loadNetRequestWithViewSkeleton(animate: false)
        LennyNetworkRequest.obtainBankList(){
            (model) in
            if model?.code == 0 && !(model?.success)!{
                showToast(view: self.view, txt: "请先登录!")
                return
            }
            self.model = model
            self.view.hideSkeleton()
            self.refreshTableViewData()
        }
    }
    
    override func refreshTableViewData() {
        mainTableView.reloadData()
    }
    
    private func tableViewFooter() -> UIView? {
        let viewFooter = UIView()
        viewFooter.frame = CGRect.init(x: 0, y: kScreenHeight-60, width: MainScreen.width, height: 50)
        
        let button = UIButton()
        viewFooter.addSubview(button)
        button.whc_Top(0).whc_CenterX(0).whc_Height(50).whc_Width(kScreenWidth-20).whc_Bottom(0)
        button.theme_backgroundColor = "Global.themeColor"
        button.setTitle("+添加银行卡", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        //        button.layer.cornerRadius = 3
        //        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonAddHandle), for: .touchUpInside)
        return viewFooter
    }
    
    @objc private func buttonAddHandle() {
        
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let addCardSwitch = config.content.allow_muti_bankcards_switch
                
                if let model = self.model{
                    if let content = model.content{
                        if addCardSwitch != "on" && content.count > 0{
                            showToast(view: self.view, txt: "不允许绑定多张银行卡，详情请联系客服")
                            return
                        }
                    }
                }                
            }
        }
        let vc = UIStoryboard(name: "add_bank_card",bundle:nil).instantiateViewController(withIdentifier: "add_bank")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadNetRequestWithViewSkeleton(animate: true)
    }
}

extension BankCardListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !fromWithDrawVC {return}
        
        if let model = self.model{
            if let content = model.content{
                let model = content[indexPath.row]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getBankListModelNoti"), object: model)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension BankCardListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.model{
            if let content = model.content{
                return content.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = BankCardCell.init(style: .default, reuseIdentifier: "cell")
            if let model = self.model{
                if let content = model.content{
                    (cell as! BankCardCell).setModel(bankListModel:content[indexPath.row])
                }
            }
        }
        return cell!
    }
}
