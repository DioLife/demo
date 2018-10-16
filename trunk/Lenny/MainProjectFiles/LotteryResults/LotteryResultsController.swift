//
//  LotteryResultsController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/9.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit
import SkeletonView
class LotteryResultsController: LennyBasicViewController {
    var isAttachInTabBar = true
    var isSelect = false
    var isSelectedEnd = true;
    var dataArr:[AllLotteryResultsList] = [AllLotteryResultsList]()
    var codeRands:[AllLotteryResultsCodeRank] = [AllLotteryResultsCodeRank]()
    private var selectedIndex: Int = 0
    private let button_Selecter = UIButton()
    private let mainPageView = WHC_PageView()
    private let layoutParameter = WHC_PageViewLayoutParam() //开奖、走势 的 titleView
    private var mainTitleView: SGPageTitleView?
    private var  mainContentView: SGPageContentScrollView?
    
    private var titles: [String]!
    private var lotteryTypes: [String]!
    private var pageViewSubNums: Int = 1
    private var vcs = [LotteryResultsDisplayController(), LotteryResultsTrendChartBasicController()]
    
    public var lotType: String! = "1"
    
    public var code: String! = "CQSSC" {
        didSet {
            
            publicLoadLotteryResults(pageNumber: 1, code: code)
            
            if lotType == "1" || lotType == "2" || lotType == "5"
            {
                titles = ["开奖","万位走势", "千位走势", "百位走势", "十位走势", "个位走势" ]
                layoutParameter.titleBarHeight = 40
                let vc_1 = LotteryResultsDisplayController()
                vc_1.isAttachInTabBar = self.isAttachInTabBar
                vc_1.code = code
                vc_1.lotType = lotType
                let vc_2 = LotteryTrendChartWanWeiController()
                vc_2.isAttachInTabBar = self.isAttachInTabBar
                vc_2.code = code
                vc_2.lotType = lotType
                let vc_3 = LotteryTrendChartQianWeiController()
                vc_3.isAttachInTabBar = self.isAttachInTabBar
                vc_3.code = code
                vc_3.lotType = lotType
                let vc_4 = LotteryTrendChartBaiWeiController()
                vc_4.isAttachInTabBar = self.isAttachInTabBar
                vc_4.code = code
                vc_4.lotType = lotType
                let vc_5 = LotteryTrendChartShiWeiController()
                vc_5.isAttachInTabBar = self.isAttachInTabBar
                vc_5.code = code
                vc_5.lotType = lotType
                let vc_6 = LotteryTrendChartGeweiController()
                vc_6.isAttachInTabBar = self.isAttachInTabBar
                vc_6.code = code
                vc_6.lotType = lotType
                vcs = [vc_1, vc_2, vc_3, vc_4, vc_5, vc_6]
            }else if lotType == "6"
            {
                //六合彩
                if let vc = vcs[0] as? LotteryResultsDisplayController {
                    vc.isAttachInTabBar = self.isAttachInTabBar
                    vc.code = code
                    vc.lotType = lotType
                    titles = [""]
                    layoutParameter.titleBarHeight = 0
                }
//                (vcs[0] as! LotteryResultsDisplayController).code = code
//                titles = [""]
//                layoutParameter.titleBarHeight = 0
                /// 北京赛车， 幸运飞艇。。。
            }else if lotType == "3"
            {
                titles = ["开奖","冠军走势", "亚军走势", "季军走势", "第四走势", "第五走势", "第六走势", "第七走势", "第八走势", "第九走势", "第十走势"]
                vcs = [LotteryResultsDisplayController(), LotteryTrendChartWanWeiController(), LotteryTrendChartQianWeiController(), LotteryTrendChartBaiWeiController(), LotteryTrendChartShiWeiController(), LotteryTrendChartGeweiController(), LotteryTrendChartSixthController(), LotteryTrendChartSeventhController(), LotteryTrendChartEighthController(), LotteryTrendChartNinethController(), LotteryTrendChartTenthController()]
                for i in 0 ... 10 {
                    if i == 0 {
                        (vcs[i] as! LotteryResultsDisplayController).isAttachInTabBar = self.isAttachInTabBar
                        (vcs[i] as! LotteryResultsDisplayController).code = code
                        (vcs[i] as! LotteryResultsDisplayController).lotType = lotType
                    }
                    else {
                        (vcs[i] as! LotteryResultsTrendChartBasicController).isAttachInTabBar = self.isAttachInTabBar
                        (vcs[i] as! LotteryResultsTrendChartBasicController).code = code
                        (vcs[i] as! LotteryResultsTrendChartBasicController).lotType = lotType
                    }
                }
                layoutParameter.titleBarHeight = 40
                ///快3
            }else if lotType == "4" || lotType == "8"
            {
                titles = ["开奖", "百位走势", "十位走势", "个位走势" ]
                let vc1 = LotteryResultsDisplayController()
                vc1.isAttachInTabBar = self.isAttachInTabBar
                vc1.code = code
                vc1.lotType = lotType
                let vc2 = LotteryTrendChartWanWeiController()
                vc2.isAttachInTabBar = self.isAttachInTabBar
                vc2.code = code
                vc2.lotType = lotType
                let vc3 = LotteryTrendChartQianWeiController()
                vc3.isAttachInTabBar = self.isAttachInTabBar
                vc3.code = code
                vc3.lotType = lotType
                let vc4 = LotteryTrendChartBaiWeiController()
                vc4.isAttachInTabBar = self.isAttachInTabBar
                vc4.code = code
                vc4.lotType = lotType
                vcs = [vc1, vc2, vc3, vc4]
                layoutParameter.titleBarHeight = 40
            }else if lotType == "7" || lotType == "9"
            {
                titles = []
                layoutParameter.titleBarHeight = 0
                let vc = LotteryResultsDisplayController()
                vc.isAttachInTabBar = self.isAttachInTabBar
                vc.code = code
                vc.lotType = lotType
                vcs = [vc]
            }
        }
    }
    
    
    //////////////////////////////////////////////////
    //MARK: - 获取数据
    func publicLoadLotteryResults(pageNumber: Int, code:String) {
        
        LennyNetworkRequest.obtainLotteryResults(pageNumber: pageNumber, gameCode: code) { [weak self](model) in
            DispatchQueue.main.async {
                if model == nil{
                    return
                }
                if model?.content == nil{
                    return
                }
                if model?.content?.history == nil{
                    return
                }
                if model?.content?.history?.list == nil{
                    return
                }
                
                if model?.content?.codeRank == nil{
                    return
                }
                
                self?.analysis(list: (model!.content?.history?.list)!,codeRankList: (model!.content?.codeRank)!, pageNumber: pageNumber )//解析
            }
        }
    }
    
    //解析请求数据结果 AllLotteryResultsModel
    func analysis(list:[AllLotteryResultsList],codeRankList:[AllLotteryResultsCodeRank],pageNumber: Int) {
        if list.count == 0 {
            print("没有更多数据")
        }else {
            LotteryResultsInstance.shared.dataArr = list
            LotteryResultsInstance.shared.codeRands = codeRankList
            LotteryResultsInstance.shared.pageNum = 2
        }
    }
    //////////////////////////////////////////////////
    //MARK: - 生命周期
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        setViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    //MARK: - UI
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
            self.navigationItem.rightBarButtonItems = [menuBtn]
        }
    }
    
    private func setPageView() {
        
        layoutParameter.titles = titles
        mainPageView.layoutParam = layoutParameter
    }
    
    private func setViews() {
        contentView.addSubview(button_Selecter)
        button_Selecter.whc_Height(45).whc_Left(0).whc_Right(0)
        
        setThemeViewNoTransparentDefaultGlassBlackOtherGray(view: button_Selecter)
        setThemeButtonTitleColorGlassWhiteOtherBlack(button: button_Selecter)
        
        if glt_iphoneX {button_Selecter.whc_Top(24)} else {button_Selecter.whc_Top(0)}
        selectedIndex = 0
        button_Selecter.setTitle(kLenny_LotteryTypes[selectedIndex], for: .normal)
//        button_Selecter.setTitleColor(UIColor.ccolor(with: 51, g: 51, b: 51), for: .normal)
        button_Selecter.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button_Selecter.setImage(UIImage(named: "pulldown"), for: .normal)
        button_Selecter.imageEdgeInsets = UIEdgeInsetsMake(0, MainScreen.width - 30, 0, 0)
        button_Selecter.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, MainScreen.width - 120)
//        button_Selecter.setTitleShadowColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .highlighted)
        button_Selecter.addTarget(self, action: #selector(button_SelectorClickHandle), for: .touchUpInside)
//        button_Selecter.isSkeletonable = true
        let viewS = UIView()
        contentView.addSubview(viewS)
        viewS.whc_Top(0, toView: button_Selecter).whc_Left(0).whc_Right(0).whc_Height(5)
//        viewS.backgroundColor = UIColor.ccolor(with: 237, g: 237, b: 237)
        setViewBackgroundColorTransparent(view: viewS)
//        viewS.isSkeletonable = true
        
//        view.isSkeletonable =  true
        contentView.addSubview(mainPageView)
        mainPageView.delegate = self
        mainPageView.whc_Top(0, toView: viewS).whc_Left(0).whc_Right(0).whc_Bottom(0)
//        mainPageView.isSkeletonable = true
//        contentView.isSkeletonable = true
        
        layoutParameter.titles = titles
        layoutParameter.itemWidth = 100 //上方 每个item滚动条的宽度
        layoutParameter.canChangeBackColor = true
        layoutParameter.selectedTextColor = UIColor.mainColor()
        layoutParameter.normalBackgorundColor = UIColor.white.withAlphaComponent(0.0)
        layoutParameter.normalTextColor = UIColor.black
        layoutParameter.selectedBackgorundColor = UIColor.white.withAlphaComponent(0.0)
        layoutParameter.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        layoutParameter.titleBarHeight = 40
        layoutParameter.normalTextColor = UIColor.black
        layoutParameter.cursorColor = UIColor.mainColor()
        
        let anima = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight, duration: 0.9)
        contentView.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient.init(baseColor: UIColor.cc_224(), secondaryColor: UIColor.cc_191()), animation: anima)
    }
    
    //MARK: - 点击事件
    //MARK: 切换彩种的点击
    @objc private func button_SelectorClickHandle() {
        if (isSelect == false) {
            isSelect = true
            showSelectedView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }
    }
    
    private func showSelectedView() {
        if self.isSelectedEnd == false {
            return
        }
        self.isSelectedEnd = false
        
        let selectedView = LennySelectView(dataSource: lotteryTypes, viewTitle: "彩种类型")
        
        selectedView.selectedIndex = self.selectedIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.button_Selecter.setTitle(selectedView.kLenny_InsideDataSource[index], for: .normal)
            self?.selectedIndex = index
            self?.lotType = LennyModel.allLotteryTypesModel?.obtainAllLotteryWithIndex()[index].lotType
            self?.code = LennyModel.allLotteryTypesModel?.obtainAllLotteryWithIndex()[index].code
            self?.setPageView()
        }
        view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (make) in
            self.isSelectedEnd = true
        }
    }
    
    //MARK: - 数据
    func loadData() {
        adjustRightBtn()
        
        LennyNetworkRequest.obtainAllLotteryTypes(version: 0) { [weak self](model) in
            
            self?.button_Selecter.isEnabled = true
            self?.lotteryTypes = [String]()
            
            var index = 0
            var selectedCodeName = ""
            
            if model == nil {return}
            for sub: AllLotteryTypesSubData in (model?.obtainAllLotteryWithIndex())! {
                self?.lotteryTypes.append(sub.name!)
                //                print(sub.name! + "----" + sub.code!)
                if sub.code == self?.code {
                    selectedCodeName = sub.name!
                }
                index += 1
            }
            
            var indexOfName = 0
            for sub: String in (self?.lotteryTypes)! {
                if sub == selectedCodeName {
                    self?.selectedIndex = indexOfName
                    self?.button_Selecter.setTitle(selectedCodeName, for: .normal)
                }
                indexOfName += 1
            }
            
            if self?.lotteryTypes.count == 0 { return }
            self?.contentView.hideSkeleton()
            self?.setPageView()
        }
    }
    
}

extension LotteryResultsController: WHC_PageViewDelegate {
    
    //MARK: - <WHC_PageViewDelegate>
    // //开奖、走势 的 titleView,设置时，触发该代理方法
    func whcPageViewStartLoadingViews() -> [UIView]! {
        if lotType == "1" || lotType == "2" || lotType == "5" {
            return [vcs[0].view, vcs[1].view, vcs[2].view, vcs[3].view, vcs[4].view, vcs[5].view]
        }else if lotType == "6" {
            return [vcs[0].view]
        }
        
        var arr = [UIView]()
        for vc in vcs {
            arr.append(vc.view)
        }
        return arr
    }
    
    func whcPageView(_ pageView: WHC_PageView, willUpdateView view: UIView, index: Int) {
        if index == 0 {
            vcs[0].refreshTableViewData()
        }else {
            if let vc = vcs[index] as? LotteryResultsTrendChartBasicController {
                vc.dataArr = LotteryResultsInstance.shared.dataArr
                vc.codeRands = LotteryResultsInstance.shared.codeRands
                if vc.pageIndex > (vc.codeRands.count - 1) {return}
                vc.codeRankArr = (Array)(vc.codeRands[vc.pageIndex].CodeNums!)
                vc.refreshTableViewData()
            }
        }
    }
}

extension LotteryResultsController: SGPageTitleViewDelegate {
    
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        mainContentView?.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
}
extension LotteryResultsController: SGPageContentScrollViewDelegate {
    
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        mainTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}

