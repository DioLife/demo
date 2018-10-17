//
//  GamePagesController.swift
//  YiboGameIos
//
//  Created by admin on 2018/6/30.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class GamePagesController: BaseMainController,UIPageViewControllerDataSource,UIScrollViewDelegate,MainViewDelegate,GamePagesChannelDelegate {
    
    @IBOutlet weak var containerConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var channelView: GamePagesChannelView!
    
    var lastContentOffset: CGFloat = 0.0
    
    var channels = ["彩票","真人","体育","电子"]
    
    var bannerHeaderView:MainHeaderView?
    
    var pageViewController: UIPageViewController!
    var controllers: NSMutableArray?
    
    var vc01 = UIStoryboard(name: "custom4", bundle: nil).instantiateViewController(withIdentifier: "GamePageChildController") as! GamePageChildController
    var vc02 = UIStoryboard(name: "custom4", bundle: nil).instantiateViewController(withIdentifier: "GamePageChildController") as! GamePageChildController
    var vc03 = UIStoryboard(name: "custom4", bundle: nil).instantiateViewController(withIdentifier: "GamePageChildController") as! GamePageChildController
    var vc04 = UIStoryboard(name: "custom4", bundle: nil).instantiateViewController(withIdentifier: "GamePageChildController") as! GamePageChildController
    
    var lastPage = 0
    var currentPage: Int = 0 {
        didSet {
            //根据currentPage 和 lastPage的大小关系，控制页面的切换方向
            if currentPage > lastPage {
                
                self.pageViewController.setViewControllers([controllers![currentPage] as! UIViewController], direction: .reverse, animated: true, completion: nil)
            }
            else {
                
                self.pageViewController.setViewControllers([controllers![currentPage] as! UIViewController], direction: .forward, animated: true, completion: nil)
            }
            
            lastPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeDataSource(notification:)), name:NSNotification.Name(rawValue: "collectionOffetYChange"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(childViewWillDisappearAction(notification:)), name:NSNotification.Name(rawValue: "childViewWillDisappear"), object: nil)
        
        self.containerConstraintHeight.constant = kScreenHeight - 149
        
        channelView.channels = channels
        channelView.delegate = self
        
        // 获取到嵌入到view的，pageviewcontroller
        self.pageViewController = self.childViewControllers.first as! UIPageViewController
        
        pageViewController.dataSource = self
        
        //手动为pageViewController提供提一个页面
        pageViewController.setViewControllers([vc01], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
        
        //把页面添加到数组中
        vc01.dataCode = CAIPIAO_MODULE_CODE
        vc02.dataCode = REAL_MODULE_CODE
        vc03.dataCode = SPORT_MODULE_CODE
        vc04.dataCode = GAME_MODULE_CODE
        controllers = [vc01,vc02,vc03,vc04]
        
        self.scrollView.addSubview(addBannerHeaderContent())
    }
    
    func childViewWillDisappearAction(notification: NSNotification) {
        self.scrollView.isScrollEnabled = true
    }
    
    func changeDataSource(notification: NSNotification) {
        let vc = self.controllers![currentPage] as! GamePageChildController
        self.scrollView.isScrollEnabled = true
        vc.gridview.isScrollEnabled = false
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        let vc = self.controllers![currentPage] as! GamePageChildController

        if (self.lastContentOffset > scrollView.contentOffset.y) {
            // 向下滚动
        } else if (self.lastContentOffset < scrollView.contentOffset.y) {
            // 向上滚动
            if offsetY > 296 {
                self.scrollView.isScrollEnabled = false
            }else {}
        }
        
        self.lastContentOffset = scrollView.contentOffset.y;
        vc.gridview.isScrollEnabled = !self.scrollView.isScrollEnabled;
    }
  
    //返回当前页面的下一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = controllers?.index(of: viewController) {
            if index == (controllers!.count - 1) || index == NSNotFound {
                channelView.selectedIndex = 3
                return nil
            }
            
            channelView.selectedIndex = index
            return ((controllers!.object(at: index + 1)) as! UIViewController)
        }else {return nil}
    }
    
    //返回当前页面的上一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = controllers?.index(of: viewController) {
            if index == 0 || index == NSNotFound {
                channelView.selectedIndex = 0
                return nil
            }
            
            channelView.selectedIndex = index
            return ((controllers!.object(at: index - 1)) as! UIViewController)
            
        }else {return nil}
    }
    
    // 添加头部视图
    func addBannerHeaderContent() -> UIView {
        if bannerHeaderView == nil{
            bannerHeaderView = Bundle.main.loadNibNamed("main_header", owner: nil, options: nil)?.first as? MainHeaderView
            bannerHeaderView?.mainDelegate = self
            if let view = bannerHeaderView{
                view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 260)
                //同步主界面头部的数据
                view.syncSomeWebData(controller: self)
                //根据后台配置切换优惠活动还是app下载
                view.updateFuncBtn()
            }
        }
        return bannerHeaderView!
    }
    
    // 点击banner
    func clickFunc(tag: Int) {
        switch tag {
        case 100,101:
            if let delegate = self.menuDelegate{
                delegate.menuEvent(isRight: true)
            }
        case 102:
            if isActiveShowFunc(){
                openActiveController(controller: self)
            }else{
                openAPPDownloadController(controller:self)
            }
        case 103:
            openContactUs(controller: self)
        default:
            break;
        }
    }
    
    func gamePagesChannelTap(_ channelView: GamePagesChannelView, forItemAt index: Int) {
        currentPage = index
    }
    
}
