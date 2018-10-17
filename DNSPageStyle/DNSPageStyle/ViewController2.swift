//
//  ViewController2.swift
//  DNSPageStyle
//
//  Created by William on 2018/10/16.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit
import DNSPageView

class ViewController2: UIViewController {

    @IBOutlet weak var titleView: DNSPageTitleView!
    @IBOutlet weak var contentView: DNSPageContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isShowBottomLine = true
        style.titleViewBackgroundColor = UIColor.clear
        style.isShowCoverView = false
        style.isTitleViewScrollEnabled = false
        
        // 设置标题内容
        let titles = ["头条", "视频"]
        
        // 设置默认的起始位置
        let startIndex = 0
        
        // 对titleView进行设置
        titleView.titles = titles
        titleView.style = style
        titleView.currentIndex = startIndex
        
        // 最后要调用setupUI方法
        titleView.setupUI()
        
        
        // 创建每一页对应的controller
  //      let childViewControllers: [ContentViewController] = titles.map { _ -> ContentViewController in
    //        let controller = ContentViewController()
      //      controller.view.backgroundColor = UIColor.orange
     //       return controller
    //    }
        /*** 上下两段代码功能相同 ***/
        let oneVC = OneViewController()
        let twoVC = TwoViewController()
        let childViewControllers = [oneVC, twoVC]
        
        // 对contentView进行设置
        contentView.childViewControllers = childViewControllers
        contentView.startIndex = startIndex
        contentView.style = style
        
        // 最后要调用setupUI方法
        contentView.setupUI()
        
        // 让titleView和contentView进行联系起来
        titleView.delegate = contentView
        contentView.delegate = titleView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
