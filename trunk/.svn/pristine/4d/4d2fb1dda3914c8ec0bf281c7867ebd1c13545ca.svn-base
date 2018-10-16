//
//  TNBasicViewController.swift
//  LSTodaysNews
//
//  Created by Lenny on 2018/2/25.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit
import SkeletonView

class LennyBasicViewController: BaseMainController {

    var contentView: UIView!
    var bottomView: UIView!
    var topView: UIView!

    var hasNavigationBar: Bool {
        return true
    }
    var hasBottomTabbar: Bool {
        return false
    }
    var hasTopView: Bool {
        return false
    }
    var hasBottomView: Bool {
        return false
    }
    var topViewHeight: CGFloat {
        return 0.0
    }
    var bottomViewHeight: CGFloat {
        return 0.0
    }
    var navigationBarHeight: CGFloat {
        return 64
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addViews()
    }
    
    final private func addViews() {
        
        //用来将self.view的位置延伸到屏幕顶部
        self.edgesForExtendedLayout = .all
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.contentView = UIView()
        self.view.addSubview(contentView)
        setViewBackgroundColorTransparent(view: contentView)
        contentView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        if hasTopView {
            topView = UIView()
            self.view.addSubview(topView)
            setViewBackgroundColorTransparent(view: topView)
            if hasNavigationBar {
                topView.whc_Top(navigationBarHeight).whc_Left(0).whc_Right(0).whc_Height(topViewHeight)
            }else {
                topView.whc_Top(0).whc_Left(0).whc_Right(0).whc_Height(topViewHeight)
            }
        }
        if hasBottomView {
            bottomView = UIView()
            setViewBackgroundColorTransparent(view: bottomView)
            self.view.addSubview(bottomView)
            if hasBottomTabbar {
                bottomView.whc_Left(0).whc_Right(0).whc_Bottom(49).whc_Height(bottomViewHeight)
            }else {
                bottomView.whc_Left(0).whc_Right(0).whc_Bottom(0).whc_Height(bottomViewHeight)
            }
        }
        if hasNavigationBar && hasBottomTabbar {
            contentView.whc_Top(navigationBarHeight + topViewHeight).whc_Left(0).whc_Right(0).whc_Bottom(bottomViewHeight + 49)
        }else if !hasBottomTabbar && hasNavigationBar{
            contentView.whc_Top(navigationBarHeight + topViewHeight).whc_Left(0).whc_Right(0).whc_Bottom(0)
        }else if hasNavigationBar {
            contentView.whc_Top(navigationBarHeight + topViewHeight).whc_Left(0).whc_Right(0).whc_Bottom(bottomViewHeight)
        }else if hasBottomTabbar {
            contentView.whc_Top(topViewHeight).whc_Left(0).whc_Right(0).whc_Bottom(49 + bottomViewHeight)
        }
        
    }
    ///子类，手动刷新TableView，重载这个方法去自定义
    func refreshTableViewData() {}
    
    private var isSetViews: Bool = false
    func setStaticViewsAndContent() {
        if isSetViews { return }
        else { isSetViews = true }
    }
    var skeletonAnimation: SkeletonLayerAnimation {
        return SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight, duration: 0.9)
    }
    
    func loadNetRequestWithViewSkeleton(animate: Bool) {
        
//        view.isSkeletonable = animate
//        contentView.isSkeletonable = animate
//        if animate {
//            view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient.init(baseColor: UIColor.cc_224(), secondaryColor: UIColor.cc_191()), animation: skeletonAnimation)
//        }
    }
    
    @objc override func onBackClick(){
        if self.navigationController != nil{
            let count = self.navigationController?.viewControllers.count
            if count! > 1{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
