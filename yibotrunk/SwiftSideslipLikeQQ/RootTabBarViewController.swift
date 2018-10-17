//
//  RootTabBarViewController.swift
//  unionMerchant
//
//  Created by simpsons on 2017/8/16.
//  Copyright © 2017年 simpsons. All rights reserved.
//

import UIKit

class RootTabBarViewController: MainTabBarController, RootTabBarDelegate,SnailFullViewDelegate{
    

    let tabBarNormalImages = ["tabbar_home","tabbar_discover","tabbar_message_center","tabbar_profile"]
    let tabBarSelectedImages = ["tabbar_home_selected","tabbar_discover_selected","tabbar_message_center_selected","tabbar_profile_selected"]
    let tabBarTitles = ["游戏大厅","购彩大厅","开奖公告","个人中心"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().backgroundColor = UIColor(hex: 0xf3f3f5)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = RootTabBar()
        tab.addDelegate = self
        self.setValue(tab, forKey: "tabBar")
        self.setRootTabbarConntroller()
    }
    
    func addClick() {
        self.popupWindow()
    }
    
    func fullView(whenTapped fullView: SnailFullView) {
        print("fullview callback------")
    }
    
    func fullView(_ fullView: SnailFullView, didSelectItemAt index: Int) {
        print("select index = ",index)
        let text = fullView.bannerViews[index].label.text!
        print("text ==== ",text)
        if text == "抢红包"{
//            openRainController(controller:  self)
            let vc = UIStoryboard(name: "rain_packet", bundle: nil).instantiateViewController(withIdentifier: "rain_page")
            let page = vc as! RainPackageController
            let nav = UINavigationController.init(rootViewController: page)
            self.present(nav, animated: true, completion: nil)
        } else if text == "大转盘"{
//            openBigPanPage(controller: self)
            let vc = UIStoryboard(name: "bigpan", bundle: nil).instantiateViewController(withIdentifier: "big_pan")
            let page = vc as! BigPanController
            let nav = UINavigationController.init(rootViewController: page)
            self.present(nav, animated: true, completion: nil)
        } else if text == "积分兑换"{
//            openScoreExchangePage(controller: self)
            let vc = UIStoryboard(name: "score_change_page", bundle: nil).instantiateViewController(withIdentifier: "scoreExchange")
            let page = vc as! ScoreExchangeController
            let nav = UINavigationController.init(rootViewController: page)
            self.present(nav, animated: true, completion: nil)
        } else if text == "优惠活动"{
//            openActiveController(controller: self)
            let vc = UIStoryboard(name: "active_page", bundle: nil).instantiateViewController(withIdentifier: "activePage")
            let page = vc as! ActiveController
            let nav = UINavigationController.init(rootViewController: page)
            self.present(nav, animated: true, completion: nil)
        } else if text == "站内信"{
//            openMessageCenter(controller: self)
            let vc = UIStoryboard(name: "message_center", bundle: nil).instantiateViewController(withIdentifier: "mc")
            let page = vc as! MessageCenterController
            let nav = UINavigationController.init(rootViewController: page)
            self.present(nav, animated: true, completion: nil)
        } else if text == "返回电脑版"{
            openBrower(urlString: BASE_URL+PORT+"/?toPC=1")
        }else if text == "首页浮动链接"{
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    let url = config.content.mobile_web_index_slide_url
                    if !isEmptyString(str: url){
                        openBrower(urlString: url)
                    }else{
                        showToast(view: self.view, txt: "没有配置浮动链接，请联系客服")
                    }
                }
            }
        } else if text == "游戏大厅"{
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    let url = config.content.foreign_game_hall_link
                    if !isEmptyString(str: url){
                        openBrower(urlString: url)
                    }else{
                        showToast(view: self.view, txt: "没有配置游戏大厅链接，请联系客服")
                    }
                }
            }
        }
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
            if !isEmptyString(str: sys.content.switch_backto_computer) && sys.content.switch_backto_computer == "on"{
                array.append("返回电脑版")
            }
            if !isEmptyString(str: sys.content.mobile_web_index_slide_images){
                array.append("首页浮动链接")
            }
            if !isEmptyString(str: sys.content.foreign_game_hall_link_switch) && sys.content.foreign_game_hall_link_switch == "on"{
                array.append("游戏大厅")
            }
        }
        array.append("优惠活动")
        array.append("站内信")
        
        var items: [BannerItem] = []
        for (_, name) in array.enumerated(){
            let item = BannerItem()
            item.title = name
            if let img = UIImage(named: "popup_".appending(name)) { item.image = img }
            if name == "首页浮动链接"{
                item.imageUrl = (getSystemConfigFromJson()?.content.mobile_web_index_slide_images)!
            }
            items.append(item)
        }
        let fullView = SnailFullView()
        fullView.size = UIScreen.size
        fullView.items = items
        fullView.delegate = self
        fullView.show()
    }
    
    
    func setRootTabbarConntroller(){
        
        let moduleStyle = YiboPreference.getMallStyle()
        let (xibname,_) = selectMainStyleByModuleID(styleID: moduleStyle)
        var vc:BaseController!
        
        for i in 0..<self.tabBarNormalImages.count {
            //创建根控制器
            switch i {
            case 0:
                vc = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "home") as? BaseController
            case 1:
                vc = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "mall") as? BaseController
            case 2:
                vc = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "notice") as? BaseController
            case 3:
                vc = UIStoryboard(name: xibname,bundle:nil).instantiateViewController(withIdentifier: "profile") as? BaseController
            default:
                break
            }
            
            //创建导航控制器
            let nav = MainNavController.init(rootViewController: vc!)
            //1.创建tabbarItem
            let barItem = UITabBarItem.init(title: self.tabBarTitles[i], image: UIImage.init(named: self.tabBarNormalImages[i])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: self.tabBarSelectedImages[i])?.withRenderingMode(.alwaysOriginal))
            
            //2.更改字体颜色及大小
            barItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(hex: 0xcccccc)!,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 13)], for: .normal)
            barItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(hex: 0x21d1c1)!,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 13)], for: .selected)
            
            //设置标题
            vc?.title = self.tabBarTitles[i]
            //设置根控制器
            vc?.tabBarItem = barItem
            //添加到当前控制器
            self.addChildViewController(nav)
        }
        self.bindMenuDelegate(delegate: self.menuDelegate)
        
    }
    
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

/// 上传按钮点击代理
protocol RootTabBarDelegate:NSObjectProtocol {
    func addClick()
}

/// 自定义tabbar，修改UITabBarButton的位置
class RootTabBar: UITabBar{
    
    weak var addDelegate: RootTabBarDelegate?
    
    private lazy var addButton:UIButton = {
        return UIButton()
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addButton.setBackgroundImage(UIImage.init(named: "ic_fabushangping"), for: .normal)
        addButton.addTarget(self, action: #selector(RootTabBar.addButtonClick), for: .touchUpInside)
        self.addSubview(addButton)
        /// tabbar设置背景色
        self.backgroundImage = UIColor.creatImageWithColor(color: UIColor.white)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addButtonClick(){
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
                    addButton.frame.size = CGSize.init(width: (addButton.currentBackgroundImage?.size.width)!, height: (addButton.currentBackgroundImage?.size.height)!)
                    addButton.center = CGPoint.init(x: self.center.x, y: self.frame.size.height/2 - 18)
                    index += 1
                }
                barButton.frame = CGRect.init(x: buttonX * CGFloat(index), y: 0, width: buttonX, height: self.frame.size.height)
                index += 1
            }
        }
        self.bringSubview(toFront: addButton)
    }
    
    /// 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
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

