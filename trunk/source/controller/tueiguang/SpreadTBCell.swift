//
//  SpreadTBCell.swift
//  gameplay
//
//  Created by William on 2018/8/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

protocol DelegateSpreadTBCell:NSObjectProtocol {
    //设置协议方法
    func queryDetail(datasoure:[String]) // 查看详情
    func deleteUrl(index:Int, num:Int) //删除推广链接
}

class SpreadTBCell: UITableViewCell {
    
    weak var delegate:DelegateSpreadTBCell?
    
    private var mymodel:DailiModel!
    private var num:Int!
    
    @IBOutlet weak var tueiguangLb: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var maiLB: UILabel!
    @IBOutlet weak var rebackLB: UILabel!
    @IBOutlet weak var ordinaryUrl: UILabel!
    @IBOutlet weak var copyputongUrl: UIButton!
    @IBOutlet weak var queryBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        copyputongUrl.addTarget(self, action: #selector(copyputongUrlAction(btn:)), for: UIControlEvents.touchUpInside)
        queryBtn.addTarget(self, action: #selector(queryDetail(btn:)), for: UIControlEvents.touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteMethod), for: UIControlEvents.touchUpInside)
    }
    
    @objc func deleteMethod(){
        self.delegate?.deleteUrl(index: self.mymodel.id!, num: self.num!)
    }
    
    @IBAction func copyTueiguangMa(_ sender: UIButton) {
        UIPasteboard.general.string = maiLB.text
        showToast(view: self.contentView, txt: convertString(string: "复制成功"))
    }
    @objc func copyputongUrlAction(btn:UIButton){
        UIPasteboard.general.string = ordinaryUrl.text
        showToast(view: self.contentView, txt: convertString(string: "复制成功"))
    }
    
    
    @objc func queryDetail(btn:UIButton){//点击查看详情
        var arr = Array<String>()
        if let model = self.mymodel{
            arr.append("生成时间: \(model.createTime!)")
            arr.append("总访问量: \(model.accessNum!)")
            arr.append("注册人数: \(model.registerNum!)")
            arr.append("彩票返点: \(model.cpRolling!)‰")
            
            let system = getSystemConfigFromJson()
            let sport = system?.content.onoff_sport_switch
            let sbsport = system?.content.onoff_sb_switch
            let zhenren = system?.content.onoff_zhen_ren_yu_le
            let game = system?.content.onoff_dian_zi_you_yi
            
            if !isEmptyString(str: sport!) && sport == "on"{
                if model.sportRebate != nil {
                    arr.append("体育返点: \(model.sportRebate!)‰")
                }
            }
            if !isEmptyString(str: sbsport!) && sbsport == "on"{
                if model.sbSportRebate != nil {
                    arr.append("沙巴体育返点: \(model.sbSportRebate!)‰")
                }
            }
            if !isEmptyString(str: zhenren!) && zhenren == "on"{
                if model.realRebate != nil {
                    arr.append("真人返点: \(model.realRebate!)‰")
                }
            }
            if !isEmptyString(str: game!) && game == "on"{
                if model.egameRebate != nil {
                    arr.append("电子返点: \(model.egameRebate!)‰")
                }
            }
            delegate?.queryDetail(datasoure: arr)
        }
        
    }
    
    
    func addMst(model:DailiModel, num:Int) {
        self.mymodel = model
        self.num = num
        tueiguangLb.text = "推广\(num+1)" //model.registerNum!
        typeLB.text = getType(type: model.type!)
        maiLB.text = model.linkKey
        rebackLB.text = "\(model.cpRolling!)%"
        
        //loginWhenSessionInvalid(controller: self)
        
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let url = config.content.app_download_link_ios
                ordinaryUrl.text = url
            }
        }
//        ordinaryUrl.text = model.linkUrl
//        jiami.text = model.linkUrlEn
    }
    
    func getType(type:Int) -> String {
        switch type {
        case 1:
            return "会员"
        case 2:
            return "代理"
        default:
            print("类型错误 ========= ")
        }
        return "error"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
