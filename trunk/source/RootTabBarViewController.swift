//
//  RootTabBarViewController.swift
//  unionMerchant
//
//  Created by simpsons on 2017/8/16.
//  Copyright © 2017年 simpsons. All rights reserved.
//

import UIKit


/**
 *  屏幕高度
 */
private let MHEIGHT = UIScreen.main.bounds.size.height

/**
 *  tabbar背景色
 */
private let ColorTabBar = UIColor.white

/**
 *  title默认颜色
 */
private let ColorTitle = UIColor.gray

/**
 *  title字体大小
 */
private let titleFontSize : CGFloat = 12.0

/**
 *  button 图片与文字上下占比
 */
private let scale:CGFloat = 0.55


extension RootTabBarViewController{
    
    public func showControllerIndex(_ index: Int) {

        if index < 2 {
            self.seleBtn!.isSelected = false
            let button = (cusTabbar.viewWithTag(1000+index) as? UIButton)!
            button.isSelected = true
            self.seleBtn = button
            print("点击的tabbar index： \(index)")
            self.selectedIndex = index
        }else if index == 2 {

        }else {
            if index == 4 && !YiboPreference.getLoginStatus(){
                loginWhenSessionInvalid(controller: self)
            }else {
                self.seleBtn!.isSelected = false
                let button = (cusTabbar.viewWithTag(1000+index) as? UIButton)!
                button.isSelected = true
                self.seleBtn = button
                print("点击的tabbar index： \(index)")
                self.selectedIndex = index - 1
            }
        }
        
    }
}

//MARK: - TabBarButton
class XHTabBarButton:UIButton {
    
    override var isHighlighted: Bool{
        
        didSet{
            super.isHighlighted = false
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let newX:CGFloat = 0.0
        let newY:CGFloat = 5.0
        let newWidth:CGFloat = CGFloat(contentRect.size.width)
        let newHeight:CGFloat = CGFloat(contentRect.size.height)*scale-newY
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let newX: CGFloat = 0
        let newY: CGFloat = contentRect.size.height*scale
        let newWidth: CGFloat = contentRect.size.width
        let newHeight: CGFloat = contentRect.size.height-contentRect.size.height*scale
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
}

//MARK: - TabBarController
class RootTabBarViewController:MainTabBarController,SnailFullViewDelegate,RootTabBarDelegate {
    
    private var isSelect = false
    
    func addClick() {
        self.popupWindow()
    }
    
    func popupWindow() {
        var array:[String] = []
        if let sys = getSystemConfigFromJson()  {
            if !isEmptyString(str: sys.content.onoff_turnlate) && sys.content.onoff_turnlate == "on"{
                array.append("大转盘")
            }
            if !isEmptyString(str: sys.content.onoff_member_mobile_red_packet) && sys.content.onoff_member_mobile_red_packet == "on"{
                array.append("抢红包")
            }
            if !isEmptyString(str: sys.content.exchange_score) && sys.content.exchange_score == "on"{
                array.append("积分兑换")
            }
            if !isEmptyString(str: sys.content.switch_back_computer) && sys.content.switch_back_computer == "on"{
                array.append("返回电脑版")
            }
            
            if !isEmptyString(str: sys.content.switch_back_wap) && sys.content.switch_back_wap == "on"{
                array.append("返回wap版")
            }
            
            if !isEmptyString(str: sys.content.switch_sign_in) && sys.content.switch_sign_in == "on"{
                array.append("签到")
            }
            
        }
        array.append("优惠活动")
        array.append("站内信")
        array.append("主题切换")
        
        
        
        var items: [BannerItem] = []
        for (_, name) in array.enumerated(){
            let item = BannerItem()
            item.title = name
    
            item.image = "PopView." + "popup_\(name)"
            
            //快速定位正在修改代码
            items.append(item)
        }
        let fullView = SnailFullView()
        setupthemeBgView(view: fullView)
        fullView.size = UIScreen.size
        fullView.items = items
        fullView.delegate = self
        fullView.show()
    }
    
    func fullView(whenTapped fullView: SnailFullView) {
        print("fullview callback------")
    }
    
    func fullView(_ fullView: SnailFullView, didSelectItemAt index: Int) {
        let item = fullView.bannerViews[index]
        if item.label.text == nil{
            return
        }
        let text = item.label.text!
        if text == "抢红包"{

//            let nav = UINavigationController.init(rootViewController: RedPackageViewController())
//            self.present(nav, animated: true, completion: nil)
            let vc = RedPackageViewController()
            self.present(vc, animated: true, completion: nil)
        } else if text == "大转盘"{

            let vc = UIStoryboard(name: "NewBigPanController", bundle: nil).instantiateViewController(withIdentifier: "newBigPanController")
            let page = vc as! NewBigPanController
            self.present(page, animated: true, completion: nil)
            
        } else if text == "积分兑换"{

            let vc = UIStoryboard(name: "score_change_page", bundle: nil).instantiateViewController(withIdentifier: "scoreExchange")
            let page = vc as! ScoreExchangeController
            let nav = UINavigationController.init(rootViewController: page)
            self.present(nav, animated: true, completion: nil)
        } else if text == "优惠活动"{

            let vc = UIStoryboard(name: "active_page", bundle: nil).instantiateViewController(withIdentifier: "activePage")
            let page = vc as! ActiveController
            page.isAttachInTabBar = false
            let nav = UINavigationController.init(rootViewController: page)
            self.present(nav, animated: true, completion: nil)
        } else if text == "站内信"{
            let nav = UINavigationController.init(rootViewController: InsideMessageController())
            self.present(nav, animated: true, completion: nil)
        } else if text == "返回电脑版"{
            let url = String.init(format: "%@/?toPC=1", BASE_URL)
            openBrower(urlString: url)
        } else if text == "返回wap版"{
            let url = String.init(format: "%@/m", BASE_URL)
            openBrower(urlString: url)
        } else if text == "主题切换"{
            if (isSelect == false) {
                isSelect = true
                themeSwitch(dataSource: themes,viewTitle: "主题风格切换")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isSelect = false
                }
            }
        }else if text == "签到" {
            let nav = UINavigationController.init(rootViewController: CalenderController2())
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    var seleBtn: UIButton?
    var tabBarHeight:CGFloat = 49.0
    var titleArray = [String]()
    var imageArray = [String]()
    var selImageArray = [String]()

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        addController()
        cusTabbar.addDelegate = self
        self.tabBar.addSubview(cusTabbar)
        addTabBarButton()
        setupTabbarLine()
        
        registerNotification()
    }
    
    // 切换主题风格
    private func themeSwitch(dataSource: [String], viewTitle: String){
        
        let currentThmeIndex = YiboPreference.getCurrentThme()
        
        let selectedView = LennySelectView(dataSource: dataSource, viewTitle: viewTitle)
        selectedView.selectedIndex = currentThmeIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            
            let themeStr: String
            switch index {
            case 0:
                themeStr = "Red"
            case 1:
                themeStr = "Blue"
            case 2:
                themeStr = "Green"
            case 3:
                themeStr = "FrostedOrange"
            case 4:
                themeStr = "FrostedBlue"
            case 5:
                themeStr = "FrostedPurple"
            case 6:
                themeStr = "FrostedBeautyOne"
            default:
                themeStr = "Red"
            }
            ThemeManager.setTheme(plistName: themeStr, path: .mainBundle)
            YiboPreference.setCurrentThemeByName(value: themeStr as AnyObject)
            YiboPreference.setCurrentTheme(value: index as AnyObject)
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            
        }
    }
    
    override open func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.removeTabBarButton()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().backgroundColor = UIColor(hex: 0xf3f3f5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func addControllerVersion1() {
        self.titleArray = ["游戏大厅","优惠活动","","开奖结果","会员中心"]
        self.imageArray = ["tabHome_normal","tabDiscount_normal","tabHome_normal","tabLottery_normal","tabPersonal_normal"]
        self.selImageArray = ["TabBar.home","TabBar.discount","TabBar.home","TabBar.lottery","TabBar.personal"]
        
        let moduleStyle = YiboPreference.getMallStyle()
        let (xibname,_) = selectMainStyleByModuleID(styleID: moduleStyle)
        
        var navArray = [UIViewController]()
        
        let vc0 = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "new_home")
        vc0.title = titleArray[0]

        let vc1 = UIStoryboard(name: "active_page",bundle:nil).instantiateViewController(withIdentifier: "activePage")
        vc1.title = titleArray[1]

        let vc2 = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "notice") as! LotteryResultsController
        vc2.code = "CQSSC"
        vc2.title = titleArray[3]
        let vc3 = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "member_page")
        vc3.title = titleArray[4]
        
        var nav0: MainNavController!
        nav0 = MainNavController.init(rootViewController: vc0)
        var nav1: MainNavController!
        nav1 = MainNavController.init(rootViewController: vc1)
        var nav2: MainNavController!
        nav2 = MainNavController.init(rootViewController: vc2)
        var nav3: MainNavController!
        nav3 = MainNavController.init(rootViewController: vc3)
        
        navArray.append(nav0)
        navArray.append(nav1)
        navArray.append(nav2)
        navArray.append(nav3)
        
        viewControllers  = navArray;
        
        self.bindMenuDelegate(delegate: self.menuDelegate)
    }
    
    private func addControllerVersion2() {
        self.titleArray = ["游戏大厅","开奖结果","","下注记录","会员中心"]
        self.imageArray = ["tabHome_normal","tabLottery_normal","tabHome_normal","tabBetRecord_normal","tabPersonal_normal"]
        self.selImageArray = ["TabBar.home","TabBar.lottery","TabBar.home","HomePage.betRecord","TabBar.personal"]
        
        let moduleStyle = YiboPreference.getMallStyle()
        let (xibname,_) = selectMainStyleByModuleID(styleID: moduleStyle)
        
        var navArray = [UIViewController]()
        
        let vc0 = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "new_home")
        vc0.title = titleArray[0]
        
        let vc1 = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "notice") as! LotteryResultsController
        vc1.code = "CQSSC"
        vc1.title = titleArray[1]
        
        let vc2 = GoucaiQueryController()
        vc2.title = titleArray[3]
        
        
        let vc3 = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "member_page")
        vc3.title = titleArray[4]
        
        var nav0: MainNavController!
        nav0 = MainNavController.init(rootViewController: vc0)
        var nav1: MainNavController!
        nav1 = MainNavController.init(rootViewController: vc1)
        var nav2: MainNavController!
        nav2 = MainNavController.init(rootViewController: vc2)
        var nav3: MainNavController!
        nav3 = MainNavController.init(rootViewController: vc3)
        
        navArray.append(nav0)
        navArray.append(nav1)
        navArray.append(nav2)
        navArray.append(nav3)
        
        viewControllers  = navArray;
        
        self.bindMenuDelegate(delegate: self.menuDelegate)
    }
    
    fileprivate func addController(){

        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let str = config.content.mainPageVersion
                if str == "V1" {
                    addControllerVersion1()
                    return
                }else if str == "V2" {
                    addControllerVersion2()
                    return
                }
            }
        }
        
        addControllerVersion1()
    }
    
    fileprivate func removeTabBarButton()
    {
        for view in tabBar.subviews {
            if view.isKind(of: NSClassFromString("UITabBarButton")!) {
                view.removeFromSuperview()
            }
        }
        
    }

    fileprivate func addTabBarButton()
    {
        
        let num = 4 + 1
        for i in 0..<num {
            
            let  width = UIScreen.main.bounds.size.width
            let  x = CGFloat(width/CGFloat(num)*CGFloat(i))
            let  y:CGFloat = 0.0
            let  w = width/CGFloat(num)
            let  h = tabBarHeight
            let button = XHTabBarButton(frame:CGRect(x: x,y: y,width: w,height: h))
            let imgWidth: CGFloat = 192
            let imgHeight: CGFloat = 288
            
            button.tag = 1000 + i
            
            if i == 2 {
                
                let addBtn:UIButton = cusTabbar.addButton
                let centerXY = button.center
                let addButtonBounds = CGRect(x: 0, y: 0, width: w * CGFloat(0.58), height: imgHeight * w / imgWidth * CGFloat(0.58))
                addBtn.center = CGPoint(x: centerXY.x, y: (centerXY.y - CGFloat(12)) )
                addBtn.theme_setBackgroundImage("TabBar.plus", forState: .normal)
                addBtn.theme_setBackgroundImage("TabBar.plus", forState: .selected)
                addBtn.theme_setImage("TabBar.plus", forState: .highlighted)
                addBtn.bounds = addButtonBounds
                addBtn.contentMode = .scaleToFill
//                cusTabbar.addSubview(button)
            }else {
                button.titleLabel?.font = UIFont.systemFont(ofSize: titleFontSize)
                button.theme_setTitleColor("Global.themeColor", forState: .selected)
                button.theme_setTitleColor("Global.lightGray", forState: .normal)
                button.theme_setImage(ThemeImagePicker(keyPath: self.self.selImageArray[i]), forState: .selected)
                button.setImage(UIImage.init(named:self.imageArray[i]), for: .normal)
                button.setTitle(self.titleArray[i], for: UIControlState())
                cusTabbar.addSubview(button)
            }
            
            button.addTarget(self, action:#selector(buttonAction(_:)), for: .touchDown)
            
            
            //默认选中
            if i == 0 {
                button.isSelected = true
                self.seleBtn = button
            }
            
        }
    }
    
    /**
     处理高度>49 tabbar顶部线
     */
    fileprivate func setupTabbarLine()
    {
        guard tabBarHeight > 49 else
        {
            return;
        }
        self.tabBar.shadowImage = UIImage.init()
        self.tabBar.backgroundImage = UIImage.init()
        let line = UILabel(frame: CGRect(x: 0, y: 0,width: kScreenWidth, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        cusTabbar.addSubview(line)
    }
    
    //MARK: - Action
    @objc fileprivate func buttonAction(_ button: UIButton) {
        let index: Int = button.tag-1000
        self.showControllerIndex(index)
    }
    
    //MARK: 通知
    private func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(signOutToFirstTabNoti), name: NSNotification.Name(rawValue: "signOutToFirstTabNoti"), object: nil)
        
    }
    
    @objc private func signOutToFirstTabNoti() {
        self.showControllerIndex(0)
    }
    
    //MARK: - 懒加载
    fileprivate lazy var cusTabbar: FakeTabBar = {
        
        let x = CGFloat(0)
        let y = 49.0 - self.tabBarHeight
        let width = kScreenWidth
        let height = self.tabBarHeight
        
        let view = FakeTabBar(frame:CGRect(x: x,y: y,width: width,height: height))
        view.isUserInteractionEnabled = true
//        view.backgroundColor = UIColor.init(hexString: "#f6f6f6")
//        view.backgroundColor = UIColor.white
        view.theme_backgroundColor = "TabBar.tabbarBackgroundColor"
        
        return view
    }()
    
    
    //给每个子页面绑定菜单事件
    func bindMenuDelegate(delegate:MenuDelegate?) -> Void {
        if let menuEvent = delegate{
            guard let controllers = self.viewControllers else {return}
            for controller in controllers{
                if controller.isKind(of: MainNavController.self){
                    let base = (controller as? MainNavController)?.viewControllers[0] as? BaseController
                    base?.menuDelegate = menuEvent
                }
            }
        }
    }
}

class FakeTabBar: UIView {

    weak var addDelegate: RootTabBarDelegate?
    
    var addButton:UIButton = {
        return UIButton()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton.setBackgroundImage(UIImage.init(named: "ic_fabushangping"), for: .normal)
        addButton.addTarget(self, action: #selector(FakeTabBar.addButtonClick), for: .touchUpInside)
        self.addSubview(addButton)
        self.backgroundColor = UIColor.orange
    }
    
    @objc func addButtonClick(){
        if addDelegate != nil{
            addDelegate?.addClick()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let buttonX = self.frame.size.width/5
        var index = 0
        for barButton in self.subviews{
            if barButton.isKind(of: NSClassFromString("UITabBarButton")!){
                if index == 2{
                    /// 设置添加按钮位置
                    addButton.frame.size = CGSize.init(width: (addButton.currentBackgroundImage?.size.width)! * CGFloat(0.48), height: (addButton.currentBackgroundImage?.size.height)! * CGFloat(0.48))
                    addButton.center = CGPoint.init(x: self.center.x, y: self.frame.size.height/2 - 15)
                    index += 1
                }
                barButton.frame = CGRect.init(x: buttonX * CGFloat(index), y: 0, width: buttonX, height: self.frame.size.height)
                index += 1
            }
        }
        self.bringSubview(toFront: addButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /// 判断是否为根控制器
        if self.isHidden {
            /// tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)

        }else{
            /// 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.addButton)
            /// 判断新的点是否在按钮上
            if self.addButton.point(inside: onButton, with: event){
                return addButton
            }else{
                /// 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }

    }
    
}

/// 上传按钮点击代理
protocol RootTabBarDelegate:NSObjectProtocol {
    func addClick()
}
