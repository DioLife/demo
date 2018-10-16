//
//  GoucaiQueryController.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/6/1.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

// buy lottery record query page
class GoucaiQueryController: LennyBasicViewController {
    
    var isAttachInTabBar = true

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view,alpha: 0)
        
        initDate()
        setViews()
    }
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
//            self.navigationItem.rightBarButtonItems?.removeAll()
//            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
//            self.navigationItem.rightBarButtonItems = [menuBtn]
            
            self.navigationItem.rightBarButtonItems?.removeAll()
            let button = UIButton(type: .custom)
            button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
            //        button.setImage(UIImage.init(named: "filter"), for: .normal)
            button.setTitle("筛选", for: .normal)
            button.contentHorizontalAlignment = .right
            button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
            button.isSelected = false
            button.theme_setTitleColor("Global.barTextColor", forState: .normal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        }
    }
    
    private let mainPageView = WHC_PageView()
    private let layoutParameter = WHC_PageViewLayoutParam()
    
    var filterUsername = ""
    var filterLotCode = ""
    var filterStartTime = ""
    var filterEndTime = ""
    var current_index = 0
    
    private func setViews() {
        
        if self.title == nil {self.title = "购彩查询"}
//        let button = UIButton(type: .custom)
//        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
////        button.setImage(UIImage.init(named: "filter"), for: .normal)
//        button.setTitle("筛选", for: .normal)
//        button.contentHorizontalAlignment = .right
//        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
//        button.isSelected = false
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        
        if !isAttachInTabBar{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        }

//        view.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(mainPageView)
        if glt_iphoneX {
            mainPageView.whc_AutoSize(left: 0, top: 24, right: 0, bottom: 0)
        }else {
            mainPageView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        }
        
        setViewBackgroundColorTransparent(view: self.view)
        setViewBackgroundColorTransparent(view: self.mainPageView)
        mainPageView.delegate = self
        layoutParameter.titleBarHeight = 40
        layoutParameter.cursorColor = UIColor.mainColor()
        layoutParameter.cursorMargin = 0
        layoutParameter.cursorHeight = 1.5
//        layoutParameter.normalBackgorundColor = UIColor.white.withAlphaComponent(0.0)
//        layoutParameter.backgroundColor = UIColor.cc_71()
        layoutParameter.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        layoutParameter.selectedBackgorundColor = UIColor.white.withAlphaComponent(0.0)
        layoutParameter.normalTextColor = UIColor.darkGray
        layoutParameter.selectedTextColor = UIColor.mainColor()
        layoutParameter.titles = ["全部", "未开奖", "已中奖", "未中奖"]
        mainPageView.layoutParam = layoutParameter
        
    }
    
    func initDate(){
        self.filterStartTime = getTodayZeroTime()
        self.filterEndTime = getTomorrowNowTime()
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            if contentView.viewWithTag(101) != nil { return }
            let filterView = GoucaiFilterView(height: 200,controller:self)
            filterView.initializeDate(start: self.filterStartTime, end: self.filterEndTime)
            
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.didClickConfirmButton = {(username:String,lotCode:String,startTime:String,endTime:String)->Void in
                self.rightBarButtonItemAction(button: button)
                self.filterUsername = username
                self.filterLotCode = lotCode
                self.filterStartTime = startTime
                self.filterEndTime = endTime
                self.startLayoutAndQuery(index: self.current_index)
                
            }
            filterView.tag = 101
            contentView.addSubview(filterView)
            filterView.frame = CGRect.init(x: 0, y: -180, width: MainScreen.width, height: 180)
            contentView.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                filterView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: 180)
                self.mainPageView.frame = CGRect.init(x: 0, y: 180, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                button.isSelected = true
            }
        }else {
            button.isSelected = false
            let filterView = contentView.viewWithTag(101)
            UIView.animate(withDuration: 0.5, animations: {
                filterView?.alpha = 0
                filterView?.frame = CGRect.init(x: 0, y: -180, width: MainScreen.width, height: 180)
                self.mainPageView.frame = CGRect.init(x: 0, y: 0, width: MainScreen.width, height: self.contentView.height)
            }) { ( _) in
                filterView?.removeFromSuperview()
                button.isSelected = false
            }
        }
    }
    private var vcs = [QueryResultsAllController(), QueryResultsWeiKaiJiangController(), QueryResultsYiZhongJiangController(), QueryResultsWeiZhongJiangController()]
    
    public func startLayoutAndQuery(index:Int){
        let page = self.vcs[index] as QueryResultsBasicController
        page.filterUsername = self.filterUsername
        page.filterLotCode = self.filterLotCode
        page.filterStartTime = self.filterStartTime
        page.filterEndTime = self.filterEndTime
        
        if let vc0 = page as? QueryResultsAllController {
            vc0.loadNetRequest(isLoadMoreData: false)
        }
        
        if let vc1 = page as? QueryResultsWeiKaiJiangController {
            vc1.loadNetRequest(isLoadMoreData: false)
        }
        
        if let vc2 = page as? QueryResultsYiZhongJiangController {
            vc2.loadNetRequest(isLoadMoreData: false)
        }
        
        if let vc3 = page as? QueryResultsWeiZhongJiangController {
            vc3.loadNetRequest(isLoadMoreData: false)
        }
        
        
//        page.setStaticViewsAndContent()
    }
    
}
extension GoucaiQueryController: WHC_PageViewDelegate {
    
    func whcPageViewStartLoadingViews() -> [UIView]! {
        
        var arr = [UIView]()
        for vc in vcs {
            arr.append(vc.view)
        }
        return arr
    }
    func whcPageView(_ pageView: WHC_PageView, willUpdateView view: UIView, index: Int) {
//        vcs[index].setStaticViewsAndContent()
        current_index = index
        self.startLayoutAndQuery(index: index)
    }
}
