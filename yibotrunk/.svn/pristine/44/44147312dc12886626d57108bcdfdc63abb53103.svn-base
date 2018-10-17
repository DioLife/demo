//
//  GameMall15EController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/21.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//15e官方信用兼容版风格界面代码,moduleStyle=3
class GameMall15EController: BaseMainController {
    
    @IBOutlet weak var scrollview:UIScrollView!
    @IBOutlet weak var gridview:UICollectionView!
//    var actionButton: ActionButton!//悬浮按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        actionButton = createFAB(controller:self)
    }
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
            self.navigationItem.rightBarButtonItems = [menuBtn]
        }
    }
    
    
    
    
}
