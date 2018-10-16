//
//  ConfirmTouzhCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class ConfirmTouzhCell: UITableViewCell {
    
    @IBOutlet weak var playUI:UILabel!
    @IBOutlet weak var numUI:UILabel!
    @IBOutlet weak var beishuUI:UILabel!
    @IBOutlet weak var moneyUI:UILabel!
    @IBOutlet weak var deleteUI:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data:OrderDataInfo) -> Void {
        playUI.text = String.init(format: "%@-%@", data.subPlayName,data.oddsName)
        numUI.text = !isEmptyString(str: data.numbers) ? data.numbers : "暂无号码"
        beishuUI.text = String.init(format: "%d倍%@", data.beishu,convert_mode(mode: data.mode))
//        moneyUI.text = String.init(format: "%d注%.2f元", data.zhushu,convert_moneyOfMode(mode: data.mode, money: data.money))
        moneyUI.text = String.init(format: "%d注%.2f元", data.zhushu,data.money)
    }
    
    func convert_moneyOfMode(mode: Int, money: Double) -> Double{
        return money / Double(mode)
    }
    
    func convert_mode(mode:Int) -> String {
        if mode == 1{
            return "元模式"
        }else if mode == 10{
            return "角模式"
        }else if mode == 100{
            return "分模式"
        }
        return ""
    }

}
