//
//  LeftViewController.swift
//
//  Created by Johnson on 15/4/11.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

// person center View Controller

class MenuController: BaseMainController {
    
    
    @IBOutlet weak var headerBgImage: UIImageView!
    @IBOutlet weak var funcTable: UITableView!
    @IBOutlet weak var accountTV:UILabel!
    @IBOutlet weak var balanceTV:UILabel!
    @IBOutlet weak var refreshImg:UIImageView!
    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var chargebtn: UIButton!
    @IBOutlet weak var widthdrawbtn: UIButton!
    
    
    @IBOutlet weak var exitButton: UIButton!
    @IBAction func exitAction(_ sender: UIButton) {
        showConfirmExitDialog()
    }
    
    var unreadCount:Int = 0
    var useForSlideMenu = false
    var datas:[MenuData] = []
    var meminfo:Meminfo?
    lazy var openArray:NSMutableArray=NSMutableArray()//保存各分组的开闭状态，若数组中包含分组section，则说明该分组是展开的
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name(rawValue: ThemeUpdateNotification), object: nil)
        
        exitButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        chargebtn.imageView?.contentMode = .scaleAspectFit
        widthdrawbtn.imageView?.contentMode = .scaleAspectFit
        chargebtn.contentMode = .scaleAspectFit
        widthdrawbtn.contentMode = .scaleAspectFit
        chargebtn.theme_setImage("HomePage.homeDeposit", forState: .normal)
        widthdrawbtn.theme_setImage("HomePage.withdrawal", forState: .normal)
        
        headerBgImage.contentMode = .scaleAspectFill
        headerBgImage.clipsToBounds = true
        headerImg.layer.cornerRadius = 30.0
        headerImg.layer.masksToBounds = true
        funcTable.delegate = self
        funcTable.dataSource = self
        
        chargebtn.addTarget(self, action: #selector(onChargeBtn), for: .touchUpInside)
        widthdrawbtn.addTarget(self, action: #selector(onWithDrawBtn), for: .touchUpInside)
        
        let longPress = UITapGestureRecognizer(target: self, action: #selector(self.refreshClick))
        refreshImg.isUserInteractionEnabled = true
        refreshImg.addGestureRecognizer(longPress)
    }
    
    @objc func themeChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateAppLogo()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        accountWeb()
        self.datas.removeAll()
        prepareDatas()
        funcTable.reloadData()
        updateAppLogo()
    }
    
    @objc func onChargeBtn(){
        if YiboPreference.getAccountMode() == GUEST_TYPE{
            showToast(view: self.view, txt: "试玩账号不能进行此操作")
            return
        }
        actionChargeMoney(meminfo:self.meminfo)
    }
    
    @objc func onWithDrawBtn(){
        if YiboPreference.getAccountMode() == GUEST_TYPE{
            showToast(view: self.view, txt: "试玩账号不能进行此操作")
            return
        }
        actionPickMoney(meminfo:self.meminfo)
    }
    
    func actionChargeMoney(meminfo:Meminfo?){
        if self.navigationController != nil{
            openChargeMoney(controller: self,meminfo:meminfo)
        }else{
            let loginVC = UIStoryboard(name: "new_charge_money_page", bundle: nil).instantiateViewController(withIdentifier: "new_charge")
            let recordPage = loginVC as! NewChargeMoneyController
            recordPage.meminfo = meminfo
            self.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func actionPickMoney(meminfo:Meminfo?){
        if self.navigationController != nil{
            openPickMoney(controller: self,meminfo:meminfo)
        }else{
            let loginVC = UIStoryboard(name: "withdraw_page", bundle: nil).instantiateViewController(withIdentifier: "withDraw")
            let recordPage = loginVC as! WithdrawController
            recordPage.meminfo = meminfo
            self.navigationController?.pushViewController(recordPage, animated: true)
            let nav = UINavigationController.init(rootViewController: recordPage)
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    @objc func refreshClick(){
        accountWeb()
    }
    
    func updateAppLogo() -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        var logoImg = sys.content.member_page_logo_url
        var logoBgImg = sys.content.member_page_bg_url
        
        let themeBgName = YiboPreference.getCurrentThmeByName()
        var bgImageName = ""
        var headerNmae = ""
        if themeBgName == "Red" {
            bgImageName = "personalHeaderBg_red"
            headerNmae = "placeHeader_red"
        }else if themeBgName == "Blue" {
            bgImageName = "personalHeaderBg_blue"
            headerNmae = "placeHeader_blue"
        }else if themeBgName == "Green" {
            bgImageName = "personalHeaderBg_green"
            headerNmae = "placeHeader_green"
        }else if themeBgName == "FrostedOrange" {
            bgImageName = "personalHeaderBg_glassOrange"
            headerNmae = "placeHeader_glassOrange"
        }

        if !isEmptyString(str: logoImg){
            //这里的logo地址有可能是相对地址
            logoImg = handleImageURL(urlString: logoImg)
            let imageURL = URL(string: logoImg)
            headerImg?.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: headerNmae), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            self.headerImg.theme_image = "General.placeHeader"
        }
        
        if !isEmptyString(str: logoBgImg) {
            logoBgImg = handleImageURL(urlString: logoBgImg)
            let logoBgImgURL = URL(string: logoBgImg)
            
            headerBgImage.kf.setImage(with: ImageResource(downloadURL: logoBgImgURL!), placeholder: UIImage.init(named: bgImageName), options: nil, progressBlock: nil, completionHandler: nil)
        }else {
            self.headerBgImage.theme_image = "General.personalHeaderBg"
        }
    }
    
    func accountWeb() -> Void {
        //帐户相关信息
        request(frontDialog: false, url:MEMINFO_URL,
                           callback: {(resultJson:String,resultStatus:Bool)->Void in
                            if !resultStatus {
                                return
                            }
                            if let result = MemInfoWraper.deserialize(from: resultJson){
                                if result.success{
                                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                                    if let memInfo = result.content{
                                        //更新帐户名，余额等信息
                                        self.meminfo = memInfo
                                        self.updateAccount(memInfo:memInfo);
                                    }
                                }
                            }
        })
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var accountNameStr = ""
        if !isEmptyString(str: memInfo.account){
            accountNameStr = memInfo.account
        }else{
            accountNameStr = "暂无名称"
        }
        accountTV.text = accountNameStr
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = "\(memInfo.balance)"
        }else{
            leftMoneyName = "0"
        }
        balanceTV.text = String.init(format: "余额:%@元",  leftMoneyName)
    }
    
    
    private func gettzjrSubDatas() -> [MenuData]{
        
        var list = [MenuData]()
        
        let m1 = MenuData()
        m1.img = "icon_blue_point"
        m1.txt = "购彩查询"
        list.append(m1)
        
        let m2 = MenuData()
        m2.img = "icon_blue_point"
        m2.txt = "追号查询"
        list.append(m2)
        
        let m5 = MenuData()
        m5.img = "icon_blue_point"
        m5.txt = "体育注单"
        list.append(m5)
        
        if let sys = getSystemConfigFromJson() {
            if sys.content != nil{
                //真人注单
                let realSwitch = sys.content.onoff_zhen_ren_yu_le
                if realSwitch == "on"{
                    let m10 = MenuData()
                    m10.img = "icon_blue_point"
                    m10.txt = "真人注单"
                    list.append(m10)
                }
                //电子注单
                let gameSwitch = sys.content.onoff_dian_zi_you_yi
                if gameSwitch == "on"{
                    let m11 = MenuData()
                    m11.img = "icon_blue_point"
                    m11.txt = "电子注单"
                    list.append(m11)
                }
            }
        }
        return list
    }
    
    private func getbbglSubDatas() -> [MenuData]{
        
        var list = [MenuData]()
        
        let m1 = MenuData()
        m1.img = "icon_blue_point"
        m1.txt = "充提记录"
        list.append(m1)
        
        let m2 = MenuData()
        m2.img = "icon_blue_point"
        m2.txt = "个人报表"
        list.append(m2)
        
        if !needDailiFilterItem(txtName: "团队报表"){
            let m3 = MenuData()
            m3.img = "icon_blue_point"
            m3.txt = "团队报表"
            list.append(m3)
        }
        
        let m4 = MenuData()
        m4.img = "icon_blue_point"
        m4.txt = "账变报表"
        list.append(m4)
        
        return list
    }
    
    private func getzhglSubDatas() -> [MenuData]{
        
        let m1 = MenuData()
        m1.img = "icon_blue_point"
        m1.txt = "个人总览"
        
        let m2 = MenuData()
        m2.img = "icon_blue_point"
        m2.txt = "密码修改"
        
        let m3 = MenuData()
        m3.img = "icon_blue_point"
        m3.txt = "银行卡"
        
        let m4 = MenuData()
        m4.img = "icon_blue_point"
        m4.txt = "资料修改"
        
        let m5 = MenuData()
        m5.img = "icon_blue_point"
        m5.txt = "彩种信息"
        
        var list = [MenuData]()
        list.append(m1)
        list.append(m2)
        list.append(m3)
        list.append(m4)
        list.append(m5)
        return list
    }
    
    private func getdlglSubDatas() -> [MenuData]{
        
        let m1 = MenuData()
        m1.img = "icon_blue_point"
        m1.txt = "团队总览"
        
        let m2 = MenuData()
        m2.img = "icon_blue_point"
        m2.txt = "用户列表"
        
        let m3 = MenuData()
        m3.img = "icon_blue_point"
        m3.txt = "注册管理"
        
        var list = [MenuData]()
        list.append(m1)
        list.append(m2)
        list.append(m3)
        return list
    }
    
    private func getdxglSubDatas() -> [MenuData]{
        
        let m1 = MenuData()
        m1.img = "icon_blue_point"
        m1.txt = "站内短信"
        
        let m2 = MenuData()
        m2.img = "icon_blue_point"
        m2.txt = "网站公告"
        
        var list = [MenuData]()
        list.append(m1)
        list.append(m2)
        return list
    }
    
    
    
    func prepareDatas(){
        let m1 = MenuData()
        m1.img = "Menucontroller.czjr"
        m1.txt = "投注记录"
        m1.subDatas = gettzjrSubDatas()
        datas.append(m1)
        
        let m2 = MenuData()
        m2.img = "Menucontroller.bbgl"
        m2.txt = "报表管理"
        m2.subDatas = getbbglSubDatas()
        datas.append(m2)
        
        let m3 = MenuData()
        m3.img = "Menucontroller.zhgl"
        m3.txt = "帐户管理"
        m3.subDatas = getzhglSubDatas()
        datas.append(m3)
        
        if !needDailiFilterItem(txtName: "代理管理"){
            let m4 = MenuData()
            m4.img = "Menucontroller.dlgl"
            m4.txt = "代理管理"
            m4.subDatas = getdlglSubDatas()
            datas.append(m4)
        }
        
        let m5 = MenuData()
        m5.img = "Menucontroller.dxgl"
        m5.txt = "短信管理"
        m5.subDatas = getdxglSubDatas()
        datas.append(m5)
        
        
//        let m6 = MenuData()
//        m6.img = "Menucontroller.tcdl"
//        m6.txt = "退出登录"
//        m6.subDatas = []
//        datas.append(m6)
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
        }
    }
    
    
    func onLeftEvent(tag: Int) {
        print("receive left menu event --------")
//        adjustLeftMenusBySystemConfig()
//        perforWhenCreate()
    }
    
    func postExitLogin() -> Void {
        request(frontDialog: true, loadTextStr:"退出登录中...",url:LOGIN_OUT_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "退出失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LoginOutWrapper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            YiboPreference.saveLoginStatus(value: false as AnyObject)
                            if self.navigationController != nil{
                                loginWhenSessionInvalid(controller: self)
                            }else{
                                let loginVC = UIStoryboard(name: "login", bundle: nil).instantiateViewController(withIdentifier: "login_page")
                                let loginPage = loginVC as! LoginController
                                loginPage.openFromOtherPage = true
//                                let nav = UINavigationController.init(rootViewController: loginPage)
                                self.present(loginPage, animated: true, completion: nil)
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "退出失败,请重试"))
                            }
                        }
                    }
        })
    }
    
}

extension MenuController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let data = self.datas[indexPath.section].subDatas[indexPath.row]
            if data.txt == "购彩查询"{
                let vc = GoucaiQueryController()
                vc.isAttachInTabBar = false
                let nav = MainNavController.init(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "追号查询"{
                let nav = MainNavController.init(rootViewController: ZuihaoQueryController())
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "真人注单"{
                let vc = UIStoryboard(name: "betHistory_page", bundle: nil).instantiateViewController(withIdentifier: "betHistoryController")
                let page = vc as! BetHistoryController
                page.viewControllerType = 0
                let nav = MainNavController.init(rootViewController: page)
                self.present(nav, animated: true, completion: nil)
                
//                let loginVC = UIStoryboard(name: "touzhu_record", bundle: nil).instantiateViewController(withIdentifier: "touzhuRecord")
//                let recordPage = loginVC as! TouzhuRecordController
//                recordPage.titleStr = "真人记录"
//                recordPage.recordType = MenuType.REAL_MAN_RECORD
//                let nav = MainNavController.init(rootViewController: recordPage)
//                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "电子注单"{
                
                let vc = UIStoryboard(name: "betHistory_page", bundle: nil).instantiateViewController(withIdentifier: "betHistoryController")
                let page = vc as! BetHistoryController
                page.viewControllerType = 1
                let nav = MainNavController.init(rootViewController: page)
                self.present(nav, animated: true, completion: nil)
//
//
//                let dianziVC = UIStoryboard(name: "touzhu_record", bundle: nil).instantiateViewController(withIdentifier: "touzhuRecord")
//                let recordPage = dianziVC as! TouzhuRecordController
//                recordPage.titleStr = "电子记录"
//                recordPage.recordType = MenuType.GAME_RECORD
//                let nav = MainNavController.init(rootViewController: recordPage)
//                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "体育注单"{
                let loginVC = UIStoryboard(name: "touzhu_record", bundle: nil).instantiateViewController(withIdentifier: "touzhuRecord")
                let recordPage = loginVC as! TouzhuRecordController
                recordPage.titleStr = "体育注单"
                recordPage.recordType = MenuType.SPORT_RECORD
                let nav = MainNavController.init(rootViewController: recordPage)
                self.present(nav, animated: true, completion: nil)
            }
        }else if indexPath.section == 1{
            let data = self.datas[indexPath.section].subDatas[indexPath.row]
            if data.txt == "充提记录"{
                let nav = MainNavController.init(rootViewController: TopupAndWithdrawRecords())
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "个人报表"{
                let nav = MainNavController.init(rootViewController: GerenReportController())
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "团队报表"{
                let nav = MainNavController.init(rootViewController: TeamReportsController())
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "账变报表"{
                let nav = MainNavController.init(rootViewController: AccountChangeController())
                self.present(nav, animated: true, completion: nil)
            }
//            else if data.txt == "优惠活动"{
//                let vc = UIStoryboard(name: "active_page",bundle:nil).instantiateViewController(withIdentifier: "activePage")
//                let nav = MainNavController.init(rootViewController: vc)
//                self.present(nav, animated: true, completion: nil)
//            }
        }else if indexPath.section == 2{
            let data = self.datas[indexPath.section].subDatas[indexPath.row]
            if data.txt == "个人总览"{
                let vc = UIStoryboard(name: "geren_overview",bundle:nil).instantiateViewController(withIdentifier: "geren_overview") as! GerenTeamProfileController
                vc.fromTeam = false
                let nav = MainNavController.init(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "密码修改"{
                let nav = MainNavController.init(rootViewController: PasswordModifyController())
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "银行卡"{
                let nav = MainNavController.init(rootViewController: BankCardListController())
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "资料修改"{
                let nav = MainNavController.init(rootViewController: UserInfoController())
                self.present(nav, animated: true, completion: nil)
            }else if data.txt == "彩种信息"{
                let vc = UIStoryboard(name: "lot_info_list",bundle:nil).instantiateViewController(withIdentifier: "lotInfo") as! LotInfoListController
                let nav = MainNavController.init(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            }
        }else{
            if YiboPreference.getAccountMode() == MEMBER_TYPE || YiboPreference.getAccountMode() == GUEST_TYPE{
                if indexPath.section == 3{
                    let data = self.datas[indexPath.section].subDatas[indexPath.row]
                    if data.txt == "站内短信"{
                        let nav = MainNavController.init(rootViewController: InsideMessageController())
                        self.present(nav, animated: true, completion: nil)
                    }else if data.txt == "网站公告"{
                        let vc = UIStoryboard(name: "notice_page",bundle:nil).instantiateViewController(withIdentifier: "notice_page") as! NoticesPageController
                        let nav = MainNavController.init(rootViewController: vc)
                        self.present(nav, animated: true, completion: nil)
                    }
                }else if indexPath.section == 4{
                    
                }
            }else{
                if indexPath.section == 3{
                    let data = self.datas[indexPath.section].subDatas[indexPath.row]
                    if data.txt == "团队总览"{
                        let vc = UIStoryboard(name: "geren_overview",bundle:nil).instantiateViewController(withIdentifier: "geren_overview") as! GerenTeamProfileController
                        vc.fromTeam = true
                        let nav = MainNavController.init(rootViewController: vc)
                        self.present(nav, animated: true, completion: nil)
                    }else if data.txt == "用户列表"{
                        let vc = UIStoryboard(name: "user_list_page",bundle:nil).instantiateViewController(withIdentifier: "userList") as! UserListViewController
                        let nav = MainNavController.init(rootViewController: vc)
                        self.present(nav, animated: true, completion: nil)
                    }else if data.txt == "注册管理"{
//                        let nav = MainNavController.init(rootViewController: RegistrationManagementController())
//                        self.present(nav, animated: true, completion: nil)
                        
                        let vc = UIStoryboard(name: "register_manager_page",bundle:nil).instantiateViewController(withIdentifier: "register_manager") as! RegisterManagerContrller
                        let nav = MainNavController.init(rootViewController:vc)
                        self.present(nav, animated: true, completion: nil)
                    }
                }else if indexPath.section == 4{
                    let data = self.datas[indexPath.section].subDatas[indexPath.row]
                    if data.txt == "站内短信"{
                        let nav = MainNavController.init(rootViewController: InsideMessageController())
                        self.present(nav, animated: true, completion: nil)
                    }else if data.txt == "网站公告"{
                        let vc = UIStoryboard(name: "notice_page",bundle:nil).instantiateViewController(withIdentifier: "notice_page") as! NoticesPageController
                        let nav = MainNavController.init(rootViewController: vc)
                        self.present(nav, animated: true, completion: nil)
                    }
                }else if indexPath.section == 5{
                    
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //如果数组中包含当前的section则返回数据源中当前section的数组大小，否则返回零
        if(self.openArray.contains(section)){
            return self.datas[section].subDatas.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as! LeftTableCell
        cell.backgroundColor = UIColor.init(hex: 0xE7E7E7)
        cell.name.font = UIFont.systemFont(ofSize: 12)
        let data = self.datas[indexPath.section].subDatas[indexPath.row]
        cell.setupData(data:data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //绑定表格头部行
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MenuLineHeader.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 41))
        header.setupSection(section: section)//绑定section,方便标识子项的开闭状态
        header.headerDelegate = self
        let data:MenuData = self.datas[section]
//        header.imgTV.image = UIImage.init(named: data.img)
        header.imgTV.theme_image = ThemeImagePicker.init(keyPath: data.img)
        header.labelTV.text = data.txt
        let isExpand = self.openArray.contains(section)
        header.updateIndictor(expand: isExpand)
        return header
    }

}

extension MenuController:MenuLineHeaderDelegate{
    func onHeaderClick(section: Int) {
//        if section == self.datas.count - 1{
//            self.showConfirmExitDialog()
//            return
//        }
        //判断是否是张开或合住
        if(self.openArray.contains(section)) {
            self.openArray.remove(section)
        }else {
            self.openArray.add(section)
        }
        self.funcTable.reloadSections(IndexSet.init(integer: section), with: UITableViewRowAnimation.fade)
    }
    
    func showConfirmExitDialog() -> Void {
        let message = "确定要退出吗？"
        let alertController = UIAlertController(title: "温馨提示",
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.postExitLogin()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
