//
//  MemberPageController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/5.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

let offset_HeaderStop:CGFloat = 40.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 95.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label

class MemberPageController: BaseMainController ,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var gridview:UICollectionView!
    var headerView:MemberPageHeader?
    var datas:[MemberBean] = []
    var bgImageView = UIImageView()
    
    //MARK: - UI
    //MARK: 设置下拉时，headerView效果
    private func setupBGView() {
        bgImageView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 40)
        self.view.insertSubview(bgImageView, at: 0)
        updateHeaderBgLogo()
    }
    
    func updateHeaderBgLogo() -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        var logoImg = sys.content.member_page_bg_url
        if !isEmptyString(str: logoImg){
            //这里的logo地址有可能是相对地址
            print("the logo url = ",logoImg)
            if logoImg.contains("\t"){
                let strs = logoImg.components(separatedBy: "\t")
                if strs.count >= 2{
                    logoImg = strs[1]
                }
            }
            logoImg = logoImg.trimmingCharacters(in: .whitespaces)
            if !logoImg.hasPrefix("https://") && !logoImg.hasPrefix("http://"){
                logoImg = String.init(format: "%@/%@", BASE_URL,logoImg)
            }
            downloadImage(url: URL.init(string: logoImg)!, imageUI: self.bgImageView)
        }else{
            self.bgImageView.contentMode = .scaleAspectFill
            self.bgImageView.clipsToBounds = true
            self.bgImageView.theme_image = "General.personalHeaderBg"
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity

        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / bgImageView.bounds.height
            let headerSizevariation = ((bgImageView.bounds.height * (1.0 + headerScaleFactor)) - bgImageView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            bgImageView.layer.transform = headerTransform
        }else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
        }
    }
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        if glt_iphoneX {
            let themeView = UIView.init()
            self.view.addSubview(themeView)
            themeView.whc_Left(0).whc_Right(0).whc_Top(0).whc_Height(44)
            themeView.theme_backgroundColor = "Global.themeColor"
        }
        
        setupthemeBgView(view: self.view, alpha: 0)

        gridview.delegate = self
        gridview.dataSource = self
        gridview.register(MemberCell.self, forCellWithReuseIdentifier:"memberCell")
        gridview.showsVerticalScrollIndicator = false
        //添加头视图
        gridview.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if headerView != nil{
            headerView?.syncDatas()
            headerView?.setupButtonClick = {
                openSetting(controller: self)
            }
            
            headerView?.loginButtonClick = {
                super.loginAction()
            }
            
            headerView?.registerButtonClick = {
                super.registerAction()
            }
        }
        self.loadMemberDatas()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    func loadMemberDatas() -> Void {
        DispatchQueue.global().async {
            do{
                let path = Bundle.main.path(forResource: "member_data", ofType: "json")
                if let pathValue = path{
                    //2 获取json文件里面的内容,NSData格式
                    let jsonData = NSData.init(contentsOfFile: pathValue)
                    //3 解析json内容
                    let json = try JSONSerialization.jsonObject(with: jsonData! as Data, options:[]) as! [AnyObject]
                    self.datas.removeAll()
                    let dailiFilter:[String] = ["团队报表","团队总览","代理管理","推广链接","我的推荐","注册管理"]
                    for item in json{
                        let iconName = item["icon_name"] as! String
                        let txtName = item["txt_name"] as! String
                        let result = MemberBean()
                        result.iconName = iconName
                        result.txtName = txtName
                        
                        
                        //会员或试玩账号时，不显示
                        if YiboPreference.getAccountMode() == MEMBER_TYPE || YiboPreference.getAccountMode() == GUEST_TYPE{
                            if dailiFilter.contains(txtName){
                                continue
                            }
                        }
                        
                        if let sys = getSystemConfigFromJson() {
                            if sys.content != nil{
                                //额度转换开关没开时，不显示
                                if txtName == "额度转换" {
                                    let switch_money_change = sys.content.switch_money_change
                                    if isEmptyString(str: switch_money_change) || switch_money_change == "off"{
                                        continue
                                    }
                                }
                                
                                //额度转换开关没开时，不显示
                                if txtName == "积分兑换" {
                                    let switch_money_change = sys.content.exchange_score
                                    if isEmptyString(str: switch_money_change) || switch_money_change == "off"{
                                        continue
                                    }
                                }
                                
                                //我的推荐在动态赔率开关打开时，不显示
                                if txtName == "我的推荐" {
                                    let lottery_dynamic_odds = sys.content.lottery_dynamic_odds
                                    if !isEmptyString(str: lottery_dynamic_odds) && lottery_dynamic_odds == "on"{
                                        continue
                                    }
                                }
                                
                                if txtName == "推广链接" || txtName == "注册管理" {
                                    let lottery_dynamic_odds = sys.content.lottery_dynamic_odds
                                    if isEmptyString(str: lottery_dynamic_odds) || lottery_dynamic_odds == "off"{
                                        continue
                                    }
                                }
                                
                                if txtName == "真人注单" {
                                    let onoff_zhen_ren_yu_le = sys.content.onoff_zhen_ren_yu_le
                                    if isEmptyString(str: onoff_zhen_ren_yu_le) || onoff_zhen_ren_yu_le == "off"{
                                        continue
                                    }
                                }
                                
                                if txtName == "电子注单" {
                                    let onoff_dian_zi_you_yi = sys.content.onoff_dian_zi_you_yi
                                    if isEmptyString(str: onoff_dian_zi_you_yi) || onoff_dian_zi_you_yi == "off"{
                                        continue
                                    }
                                }
                            }
                        }
                        self.datas.append(result)
                    }
                    
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.gridview.reloadData()
            }
        }
        
    }
    
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //创建头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            //添加头部视图
            header.addSubview(self.addHeaderContent())
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: kScreenWidth, height: 264)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth - 2.5) / 3, height: 100)
    }
    
    func addHeaderContent() -> UIView {
        if headerView == nil{
            headerView = MemberPageHeader.init(icon: UIImage.init(named: "member_page_default_header"), account: "zhangsan", balance: 0,levelName:"",levelIcon:"",slideMenu: false, controller: self)
            if let view = headerView{
                view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 250)
                //同步头部的数据
                view.syncDatas()
            }
        }
        return headerView!
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memberCell", for: indexPath) as! MemberCell
        cell.tag = indexPath.row
        cell.setupData(data: self.datas[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.datas[indexPath.row]
        self.stackViewButtonsClickHandle(name: data.txtName)
    }
    
    //each item click method when response cell click
    @objc private func stackViewButtonsClickHandle(name: String) {
        switch name {
        case "真人注单":
            let vc = UIStoryboard(name: "betHistory_page", bundle: nil).instantiateViewController(withIdentifier: "betHistoryController")
            let page = vc as! BetHistoryController
            page.viewControllerType = 0
            self.navigationController?.pushViewController(page, animated: true)
        case "电子注单":
            let vc = UIStoryboard(name: "betHistory_page", bundle: nil).instantiateViewController(withIdentifier: "betHistoryController")
            let page = vc as! BetHistoryController
            page.viewControllerType = 1
            self.navigationController?.pushViewController(page, animated: true)
        case "额度转换":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            openConvertMoneyPage(controller: self)
            break
        case "积分兑换":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            let vc = UIStoryboard(name: "score_change_page", bundle: nil).instantiateViewController(withIdentifier: "scoreExchange")
            let page = vc as! ScoreExchangeController
            self.navigationController?.pushViewController(page, animated: true)
//            openScoreChange(controller: self)
            break
        case "购彩查询":
            let vc = GoucaiQueryController()
            vc.isAttachInTabBar = false
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "追号查询":
            self.navigationController?.pushViewController(ZuihaoQueryController(), animated: true)
            break
        case "个人报表":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                let username = YiboPreference.getUserName()
                if username.starts(with: "guest") || isEmptyString(str: username){
                    showToast(view: self.view, txt: "试玩账号不能进行此操作")
                    return
                }
            }
            self.navigationController?.pushViewController(GerenReportController(), animated: true)
            break
        case "团队报表":
            self.navigationController?.pushViewController(TeamReportsController(), animated: true)
            break
        case "账变报表":
            self.navigationController?.pushViewController(AccountChangeController(), animated: true)
            break
        case "充提记录":
            self.navigationController?.pushViewController(TopupAndWithdrawRecords(), animated: true)
            break
        case "优惠活动":
            let vc = UIStoryboard(name: "active_page",bundle:nil).instantiateViewController(withIdentifier: "activePage") as! ActiveController
            vc.isAttachInTabBar = false
            self.navigationController?.pushViewController(vc, animated: true)
        case "用户资料":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            self.navigationController?.pushViewController(UserInfoController(), animated: true)
            break
        case "银行卡":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            self.navigationController?.pushViewController(BankCardListController(), animated: true)
        case "个人总览":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            let vc = UIStoryboard(name: "geren_overview",bundle:nil).instantiateViewController(withIdentifier: "geren_overview") as! GerenTeamProfileController
            vc.fromTeam = false
            
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "密码修改":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            self.navigationController?.pushViewController(PasswordModifyController(), animated: true)
            break
        case "彩种信息":
            let vc = UIStoryboard(name: "lot_info_list",bundle:nil).instantiateViewController(withIdentifier: "lotInfo") as! LotInfoListController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "彩种限额":
            let vc = UIStoryboard(name: "lot_fee_limit_page",bundle:nil).instantiateViewController(withIdentifier: "lotInfo") as! LotFeeLimitController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "开奖结果":
            let vc = LotteryResultsController()
            vc.isAttachInTabBar = false
            vc.code = "CQSSC"
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "走势图":
            let vc = LotteryResultsController()
            vc.isAttachInTabBar = false
            vc.code = "CQSSC"
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "团队总览":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            let vc = UIStoryboard(name: "geren_overview",bundle:nil).instantiateViewController(withIdentifier: "geren_overview") as! GerenTeamProfileController
            vc.fromTeam = true
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "用户列表":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            let vc = UIStoryboard(name: "user_list_page",bundle:nil).instantiateViewController(withIdentifier: "userList") as! UserListViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "我的推荐":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            let vc = TueijianViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "注册管理":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            let vc = UIStoryboard(name: "register_manager_page",bundle:nil).instantiateViewController(withIdentifier: "register_manager") as! RegisterManagerContrller
            self.navigationController?.pushViewController(vc, animated: true)
//            self.navigationController?.pushViewController(RegistrationManagementController(), animated: true)
            break
        case "站内短信":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            self.navigationController?.pushViewController(InsideMessageController(), animated: true)
        case "网站公告":
            let vc = UIStoryboard(name: "notice_page",bundle:nil).instantiateViewController(withIdentifier: "notice_page") as! NoticesPageController
            self.navigationController?.pushViewController(vc, animated: true)
        case "帮助中心":
            let url = String.init(format: "%@%@%@", BASE_URL,PORT, HELP_CENTER_URL)
            openActiveDetail(controller: self, title: "帮助中心", content: "", foreighUrl: url)
            break;
        case "推广链接":
            if YiboPreference.getAccountMode() == GUEST_TYPE{
                showToast(view: self.view, txt: "试玩账号不能进行此操作")
                return
            }
            let vc = SpreadVC()
            self.navigationController?.pushViewController(vc, animated: true)
            break;
        default:
            break
        }
    }


}
