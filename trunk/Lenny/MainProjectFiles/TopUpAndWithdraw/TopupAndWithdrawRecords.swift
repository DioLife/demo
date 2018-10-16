//
//  TopupAndWithdrawRecords.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/2.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class TopupAndWithdrawRecords: LennyBasicViewController {

    fileprivate var vcs = [TopupViewController(), WithdrawRecordsViewController()]
    private var mainPageView = WHC_PageView()
    
    var filterOrderNum = ""
    var filterStartTime = ""
    var filterEndTime = ""
    var filterAccountId:Int64 = 0
    var current_index = 0
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        initDate()
        setViews()
    }

    func initDate(){
        self.filterStartTime = getTodayZeroTime()
        self.filterEndTime = getTomorrowNowTime()
    }
    
    private func setViews() {
        
        self.title = "充提记录"
        
        let button = UIButton(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
//        button.setImage(UIImage.init(named: "filter"), for: .normal)
        button.setTitle("筛选", for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(rightBarButtonItemAction(button:)), for: .touchUpInside)
        button.theme_setTitleColor("Global.barTextColor", forState: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        mainPageView.delegate = self
        setViewBackgroundColorTransparent(view: mainPageView)
        contentView.addSubview(mainPageView)
        
        mainPageView.whc_Left(0).whc_Right(0).whc_Bottom(0)
        if glt_iphoneX {mainPageView.whc_Top(24)}else {mainPageView.whc_Top(0)}
        
        let layoutParameter = WHC_PageViewLayoutParam()
        layoutParameter.titles = ["充值记录", "提现记录"]
        layoutParameter.selectedTextColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        layoutParameter.selectedFont = UIFont.systemFont(ofSize: 16)
        layoutParameter.normalTextColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        layoutParameter.normalFont = UIFont.systemFont(ofSize: 16)
        layoutParameter.cursorColor = UIColor.ccolor(with: 236, g: 40, b: 40)
        layoutParameter.canChangeFont = true
        layoutParameter.canChangeTextColor = true
        layoutParameter.cursorHeight = 5
        layoutParameter.defaultSelectIndex = current_index
        mainPageView.layoutIfNeeded()
        mainPageView.layoutParam = layoutParameter
        
//        let deadline2 = DispatchTime.now() + 0.1
//        DispatchQueue.main.asyncAfter(deadline: deadline2) {
//            self.mainPageView.handleTitleItemClick(animation: true, index: 1)
//        }
        self.mainPageView.handleTitleItemClick(animation: true, index: 1)//模拟点击事件
    }
    
    public func startLayoutAndQuery(index:Int){
        if index == 0{
            let page = self.vcs[index] as! TopupViewController
            page.filterOrderNum = self.filterOrderNum
            page.filterStartTime = self.filterStartTime
            page.filterEndTime = self.filterEndTime
//            page.loadNetRequestWithViewSkeleton(animate: true)
            page.loadObtainChargeQueryRequest(isLoadMoreData: false)
        }else{
            let page = self.vcs[index] as! WithdrawRecordsViewController
            page.filterOrderNum = self.filterOrderNum
            page.filterStartTime = self.filterStartTime
            page.filterEndTime = self.filterEndTime
            page.shouldGotoLogin = false
            page.loadObtainwithdrawQueryRequest(isLoadMoreData: false)
        }
    }
    
    @objc private func rightBarButtonItemAction(button: UIButton) {
        
        if button.isSelected == false {
            if contentView.viewWithTag(101) != nil { return }
            let filterView = ChargeWithdrawFilterView(height: 200,controller:self)
            filterView.initializeDate(start: self.filterStartTime, end: self.filterEndTime,orderNum: self.filterOrderNum)
            
            filterView.didClickCancleButton = {
                self.rightBarButtonItemAction(button: button)
            }
            filterView.didClickConfirmButton = {(orderNum:String,startTime:String,endTime:String)->Void in
                self.rightBarButtonItemAction(button: button)
                self.filterOrderNum = orderNum
                self.filterStartTime = startTime
                self.filterEndTime = endTime
                self.startLayoutAndQuery(index: self.current_index)
            }
            filterView.tag = 101
            contentView.addSubview(filterView)
            filterView.frame = CGRect.init(x: 0, y: -180, width: MainScreen.width, height: 180)
            contentView.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, animations: {
                filterView.frame = CGRect.init(x: 0, y: glt_iphoneX ? 24 : 0, width: MainScreen.width, height: 180)
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
    
}

extension TopupAndWithdrawRecords: WHC_PageViewDelegate {
    
    private func initialize(){
        self.filterOrderNum = ""
        self.filterStartTime = ""
        self.filterEndTime = ""
        self.initDate()
    }
    
    func whcPageViewStartLoadingViews() -> [UIView]! {
        return [vcs.first!.view, vcs.last!.view]
    }
    
    func whcPageView(_ pageView: WHC_PageView, willUpdateView view: UIView, index: Int) {
        current_index = index
        initialize()
        self.startLayoutAndQuery(index: index)
    }
}
