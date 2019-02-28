//
//  MyNavigationController.swift
//  MyTabBar
//
//  Created by hello on 2019/1/15.
//  Copyright © 2019 hello. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetting()
    }
    
    func defaultSetting(){
        //导航栏的背景色与标题设置
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray,
                                                  NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0{
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(didBackButton(sender:)))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    //点击事件
    @objc func didBackButton(sender:UIButton){
        self.popViewController(animated:true)
    }

}
