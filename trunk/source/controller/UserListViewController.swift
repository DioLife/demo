//
//  UserListViewController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import MJRefresh
//用户列表

class UserListViewController: BaseController {
    
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var content:UITableView!
    @IBOutlet weak var titleViewTopConstraint: NSLayoutConstraint!
    
    var datas:[UserListSmallBean] = []
    var filterUsername = ""
    var filterMinBalance = ""
    var filterMaBalance = ""
    var filterStartTime = ""
    var filterEndTime = ""
    var pageNumber = 1
    var pageSize = 60
    lazy var filterView = UserlistFilterView.init()
    
    var dataRows = [UserListSmallBean]()
    
    let refreshHeader = MJRefreshNormalHeader()
    let refreshFooter = MJRefreshBackNormalFooter()
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        setupNoPictureAlphaBgView(view: self.titleView,alpha: 0.4,bgViewColor: "FrostedGlass.subColorImageCoverDarkColorForNotGlass")
        
        self.title = "用户列表"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        content.delegate = self
        content.dataSource = self
        content.tableFooterView = UIView()
        setupRefreshView()
        self.loadAllDatas(isLoadMoreData: false)
    }
    
    private func setupRightNavBarItem() {
        let button = UIButton(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        
        button.setTitle("筛选", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
        button.theme_setTitleColor("Global.barTextColor", forState: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            button.isSelected = true
            self.view.addSubview(filterView)
            self.filterView.frame = CGRect.init(x: 0, y: glt_iphoneX ? -60 + 60 + 24 : -60 + 64, width: screenWidth, height: 60)
            
            UIView.animate(withDuration: 0.3) {
                self.titleViewTopConstraint.constant = 60
                self.filterView.alpha = 1.0
                self.filterView.frame = CGRect.init(x: 0, y: glt_iphoneX ? 88 : 64, width: screenWidth, height: 60)
            }
            
            self.filterView.didClickShowAllLevelBtn = {(showAllLevel: Bool) -> Void in
                self.loadAllDatas(isLoadMoreData: false, include: showAllLevel)
            }
        }else {
            button.isSelected = false
            UIView.animate(withDuration: 0.3, animations: {
                self.titleViewTopConstraint.constant = 0
                self.filterView.alpha = 0.2
                self.filterView.frame = CGRect.init(x: 0, y: glt_iphoneX ? -60 + 60 + 24 : -60 + 64, width: screenWidth, height: 60)
            }) { (_) in
                self.filterView.removeFromSuperview()
            }
        }
    }

}

extension UserListViewController {
    
    func loadAllDatas(isLoadMoreData: Bool,showDialog:Bool = true,include: Bool = false,pageSize: Int = defaultCountOfRequestPagesize) -> Void {
        
        var pageNumber = 1
        if isLoadMoreData {
            if self.dataRows.count % pageSize == 0 {
                pageNumber = self.dataRows.count / pageSize + 1
            }else {
                noMoreDataStatusRefresh()
                return
            }
        }
        
        let params = ["include":include,"username":self.filterUsername,"minBalance":self.filterMinBalance,"maxBalance":self.filterMaBalance,
                      "start":self.filterStartTime,"end":self.filterEndTime,"pageNumber":pageNumber,"pageSize":pageSize] as [String : Any]
        
        request(frontDialog: showDialog, method:.get, loadTextStr:"获取中...", url:API_USERLISTDATA,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    self.endRefresh()
                    
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = UserListBeanWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if result.content != nil{
                                self.datas = (result.content?.rows)!
                                
                                guard let contentP = result.content else {return}
                                guard let rowsP = contentP.rows else {return}
                                if !isLoadMoreData {
                                    self.dataRows.removeAll()
                                }
                                self.dataRows += rowsP
                                self.noMoreDataStatusRefresh(noMoreData: rowsP.count % pageSize != 0 || rowsP.count == 0)
                                self.content.reloadData()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                self.print_error_msg(msg: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
                    
        })
    }
    
    //MARK: - 刷新
    private func setupRefreshView() {
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.content.mj_header = refreshHeader
        self.content.mj_footer = refreshFooter
    }
    
    @objc fileprivate func headerRefresh() {
        self.loadAllDatas(isLoadMoreData: false)
    }
    
    @objc fileprivate func footerRefresh() {
        self.loadAllDatas(isLoadMoreData: true)
    }
    
    private func endRefresh() {
        self.content.mj_header.endRefreshing()
        self.content.mj_footer.endRefreshing()
    }
    
    private func noMoreDataStatusRefresh(noMoreData: Bool = true) {
        if noMoreData {
            self.content.mj_footer.endRefreshingWithNoMoreData()
        }else {
            self.content.mj_footer.resetNoMoreData()
        }
    }
    
}

extension UserListViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.datas.count
        return self.dataRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userListCell") as? UserListCell  else {
            fatalError("The dequeued cell is not an instance of UserListCell.")
        }
        cell.selectionStyle = .none
//        cell.setModel(model: self.datas[indexPath.row])
        cell.setModel(model: self.dataRows[indexPath.row])
        cell.teamOverviewBtn.tag = indexPath.row
        cell.accountChangeBtn.tag = indexPath.row
        cell.teamOverviewBtn.addTarget(self, action: #selector(clickTeamBtn(ui:)), for: .touchUpInside)
        cell.accountChangeBtn.addTarget(self, action: #selector(clickAccountCBtn(ui:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemClick(datasoure: self.formSource(row: indexPath.row))
    }
    
    private func formSource(row:Int) -> [String]{
//        let content = self.datas[row]
        let content = self.dataRows[row]
        var sources = [String]()
        let t1 = String.init(format: "用户名称: %@", content.username!)
        let t2 = String.init(format: "余额: %@", String.init(format: "%d元", content.money))
        let t3 = String.init(format: "返点级别: %@", String.init(format: "%.2f", content.kickback))
        let t4 = String.init(format: "用户等级: %@", getUserType(t: content.type))
        let t5 = String.init(format: "注册时间: %@", content.createDatetime)
        let t6 = String.init(format: "最后登录时间: %@", content.lastLoginDatetime)
        sources.append(t1)
        sources.append(t2)
        sources.append(t3)
        sources.append(t4)
        sources.append(t5)
        sources.append(t6)
        return sources
    }
    
    @objc func onItemClick(datasoure:[String]){
        if datasoure.isEmpty{
            return
        }
        let dialog = DetailListDialog(dataSource: datasoure, viewTitle: "用户详情")
        dialog.selectedIndex = 0
        //        randomView.didSelected = {
        //        }
        self.view.window?.addSubview(dialog)
        dialog.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(dialog.kHeight)
        dialog.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            dialog.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc func clickTeamBtn(ui:UIButton){
        let vc = UIStoryboard(name: "geren_overview",bundle:nil).instantiateViewController(withIdentifier: "geren_overview") as! GerenTeamProfileController
        vc.fromTeam = true
        let data = self.datas[ui.tag]
        vc.accountId = data.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickAccountCBtn(ui:UIButton){
        let data = self.datas[ui.tag]
        let vc = AccountChangeController()
        vc.filterUserName = data.username!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
