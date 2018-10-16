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
    @IBOutlet weak var awardOrderView:MarqueeView!
    @IBOutlet weak var v1:UILabel!
    @IBOutlet weak var v2:UILabel!
    @IBOutlet weak var toastView:UIView!
    
    @IBOutlet weak var infoLabel1: UILabel!//抽奖资格
    @IBOutlet weak var infolabel2: UILabel!//活去规则
    @IBOutlet weak var infolabel3: UILabel!//活动申明
//    var model = DazhuanpanContent()
    
    
    var controller:BaseController!
    var delegate:BigPanFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        getData()
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        getData()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.getData()
        startBtn.addTarget(self, action: #selector(onStartClick), for: .touchUpInside)
    }
    
    func getData() {
        let vc = BaseController()
        vc.request(frontDialog: false, url:BIGWHELL,
                   callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
//                    print(resultJson)
                    if let result = DazhuanpanModel.deserialize(from: resultJson){
                        if result.success{
//                            self.model.condition = result.content?.condition!
//                            self.model.rule = result.content?.rule!
//                            self.model.remark = result.content?.remark!
                            
                            self.infoLabel1.text = result.content?.condition!
                            self.infolabel2.text = result.content?.rule!
                            self.infolabel3.text = result.content?.remark!
                        }
                    }
        })
    }
    
    @objc func onStartClick() -> Void {
        if let delegate = self.delegate{
            delegate.onChouJianEvent()
        }
    }
    
    func actionAwardRecord(controller:BaseController,activeId:Int64) -> Void {
        
        //"activeId":activeId,
//        let params = ["begin":"2018-01-01 00:00:00","end":getTodayZeroTime()] as [String : Any] as [String : Any]
        let params = ["activeId":activeId] as [String : Any]
        controller.request(frontDialog: false,method: .post, url:BIG_WHEEL_AWARD_RECORD_URL,params:params,
               callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    return
                }
                if let result = AwardRecordWraper.deserialize(from: resultJson){
                    if result.success{
                        YiboPreference.setToken(value: result.accessToken as AnyObject)
                        guard let records = result.content else {return}
                        let str = self.formAwardRecordStr(records: records)
                        self.awardOrderView.setupView(title: str)
                        self.awardOrderView.backgroundColor = UIColor.clear
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
//            let a = hideChar(str: record.account, showBackCharCount: 3)
            let a = record.username
            sb = sb + (!isEmptyString(str: a) ? a : "暂无姓名")
            sb = sb + "    "
            sb = sb + record.itemName + "    "
            sb = sb + record.winTime + ";    "
        }
        return sb
    }

    
}
