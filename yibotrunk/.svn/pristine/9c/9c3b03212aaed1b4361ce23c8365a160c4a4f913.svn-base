//
//  ClassicPayCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class ClassicPayCell: UITableViewCell {
    
    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var name:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func fixPayIconWithPayType(iconCss:String) -> String {
        if isEmptyString(str: iconCss){
            return ""
        }
        switch iconCss {
        case "wechat":
            return "/native/resources/images/weixin.jpg"
        case "alipay":
            return "/native/resources/images/zhifubao.jpg"
        case "qq":
            return "/native/resources/images/qqpay.png"
        case "jd":
            return "/native/resources/images/jdpay.jpg"
        case "baidu":
            return "/native/resources/images/baidu.jpg"
        case "union":
            return "/native/resources/images/union.jpg"
        default:
            return ""
        }
    }
    

    func setData(online:OnlinePay){
        let payStr =  String.init(format: "(最小充值金额%d元)", online.minFee)
        name.text = payStr
        img?.contentMode = UIViewContentMode.scaleAspectFit
        var icon = online.icon
        if !isEmptyString(str: icon){
            icon = icon.trimmingCharacters(in: .whitespaces)
            if let imageURL = URL(string: icon){
                img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "deault_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }else{
            let icon = fixPayIconWithPayType(iconCss: online.iconCss)
            if isEmptyString(str: icon){
                img.image = UIImage.init(named: "deault_pay_icon")
            }else{
                let fixurl = String.init(format: "%@%@%@", BASE_URL,PORT,icon)
                let imageURL = URL(string: fixurl)!
                img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    func setData(fast:FastPay){
        
        var payStr = !isEmptyString(str: fast.payName) ? fast.payName : "暂无支付名称"
        payStr = payStr + String.init(format: "(最小充值金额%d元)", fast.minFee)
        name.text = payStr
        img?.contentMode = UIViewContentMode.scaleAspectFit
        var icon = fast.icon
        if !isEmptyString(str: icon){
            icon = icon.trimmingCharacters(in: .whitespaces)
            if let imageURL = URL(string: icon){
                img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "deault_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }else{
            var url = fixPayIconWithPayType(iconCss: fast.iconCss)
            if isEmptyString(str: url){
                img.image = UIImage.init(named: "deault_pay_icon")
            }else{
                if !url.starts(with: "http://") && !url.starts(with: "https://"){
                    url = String.init(format: "%@%@%@", BASE_URL,PORT,url)
                }
                if let imageURL = URL(string: url){
                    img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "deault_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
    }
    
    func setData(bank:BankPay){
        let payStr =  String.init(format: "(最小充值金额%d元)", bank.minFee)
        name.text = payStr
        img?.contentMode = UIViewContentMode.scaleAspectFit
        var icon = bank.icon
        if !isEmptyString(str: icon){
            icon = icon.trimmingCharacters(in: .whitespaces)
            if let imageURL = URL(string: icon){
                img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "deault_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }else{
            var url = fixPayIconWithPayType(iconCss: bank.iconCss)
            if isEmptyString(str: url){
                img.image = UIImage.init(named: "deault_pay_icon")
            }else{
                if !url.starts(with: "http://") && !url.starts(with: "https://"){
                    url = String.init(format: "%@%@%@", BASE_URL,PORT,url)
                }
                if let imageURL = URL(string: url){
                    img.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "deault_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
    }

}
