//
//  AboutUsController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/19.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class AboutUsController: UIViewController {

    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var appName:UILabel!
    @IBOutlet weak var appVersion:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupthemeBgView(view: self.view)
        appName.text = getAppName()
        appVersion.text = getVerionName()
        icon.image = UIImage.init(named: "AppIcon")
        
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: appName)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: appVersion)
    }

}
