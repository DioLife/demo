//
//  AppSettingCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class AppSettingCell: UITableViewCell {
    
    @IBOutlet weak var txt:UILabel!
    @IBOutlet weak var exitlogin:UILabel!
    @IBOutlet weak var moreImg:UIImageView!
    @IBOutlet weak var toggle:UISwitch!
    @IBOutlet weak var defaultName:UILabel!
    
    func onSwitchAction(view:UISwitch) -> Void {
        print("on switch action ,tag = \(view.tag)")
        print("view is on === \(view.isOn)")
        if view.tag == 0{
            YiboPreference.saveAutoLoginStatus(value: view.isOn as AnyObject)
        }else if view.tag == 1{
            YiboPreference.saveShakeTouzhuStatus(value: view.isOn as AnyObject)
        }else if view.tag == 2{
            YiboPreference.setPlayTouzhuVolume(value: view.isOn as AnyObject)
        }
    }
    
}
