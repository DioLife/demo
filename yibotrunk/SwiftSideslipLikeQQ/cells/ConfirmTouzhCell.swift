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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data:OrderDataInfo) -> Void {
        playUI.text = String.init(format: "%@-%@", data.playName,data.subPlayName)
        numUI.text = !isEmptyString(str: data.numbers) ? data.numbers : "暂无号码"
        beishuUI.text = String.init(format: "%d倍%@", data.beishu,convert_mode(mode: data.mode))
        moneyUI.text = String.init(format: "%d注%.2f元", data.zhushu,data.money)
    }
    
    func convert_mode(mode:Int) -> String {
        if mode == YUAN_MODE{
            return "元模式"
        }else if mode == JIAO_MODE{
            return "角模式"
        }else if mode == FEN_MODE{
            return "分模式"
        }
        return ""
    }

}
