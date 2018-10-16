//
//  TueijianViewController.swift
//  gameplay
//
//  Created by William on 2018/8/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class TueijianViewController: LennyBasicViewController {
    
    fileprivate let vcs = [TueijianInfoViewController(), TueijianAddViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        //接受通知并跳转
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name(rawValue:"tueijianJump"), object:nil)
        
        setViews()
    }
    
    //    实现通知监听方法
    @objc func test(nofi : Notification){
        let vc = UIStoryboard(name: "user_list_page",bundle:nil).instantiateViewController(withIdentifier: "userList") as! UserListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private var mainPageView: WHC_PageView!
    
    private func setViews() {
        self.title = "我的推荐"
        mainPageView = WHC_PageView()
        contentView.addSubview(mainPageView)
        if glt_iphoneX {
            mainPageView.whc_AutoSize(left: 0, top: 24, right: 0, bottom: 0)
        }else {
            mainPageView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        }
        
        mainPageView.delegate = self
        let layoutParameter = WHC_PageViewLayoutParam()
        layoutParameter.titles = ["推荐信息", "添加会员"]
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
    

    
//    public func startLayoutAndQuery(index:Int){
//        if index == 0{
//            let page = self.vcs[index] as! TueijianInfoViewController
//            //page.loadNetRequestWithViewSkeleton(animate: true)
//        }else{
//            let page = self.vcs[index] as! TueijianAddViewController
//            //page.loadNetRequestWithViewSkeleton(animate: true)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TueijianViewController: WHC_PageViewDelegate {
    
    func whcPageViewStartLoadingViews() -> [UIView]! {
        return [vcs.first!.view, vcs.last!.view]
    }
//    func whcPageView(_ pageView: WHC_PageView, willUpdateView view: UIView, index: Int) {
//        startLayoutAndQuery(index: index)
//    }
}
