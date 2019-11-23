//
//  HideViewController.swift
//  DemoSwift
//
//  Created by hello on 2019/6/18.
//  Copyright © 2019 Dio. All rights reserved.
//

import UIKit
import WebKit

/// 状态栏高度
let kStatusBarHeight:CGFloat = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
let kNavBarHeight:CGFloat = 44.0

class HideViewController: UIViewController {
    
    var model:SwitchData?
    var myWeb:UIWebView!
    var rightBottomBtn: UIButton!
    
    let titles = ["创建群聊", "加好友/群", "扫一扫", "面对面快传", "付款", "拍摄"]
    let images = [UIImage(named: "right_menu_multichat"),
                  UIImage(named: "right_menu_addFri"),
                  UIImage(named: "right_menu_QR"),
                  UIImage(named: "right_menu_facetoface"),
                  UIImage(named: "right_menu_payMoney"),
                  UIImage(named: "right_menu_sendvideo")]
    
    let images2 = [UIImage(named: "right_menu_multichat_white"),
                   UIImage(named: "right_menu_addFri_white"),
                   UIImage(named: "right_menu_QR_white"),
                   UIImage(named: "right_menu_facetoface_white"),
                   UIImage(named: "right_menu_payMoney_white"),
                   UIImage(named: "right_menu_sendvideo_white")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.myWeb = UIWebView.init(frame: self.view.frame)
        self.myWeb.delegate = self
        self.myWeb.scrollView.showsVerticalScrollIndicator = false
        self.myWeb.scrollView.showsHorizontalScrollIndicator = false
        if model != nil {
            if let urlStr = model!.homeUrl {
                let url = URL.init(string: urlStr)
                let urlRequest = URLRequest.init(url: url!)
                self.myWeb.loadRequest(urlRequest)
            }
        }
        self.view.addSubview(self.myWeb)
        
        rightBottomBtn = self.setupBtn(title: "右下角按钮", frame: CGRect(x: UIScreen.main.bounds.width - 110, y: UIScreen.main.bounds.height * 0.8, width: 100, height: 50), tag: 3) as? UIButton
        self.view.addSubview(rightBottomBtn)
    }
}

extension HideViewController {
    func setupBtn(title: String, frame: CGRect, tag: Int) -> UIView {
        let btn = UIButton(type: .custom)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        btn.backgroundColor = UIColor.lightGray
        btn.tag = tag
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        
        return btn
    }
    
    @objc func btnAction(_ sender: UIButton) {
        let property = FWMenuViewProperty()
        property.popupCustomAlignment = .bottomRight
        property.popupAnimationType = .scale
        property.maskViewColor = UIColor.clear
        property.touchWildToHide = "1"
        property.popupViewEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: UIScreen.main.bounds.height - self.rightBottomBtn.frame.minY, right: 10)// - kStatusBarHeight - kNavBarHeight
        property.topBottomMargin = 0
        property.animationDuration = 0.3
        property.popupArrowStyle = .round
        property.popupArrowVertexScaleX = 0.8
        property.cornerRadius = 5
        
        let menuView = FWMenuView.menu(itemTitles: titles, itemImageNames: images as? [UIImage], itemBlock: { (popupView, index, title) in
            print("Menu：点击了第\(index)个按钮")
        }, property: property)
        menuView.show()
    }
    
    @objc func barBtnAction(_ sender: Any) {
//        self.menuView2.show()
    }
}

extension HideViewController:UIWebViewDelegate {
    
}
