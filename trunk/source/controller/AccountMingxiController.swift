//
//  AccountMingxiController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class AccountMingxiController: BaseController,UITableViewDelegate,UITableViewDataSource,MingxiBarDelegate {
    
    @IBOutlet weak var menuBar:AccountMingxiMenuBar!
    @IBOutlet weak var menuLine:UIView!
    @IBOutlet weak var menuLineConstraint:NSLayoutConstraint!
    @IBOutlet weak var tableView:UITableView!
    
    var pageIndex = 0//当前是充值记录页还是取款记录页
    var datas:[MoneyRecordResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.menuBar.delegate = self
        
        self.navigationItem.title = "帐户明细"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        self.updateMenuBottomLine(tabIndex: pageIndex)
        loadDatas()
    }
    
    func loadDatas() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "获取中...",url:CHARGE_DRAW_RECORD_URL,
                params: ["queryType":pageIndex == 0 ? "recharge" : "withdraw"],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if !isEmptyString(str: resultJson){
                            showToast(view: self.view, txt: resultJson)
                        }else{
                            showToast(view: self.view, txt: "获取失败")
                        }
                        return
                    }
                    if let result = MoneyChargeDrawRecordWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let content = result.content{
                                self.updateData(data:content)
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func updateData(data:[MoneyRecordResult]) -> Void {
            self.datas.removeAll()
            self.datas = self.datas + data
            self.tableView.reloadData()
    }
    
    func convertMoneyRecordStatus(status:Int) -> String {
        if (status == STATUS_UNTREATED) {
            return "处理中";
        } else if (status == STATUS_SUCCESS) {
            return "处理成功";
        } else if (status == STATUS_FAILED) {
            return "处理失败";
        } else if (status == STATUS_CANCELED) {
            return "已取消";
        } else if (status == STATUS_EXPIRED) {
            return "已过期";
        }
        return "处理中";
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mingxiCell") as? AccountMingxiCell  else {
            fatalError("The dequeued cell is not an instance of mingxiCell.")
        }
        let data = self.datas[indexPath.row]
        cell.payNameUI.text = String.init(format: "充值方式:%@", !isEmptyString(str: data.title) ? data.title : "无")
        cell.payStatusUI.text = convertMoneyRecordStatus(status: data.status)
        cell.moneyUI.text = String.init(format: "充值金额: %.2f元", data.money)
        let timeStr = String.init(format: "%@ %@", data.betdate,data.bettime)
        cell.dataUI.text = timeStr
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    //点击分栏菜单的回调事件
    func onMenuItemClick(itemTag: Int) {
        self.pageIndex = itemTag
        self.updateMenuBottomLine(tabIndex: itemTag)
        loadDatas()
    }
    
    func updateMenuBottomLine(tabIndex:Int) -> Void {
        self.menuLineConstraint.constant = CGFloat(tabIndex) * kScreenWidth/2
    }
}
