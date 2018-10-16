//
//  PasswordModifyController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class PasswordModifyController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }
    
    fileprivate var mainPageView: WHC_PageView!
    
    fileprivate let vcs = [ModifyLoginPasswordController(), SetWithdrawPasswordController()]
    
    private func setViews() {
        
        self.title = "密码修改"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
//        self.navigationController?.navigationBar.barTintColor = UIColor.ccolor(with: 236, g: 40, b: 40)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        mainPageView = WHC_PageView()
        contentView.addSubview(mainPageView)
        if glt_iphoneX {
            mainPageView.whc_AutoSize(left: 0, top: 24, right: 0, bottom: 0)
        }else {
            mainPageView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        }
        mainPageView.delegate = self
        let layoutParameter = WHC_PageViewLayoutParam()
        layoutParameter.titles = ["修改登录密码", "设置提款密码"]
        layoutParameter.selectedTextColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        layoutParameter.selectedFont = UIFont.systemFont(ofSize: 16)
        layoutParameter.normalTextColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        layoutParameter.normalFont = UIFont.systemFont(ofSize: 16)
        layoutParameter.cursorColor = UIColor.ccolor(with: 236, g: 40, b: 40)
        layoutParameter.canChangeFont = true
        layoutParameter.canChangeTextColor = true
        layoutParameter.cursorHeight = 2
        mainPageView.layoutIfNeeded()
        mainPageView.layoutParam = layoutParameter
        
    }
}

extension PasswordModifyController: WHC_PageViewDelegate {
    
    func whcPageViewStartLoadingViews() -> [UIView]! {
        return [vcs.first!.view, vcs.last!.view]
    }
    func whcPageView(_ pageView: WHC_PageView, willUpdateView view: UIView, index: Int) {
        
    }
}
