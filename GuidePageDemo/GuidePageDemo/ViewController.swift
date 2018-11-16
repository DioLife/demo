//
//  ViewController.swift
//  GuidePageDemo
//
//  Created by hello on 2018/11/16.
//  Copyright © 2018 hello. All rights reserved.
//

import UIKit
import GuidePageView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 首页背景图
        let imageView = UIImageView.init(image: UIImage.init(named: "view_bg_image.png"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        
        // 引导页案例
        //        let gifArray = ["shopping.gif", "guideImage6.gif", "guideImage7.gif", "guideImage8.gif", "adImage3.gif", "adImage4.gif"]
        let imageArray = ["guideImage1.jpg", "guideImage2.jpg", "guideImage3.jpg", "guideImage4.jpg", "guideImage5.jpg"]
        //        let imageGifArray = ["guideImage1.jpg","guideImage6.gif","guideImage7.gif","guideImage3.jpg", "guideImage5.jpg"]
        let guideView = GuidePageView.init(images: imageArray, loginRegistCompletion: {
            print("登录/注册")
        }) {
            print("开始使用app")
        }
        self.view.addSubview(guideView)
    }


}

