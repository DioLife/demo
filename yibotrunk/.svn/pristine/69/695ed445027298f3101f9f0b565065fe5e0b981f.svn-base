//
//  RainPackageController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/27.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//红包雨页面
class RainPackageController: BaseController {
    
    @IBOutlet weak var awardResultView:JXMarqueeView!
    @IBOutlet weak var awardHeight:NSLayoutConstraint!
//    var rainView:AxcRedEnvelopeView!
    var redPacketId = 0
    
    var timer:Timer = Timer.init()//定时器
    var moveLayer :CALayer = CALayer.init()//动画layer
    var tapGesture:UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitle(title: "抢红包")
        let bg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        bg.image = UIImage.init(named: "rp_bg")
        self.view.addSubview(bg)
        tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickEvent(ui:)))
        self.view.addGestureRecognizer(tapGesture)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        loadWebData()
    }
    
    func clickEvent(ui:UITapGestureRecognizer) -> Void {
        print("click event ")
        grabPacket()
    }
    
    func beginRain() {
        //防止timer重复添加
        self.timer.invalidate()
        self.timer =  Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showRain), userInfo: "", repeats: true)
    }
    
    func showRain(){
        
        //创建画布
        let imageV = UIImageView.init()
        imageV.isUserInteractionEnabled = true
        imageV.image = UIImage.init(named: "rob_rp")
        imageV.frame = CGRect.init(x: 0, y: 0, width: 60, height: 64.5)
        //这里把这句消除动画有问题
        self.moveLayer = CALayer.init()
        self.moveLayer.bounds = (imageV.frame)
        self.moveLayer.anchorPoint = CGPoint.init(x: 0, y: 0)
        //此处y值需比layer的height大
        self.moveLayer.position = CGPoint.init(x:0,y:-64.5)
        self.moveLayer.contents = imageV.image!.cgImage
        
        self.view.layer.addSublayer(self.moveLayer)
        //画布动画
        self.addAnimation()
        
    }
    
    //给画布添加动画
    func addAnimation() {
        //此处keyPath为CALayer的属性
        let  moveAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath:"position")
        //动画路线，一个数组里有多个轨迹点
        moveAnimation.values = [NSValue(cgPoint: CGPoint.init(x:CGFloat(Float(arc4random_uniform(320))), y:10)),NSValue(cgPoint: CGPoint.init(x:CGFloat(Float(arc4random_uniform(160))), y:300)),NSValue(cgPoint: CGPoint.init(x:CGFloat(Float(arc4random_uniform(240))), y:400)),NSValue(cgPoint: CGPoint.init(x:CGFloat(Float(arc4random_uniform(480))), y:500)),NSValue(cgPoint: CGPoint.init(x:CGFloat(Float(arc4random_uniform(320))), y:800))]
        //动画间隔
        moveAnimation.duration = 5
        moveAnimation.rotationMode = kCAAnimationRotateAutoReverse
        //重复次数
        moveAnimation.repeatCount = 3
        //动画的速度
        moveAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.moveLayer.add(moveAnimation, forKey: "move")
    }
    
    func loadWebData() -> Void {
        request(frontDialog: true,method: .post, loadTextStr:"获取红包数据中...", url:VALID_RED_PACKET_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = RedPacketWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let redPacket = result.content else {return}
                            self.redPacketId = redPacket.id
                            self.updateTitle(title:!isEmptyString(str: redPacket.title) ? redPacket.title : "抢红包")
                            self.beginRain()
                            //异步获取当前用户已抢的红包金额
                            self.grabFakeRecord()
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func grabPacket() -> Void {
        request(frontDialog: true,method: .post, loadTextStr:"抢红包中...", url:GRAB_RED_PACKET_URL,params:["redPacketId":self.redPacketId],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "抢红包失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = GrabPacketWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let money = result.content else {return}
                            if money > 0{
                                self.showGrabDialog(money: money)
                            }
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "抢红包失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func showGrabDialog(money:Float) -> Void {
        let message = String.init(format: "恭喜您抢到了%.2f元", money)
        let alertController = UIAlertController(title: "温馨提示",
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func grabFakeRecord() -> Void {
        request(frontDialog: true,method: .post, loadTextStr:"获取记录中...", url:FAKE_PACKET_DATAS,params:["redPacketId":self.redPacketId],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = FakePacketModelWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            guard let redPacket:[FakePacketModel] = result.content else {return}
                            self.createScrollTxt(record:redPacket)
                        }else{
                            if let errorMsg = result.msg{
                                Tool.confirm(title: "对不起", message: errorMsg, controller: self)
                            }else{
                                Tool.confirm(title: "对不起", message: "获取失败", controller: self)
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func createScrollTxt(record:[FakePacketModel]) -> Void {
        var txt = ""
        if !record.isEmpty{
//            for item in 0...record.count-1{
//                txt = txt + hideTailChar(str: record[item].account, showCount: 4)
//                txt = txt + ":" + String.init(format: "%.2f元", record[item].money)+"    "
//            }
            for model in record{
                txt = txt + model.account
                txt = txt + ":" + String.init(format: "%.2f元", model.money)+"               "
                if txt.count > 2500{
                    break;
                }
            }
        }
        if !isEmptyString(str: txt){
            self.awardResultView.isHidden = false
            self.updateAwardOrders(str: txt)
        }else{
            self.awardResultView.isHidden = true
//            self.awardHeight.constant = -30
        }
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
        awardResultView.contentView = label
        awardResultView.backgroundColor = UIColor.clear
        awardResultView.contentMargin = 50
        awardResultView.marqueeType = .left
        
//        let label = UILabel()
//        do{
//            let attrStr = try NSAttributedString.init(data: str.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
//            label.attributedText = attrStr
//            label.textColor = UIColor.black
//            label.font = UIFont.boldSystemFont(ofSize: 18)
//        }catch{
//            print(error)
//        }
//        awardResultView.contentView = label
//        awardResultView.backgroundColor = UIColor.clear
//        awardResultView.contentMargin = 50
//        awardResultView.marqueeType = .left
    }
    
    func updateTitle(title:String) -> Void {
        self.navigationItem.title = title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
        //停止所有layer的动画
        for item in self.view.layer.sublayers!{
            item.removeAllAnimations()
        }
    }
}
