//
//  TueijianViewController.swift
//  YiboGameIos
//
//  Created by William on 2018/10/16.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import DNSPageView
import SnapKit

class TueijianViewController: UIViewController {

//    @IBOutlet weak var titleView: DNSPageTitleView!
//    @IBOutlet weak var contentView: DNSPageContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的推荐"
        automaticallyAdjustsScrollViewInsets = false
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isShowBottomLine = true
        style.bottomLineColor = UIColor.red
        style.titleColor = UIColor.black
        style.titleSelectedColor = UIColor.red
        style.titleViewBackgroundColor = UIColor.clear
        style.isShowCoverView = false
        
        // 设置标题内容
        let titles = ["推荐信息", "添加会员"]
        // 设置默认的起始位置
        let startIndex = 0
        
        let titleView = DNSPageTitleView.init(frame: CGRect(x: 0, y: 0, width: 375, height: 50), style: style, titles: titles, currentIndex: startIndex)
        self.view.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(44)
        }
        
        let childViewControllers = [TueijianInfoViewController(),TueijianAddViewController()]
        let contentView = DNSPageContentView.init(frame: CGRect(x: 0, y: 0, width: 375, height: 50), style: style, childViewControllers: childViewControllers, startIndex: startIndex)
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView).offset(44)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
        
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
