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
class MainHeaderView: UIView ,MarqueeDelegate{
    
    
    
    @IBOutlet weak var noticeUIHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var speakerIcon: UIImageView!
    @IBOutlet weak var notiUIBgView: UIView!
    @IBOutlet weak var activeTxt:UILabel!
    @IBOutlet weak var fourthTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var onlineSeviceImage: UIImageView!
    @IBOutlet weak var activeImg: UIImageView!
    @IBOutlet weak var betRecordImage: UIImageView!
    @IBOutlet weak var inOutImage: UIImageView!
    @IBOutlet weak var cycleScrollView: WRCycleScrollView!
    //存取款，投注记录，优惠活动，在线客服等按钮
    @IBOutlet weak var helpUI:UIView!
    @IBOutlet weak var withdrawBtn: UIView!
    @IBOutlet weak var recordsBtn: UIView!
    @IBOutlet weak var activeBtn: UIView!
    @IBOutlet weak var activeBadge:UIButton!
    @IBOutlet weak var serviceBtn: UIView!
    @IBOutlet weak var noticeUI:MarqueeView!
    @IBOutlet weak var noticeMoreBtn:UIButton!
    
    var lunboImgs:[String] = [];//轮播图片数据集
    
    var mainDelegate:MainViewDelegate?
    var controller:BaseController!
    var notices:[NoticeBean] = []
    

    override func awakeFromNib() {
        
        setupNoPictureAlphaBgView(view: withdrawBtn)
        setupNoPictureAlphaBgView(view: recordsBtn)
        setupNoPictureAlphaBgView(view: activeBtn)
        setupNoPictureAlphaBgView(view: serviceBtn)
        setupNoPictureAlphaBgView(view: notiUIBgView)
        
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: firstTitleLabel)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: secondTitleLabel)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: activeTxt)
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: fourthTitleLabel)
        
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
        noticeUI.delegate = self
        
        chooseMainPageVersion()
    }
    
    private func chooseMainPageVersion() {
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                
               let str = config.content.mainPageVersion
                if str == "V1" {
                    version1()
                }else if str == "V2" {
                    version2()
                }else {
                    version1()
                }
                
                return
            }
        }
        
        version1()
    }
    
    private func version1() {
        onlineSeviceImage.theme_image = "HomePage.onelineService"
        betRecordImage.theme_image = "HomePage.betRecord"
        inOutImage.theme_image = "HomePage.homeDepositAndWithDraw"
        activeImg.theme_image = "HomePage.download"
        
        firstTitleLabel.text = "存取款"
        secondTitleLabel.text = "投注记录"
        activeTxt.text = "APP下载"
        fourthTitleLabel.text = "在线客服"
    }
    
    private func version2() {
        onlineSeviceImage.theme_image = "HomePage.onelineService"
        betRecordImage.theme_image = "HomePage.withdrawal"
        inOutImage.theme_image = "HomePage.homeDeposit"
        activeImg.theme_image = "TabBar.discount"
        
        firstTitleLabel.text = "存款"
        secondTitleLabel.text = "取款"
        activeTxt.text = "优惠活动"
        fourthTitleLabel.text = "在线客服"
    }
    
    @objc func onMoreNoticeClick() -> Void {
        print("click notice")
        if self.notices.isEmpty{
            return
        }
        if let delegate = self.mainDelegate{
            openNoticePage(controller: delegate as! BaseController, notices: self.notices)
        }
    }
    
    func syncHeaderFromWeb(controller:BaseController) -> Void {
        self.controller = controller
        self.syncSomeWebData(controller: controller)
    }

    func updateFuncBtn() -> Void {
//        if isActiveShowFunc(){
//            activeTxt.text = "优惠活动"
//            activeImg.image = UIImage.init(named: "app_active_icon")
//        }else{
            activeTxt.text = "APP下载"
//            activeImg.image = UIImage.init(named: "app_download_icon")
        activeImg.theme_image = "HomePage.download"
//        }
        //获取一些主页需要的web数据
    }
    
    @objc func tapEvent(_ recongnizer: UIPanGestureRecognizer) {
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
                            self.notices = result.content
                            if !result.content.isEmpty{
                                self.updateNotice(str: result.content)
                            }else {
                                self.setupNoticeUIWithNotices(notices: "")
                            }
                        }
                    }
        })
        //获取轮播
        controller.request(frontDialog: false, url:LUNBO_URL,params:["code":5],
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
        
        showAnnounce(controller:controller)
        checkVersion(controller: controller, showDialog: false, showText: "正在检测新版本…")
    }
    
    private func showAnnounce(controller:BaseController) {
        if YiboPreference.isShouldAlert_isAll() == "" {
            YiboPreference.setAlert_isAll(value: "on" as AnyObject)
        }
        
        if YiboPreference.isShouldAlert_isAll() == "off"{
            return
        }
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
                                        }else {
                                            
                                            self.forArrToAlert(notices: notices)
                                        }
                                    }
                                }
                            }
        })
    }
    
    // 遍历数组,取出公告赋值
    private func forArrToAlert(notices: Array<NoticeResult>) {
        
        var noticesP = notices
        noticesP = noticesP.sorted { (noticesP1, noticesP2) -> Bool in
            return noticesP1.sortNum < noticesP2.sortNum
        }
        

        var models = [NoticeResult]()
        for index in 0..<noticesP.count {
            let model = noticesP[index]
            if model.isIndex {
                models.append(model)
            }
        }
        
        if models.count > 0 {
            let weblistView = WebviewList.init(noticeResuls: models)
            weblistView.show()
        }
        
}
    
    func showNoticeDialog(title:String,content:String) -> Void {
        let qrAlert = PopupAlert.init(title: title, message: content, cancelButtonTitle: nil, sureButtonTitle: "我知道了")
        qrAlert.show()
    }
    
    func updateLunbo(lunbo:[LunboResult]) -> Void {
        if lunbo.isEmpty{
            return
        }
        self.lunboImgs.removeAll()// remove all banner images first
        for item in lunbo{
            if !isEmptyString(str: item.titleImg) && (item.titleImg.hasPrefix("http://")||item.titleImg.hasPrefix("https://")){
                print(item.titleImg)
                item.titleImg = item.titleImg.trimmingCharacters(in: .whitespaces)
                if let status = item.status {
                    if status == 2 {
                        self.lunboImgs.append(item.titleImg)
                    }
                }
            }
        }
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 130)
//        cycleScrollView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: lunboImgs)
        cycleScrollView = WRCycleScrollView.init(frame: frame, type: .SERVER, imgs: lunboImgs, descs: nil, defaultDotImage: nil, currentDotImage: nil)
        cycleScrollView.autoScrollInterval = 3.5
//        cycleScrollView.delegate = self as! WRCycleScrollViewDelegate
        cycleScrollView.backgroundColor = UIColor.lightGray
//        cycleScrollView.imageContentModel = UIViewContentMode.scaleToFill
        cycleScrollView.clipsToBounds = true
        cycleScrollView.descLabelHeight = 40
        cycleScrollView.descLabelFont = UIFont.systemFont(ofSize: 13)
        cycleScrollView.pageControlAliment = .CenterBottom
//        cycleScrollView.imgsType = .SERVER
        cycleScrollView.bottomViewBackgroundColor = UIColor.lightGray
//        cycleScrollView.serverImgArray = lunboImgs
        cycleScrollView.removeFromSuperview()
        self.addSubview(cycleScrollView)
        
    }
    
    func updateNotice(str:[NoticeBean]) -> Void {
        var notices = ""
        for item in str{
            if let content = item.content{
                notices.append(content)
            }
        }
        
        noticeUI.setupView(title: notices,htmlTxt: true)
        self.setupNoticeUIWithNotices(notices: notices)
    }
    
    var didGetNotices:((Bool) -> Void)?
    
    // 布局有些杂乱，这里就不改变布局，其他控件直接隐藏了
    private func setupNoticeUIWithNotices(notices: String) {
        let hasNotices = !isEmptyString(str: notices)
        
        self.noticeUIHeightConstraint.constant = hasNotices ? 30 : 0
        self.speakerIcon.isHidden = !hasNotices
        self.notiUIBgView.isHidden = !hasNotices
        self.noticeMoreBtn.isHidden = !hasNotices
        
        didGetNotices?(hasNotices)
    }
    
    func onDelegate() {
        onMoreNoticeClick()
    }

}

