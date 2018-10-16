//
//  InsideMessageController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class InsideMessageController: LennyBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"lzd"), object: nil)
        setViews()
    }
    
    //实现通知监听方法
    @objc func test(nofi:Notification){
        let vc = SendMessageController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private var mainPageView: WHC_PageView!
    
    private func setViews() {
        
        self.title = "站内短信"
        mainPageView = WHC_PageView()
        contentView.addSubview(mainPageView)
        if glt_iphoneX {
            mainPageView.whc_AutoSize(left: 0, top: 24, right: 0, bottom: 0)
        }else {
            mainPageView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        }
        
        mainPageView.delegate = self
        let layoutParameter = WHC_PageViewLayoutParam()
        layoutParameter.titles = ["收件箱", "发件箱"]
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
    
    fileprivate let vcs = [InboxController(), OutboxController()]
    
    public func startLayoutAndQuery(index:Int){
        if index == 0{
            let page = self.vcs[index] as! InboxController
            page.loadNetRequestWithViewSkeleton(animate: true)
        }else{
            let page = self.vcs[index] as! OutboxController
            page.loadNetRequestWithViewSkeleton(animate: true)
        }
    }
    
}

extension InsideMessageController: WHC_PageViewDelegate {
    
    func whcPageViewStartLoadingViews() -> [UIView]! {
        return [vcs.first!.view, vcs.last!.view]
    }
    func whcPageView(_ pageView: WHC_PageView, willUpdateView view: UIView, index: Int) {
        startLayoutAndQuery(index: index)
    }
}
