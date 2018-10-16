//
//  LotMenuController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/12.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
/**
 彩种列表菜单
 **/
class LotMenuController: UIViewController {

    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerBgImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        headerBgImage.theme_image = "General.personalHeaderBg"
        headerImage.theme_image = "General.placeHeader"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
