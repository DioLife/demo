//
//  UserlistFilterView.swift
//  gameplay
//
//  Created by admin on 2018/8/17.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit

class UserlistFilterView: UIView {
    
    var showAllLevelBtn = UIButton()
    
    var didClickShowAllLevelBtn: ((Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(showAllLevelBtn)
        showAllLevelBtn.whc_CenterX(0).whc_CenterY(0).whc_Height(30)
        showAllLevelBtn.setTitle("包含下级", for: .normal)
        showAllLevelBtn.setTitle("取消包含下级", for: .selected)
        showAllLevelBtn.theme_backgroundColor = "Global.themeColor"
        showAllLevelBtn.setTitleColor(UIColor.white, for: .normal)
        showAllLevelBtn.setTitleColor(UIColor.white, for: .selected)
        showAllLevelBtn.addTarget(self, action: #selector(showAllLevelAction), for: .touchUpInside)
    }
    
    @objc private func showAllLevelAction(button: UIButton) {
        if button.isSelected {
            showToast(view: self, txt: "取消包含下级")
            didClickShowAllLevelBtn?(false)
        }else {
            showToast(view: self, txt: "包含下级")
            didClickShowAllLevelBtn?(true)
        }
        
        button.isSelected = !button.isSelected
    }

}
