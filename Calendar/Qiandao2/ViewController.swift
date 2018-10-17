//
//  ViewController.swift
//  Qiandao2
//
//  Created by William on 2018/8/14.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CalenderControllerDelegate {
    
    func didSelectData(year: Int, month: Int, day: Int) {
        let timeString = String.init(format: "%d 年 %d 月 %d 日", year,month,day)
        print(timeString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "日历", style: UIBarButtonItemStyle.plain, target: self, action: #selector(jump))
    }
    
    @objc func jump(){
        let vc = CalenderController();
        vc.delegate = self;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

