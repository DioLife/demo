//
//  MainHeaderView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/24.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

//主界面固定视图，轮播，功能区，公告

protocol MainViewDelegate {
    func clickFunc(tag:Int)
}
class MainHeaderView: UIView , UrlJumpDelegate{
    
    @IBOutlet weak var cycleScrollView: WRCycleScrollView!
    //存取款，投注记录，优惠活动，在线客服等按钮
    @IBOutlet weak var helpUI:UIView!
    @IBOutlet weak var withdrawBtn: UIView!
    @IBOutlet weak var recordsBtn: UIView!
    @IBOutlet weak var activeBtn: UIView!
    @IBOutlet weak var activeImg: UIImageView!
    @IBOutlet weak var activeBadge:UIButton!
    @IBOutlet weak var activeTxt:UILabel!
    @IBOutlet weak var serviceBtn: UIView!
    @IBOutlet weak var noticeUI:JXMarqueeView!
    @IBOutlet weak var noticeMoreBtn:UIButton!
    @IBOutlet weak var mainTabs:MainTabsBar!
    @IBOutlet weak var mainTabsHeight:NSLayoutConstraint!
    var isActiveShow = false;//是否显示优惠活动
    var lunboImgs:[String] = [];//轮播图片数据集
    var titleUrls:[String] = [];//轮播图片点击跳转地址
    
    var mainDelegate:MainViewDelegate?
    var controller:BaseController!
    var noticeStrings:[String] = []

    override func awakeFromNib() {
        
        //给界面上各按钮添加手势事件
        withdrawBtn.isUserInteractionEnabled = true
        recordsBtn.isUserInteractionEnabled = true
        activeBtn.isUserInteractionEnabled = true
        serviceBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        withdrawBtn.addGestureRecognizer(tap)
        recordsBtn.addGestureRecognizer(tap2)
        activeBtn.addGestureRecognizer(tap3)
        serviceBtn.addGestureRecognizer(tap4)
        noticeMoreBtn.addTarget(self, action: #selector(onMoreNoticeClick), for: .touchUpInside)
//        noticeUI.delegate = self
    }
    
    func onMoreNoticeClick() -> Void {
        if self.noticeStrings.isEmpty{
            return
        }
        if let delegate = self.mainDelegate{
            openNoticePage(controller: delegate as! BaseController, notices: self.noticeStrings)
        }
    }
    
    func syncHeaderFromWeb(controller:BaseController) -> Void {
        self.controller = controller
        self.syncSomeWebData(controller: controller)
    }
    
    func toggleMainTabs(show:Bool){
        if show{
            mainTabs.isHidden = false
            mainTabsHeight.constant = 40
        }else{
            mainTabs.isHidden = true
            mainTabsHeight.constant = 0
        }
    }

    func updateFuncBtn() -> Void {
        isActiveShow = isActiveShowFunc()
        if isActiveShow{
            activeTxt.text = "优惠活动"
            activeImg.image = UIImage.init(named: "app_active_icon")
//            activeBadge.isHidden = false
        }else{
            activeTxt.text = "APP下载"
            activeImg.image = UIImage.init(named: "app_download_icon")
            activeBadge.isHidden = true
        }
        //获取一些主页需要的web数据
    }
    
    func tapEvent(_ recongnizer: UIPanGestureRecognizer) {
        let tag = recongnizer.view!.tag
        if let delegate = self.mainDelegate{
            delegate.clickFunc(tag: tag)
        }
    }
    
    func syncSomeWebData(controller:BaseController) ->  Void {
        //最新公告
        // 类型 1:关于我们,2:取款帮助,3:存款帮助,4:合作伙伴->联盟方案,5:合作伙伴->联盟协议,
        //6:联系我们,7:常见问题 ,8:玩法介绍,9:彩票公告,10:视讯公告,11:体育公告,12:电子公告,13:最新公告
        controller.request(frontDialog: false, url:NOTICE_URL,params:["code":13],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    if let result = NoticeWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let str = result.content{
                                self.noticeStrings = str
                                self.updateNotice(str: str)
                            }
                        }
                    }
        })
        //获取轮播
        getLundos(controller:controller,code: 5)
        //获取公告弹窗内容
        controller.request(frontDialog: false, url:ACQURIE_NOTICE_POP_URL,params:["code":19],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    if let result = NoticeResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let notices = result.content{
                                //显示公告内容
                                if notices.isEmpty{
                                    return
                                }
                                self.showNoticeDialog(title: notices[0].title, content: notices[0].content)
                            }
                        }
                    }
        })
        checkVersion(controller: controller, showDialog: false, showText: "正在检测新版本…")
        //判断是否优惠活动
        if isActiveShow{
//            activeBadge.isHidden = false
            //获取优惠活动角标
            controller.request(frontDialog: false, url:ACTIVE_BADGE_URL,params:["code":19],
                               callback: {(resultJson:String,resultStatus:Bool)->Void in
                                if !resultStatus {
                                    return
                                }
                                if let result = ActiveBadgeWrapper.deserialize(from: resultJson){
                                    if result.success{
                                        YiboPreference.setToken(value: result.accessToken as AnyObject)
                                        //更新优惠活动角标
                                        self.updateActiveBadge(count: result.content)
                                    }
                                }
            })
        }else{
            activeBadge.isHidden = true
        }
        
    }
    
    func getLundos(controller:BaseController,code:Int){
        controller.request(frontDialog: false, url:LUNBO_URL,params:["code":code],
               callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    return
                }
                if let result = LunboWraper.deserialize(from: resultJson){
                    if result.success{
                        YiboPreference.setToken(value: result.accessToken as AnyObject)
                        if let lunbo = result.content{
                            //更新轮播图
                            self.updateLunbo(lunbo:lunbo);
                        }
                    }
                }
        })
    }
    
    func updateActiveBadge(count:Int) -> Void {
        if let json = getSystemConfigFromJson(){
            if json.content != nil{
                if json.content.show_active_badge != "on"{
                    activeBadge.isHidden = true
                    return
                }
            }
        }
        if count > 0{
            activeBadge.isHidden = false
            activeBadge.setTitle(String.init(describing: count), for: .normal)
        }else{
            activeBadge.isHidden = true
            activeBadge.setTitle("", for: .normal)
        }
    }
    
    func showNoticeDialog(title:String,content:String) -> Void {
//        openActiveDetail(controller: controller, title: "ddd", content: content)
        let qrAlert = PopupAlert.init(title: title, message: content, cancelButtonTitle: nil, sureButtonTitle: "我知道了")
        qrAlert.urlDelegate = self
        qrAlert.show()
    }
    
    func urlJump(url: String) {
        openActiveDetail(controller: controller, title: "弹窗活动", content: "", foreighUrl: url)
    }
    
    func updateLunbo(lunbo:[LunboResult]) -> Void {
        if lunbo.isEmpty{
            return
        }
        self.lunboImgs.removeAll()// remove all banner images first
        titleUrls.removeAll()
        for item in lunbo{
            if !isEmptyString(str: item.titleImg) && (item.titleImg.hasPrefix("http://")||item.titleImg.hasPrefix("https://")){
                print(item.titleImg)
                self.lunboImgs.append(item.titleImg)
            }
            self.titleUrls.append(item.titleUrl)
        }
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 150)
//        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: lunboImgs)
        cycleScrollView = WRCycleScrollView.init(frame: frame, type: .SERVER, imgs: lunboImgs, descs: nil, defaultDotImage: nil, currentDotImage: nil)
        cycleScrollView.delegate = self
        cycleScrollView.backgroundColor = UIColor.lightGray
//        cycleScrollView.imageContentModel = UIViewContentMode.scaleToFill
        cycleScrollView.clipsToBounds = true
        cycleScrollView.descLabelHeight = 40
        cycleScrollView.autoScrollInterval = 5.5
        cycleScrollView.descLabelFont = UIFont.systemFont(ofSize: 13)
        cycleScrollView.pageControlAliment = .CenterBottom
//        cycleScrollView.imgsType = .SERVER
        cycleScrollView.bottomViewBackgroundColor = UIColor.lightGray
//        cycleScrollView.serverImgArray = lunboImgs
        cycleScrollView.removeFromSuperview()
        self.addSubview(cycleScrollView)
        if self.lunboImgs.count > 1{
            cycleScrollView.isAutoScroll = true
        }else{
            cycleScrollView.isEndlessScroll = true
            cycleScrollView.isAutoScroll = false
        }
    }
    
    func updateNotice(str:[String]) -> Void {
        var notices = ""
        for item in str{
            notices = notices + item + ";"
//            if notices.count > 2500{
//                break;
//            }
        }
//        if notices.count > 2500{
//            notices = (notices as NSString).substring(to: 1000)
//        }
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        do{
            let attrStr = try NSAttributedString.init(data: notices.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
            label.attributedText = attrStr
        }catch{
            print(error)
        }
        noticeUI.contentView = label
        noticeUI.backgroundColor = UIColor.clear
        noticeUI.contentMargin = 50
        noticeUI.marqueeType = .left
    }
    
    func onDelegate() {
        onMoreNoticeClick()
    }

}

extension MainHeaderView : WRCycleScrollViewDelegate{
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: WRCycleScrollView) {
        if self.titleUrls.count < index || index < 0{
            return
        }
        let url = self.titleUrls[index]
        if isEmptyString(str: url){
            return
        }
        if !ValidateUtil.URL(url).isRight{
            return
        }
        openBrower(urlString: url)
    }
}

