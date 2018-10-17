//
//  BigPanFooterView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/28.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol BigPanFooterDelegate {
    func onChouJianEvent()
}

class BigPanFooterView: UIView {

    @IBOutlet weak var startBtn:UIButton!
    @IBOutlet weak var awardView:UIView!
    @IBOutlet weak var awardOrderView:JXMarqueeView!
//    @IBOutlet weak var v1:UILabel!
//    @IBOutlet weak var v2:UILabel!
//    @IBOutlet weak var toastView:UIView!
    
    @IBOutlet weak var rulesTV:UITextView!
    
//    @IBOutlet weak var activity_rule:UILabel!
//    @IBOutlet weak var activity_condition:UILabel!
//    @IBOutlet weak var activity_notices:UILabel!
    
    var controller:BaseController!
    var delegate:BigPanFooterDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        startBtn.addTarget(self, action: #selector(onStartClick), for: .touchUpInside)
    }
    
    func onStartClick() -> Void {
        if let delegate = self.delegate{
            delegate.onChouJianEvent()
        }
    }
    
    func updateActivitys(rule:String,condition:String,notices:String){
//        activity_rule.text = rule
//        activity_condition.text = condition
//        activity_notices.text = notices
        var str = "活动规则:\n\n";
        str += rule+"\n\n\n"
        str += "抽奖资格:\n\n";
        str += condition+"\n\n\n";
        str += "活动声明:\n\n"
        str += notices+"\n\n\n"
        rulesTV.text = str
    }
    
    //更新中奖名单
    func updateAwardOrders(str:String) -> Void {
        
        if isEmptyString(str: str){
            return
        }
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        do{
            let attrStr = try NSAttributedString.init(data: str.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
            label.attributedText = attrStr
        }catch{
            print(error)
        }
        awardOrderView.contentView = label
        awardOrderView.backgroundColor = UIColor.clear
        awardOrderView.contentMargin = 50
        awardOrderView.marqueeType = .left
    }
    
    func actionAwardRecord(controller:BaseController,activeId:Int64) -> Void {
        controller.request(frontDialog: false,method: .post, url:BIG_WHEEL_AWARD_RECORD_URL,params:["activeId":activeId],
               callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    return
                }
                if let result = AwardRecordWraper.deserialize(from: resultJson){
                    if result.success{
                        YiboPreference.setToken(value: result.accessToken as AnyObject)
                        guard let records = result.content else {return}
                        let str = self.formAwardRecordStr(records: records)
                        self.updateAwardOrders(str: str)
                    }else{
                        if !isEmptyString(str: result.msg){
                            showToast(view: controller.view, txt: result.msg)
                        }else{
                            showToast(view: controller.view, txt: convertString(string: "获取失败"))
                        }
                        if (result.code == 0) {
                            loginWhenSessionInvalid(controller: controller)
                        }
                    }
                }
        })
    }
    
    func formAwardRecordStr(records:[ActiveRecord]) -> String {
        if records.isEmpty{
            return "暂无中奖名单"
        }
        var sb = ""
        for record in records{
            let a = hideChar(str: record.account, showBackCharCount: 3)
            sb = sb + (!isEmptyString(str: a) ? a : "暂无姓名")
            sb = sb + "    "
            sb = sb + record.productName + "    "
            sb = sb + timeStampToString(timeStamp: record.createDatetime) + ";    "
        }
        return sb
    }

    
}
