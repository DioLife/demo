//
//  MainViewController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit


class MainViewController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    private let bottomTabbar = LennyBottomTabView()
    
    
    override var hasBottomView: Bool {
        return true
    }
    override var bottomViewHeight: CGFloat {
        return 50
    }
    
    private var currentView: UIView!
    let lottryVC = LotteryResultsController()
    private let vcs = [UIStoryboard(name: selectMainStyleByModuleID(styleID: YiboPreference.getMallStyle()).0,bundle:nil).instantiateViewController(withIdentifier: "home"),
                       UIStoryboard(name: selectMainStyleByModuleID(styleID: YiboPreference.getMallStyle()).0,bundle:nil).instantiateViewController(withIdentifier: "mall"),
                       MainNavigationController.init(rootViewController: LotteryResultsController()),
                       MainNavigationController.init(rootViewController: MemberPageController())]
    
    private func setViews() {
        print(UIStoryboard(name: selectMainStyleByModuleID(styleID: YiboPreference.getMallStyle()).0,bundle:nil).instantiateViewController(withIdentifier: "home"))
        bottomView.addSubview(bottomTabbar)
        bottomTabbar.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        
        currentView = vcs.first?.view
        self.view.addSubview(currentView)
        currentView.whc_AutoSize(left: 0, top: 64, right: 0, bottom: 50)
        
        bottomTabbar.clickCallBack = { (index) in
            
            switch index {
            case 1:
                if self.currentView != self.vcs.first?.view {
                    self.currentView.whc_ResetConstraints().removeFromSuperview()
                    self.currentView = self.vcs.first?.view
                    self.view.addSubview(self.currentView)
                    self.currentView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 50)
                }
                break
            case 2:
                if self.currentView != self.vcs[1].view {
                    self.currentView.whc_ResetConstraints().removeFromSuperview()
                    self.currentView = self.vcs[1].view
                    self.view.addSubview(self.currentView)
                    self.currentView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 50)
                }
            case 3:
                
                break
            case 4:
                if self.currentView != self.vcs[2].view {
                    self.currentView.whc_ResetConstraints().removeFromSuperview()
                    self.currentView = self.vcs[2].view
                    self.view.addSubview(self.currentView)
                    self.currentView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 50)
                }
                break
            case 5:
                if self.currentView != self.vcs[3].view {
                    self.currentView.whc_ResetConstraints().removeFromSuperview()
                    self.currentView = self.vcs[3].view
                    self.view.addSubview(self.currentView)
                    self.currentView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 50)
                }
            default:
                break
            }
            self.view.bringSubview(toFront: self.bottomTabbar)
        }
    }
}

private class LennyBottomTabView: UIView {
    
    let tabBarNormalImages = ["tabbar_home","tabbar_discover","tabbar_message_center","tabbar_profile"]
    let tabBarSelectedImages =  ["tabbar_home_selected","tabbar_discover_selected","tabbar_message_center_selected","tabbar_profile_selected"]
//    let tabBarTitles = ["游戏大厅","购彩大厅","开奖公告","个人中心"]
    let tabBarTitles = ["游戏大厅","优惠活动","开奖结果","会员中心"]
    
    public var clickCallBack: ( (Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 50))
        self.whc_AddTopLine(0.5, color: UIColor.ccolor(with: 136, g: 136, b: 136))
        let button1 = UIButton()
        let button2 = UIButton()
        let button3 = UIButton()
        let button4 = UIButton()
        let button5 = UIButton()
        
        let spacing = MainScreen.width/6
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        addSubview(button4)
        addSubview(button5)
        
        button3.whc_Center(0, y: -20).whc_Width(60).whc_Height(60)
        
        button1.whc_CenterY(0).whc_CenterX(-spacing * 2, toView: button3).whc_Width(60).whc_Height(49)
        button2.whc_CenterY(0).whc_CenterX(-spacing, toView: button3).whc_Width(60).whc_Height(49)
        
        button4.whc_CenterY(0).whc_CenterX(spacing, toView: button3).whc_Height(49)
        button5.whc_CenterY(0).whc_CenterX(spacing * 2, toView: button3).whc_Width(60).whc_Height(49)
        
        button1.setTitle(tabBarTitles[0], for: .normal)
        button2.setTitle(tabBarTitles[1], for: .normal)
        button4.setTitle(tabBarTitles[2], for: .normal)
        button5.setTitle(tabBarTitles[3], for: .normal)
        
        button1.setTitleColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .normal)
        button2.setTitleColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .normal)
        button4.setTitleColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .normal)
        button5.setTitleColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .normal)
        
        button1.setImage(UIImage(named: tabBarNormalImages[0]), for: .normal)
        button2.setImage(UIImage(named: tabBarNormalImages[1]), for: .normal)
        button4.setImage(UIImage(named: tabBarNormalImages[2]), for: .normal)
        button5.setImage(UIImage(named: tabBarNormalImages[3]), for: .normal)
        
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button4.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button5.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        layoutIfNeeded()

        button1.layoutStyle = .image_Top_Text_Bottom
        button2.layoutStyle = .image_Top_Text_Bottom
        button3.layoutStyle = .image_Top_Text_Bottom
        button4.layoutStyle = .image_Top_Text_Bottom
        button5.layoutStyle = .image_Top_Text_Bottom
        
        button3.setBackgroundImage(UIImage(named: "ic_fabushangping"), for: .normal)
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        button5.tag = 5
        button1.addTarget(self, action: #selector(buttonClickHandle(button:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonClickHandle(button:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonClickHandle(button:)), for: .touchUpInside)
        button4.addTarget(self, action: #selector(buttonClickHandle(button:)), for: .touchUpInside)
        button5.addTarget(self, action: #selector(buttonClickHandle(button:)), for: .touchUpInside)
    }
    
    @objc private func buttonClickHandle(button: UIButton) {
        
        for (index, view) in subviews.enumerated() {
            if button.tag == 3 { continue }
            if view.isKind(of: UIButton.self) {
                (view as! UIButton).setTitleColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .normal)
                (view as! UIButton).setImage(UIImage(named: tabBarNormalImages[index > 3 ? index - 2 : index - 1]), for: .normal)
                
            }
        }
        
        button.setImage(UIImage(named: tabBarSelectedImages[button.tag > 3 ? button.tag - 2 : button.tag - 1]), for: .normal)
        button.setTitleColor(UIColor.mainColor(), for: .normal)
        clickCallBack?(button.tag)
    }
}

