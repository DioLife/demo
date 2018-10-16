//
//  JianjinTouzhController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/15.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import SwiftTheme

protocol CellBtnsDelegate:NSObjectProtocol {
    func onBtnsClickCallback(btnTag:Int,cellPos:Int)
    func onNumBallClickCallback(number:String,cellPos:Int)
}

class TouzhController: BaseController,UITableViewDataSource,UITableViewDelegate,
CellBtnsDelegate,PeilvCellDelegate,UITextFieldDelegate,SeekbarChangeEvent,LotsMenuDelegate{
    
    var betShouldPayMoney = 0.0
    var accountBanlance = 0.0
    var meminfo:Meminfo?
    var awardNum = ""
    var multiplyValue:Float = 1.0
    var bombSoundEffect: AVAudioPlayer?
    
    let PLAY_RULE_TABLVIEW_TAG = 0
    let PLAY_PANE_TABLEVIEW_TAG = 1
    let RECENT_RESULTS_TABLEVIEW_TAG = 2
    
    var lotData:LotteryData?
    var peilvListDatas:[BcLotteryPlay] = []//赔率版彩票列表数据源
    var selectNumList:[PeilvWebResult] = []//选择好的赔率项数据
    var ballonDatas:[BallonRules] = []//官方版彩票列表数据源
    var officail_odds:[PeilvWebResult] = []//官方版所有赔率
    var honest_odds:[HonestResult] = []//信用版用户选择的侧边打玩法对应的所有小玩法对应的所有赔率列表数据
    var selectPlay:BcLotteryPlay?//当前选择的侧边玩法
    
    let BALL_COUNT_PER_LINE = 5
    let BALL_COUNT_PER_LINE_WHEN_EXPAND = 5
    
    var is_fast_bet_mode = true//是否快捷下注模式
    var currentQihao:String = "";//当前期号
    var cpVersion:String = VERSION_1;//当前彩票版本
    var subPlayCode:String = ""
    var subPlayName = ""
    var czCode:String = ""
    var cpBianHao:String = "";//彩票编码
    var cpTypeCode:String = ""////彩票类型代号
    var lotteryICON = ""//icon
    var cpName:String = ""
    var ago:Int64 = 0//开奖时间与封盘时间差,单位秒
    let offset:Int = 1//偏差1秒
    var tickTime:Int64 = 0////倒计时查询最后开奖的倒计时时间
    var endBetDuration:Int = 0;//秒
    var endBetTime:Int = 0//距离停止下注的时间
    var disableBetTime:Int64 = 0//距离再次开始下注的剩余时间
    
    var selectMode = "";//金额模式，元模式
    var selectedBeishu = 1;//选择的倍数
    var selectedMoney = 0.0;//总投注金额,单位元
    var winExample = "";
    var detailDesc = "";
    var playMethod = "";
    
    var playRules:[BcLotteryPlay] = []//所有叶子玩法列表数据
    var selected_rule_position = 0;//用户在侧边玩法栏选择的玩法位置
    
    var titleBtn:UIButton!
    var titleIndictor:UIImageView!
    var lotWindow:LotsMenuView!//彩种菜单
    var allLotDatas:[LotteryData] = []
    var shouldPlayKaiJianVolume = false
    
    var firstResultQiHao = "" {
        didSet {
            if oldValue != firstResultQiHao && shouldPlayKaiJianVolume{
                playKaiJianVolume()
            }
        }
    }
    
    
    @IBOutlet weak var touzhuHeaderBgView: UIView!
    @IBOutlet weak var playPaneTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var recentTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var normalModeButton: UIButton!
    @IBOutlet weak var fastModeButton: UIButton!
    @IBOutlet weak var bottomDottedLine: UIView!
    @IBOutlet weak var topDottedLine: UIView!
    @IBOutlet weak var bottomViewTopLine: UIView!
    @IBOutlet weak var bottomLine: UIView! // 顶部视图的 
    @IBOutlet weak var recent_open_result_tableview:UITableView!//底层最近开奖结果列表
    @IBOutlet weak var line_between_header_and_betarea:UIView!//投注栏头部与下注区的分隔线
    
    @IBOutlet weak var topHeaderImg:UIImageView!//头部背景
    @IBOutlet weak var lastQihaoUI:UILabel!//上一期期号
    @IBOutlet weak var currentQihaoUI:UILabel!//当前期号
    @IBOutlet weak var countDownUI:UILabel!//倒计时时间
    @IBOutlet weak var numViews:BallsView!//开奖号码
    @IBOutlet weak var exceptionNumTV:UILabel!//没有开奖结果时的文字
    @IBOutlet weak var verticalLine:UIImageView!//分割线
    @IBOutlet weak var topVerticalLine: UIView!
    
    @IBOutlet weak var betDeadlineDesLabel: UILabel!
    @IBOutlet weak var balanceButton: UIButton!
    
    @IBOutlet weak var middleHeaderView:UIView!//头部栏中间view
    
    @IBOutlet weak var lot_name_button:UIButton!//当前彩票按钮
    @IBOutlet weak var random_bet_button:UIButton!//机选按钮
    @IBOutlet weak var recent_open_result_button:UIButton!//最近几期开奖结果按钮
    @IBOutlet weak var current_play_label:UILabel!//当前玩法
    
    @IBOutlet weak var play_introduce_view:UIView!//玩法说明view
    
    @IBOutlet weak var play_introduce_label:UILabel!//玩法说明文字
    @IBOutlet weak var coolHotButton: UIButton!
    @IBOutlet weak var missingNumButton: UIButton!

    @IBOutlet weak var bet_mode_switch_view:UIView!//下注模式切换view
    @IBOutlet weak var fast_bet_button:UIButton!//左边快捷下注
    @IBOutlet weak var normal_bet_button:UIButton!//右边普通下注
    
    @IBOutlet weak var pullpushBar:UIButton!//玩法推拉条
    @IBOutlet weak var pullpushButton: UIButton!
    
    @IBOutlet weak var playRuleTableView:UITableView!//玩法列表
    @IBOutlet weak var playPaneTableView:UITableView!//玩法球列表
    
    
    @IBOutlet weak var creditBottomTopBar: UIView!
    @IBOutlet weak var creditBottomTopFastImgBtn: UIButton!
    @IBOutlet weak var creditbottomTopField: CustomFeildText!
    @IBOutlet weak var bottomtopTipsLabel: UILabel!
    @IBOutlet weak var creditbottomSlideLeftLabel: UILabel!
    
    @IBOutlet weak var balanceUI: UILabel!
    
    @IBOutlet weak var creditBottomHistoryLabel: UILabel!
    @IBOutlet weak var creditBottomHistoryImg: UIImageView!
    
    @IBOutlet weak var creditBottomHistoryButton: UIButton!
    @IBOutlet weak var creditbottomTopSlider: CustomSlider!
    
    @IBOutlet weak var bottomBgBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var creditSliderBgBar: UIView!
    
    //底部栏控件
    @IBOutlet weak var money_beishu_mode_view:UIView!
    @IBOutlet weak var bet_record_view:UIView!
    @IBOutlet weak var modeBtn:UIButton!
    @IBOutlet weak var beishuTV:UILabel!
    @IBOutlet weak var beishu_money_input:CustomFeildText!
    @IBOutlet weak var ratebackTV:UILabel!
    @IBOutlet weak var oddSlider:CustomSlider!
    @IBOutlet weak var currentOddTV:UILabel!
    @IBOutlet weak var clearBtn:UIButton!
    @IBOutlet weak var betBtn:UIButton!
    @IBOutlet weak var bottomZhushuTV:UILabel!
    @IBOutlet weak var bottomMoneyTV:UILabel!

    @IBOutlet weak var playRuleLayoutConstraint:NSLayoutConstraint!
    @IBOutlet weak var playPaneLayoutConstraint:NSLayoutConstraint!
//    @IBOutlet weak var playPaneHeightLayoutConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var resultTBTOP: NSLayoutConstraint!
    
    @IBAction func minusMultipleAction() {
        if isEmptyString(str: beishu_money_input.text!) {
            beishu_money_input.text = "1"
        }else {
            let nowNumP = Int(beishu_money_input.text!)
            if let nowNum = nowNumP {
                var nowChangeNum = nowNum
                if nowChangeNum > 1 {
                    nowChangeNum -= 1
                    beishu_money_input.text = "\(nowChangeNum)"
                    
                    self.selectedBeishu = nowChangeNum
                    self.updateBottomUI()
                    
//                    let str = String.init(format: "%.3f", awardNum)
                    if let curentOddTvNum = Float(awardNum) {
                        let lastCurrentOddTVNum = Double(curentOddTvNum) * Double(nowChangeNum)
                        let string = String.init(format: "%.3", lastCurrentOddTVNum)
                        if let doubleValue = Double(string) {
                            bottomMoneyTV.text = "\(doubleValue)元"
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func plusMultipleAction() {
        if isEmptyString(str: beishu_money_input.text!) {
            beishu_money_input.text = "1"
        }else {
            let nowNumP = Int(beishu_money_input.text!)
            if let nowNum = nowNumP {
                var nowChangeNum = nowNum
                nowChangeNum += 1
                beishu_money_input.text = "\(nowChangeNum)"
                
                self.selectedBeishu = nowChangeNum
                self.updateBottomUI()
                
                if let curentOddTvNum = Float(awardNum) {
                    let lastCurrentOddTVNum = Double(curentOddTvNum) * Double(nowChangeNum)
                    let string = String.init(format: "%.3", lastCurrentOddTVNum)
                    if let doubleValue = Double(string) {
                        bottomMoneyTV.text = "\(doubleValue)元"
                    }
                    
                }
            }
        }
    }
    
    var recentResults:[BcLotteryData] = []
    var isRecentResultOpen = false
    var isPlayBarHidden = false
    var right_top_menu:SwiftPopMenu!//右上角悬浮框
    var version_top_menu:SwiftPopMenu!//版本切换悬浮框
    let KSCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
    var tag:Int = 1
    
    var lastKaiJianResultTimer:Timer?//查询最后开奖结果的倒计时器
    var endlineTouzhuTimer:Timer?//距离停止下注倒计时器
    var disableBetCountDownTimer:Timer?//禁止下注倒计时器
    
    var lhcSelect = false;//是否在奖金版本中选中了六合彩，十分六合彩
    var betMoneyWhenPeilv = ""//每注下注金额
    
    var totalPeilvMoney = 0;//总投注金额
    
    var official_orders:[OfficialOrder] = []//官方版所有下注主单列表
    var honest_orders:[PeilvOrder] = []////信用版所有下注主单列表
    var current_rate:Float = 0;//当前拖动选择的反水比例
    var current_odds:Float = 0;//当前奖金或赔率
    
    var isViewVisible = true
    var selectedSubPlayCode:String = ""//赔率版左侧玩法栏玩法code
    var choosedPlay:BcLotteryPlay?;
    var lhcLogic = LHCLogic2()//特殊六合彩玩法的处理类
    
    var codeRank:[CodeRankModel]?
    var showCodeRank = true//是否显示冷热遗漏数据
    
    
    var right_top_datasources = [(icon:"TouzhOffical.SwiftPopMenu.firstImage",title:"投注记录"),(icon:"TouzhOffical.SwiftPopMenu.secodeImage",title:"历史开奖"),(icon:"TouzhOffical.SwiftPopMenu.thirdImage",title:"玩法说明"),(icon:"TouzhOffical.SwiftPopMenu.fourthImage",title:"设置"),(icon:"TouzhOffical.SwiftPopMenu.fiveImage",title:"切换主题"),
        (icon:"TouzhOffical.SwiftPopMenu.sixImage",title:"切换音效"),
                                 ]
    
    var version_switch_datasources = [(icon:"shake_touzhu",title:"官方下注"),(icon:"shake_touzhu",title:"信用下注")]
    
    //MARK: - showNewFunctionTipsPage
    private func showNewFunctionTipsPage() {
        let showNewFunctionPage = YiboPreference.getShowBetNewfunctionTipsPage()
        
        if showNewFunctionPage == "off" {return}
        
        if isEmptyString(str: showNewFunctionPage) {
            let tipsViewButton = self.getNewFunctionTipsPage(image: "chattingRoom")
            tipsViewButton.addTarget(self, action: #selector(showNextTipsView), for: .touchUpInside)
        }
    }
    
    @objc func showNextTipsView(sender: UIButton) {
        sender.isHidden = true
        sender.removeFromSuperview()
        YiboPreference.setShowBetNewfunctionTipsPage(value: "off")
    }
    
    private func getNewFunctionTipsPage(image: String) -> UIButton {
        let tipsViewButton = UIButton()
        tipsViewButton.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(tipsViewButton)
        tipsViewButton.setBackgroundImage(UIImage.init(named: image), for: .normal)
        
        return tipsViewButton
    }
    
    @objc func themeChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateCurrenQihao()
            self.updateLastKaiJianResult()
        }
    }
    
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name(rawValue: ThemeUpdateNotification), object: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showNewFunctionTipsPage()
        }
        
        //是否开启了聊天室
        if let sys = getSystemConfigFromJson() {
            if sys.content.switch_chatroom == "on" {
                right_top_datasources.append((icon:"TouzhOffical.SwiftPopMenu.sevenImage",title:"聊天室"))
            }
        }

        
        //在iPhone 5系列机型上 做些特殊设置
        if UIDevice.current.modelName == "iPhone 5s" || UIDevice.current.modelName == "iPhone 5" {
            resultTBTOP.constant = 35
        }
        
        if #available(iOS 11.0, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        
        setupTheme()
        // 默认的 UI相关处理
        setupUI()
        
        let moreBtn = UIButton(type: .custom)
        moreBtn.frame = CGRect.init(x: 0, y: 0, width: 50, height: 44)
        
        if #available(iOS 11, *){} else {
            if #available(iOS 10, *) {
                moreBtn.frame = CGRect.init(x: 0, y: 0, width: 65, height: 44)
            }
        }

        moreBtn.setTitle("小助手", for: .normal)
        moreBtn.theme_setTitleColor("Global.barTextColor", forState: .normal)
        moreBtn.contentHorizontalAlignment = .right
        moreBtn.addTarget(self, action: #selector(showRightTopMenuWhenResponseClick(ui:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: moreBtn)
        
        refreshLotteryTime()
        
        balanceButton.theme_setImage("TouzhOffical.piggyBank", forState: .normal)
        balanceButton.theme_setTitleColor("FrostedGlass.Touzhu.separateLineColor", forState: .normal)
        balanceButton.imageView?.contentMode = .scaleAspectFit
        
        coolHotButton.theme_setImage("TouzhOffical.checkbox_normal", forState: .normal)
        coolHotButton.theme_setImage("TouzhOffical.checkbox_selected", forState: .selected)
        coolHotButton.addTarget(self, action: #selector(TouzhController.clickCoolHotButton), for: .touchUpInside)
        
        missingNumButton.theme_setImage("TouzhOffical.checkbox_normal", forState: .normal)
        missingNumButton.theme_setImage("TouzhOffical.checkbox_selected", forState: .selected)
        missingNumButton.addTarget(self, action: #selector(TouzhController.clickMissingNumButton), for: .touchUpInside)
        
        fastModeButton.theme_setImage("TouzhOffical.checkbox_normal", forState: .normal)
        fastModeButton.theme_setImage("TouzhOffical.checkbox_selected", forState: .selected)
        fastModeButton.addTarget(self, action: #selector(TouzhController.clickFastModeButton), for: .touchUpInside)
        
        normalModeButton.theme_setImage("TouzhOffical.checkbox_normal", forState: .normal)
        normalModeButton.theme_setImage("TouzhOffical.checkbox_selected", forState: .selected)
        normalModeButton.addTarget(self, action: #selector(TouzhController.clickNormalModeButton), for: .touchUpInside)
        
        pullpushButton.theme_setBackgroundImage("TouzhOffical.handleLeft", forState: .normal)
        pullpushButton.addTarget(self, action: #selector(clickPlayRulePushpullBar), for: .touchUpInside)
        
        //初始化玩法推拉条相关数据
        pullpushBar.addTarget(self, action: #selector(clickPlayRulePushpullBar), for: .touchUpInside)
        pullpushBar.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        pullpushBar.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        pullpushBar.titleLabel?.numberOfLines = 0
        pullpushBar.setTitleColor(UIColor.init(hex: 0xF36664), for: .normal)
        pullpushBar.setTitleColor(UIColor.init(hex: 0xEF241D), for: .highlighted)
        //初始化并自定义标题兰
        self.customTitleView()
        
        self.recent_open_result_tableview.tag = RECENT_RESULTS_TABLEVIEW_TAG
        recent_open_result_tableview.delegate = self
        recent_open_result_tableview.dataSource = self
        recent_open_result_tableview.separatorStyle = .none
        recent_open_result_tableview.backgroundColor = UIColor.init(hex: 0xf2f1f8)
        line_between_header_and_betarea.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        
        play_introduce_view.isUserInteractionEnabled = true
        play_introduce_view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoResultsPage)))
        
        //绑定开奖号码视图的点击事件，打开开奖结果列表
        numViews.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(gotoResultsPage)))
        recent_open_result_button.addTarget(self, action: #selector(onOpenNumberClick), for: .touchUpInside)
//        middleHeaderView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onOpenNumberClick)))
        //init play rule txt in top of window
        initPlayRuleTable()
        initPlayPaneTable()
        
        creditBottomTopFastImgBtn.addTarget(self, action: #selector(onFastMoneyClick(sender:)), for: .touchUpInside)
        
        random_bet_button.imageView?.contentMode = .scaleAspectFit
        random_bet_button.addTarget(self, action: #selector(onRandomBetClick), for: .touchUpInside)
        lot_name_button.addTarget(self, action: #selector(onLotSwitch), for: .touchUpInside)
        fast_bet_button.addTarget(self, action: #selector(onFastBetButton), for: .touchUpInside)
        normal_bet_button.addTarget(self, action: #selector(onNormalBetButton), for: .touchUpInside)
        
        bet_record_view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(betRecordClickEvent(_:)))
        bet_record_view.addGestureRecognizer(tap)
        
        //init and bind ui response event
        modeBtn.addTarget(self, action: #selector(onModeSwitch(sender:)), for: .touchUpInside)
        
        beishu_money_input.addTarget(self, action: #selector(moneyTextChange(textField:)), for: UIControlEvents.editingChanged)
        beishu_money_input.delegate = self
        
        creditbottomTopField.addTarget(self, action: #selector(creditMoneyTextChange(textField:)), for: UIControlEvents.editingChanged)
        creditbottomTopField.delegate = self
        
        oddSlider.addTarget(self, action: #selector(sliderChange), for: UIControlEvents.valueChanged)
        oddSlider.delegate = self
        
        creditbottomTopSlider.addTarget(self, action: #selector(creditSliderChange), for: UIControlEvents.valueChanged)
        
        creditbottomTopSlider.addTarget(self, action: #selector(creditSliderChanged(slider:event:)), for: .valueChanged)

        
        creditbottomTopSlider.delegate = self
        
        betBtn.addTarget(self, action: #selector(click_bet_button), for: .touchUpInside)
        
        clearBtn.backgroundColor = UIColor.init(hexString: "9c9c9c")
        clearBtn.addTarget(self, action: #selector(click_bottom_clear_button), for: .touchUpInside)
        
        //当键盘弹起的时候会向系统发出一个通知，
        //这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //开始根据彩种信息获取对应的玩法
        //根据彩种信息更新本地彩票相关变量
        updateLocalConstants(lotData: self.lotData)
        sync_playrule_from_current_lottery(lotType: self.cpTypeCode, lotCode: self.cpBianHao, lotVersion: self.cpVersion)
        lhcLogic.playButtonDelegate = self
        lhcLogic.initAllDatas()
        
    }
    
    //MARK: - 键盘响应
    @objc override func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            let deltaY = intersection.height
            
            if keyBoardNeedLayout {
                playPaneTopConstraint.constant = abs(deltaY - 160)
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: {
                                self.view.frame = CGRect.init(x:0,y:-deltaY,width:self.view.bounds.width,height:self.view.bounds.height)
                                self.keyBoardNeedLayout = false
                                self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    //键盘隐藏响应
    @objc override func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            let deltaY = intersection.height
        
            playPaneTopConstraint.constant = 1
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: {
                            self.view.frame = CGRect.init(x:0,y:deltaY,width:self.view.bounds.width,height:self.view.bounds.height)
                            self.keyBoardNeedLayout = true
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func selectMoneyFromDialog(money:String){
        if isEmptyString(str: money){
            return
        }
        self.betMoneyWhenPeilv = money
        self.updateBottomUI()
        creditbottomTopField.text = money
    }
    
    //快选金额点击事件
    @objc func onFastMoneyClick(sender:UIButton){
        
        var str = ""
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                str = config.content.fast_money_setting
            }
        }
        if isEmptyString(str: str){
            str = "10,20,50,100,200,500,1000,2000,5000"
        }
        let moneys = str.components(separatedBy: ",")
        if moneys.isEmpty{
            showToast(view: self.view, txt: "没有快选金额，请联系客服")
            return
        }
        let alert = UIAlertController.init(title: "快选金额", message: nil, preferredStyle: .actionSheet)
        for m in moneys{
            let action = UIAlertAction.init(title: m, style: .default, handler: {(action:UIAlertAction) in
                self.selectMoneyFromDialog(money: m)
            })
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        //ipad使用，不加ipad上会崩溃
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        self.present(alert,animated: true,completion: nil)
    }
    
    func accountWeb() -> Void {
        //帐户相关信息
        request(frontDialog: false, url:MEMINFO_URL,
               callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    return
                }
                if let result = MemInfoWraper.deserialize(from: resultJson){
                    if result.success{
                        YiboPreference.setToken(value: result.accessToken as AnyObject)
                        if let memInfo = result.content{
                            //更新余额等信息
                            self.updateAccount(memInfo:memInfo);
                        }
                    }
                }
        })
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        self.meminfo = memInfo
        if !isEmptyString(str: memInfo.balance){
            let leftMoneyName = "\(memInfo.balance)"
            balanceUI.text = "\(leftMoneyName)元"
            if let value = Double(leftMoneyName) {
                accountBanlance = value
            }
        }
    }
    
    //获取到彩种及玩法信息后，更新本地相关变量，重新开始获取开奖结果，重新当前旗号和开始倒计时
    func sync_local_constan_restart_something_after_playrule_obtain(lottery:LotteryData?) -> Void {
        if let lot = lottery{
            self.lotData = lot
        }
        //根据彩种信息更新本地彩票相关变量
        refreshBottomBar()
        updateLocalConstants(lotData: self.lotData)
        input_hint()
        update_lotname_button()
        update_bet_header_seperator_line()
        update_mode_money_label_after_sync()
        swtichTouzhuHeader()
        switch_award_ui_after_obtain()
        toggleTouzhuModeSwitchAndPlayRuleIntroduce()
        refreshButtons()
        if (self.lotData?.rules.isEmpty)!{
            return
        }
        //奖获取到的玩法平铺成一级数组列表，展现出来的玩法是所有叶子结点的玩法数据
        if let lottery = self.lotData{
            let rules:[BcLotteryPlay] = PlayTool.leaf_play_rules(lottery: lottery)
            if !rules.isEmpty{
                playRules.removeAll()
                playRules = playRules + rules
            }
        }
        playRuleTableView.reloadData()
        if playRules.isEmpty{
            return
        }
        let first_play_obj = playRules[0]
        
        shouldPlayKaiJianVolume = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.shouldPlayKaiJianVolume = true
        }
        self.handlePlayRuleClick(playData: first_play_obj, position: 0)
        //获取开奖结果
        lastOpenResult(cpBianHao:self.cpBianHao);
        //获取截止下注倒计时
        getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: cpVersion,controller: self)
        YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        //获取冷热遗漏(官方版专有)
        if !isPeilvVersion(){
            getCodeRank(lotCode: cpBianHao)
        }
    }
    
    func update_bet_header_seperator_line(){
        if isPeilvVersion(){
            verticalLine.isHidden = false
        }else{
            verticalLine.isHidden = true
        }
    }
    
    func switch_award_ui_after_obtain(){
        if isPeilvVersion(){
            currentOddTV.isHidden = true
        }else{
            currentOddTV.isHidden = false
        }
    }
    
    func viewLotRecord(){
        let page = GoucaiQueryController()
//        page.filterLotCode = self.cpBianHao
        page.isAttachInTabBar = false
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @objc func betRecordClickEvent(_ recongnizer: UIPanGestureRecognizer) {
        viewLotRecord()
    }
    
    func update_mode_money_label_after_sync(){
        if isPeilvVersion(){
            modeBtn.setTitle("金额", for: .normal)
            modeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            beishuTV.isHidden = true
        }else{
            modeBtn.setTitle(str_from_mode(mode: self.selectMode), for: .normal)
            modeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            beishuTV.isHidden = false
        }
    }
    
    func switch_bottom_money_input_when_betmode_change(){
        if is_fast_bet_mode{
            money_beishu_mode_view.isHidden = false
            bet_record_view.isHidden = true
        }else{
            money_beishu_mode_view.isHidden = true
            bet_record_view.isHidden = false
        }
    }
    
    func input_hint() -> Void {
        if isPeilvVersion(){
            beishu_money_input.placeholder = "请输入金额"
        }else{
            beishu_money_input.placeholder = "1"
        }
    }
    
    func update_lotname_button(){
        let name = String.init(format: "  %@ %@ ", self.cpName,(self.lotWindow != nil && self.lotWindow.isShow) ? "<<  " : ">>  ")
        self.lot_name_button.setTitle(name, for: .normal)
    }
    
    //根据最新的彩种信息获取对应的玩法数据
    //网络获取
    //说明:当当前彩种变化时都需要调用此方法同步下玩法数据
    func sync_playrule_from_current_lottery(lotType:String,lotCode:String,lotVersion:String) -> Void {
        let parameters = ["lotType":lotType,"lotCode":lotCode,"lotVersion":lotVersion] as [String : Any]
        request(frontDialog: true, loadTextStr:"获取玩法中", url:GAME_PLAYS_URL,params:parameters,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取玩法失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LotPlayWraper.deserialize(from: resultJson){
                        if result.success{
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            self.sync_local_constan_restart_something_after_playrule_obtain(lottery: result.content)
                        }else{
                            self.print_error_msg(msg: result.msg)
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                        
                    }
        })
    }
    
    //自定义标题栏，方便点击标题栏切换彩票版本
    func customTitleView() -> Void {
        self.navigationItem.titleView?.isUserInteractionEnabled = true
        let titleView = UIView.init(frame: CGRect.init(x: kScreenWidth/4, y: 0, width: kScreenWidth/2, height: 44))
        titleBtn = UIButton.init(frame: CGRect.init(x: titleView.bounds.width/2-56, y: 0, width: 100, height: 44))
        titleBtn.isUserInteractionEnabled = false
        titleView.addSubview(titleBtn)
        if getLotVersionConfig() == VERSION_V1V2{
//            titleIndictor = UIImageView.init(frame: CGRect.init(x: titleView.bounds.width/2+titleBtn.bounds.width/2+6, y: 22-6, width: 12, height: 12))
            
            titleIndictor = UIImageView.init(frame: CGRect.init(x:titleBtn.x + titleBtn.bounds.width, y: 22-6, width: 12, height: 12))
            
            titleIndictor.theme_image = "FrostedGlass.Touzhu.navDownImage"
            titleView.addSubview(titleIndictor)
        }
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        update_title_label()
        self.navigationItem.titleView = titleView
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleClickEvent(recongnizer:)))
        self.navigationItem.titleView?.addGestureRecognizer(tap)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //赔率拖动条进度变化时的回调事件
    func onSeekbarEvent(currentRate: Float, currentWin: Float, progressRate: Float) {
        var award = ""
        if !isPeilvVersion(){
//            award += String.init(format: "%.3f", currentWin * multiplyValue)
            let awardStr = String.init(format: "%.3f", currentWin * multiplyValue)
//            if let awardFloat = Float(awardStr) {
////                award = "\(awardFloat)"
//                awardNum = awardStr
//            }
            award = awardStr
            awardNum = awardStr
            award += "元"
        }else{
            award += String.init(format: "%.3f", currentWin)
        }
        self.current_odds = currentWin
        self.current_rate = currentRate
        currentOddTV.text = award
        
//        let ratebackStr = String.init(format: "%.3f",currentRate * multiplyValue)
        let ratebackStr = String.init(format: "%.3f",currentRate)
        if let ratebackFloat = Float(ratebackStr) {
            ratebackTV.text = "\(ratebackFloat)"  + "%"
        }
        
        let creditbottomSlideLeftStr = String.init(format: "%.3f", currentRate)
        if let creditbottomSlideLeftFloat = Float(creditbottomSlideLeftStr) {
            creditbottomSlideLeftLabel.text = "\(creditbottomSlideLeftFloat)" + "%"
        }
        
        updateBottomUI()
    }
    
    //MARK: 根据返水的变化，改变所有球的赔率
    private func dynamicCalculateOdds(currentRate: Float) {

        var tempHonest_odds:[HonestResult] = []
        for honestIndex in 0..<(self.honest_odds.count) {
            let honestResult: HonestResult = self.honest_odds[honestIndex]
            
            let tempWebResultsArray: Array = honestResult.odds
            var webResultsArray: [PeilvWebResult] = []
            for webIndex in 0..<(tempWebResultsArray.count) {
                let webResult: PeilvWebResult = tempWebResultsArray[webIndex]
                webResult.currentOdds = webResult.maxOdds - currentRate*abs(webResult.maxOdds - webResult.minOdds)
                webResult.currentSecondOdds = webResult.secondMaxOdds - currentRate*abs(webResult.secondMaxOdds - webResult.secondMinodds)
                webResultsArray.append(webResult)
            }
            
            honestResult.odds = webResultsArray
            tempHonest_odds.append(honestResult)
        }
        
        self.honest_odds = tempHonest_odds
        self.playPaneTableView.reloadData()
        //        self.refresh_page_after_honest_odds_obtain(selected_play: &self.selectPlay, odds: self.honest_odds)
    }
    
    //拖动条滑动事件
    @objc func sliderChange(slider:UISlider) -> Void{
        oddSlider.changeSeekbar(currentProgress: slider.value)
    }
    
    @objc func creditSliderChange(slider:UISlider) -> Void{
        creditbottomTopSlider.changeSeekbar(currentProgress: slider.value)
    }
    
    @objc func creditSliderChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .ended:
            dynamicCalculateOdds(currentRate: (1 - slider.value))
            default:
                break
            }
        }
    }
    
    @objc func moneyTextChange(textField:UITextField)->Void{
        let s = textField.text
        guard let svalue = s else {return}
        if isPeilvVersion(){
            if isEmptyString(str: svalue){
                self.betMoneyWhenPeilv = ""
                return
            }
            if !isPurnInt(string: svalue){
                return
            }
            
            self.betMoneyWhenPeilv = svalue
            self.updateBottomUI()
        }else{
            if isEmptyString(str: svalue){
                self.selectedBeishu = 1
                return
            }
            if !isPurnInt(string: svalue){
                return
            }
            
            let max = Int.max
            if let doubleSvalue:Double = Double(svalue) {
                
                if doubleSvalue > Double(max) {
                    
                    showToast(view: self.view, txt: "输入数值过大")
                    
                    let numSubStr = svalue.subString(start: 0, length: svalue.length - 1)
                    beishu_money_input.text = numSubStr
                    
                    return
                }
                
            }
            
            self.selectedBeishu = Int(svalue)!
        }
        
        self.updateBottomUI()
        
        if let doubleSvalue:Double = Double(svalue) {
            if let curentOddTvNum = Float(awardNum) {
                let lastCurrentOddTVNum = Double(doubleSvalue) * Double(curentOddTvNum)
                let str = String.init(format: "%.3", lastCurrentOddTVNum)
                if let num = Double(str) {
                    bottomMoneyTV.text = "\(num)元"
                }
            }
        }
    }
    
    
    
    @objc func creditMoneyTextChange(textField:UITextField)->Void{
        let s = textField.text
        guard let svalue = s else {return}
        if isPeilvVersion(){
            if isEmptyString(str: svalue){
                self.betMoneyWhenPeilv = ""
                return
            }
            if !isPurnInt(string: svalue){
                return
            }
            
            let max = Int.max
            if let doubleSvalue:Double = Double(svalue) {
                if doubleSvalue > Double(max) {
                    
                    showToast(view: self.view, txt: "输入数值过大")
                    let numSubStr = svalue.subString(start: 0, length: svalue.length - 1)
                    creditbottomTopField.text = numSubStr
                    return
                }
            }
            
            self.betMoneyWhenPeilv = svalue
            self.updateBottomUI()
        }
    }
    
    //奖金模式点击事件
    @objc func onModeSwitch(sender:UIButton){
        show_mode_switch_dialog(sender: sender)
    }
    
    @objc func onLotSwitch(){
        self.showLotsWindow()
    }
    
    @objc func onRandomBetClick(){
        let randomView = RandomBetSelectDialog(dataSource: ["一单","五单","十单"], viewTitle: "注单选择")
        randomView.selectedIndex = 0
        randomView.didSelected = { [weak self, randomView] (index, content) in
            var orderCount = 1
            if index == 0{
                orderCount = 1
            }else if index == 1{
                orderCount = 5
            }else if index == 2{
                orderCount = 10
            }
            self?.startRandomBet(orderCount: orderCount)
        }
        self.view.window?.addSubview(randomView)
        randomView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(randomView.kHeight)
        randomView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            randomView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func startRandomBet(orderCount:Int){
        if isPeilvVersion(){
            let orders = lhcLogic.randomBet(choosePlays: peilvListDatas, orderCount: orderCount)
            if orders.isEmpty{
                showToast(view: (self.view)!, txt: "没有机选出注单，请重试")
                return
            }
            //准备数据，进入下一页主单列表
            self.formPeilvBetDataAndEnterOrderPage(order: orders,peilvs:self.peilvListDatas,lhcLogic:lhcLogic)
        }else{
            let orders = JianjinLotteryLogic.randomBet(orderCount: orderCount, cpCode: self.cpTypeCode, selectedSubCode: self.subPlayCode, peilv: officail_odds)
            if orders.isEmpty{
                showToast(view: self.view, txt: "没有机选出注单，请重试")
                return
            }
            //准备数据，进入下一页主单列表
            self.formBetDataAndEnterOrderPage(order: orders)
        }
    }
    
    @objc func onFastBetButton(){
        if is_fast_bet_mode{
            return
        }
        is_fast_bet_mode = true
//        fast_bet_button.setBackgroundImage(UIImage.init(named: "fast_bet_left_press"), for: .normal)
//        normal_bet_button.setBackgroundImage(UIImage.init(named: "normal_bet_right_normal"), for: .normal)
        switch_bottom_money_input_when_betmode_change()
        delay(0.3){
            self.clearAfterBetSuccess()
        }
    }
    
    @objc func onNormalBetButton(){
        if !is_fast_bet_mode{
            return
        }
        is_fast_bet_mode = false
//        fast_bet_button.setBackgroundImage(UIImage.init(named: "fast_bet_left_normal"), for: .normal)
//        normal_bet_button.setBackgroundImage(UIImage.init(named: "normal_bet_right_press"), for: .normal)
        switch_bottom_money_input_when_betmode_change()
        delay(0.3){
            self.clearAfterBetSuccess()
        }
    }
    
    func bindLotData(version:String) ->[LotteryData]{
        let lotterys = YiboPreference.getLotterys()
        if (isEmptyString(str:lotterys)) {
            return [];
        }
        //将彩票类型数据筛选出来
        var allDatas:[LotteryData] = []
        if let result = LotterysWraper.deserialize(from: lotterys){
            if result.success{
                allDatas.removeAll()
                for item in result.content!{
                    if item.moduleCode == 3{
                        for bean in item.subData{
                            if bean.lotVersion == Int(self.cpVersion)!{
                                allDatas.append(bean)
                            }
                        }
                    }
                }
            }
        }
        return allDatas
    }
    
    
    func showLotsWindow() -> Void {
        if lotWindow == nil{
            lotWindow = Bundle.main.loadNibNamed("lots_menu", owner: nil, options: nil)?.first as! LotsMenuView
            self.allLotDatas = self.allLotDatas + self.bindLotData(version: self.cpVersion)
        }
        lotWindow.windowDelegate = self
        lotWindow.setData(items: self.allLotDatas,lotCode:self.cpBianHao,lotName:self.cpName)
        lotWindow.show()
    }
    
    func show_mode_switch_dialog(sender:UIButton) -> Void {
        let alert = UIAlertController.init(title: "模式切换", message: nil, preferredStyle: .actionSheet)
        
        let mode = YiboPreference.getYJFMode();
        print("the mode ========= ",mode)
        if YiboPreference.getYJFMode() == YUAN_MODE{
            let action = UIAlertAction.init(title: "元", style: .default, handler: {(action:UIAlertAction) in
                self.selectModeFromDialog(title: "元")
            })
            alert.addAction(action)
        }else if YiboPreference.getYJFMode() == JIAO_MODE{
            let action1 = UIAlertAction.init(title: "元", style: .default, handler: {(action:UIAlertAction) in
                self.selectModeFromDialog(title: "元")
            })
            let action2 = UIAlertAction.init(title: "角", style: .default, handler: {(action:UIAlertAction) in
                self.selectModeFromDialog(title: "角")
            })
            alert.addAction(action1)
            alert.addAction(action2)
        }else if YiboPreference.getYJFMode() == FEN_MODE{
            let action1 = UIAlertAction.init(title: "元", style: .default, handler: {(action:UIAlertAction) in
                self.selectModeFromDialog(title: "元")
            })
            let action2 = UIAlertAction.init(title: "角", style: .default, handler: {(action:UIAlertAction) in
                self.selectModeFromDialog(title: "角")
            })
            let action3 = UIAlertAction.init(title: "分", style: .default, handler: {(action:UIAlertAction) in
                self.selectModeFromDialog(title: "分")
            })
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(action3)
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        //ipad使用，不加ipad上会崩溃
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        self.present(alert,animated: true,completion: nil)
        
    }
    
    private func selectModeFromDialog(title:String) -> Void{
        if title == "元"{
            self.selectMode = YUAN_MODE
            multiplyValue = 1.0
        }else if title == "角"{
            self.selectMode = JIAO_MODE
            multiplyValue = 0.1
        }else if title == "分"{
            self.selectMode = FEN_MODE
            multiplyValue = 0.01
        }
        modeBtn.setTitle(title, for: .normal)
        updateBottomUI()
    }
    
    //处理顶部标题栏点击事件
    @objc func titleClickEvent(recongnizer:UIPanGestureRecognizer) -> Void {
        //显示彩票版本切换弹出框
        if getLotVersionConfig() == VERSION_V1V2 || self.cpTypeCode != "9"{
            showVersionSwitchMenuWhenResponseClick()
        }
    }
    
    @objc func gotoResultsPage(){
        let page = LotteryResultsController()
        page.lotType = cpTypeCode
        page.isAttachInTabBar = false
        page.code = self.cpBianHao
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @objc func openPlayIntroduce(){
        openPlayIntroduceController(controller: self, payRule: self.playMethod, touzhu: self.detailDesc, winDemo: self.winExample)
    }
    
    @objc func onOpenNumberClick() -> Void {
        recentTableViewShowOrHide()
    }
    
    private func recentTableViewShowOrHide() {
        print("on open number click")
        self.isRecentResultOpen = !self.isRecentResultOpen
        if self.isRecentResultOpen{
            UIView.animate(withDuration: 0.3, animations: {
                self.playPaneTopConstraint.constant = 300
                self.recentTableHeightConstraint.constant = 300
                self.view.layoutIfNeeded()
            }) { ( _) in
//                self.recent_open_result_tableview.isHidden = false
            }
        }else{
//            self.recent_open_result_tableview.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.playPaneTopConstraint.constant = 0
                self.recentTableHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }) { ( _) in
//                self.recent_open_result_tableview.isHidden = true
            }
        }
    }
    
    func updateLocalConstants(lotData:LotteryData?) -> Void {
        if let lotName = lotData?.name{
            self.cpName = lotName
            update_lotname_button()
        }
        if let lotCode = lotData?.czCode{
            self.czCode = lotCode
        }
        if let lotAgo = lotData?.ago{
            self.ago = lotAgo
            self.disableBetTime = lotAgo
        }
        if let lotCpCode = lotData?.code{
            self.cpBianHao = lotCpCode
        }
        if let lotteryICON = lotData?.lotteryIcon {
            self.lotteryICON = lotteryICON
        }
        if let lotCodeType = lotData?.lotType{
            self.cpTypeCode = String.init(describing: lotCodeType)
        }
        if let lotVersion = lotData?.lotVersion{
            self.cpVersion = String.init(describing: lotVersion)
        }
        self.tickTime = self.ago + Int64(self.offset)
        if isSixMark(lotCode: self.cpBianHao){
            lhcSelect = true
            self.cpVersion = VERSION_2
        }
    }
    
    
    //获取开奖结果
    func lastOpenResult(cpBianHao:String) -> Void {
        request(frontDialog: false, url:LOTTERY_LAST_RESULT_URL,params: ["lotCode":cpBianHao,"pageSize":10],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取最近开奖结果失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = LastResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
//                            //更新开奖结果
                            if let results = result.content{
                                self.updateLastKaiJianResult(result:results);
                            }
//                            //开始请求开奖结果倒计时，时长以对应彩种中封盘时间与开奖时间差为主
                            if let timer = self.lastKaiJianResultTimer{
                                timer.invalidate()
                                self.createLastResultTimer()
                            }else{
                                self.createLastResultTimer();
                            }
                        }else{
                            if let timer = self.lastKaiJianResultTimer{
                                timer.invalidate()
                            }
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                                self.updateLastKaiJianExceptionResult(result: "没有开奖结果")
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取最近开奖结果失败"))
                                self.updateLastKaiJianExceptionResult(result: "没有开奖结果")
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                                return
                            }
                        }
                    }
        })
    }
    
    /**
     * 创建查询开奖结果倒计时
     * @param duration
     */
    func createLastResultTimer() -> Void {
        self.lastKaiJianResultTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(lastResultTickDown), userInfo: nil, repeats: true)
    }
    
    /**
     * 创建停止下注倒计时
     * @param duration
     */
    func createEndBetTimer() -> Void {
        self.endlineTouzhuTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(endBetTickDown), userInfo: nil, repeats: true)
    }
    
    @objc func endBetTickDown() -> Void {
        //将剩余时间减少1秒
        self.endBetTime -= 1
//        print("bet count time = \(self.endBetTime)")
        if self.endBetTime > 0{
            let dealDuration = getFormatTime(secounds: TimeInterval(Int64(self.endBetTime)))
            
            if isPeilvVersion() {
                self.countDownUI.theme_textColor = "Global.themeColor"
            }else {
                self.countDownUI.textColor = UIColor.white
            }
            
            self.countDownUI.text = String.init(format:"%@", dealDuration)
            
        }else if self.endBetTime == 0{
            self.countDownUI.text = String.init(format:"%@", "停止下注")
        }
        if self.endBetTime <= 0{
            //取消定时器
            if let timer = endlineTouzhuTimer{
                timer.invalidate()
            }
            let status = YiboPreference.getNotToastWhenTouzhuEnd()
            if !status{
                //弹框提示当前期号投注结束
                print("agooooo == ",ago)
                self.showToastTouzhuEndlineDialog(qihao: self.currentQihao)
//                self.createDisableBetCountDownTimer()
            }else{
                //当前期数投注时间到时，继续请求同步服务器上下一期号及离投注结束倒计时时间
                //获取下一期的倒计时的同时，获取上一期的开奖结果
                self.getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: cpVersion,controller: self)
            }
        }
    }
    
    /**
     * 创建分盘到开奖的倒计时器
     * @param duration
     */
    func createDisableBetCountDownTimer() -> Void {
        if let timer = disableBetCountDownTimer{
            timer.invalidate()
            disableBetCountDownTimer = nil
        }
        self.disableBetCountDownTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(disableBetTickDown), userInfo: nil, repeats: true)
    }
    
    @objc func disableBetTickDown() -> Void {
        //将剩余时间减少1秒
        self.disableBetTime -= 1
        //        print("bet count time = \(self.endBetTime)")
        if self.disableBetTime > 0{
            self.betBtn.backgroundColor = UIColor.lightGray
            self.betBtn.isEnabled = false
        }else if self.endBetTime == 0{
            self.betBtn.theme_backgroundColor = "Global.themeColor"
            self.betBtn.isEnabled = true
            //封盘时间结束后再次获取下一期的倒计时时间
            self.getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: self.cpVersion,controller: self)
        }
        if self.disableBetTime <= 0{
            //取消定时器
            if let timer = disableBetCountDownTimer{
                timer.invalidate()
            }
        }
    }
    
    //当前这期下注截止时间到时的弹框提示
    func showToastTouzhuEndlineDialog(qihao:String) -> Void {
        
        if !isViewVisible{
            return
        }
        let message = String.init(format: "%@期的投注已截止，投注时请注意检查当前期号是否正确！", qihao)
        let alertController = UIAlertController(title: "温馨提示",
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            action in
            self.getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: self.cpVersion,controller: self)
        })
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            self.getCountDownByCpcode(bianHao: self.cpBianHao, lotVersion: self.cpVersion,controller: self)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func lastResultTickDown() -> Void {
        //将剩余时间减少1秒
        self.tickTime -= 1
        if self.tickTime <= 0{
            //取消定时器
            if let timer = lastKaiJianResultTimer{
                timer.invalidate()
            }
            //开奖时播放开奖音
//            if YiboPreference.isPlayTouzhuVolume(){
//                playKaiJianVolume()
//            }
            //当前期数投注时间到时，继续请求同步服务器上下一期号及离投注结束倒计时时间
            //获取下一期的倒计时的同时，获取上一期的开奖结果
            self.tickTime = self.ago + Int64(self.offset)
            self.lastOpenResult(cpBianHao: self.cpBianHao)
        }
    }
    
    private func updateLastKaiJianResult() {
        
        if self.recentResults.isEmpty{
            return
        }

        let firstResult:BcLotteryData = self.recentResults[0]
        if isEmptyString(str: firstResult.qiHao) || isEmptyString(str: firstResult.haoMa){
            return
        }
        
        let qihaoStr = trimQihao(currentQihao: firstResult.qiHao)
        if isPeilvVersion() {
            let lotteryStr = String.init(format: "第 %@期 开奖结果", qihaoStr)
            let attributeString = NSMutableAttributedString(string: lotteryStr)
            attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSMakeRange(0, 2))
            
            let themeColor = self.getColorWithThemeChange()
            
            attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: themeColor, range: NSMakeRange(2, (lotteryStr.length - 2 - 5)))
            attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSMakeRange((lotteryStr.length - 4 - 1), 5))
            
            self.lastQihaoUI.attributedText = attributeString
        }else {
            self.lastQihaoUI.text = String.init(format: "第 %@期 开奖结果", qihaoStr)
            self.lastQihaoUI.textColor = UIColor.white
        }
    }
    
    /**
     * 更新开奖结果
     * @param result
     */
    func updateLastKaiJianResult(result:[BcLotteryData]) -> Void {
        
        self.recentResults.removeAll()
        if result.isEmpty{
            return
        }
        self.recentResults = self.recentResults + result
        let firstResult:BcLotteryData = result[0]
        if isEmptyString(str: firstResult.qiHao) || isEmptyString(str: firstResult.haoMa){
            return
        }
        
        self.updateLastKaiJianResult()
        
        if isEmptyString(str: firstResult.haoMa){
            return
        }
        let haomaArr = firstResult.haoMa.components(separatedBy: ",");
        var ballWidth:CGFloat = 30
        var small = false
        if isSaiche(lotType: self.cpTypeCode){
            ballWidth = 20
        }else if isFFSSCai(lotType:self.cpTypeCode){
            ballWidth = 30
            small = false
        }else if isXYNC(lotType: self.cpTypeCode){
            ballWidth = 20
        }
        numViews.isHidden = false
        exceptionNumTV.isHidden = true
        numViews.setupBalls(nums: haomaArr, offset: 0, lotTypeCode: self.cpTypeCode, cpVersion: cpVersion,ballWidth: ballWidth,small: small,ballsViewWidth: numViews.width)
        //更新底层最近开奖结果列表
        self.recent_open_result_tableview.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.accountWeb()
        }
    }
    
    func updateLastKaiJianExceptionResult(result:String) -> Void {
        numViews.isHidden = true
        exceptionNumTV.isHidden = false
        exceptionNumTV.text = result
    }
    
    @objc func click_bottom_clear_button() -> Void {
        if !isPeilvVersion(){
            if !self.official_orders.isEmpty{
                self.official_orders.removeAll()
                self.refreshPaneAndClean()
//                showToast(view: self.view, txt: "清除成功")
            }
        }else{
            if !self.honest_orders.isEmpty{
                self.honest_orders.removeAll()
            }
            self.refreshPaneAndClean()
        }
    }
    
    func refreshPaneAndClean() -> Void {
        self.clearAfterBetSuccess()
    }
    
    //MARK: 验证余额 true可以购买
    private func verifyAccountAndBet() -> Bool {
        return betShouldPayMoney <= accountBanlance
    }
    
    //底部投注按钮点击事件
    @objc func click_bet_button() -> Void {
        
        let accoundMode = YiboPreference.getAccountMode()
        if !verifyAccountAndBet() && accoundMode != 4{
            showToast(view: self.view, txt: "余额不足,请充值")
            if let meminfo = self.meminfo {
                openChargeMoney(controller: self, meminfo: meminfo)
                return
            }
        }
        
        if isPeilvVersion(){
            let errorMsg = lhcLogic.find_bet_unpass_msg(selectDatas: self.selectNumList)
            if !isEmptyString(str: errorMsg){
                showToast(view: self.view, txt: errorMsg)
                return
            }
            
            let orderJson = YiboPreference.getTouzhuOrderJson()
            if isEmptyString(str: orderJson){
                
                let message = "确定投注？"
                let alertController = UIAlertController(title: "请确认投注信息",
                                                        message: message, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    self.doPeilvBet()
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                
                //如果有选择过的存储注单，说明是从购彩列表中返回来再手选一注的，去时点下注需要再进入购彩注单页
                self.lhcLogic.clearAfterBetSuccess()
                self.selectNumList.removeAll()
                self.playPaneTableView.reloadData()
                self.clearBottomValue(clearModeAndBeiShu: true,clear_orders: false)
                
                //如果是快捷下注或多选下注时将金额框中的金额遍历存入每个注单
                if isMulSelectMode(subCode: self.selectedSubPlayCode) || is_fast_bet_mode{
                    for order in self.honest_orders{
                        
                        if !isEmptyString(str: self.betMoneyWhenPeilv) {
                            order.a = Float(self.betMoneyWhenPeilv)!
                        }
                    }
                }else{
                    var allNotMoney = true
                    var sb = ""
                    for data in self.honest_orders{
//                        data.oddName =
                        if data.a == 0{
                            sb.append("\"")
                            sb.append(!isEmptyString(str: data.c) ? data.c : "")
                            sb.append("\",")
                        }else{
                            allNotMoney = false
                        }
                    }
                    if allNotMoney{
                        showToast(view: self.view, txt: "请输入金额(整数金额)")
                        return
                    }
                    if sb.count > 0{
                        sb = (sb as NSString).substring(to: sb.count - 1)
                        showToast(view: self.view, txt: sb + "号码未输入金额,请输入后再投注")
                        return
                    }
                }
                self.formPeilvBetDataAndEnterOrderPage(order: self.honest_orders, peilvs: self.peilvListDatas, lhcLogic: self.lhcLogic)
            }
        }else{
            var total_zhushu = 0
            for order in self.official_orders{
                total_zhushu += order.n
            }
            if total_zhushu == 0{
                showToast(view: self.view, txt: "下注号码不正确，请重新选择")
                return;
            }
            //准备数据，进入下一页主单列表
            formBetDataAndEnterOrderPage(order: self.official_orders)
        }
    }
    
    //开始赔率版下注提交
    func doPeilvBet(){
        
        if selectNumList.isEmpty{
            showToast(view: self.view, txt: "请先选择号码并投注!")
            return
        }
        ////快捷投注的情况下,若没有输入投注金额则弹出键盘
        if is_fast_bet_mode || isMulSelectMode(subCode: self.selectedSubPlayCode){
            if isEmptyString(str: self.betMoneyWhenPeilv){
                showToast(view: self.view, txt: "请输入金额(整数金额)")
                self.beishu_money_input.becomeFirstResponder()
                self.creditbottomTopField.becomeFirstResponder()
                return
            }
        }
        
        //如果是快捷下注或多选下注时将金额框中的金额遍历存入每个注单
        if isMulSelectMode(subCode: self.selectedSubPlayCode) || is_fast_bet_mode{
            for order in self.honest_orders{
                order.a = Float(self.betMoneyWhenPeilv)!
            }
        }else{
            var allNotMoney = true
            var sb = ""
            for data in self.honest_orders{
                if data.a == 0{
                    sb.append("\"")
                    sb.append(!isEmptyString(str: data.c) ? data.c : "")
                    sb.append("\",")
                }else{
                    allNotMoney = false
                }
            }
            if allNotMoney{
                showToast(view: self.view, txt: "请输入金额(整数金额)")
                return
            }
            if sb.count > 0{
                sb = (sb as NSString).substring(to: sb.count - 1)
                showToast(view: self.view, txt: sb + "号码未输入金额,请输入后再投注")
                return
            }
        }
        //准备投注号码等数据
        do_peilv_bet(datas: self.honest_orders,rateback: self.current_rate)
    }
    
    //真正开始赔率下注
    /*
     @param order 下注注单
     @param rateback 用户选择的返水
     */
    func do_peilv_bet(datas:[PeilvOrder],rateback:Float){
        
        if datas.isEmpty{
            showToast(view: self.view, txt: "没有需要提交的订单，请先投注!")
            return
        }
        //构造下注POST数据
        var bets = [Dictionary<String,AnyObject>]()
        for order in datas{
            var bet = Dictionary<String,AnyObject>()
            bet["i"] = order.i as AnyObject
            bet["c"] = order.c as AnyObject
            bet["d"] = order.d as AnyObject
            bet["a"] = order.a as AnyObject
            bets.append(bet)
        }
        let postData = ["lotCode":self.cpBianHao,"data":bets,"kickback":rateback] as [String : Any]
        if (JSONSerialization.isValidJSONObject(postData)) {
            let data : NSData! = try? JSONSerialization.data(withJSONObject: postData, options: []) as NSData
            let str = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
            //do bet
            request(frontDialog: true, method: .post, loadTextStr: "正在下注...", url:DO_PEILVBETS_URL,params: ["data":str!],
                    callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "下注失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = DoBetWrapper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
                                self.accountWeb()
                                
                                //把投注成功的结果记录在常用玩法的数据库
                                let record:VisitRecords = VisitRecords()
                                record.cpName = self.cpName //名字
                                record.czCode = self.cpTypeCode //类型
                                record.ago = "0" // 时间差 传默认值
                                record.cpBianHao = self.cpBianHao //编号
                                record.lotType = self.cpTypeCode //类型
                                record.lotVersion = self.cpVersion //版本
                                record.icon = self.lotteryICON //icon
                                CommonRecords.updateRecordInDB(record: record);
                                
                                self.showBetSuccessDialog()
                                //clear select balls after bet success
                                self.clearAfterBetSuccess()
                            }else{
                                if !isEmptyString(str: result.msg){
                                    self.print_error_msg(msg: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "下注失败"))
                                }
                                //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                                //所以此接口当code == 0时表示帐号被踢，或登录超时
                                if (result.code == 0) {
                                    loginWhenSessionInvalid(controller: self)
                                    return
                                }
                            }
                        }
            })
        }
        
    }
    
    /**
     * 投注动作
     * @param selectedDatas 用户已经选择完投注球的球列表数据
     */
    func asyncPeilvBet(selectedDatas:[PeilvPlayData]) -> Void{
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                if !selectedDatas.isEmpty{
                    
                    var allNotMoney = true
                    var sb = ""
                    for item in selectedDatas{
                        if item.money == 0{
                            sb = sb + String.init(format: "%@%@%@%@", "\"", !isEmptyString(str: item.itemName) ? item.itemName+"-" : "",item.number,"\"")
                        }else{
                            allNotMoney = false
                        }
                    }
                    if isMulSelectMode(subCode: self.subPlayCode){
//                        guard let money = self.beishu_money_input.text else{
//                            showToast(view: self.view, txt: "请先输入下注金额再投注")
//                            self.beishu_money_input.becomeFirstResponder()
//                            return
//                        }
                        
                        guard let money = self.creditbottomTopField.text else{
                            showToast(view: self.view, txt: "请先输入下注金额再投注")
                            self.creditbottomTopField.becomeFirstResponder()
                            return
                        }
                        
                        
//                        if isEmptyString(str: money){
//                            showToast(view: self.view, txt: "请先输入下注金额再投注")
//                            self.beishu_money_input.becomeFirstResponder()
//                            return
//                        }
                        
                        if isEmptyString(str: money){
                            showToast(view: self.view, txt: "请先输入下注金额再投注")
                            self.creditbottomTopField.becomeFirstResponder()
                            return
                        }
                        
                        
                    }else{
//                        if allNotMoney{
//                            //择好号码，但没有输入金额时，先弹出键盘输入金额
//                            showToast(view: self.view, txt: "请先输入下注金额再投注")
//                            self.beishu_money_input.becomeFirstResponder()
//                            return
//                        }
                        
                        if allNotMoney{
                            //择好号码，但没有输入金额时，先弹出键盘输入金额
                            showToast(view: self.view, txt: "请先输入下注金额再投注")
                            self.creditbottomTopField.becomeFirstResponder()
                            return
                        }
                        
                        
                        if !isEmptyString(str: sb){
                            showToast(view: self.view, txt: String.init(format: "%@号码未输入金额,请输入后再投注", sb))
                            return
                        }
                    }
                }else{
                    showToast(view: self.view, txt: "请先选择号码并投注")
                }
            }
        }
        
    }
    
    //下注成功的时候提示框
    func showBetSuccessDialog() -> Void {
        let alertController = UIAlertController(title: "温馨提示",
                                                message: "下注成功!", preferredStyle: .alert)
        let viewAction = UIAlertAction(title: "查看记录", style: .cancel, handler: {
            action in
            self.viewLotRecord()
        })
        let okAction = UIAlertAction(title: "继续下注", style: .default, handler: {
            action in
        })
        alertController.addAction(viewAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func showRightTopMenuWhenResponseClick(ui:UIButton) -> Void {
        //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
        right_top_menu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 150-5, y: 56, width: 150, height: 250), arrowMargin: 18)
//        right_top_menu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH - 150 - 5, y: 56, width: 200, height: 250), arrowMargin: 18)
        right_top_menu.popData = right_top_datasources
//        let view = UIView.init(frame: CGRect.init(x: KSCREEN_WIDTH - 150 - 5, y: 56, width: 200, height: 250))
//        view.addSubview(right_top_menu)
//        view.bringSubview(toFront: right_top_menu)
        //点击菜单事件
        right_top_menu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.right_top_menu.dismiss()
            self?.onMenuListClick(index: index)
        }
        right_top_menu.show()
        tag += 1
//        let view = TopupFilterView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 200))
//        let popOver = Popover(options: [.blackOverlayColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))], showHandler: nil, dismissHandler: nil)
//        popOver.show(view, fromView: ui)
    }
    
    //显示下注版本切换框
    @objc func showVersionSwitchMenuWhenResponseClick() -> Void {
        //frame 为整个popview相对整个屏幕的位置 arrowMargin ：指定箭头距离右边距离
        version_top_menu = SwiftPopMenu(frame:  CGRect(x: KSCREEN_WIDTH/2 - 150/2, y: 56, width: 150, height: 100), arrowMargin: 18)
        version_top_menu.popData = version_switch_datasources
        //点击菜单事件
        version_top_menu.didSelectMenuBlock = { [weak self](index:Int)->Void in
            self?.version_top_menu.dismiss()
            self?.click_version_menu(index: index)
        }
        version_top_menu.show()
    }
    
    func click_version_menu(index:Int) {
        if !lhcSelect{
            self.cpVersion = index == 0 ? VERSION_1:VERSION_2
        }
        self.clearBottomValue(clearModeAndBeiShu: true)
        playRuleTableView.reloadData()
        swtichTouzhuHeader()
        toggleTouzhuModeSwitchAndPlayRuleIntroduce()
        //重新选择彩票版本后，需要重新获取彩种对应的玩法
        sync_playrule_from_current_lottery(lotType: self.cpTypeCode, lotCode: self.cpBianHao, lotVersion: self.cpVersion)
    }
    
    
    func swtichTouzhuHeader(){
        if isPeilvVersion(){
            topHeaderImg.isHidden = true
            topHeaderImg.image = nil
            topHeaderImg.backgroundColor = UIColor.white
            bottomDottedLine.isHidden = false
            topDottedLine.isHidden = false
            topVerticalLine.isHidden = true
        }else{
            bottomDottedLine.isHidden = true
            topDottedLine.isHidden = true
            topVerticalLine.isHidden = false
            topHeaderImg.isHidden = false
            topHeaderImg.backgroundColor = UIColor.clear
            topHeaderImg.theme_image = "TouzhOffical.topHeaderImg"
        }
        
        refreshLotteryTime()
        update_bet_header_seperator_line()
    }
    
    func toggleTouzhuModeSwitchAndPlayRuleIntroduce(){
//        if isPeilvVersion(){
//            bet_mode_switch_view.isHidden = false
//            play_introduce_view.isHidden = true
//        }else{
//            bet_mode_switch_view.isHidden = true
//            play_introduce_view.isHidden = true
//        }
    }
    
    //右上角悬浮框列表相点击回调事件
    func onMenuListClick(index:Int) -> Void {
        switch index {
        case 0://touzhu record
            viewLotRecord()
        case 1:
//            openOpenResultController(controller: self, cpName: self.cpName, cpBianMa: self.cpBianHao,cpTypeCode: self.cpTypeCode)
            gotoResultsPage()
            break
        case 2://play rule introduction
//            openPlayIntroduceController(controller: self, payRule: self.playMethod, touzhu: self.detailDesc, winDemo: self.winExample)
            var url = ""
            if isPeilvVersion(){
                url = String.init(format: "%@%@?code=%@", BASE_URL,PLAY_INTRODUCE_CREDIT_RUL,cpBianHao)
            }else{
                url = String.init(format: "%@%@?code=%@", BASE_URL,PLAY_INTRODUCE_RUL,cpBianHao)
            }
            openActiveDetail(controller: self, title: "玩法说明", content: "", foreighUrl: url)
//            openBrower(urlString: url)
//        case 3:
//            self.syncWinLost()
        case 3:
            openSetting(controller: self)
        case 4:
            switchTheme()
        case 5:
            switchSoundEffect()
        case 6://加聊天室
            self.navigationController?.pushViewController(ChatViewController(), animated: true)
        default:
            break
        }
    }
    
    //MARK:切换音效
    private func switchSoundEffect() {
        OnSoundEffectItemClick(dataSource: SoundEffects, viewTitle: "音效切换")
    }
    
    private func switchTheme() {
        onItemClick(dataSource: themes,viewTitle: "主题风格切换")
    }
    
    private func OnSoundEffectItemClick(dataSource: [String], viewTitle: String) {
        let currentSoundEffectIndex = YiboPreference.getCurrentSoundEffect()
        let selectedView = LennySelectView(dataSource: dataSource, viewTitle: viewTitle)
        selectedView.selectedIndex = currentSoundEffectIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            YiboPreference.setCurrentSoundEffect(value: index as AnyObject)
        }
        
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            
        }
    }
    
    // 切换主题风格
    private func onItemClick(dataSource: [String], viewTitle: String){
        
        let currentThmeIndex = YiboPreference.getCurrentThme()
        
        let selectedView = LennySelectView(dataSource: dataSource, viewTitle: viewTitle)
        selectedView.selectedIndex = currentThmeIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            
            let themeStr: String
            switch index {
            case 0:
                themeStr = "Red"
            case 1:
                themeStr = "Blue"
            case 2:
                themeStr = "Green"
            case 3:
                themeStr = "FrostedOrange"
            case 4:
                themeStr = "FrostedBlue"
            case 5:
                themeStr = "FrostedPurple"
            case 6:
                themeStr = "FrostedBeautyOne"
            default:
                themeStr = "Red"
            }
            
            ThemeManager.setTheme(plistName: themeStr, path: .mainBundle)
            self?.playRuleTableView.reloadData()
            self?.playPaneTableView.reloadData()
            YiboPreference.setCurrentTheme(value: index as AnyObject)
            YiboPreference.setCurrentThemeByName(value: themeStr as AnyObject)
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(onShakeStart), name: NSNotification.Name(rawValue:"shakeBegin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onShakEnd), name: NSNotification.Name(rawValue:"shakeEnd"), object: nil)
        
//        //是否开启了聊天室
//        if let sys = getSystemConfigFromJson() {
//            if sys.content.switch_chatroom == "on" {
//                right_top_datasources.append((icon:"TouzhOffical.SwiftPopMenu.sevenImage",title:"聊天室"))
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("the hidden status = \(isPlayBarHidden)")
        isViewVisible = true
        updatePlayRuleConstraint(isHidden: isPlayBarHidden)
        //同步账号
        accountWeb()
        
        showAnnounce(controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isViewVisible = false
        self.view.endEditing(true)
        YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        if let timer = self.lastKaiJianResultTimer{
            timer.invalidate()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.isPlayBarHidden = false
        //移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "shakeBegin"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "shakeEnd"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //设置侧边玩法兰列表的代理及数据原
    func initPlayRuleTable() -> Void {
        self.playRuleTableView!.delegate = self
        self.playRuleTableView!.dataSource = self
        self.playRuleTableView.separatorStyle = .none
    }
    
    func initPlayPaneTable() -> Void {
        playPaneTableView.delegate = self
        playPaneTableView.dataSource = self
        self.playPaneTableView.separatorStyle = .none
        playPaneTableView.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    
    //MARK: - 点击事件
    //MARK:遗漏 && 冷热
    @objc func clickMissingNumButton(sender:UIButton) -> Void {
        missingNumButton.isSelected = true
        coolHotButton.isSelected = false
        onMissingButton()
    }
    
    @objc func clickCoolHotButton(sender:UIButton) -> Void {
        coolHotButton.isSelected = true
        missingNumButton.isSelected = false
        onCoolHotButton()
    }
    
    @objc func clickFastModeButton(sender:UIButton) -> Void {
        fastModeButton.isSelected = true
        normalModeButton.isSelected = false
        creditBottomHistoryImg.isHidden = true
        creditBottomHistoryLabel.isHidden = true
        creditBottomHistoryButton.isHidden = true
        
        creditBottomTopFastImgBtn.isHidden = false
        bottomtopTipsLabel.isHidden = false
        creditbottomTopField.isHidden = false
        
        onFastBetButton()
        
    }
    
    @objc func clickNormalModeButton(sender:UIButton) -> Void {
        normalModeButton.isSelected = true
        fastModeButton.isSelected = false
        
        creditBottomTopFastImgBtn.isHidden = true
        bottomtopTipsLabel.isHidden = true
        creditbottomTopField.isHidden = true
        creditBottomHistoryImg.isHidden = false
        creditBottomHistoryLabel.isHidden = false
        creditBottomHistoryButton.isHidden = false
        
        onNormalBetButton()
    }
    
    private func getCodeRank(lotCode:String){
        request(frontDialog: false,method: .get,loadTextStr: "获取中...", url:API_COLD_HOT,params: ["lotCode":lotCode],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: "获取数据失败")
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = CodeRankModelWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let results = result.content{
                                self.codeRank = results
                                self.playPaneTableView.reloadData()
                            }
                        }else{
                            if isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                                return
                            }
                        }
                    }
        })
    }

    //MARK: 切换-冷热、遗漏
    func onCoolHotButton() {
        if self.codeRank == nil{
            showToast(view: self.view, txt: "还没有数据，请重试")
            return
        }
        playPaneTableView.reloadData()
    }
    
    func onMissingButton() {
        if self.codeRank == nil{
            showToast(view: self.view, txt: "还没有数据，请重试")
            return
        }
        playPaneTableView.reloadData()
    }
    
    //点击侧边玩法兰推拉条事件
    @objc func clickPlayRulePushpullBar() -> Void {
        isPlayBarHidden = !isPlayBarHidden
        self.playPaneTableView.reloadData()
        UIView.animate(withDuration: 0.3, animations: {
            if self.isPlayBarHidden{
//                if self.isPeilvVersion() {
//                    self.playRuleLayoutConstraint.constant = -kScreenWidth*0.32
//                    self.playPaneLayoutConstraint.constant = kScreenWidth*0.32
//                }else {
                    self.playRuleLayoutConstraint.constant = -kScreenWidth*0.32
                    self.playPaneLayoutConstraint.constant = kScreenWidth*0.32
//                }
            
            }else{
                self.playRuleLayoutConstraint.constant = 0
                self.playPaneLayoutConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
        }) { (finished) in
            self.updatePlayRuleConstraint(isHidden: self.isPlayBarHidden)
        }
    }
    
    func updatePlayRuleConstraint(isHidden:Bool) -> Void {
//        pullpushBar.setImage(isPlayBarHidden ? UIImage.init(named: "pull_forward") : UIImage.init(named: "pull_back"), for: .normal)
        
        pullpushButton.theme_setBackgroundImage(isPlayBarHidden ? "TouzhOffical.handleRight" : "TouzhOffical.handleLeft", forState: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            return playRules.count
        }else if tableView.tag == PLAY_PANE_TABLEVIEW_TAG{
            if !isPeilvVersion(){
                return self.ballonDatas.count
            }else{
                return self.peilvListDatas.count
            }
        }else if tableView.tag == RECENT_RESULTS_TABLEVIEW_TAG{
            return self.recentResults.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == PLAY_PANE_TABLEVIEW_TAG{
            if !isPeilvVersion(){
                let ballCount = self.ballonDatas[indexPath.row].ballonsInfo.count
                let isWeishuShow = self.ballonDatas[indexPath.row].showWeiShuView
                if !isPlayBarHidden{
                    var lines = ballCount / BALL_COUNT_PER_LINE
                    if ballCount > BALL_COUNT_PER_LINE{
                        if ballCount % BALL_COUNT_PER_LINE != 0{
                            lines = lines + 1
                        }
                    }
                    if lines == 0{
                        lines = lines + 1
                    }
//                    var height = CGFloat(CGFloat(lines)*44+65)
                    var height = CGFloat(CGFloat(lines)*44+50)
                    if isWeishuShow!{
                        height = height + 30
                    }
                    return height
                }else{
                    var lines = ballCount / BALL_COUNT_PER_LINE_WHEN_EXPAND
                    if ballCount > BALL_COUNT_PER_LINE_WHEN_EXPAND{
                        if ballCount % BALL_COUNT_PER_LINE_WHEN_EXPAND != 0{
                            lines = lines + 1
                        }
                    }
                    if lines == 0{
                        lines = lines + 1
                    }
                    var height = CGFloat(CGFloat(lines)*40+65)
                    if isWeishuShow!{
                        height = height + 30
                    }
                    return height
                }
            }else{
//                let data = self.peilvListDatas[indexPath.row]
                let specialPlay = lhcLogic.isSingleLineLayout()
                if specialPlay{
                    let cellHeight = self.peilvListDatas[indexPath.row].peilvs.count
                    return CGFloat(cellHeight*44 + 30 + 10)
                }else{
                    let cellHeight = self.peilvListDatas[indexPath.row].peilvs.count
                    var height = cellHeight/2
                    if cellHeight%2 > 0{
                        height += 1
                    }
//                    return CGFloat(height*(is_fast_bet_mode ? 70 : 105) + 30 + height)
                    return CGFloat(height*(is_fast_bet_mode ? 46 : 75) + 30)
                }
                
            }
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let _:UITableViewCell!
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            
            guard let cell = playRuleTableView.dequeueReusableCell(withIdentifier: "ruleCell") as? PlayRuleCell  else {
                fatalError("The dequeued cell is not an instance of PlayRuleCell.")
            }
            let row = indexPath.row
            let subRules = self.playRules[row]
            cell.setupUI(name: subRules.name, isSelected: self.selected_rule_position == indexPath.row)
            return cell
            
        }else if tableView.tag == RECENT_RESULTS_TABLEVIEW_TAG{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recent") as? RecentResultCell  else {
                fatalError("The dequeued cell is not an instance of RecentResultCell.")
            }
            let data = self.recentResults[indexPath.row]
            cell.setupData(qihao: data.qiHao, nums: data.haoMa, cpCode: self.cpTypeCode, cpVersion: self.cpVersion)
            return cell
        }else if tableView.tag == PLAY_PANE_TABLEVIEW_TAG{
            if !isPeilvVersion(){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "paneCell") as? JianjinPaneCell  else {
                    fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
                }
                //bind cell delegate
                cell.cpTypeCode = self.cpTypeCode
                cell.playCode = self.subPlayCode
                cell.btnsDelegate = self
                
                let ruleTestStr: String! = self.ballonDatas[indexPath.row].ruleTxt
                cell.ruleUI.layer.cornerRadius = 10
                
                if ruleTestStr != nil {
                    cell.ruleUI.setTitle(ruleTestStr, for: .normal)
                    let ruleTxtWidth = String.getStringWidth(str: ruleTestStr!, strFont: 12, h: 25)
                    cell.ruleUIConstraintWidth.constant = ruleTxtWidth <= CGFloat(65) ? CGFloat(65) : (ruleTxtWidth + CGFloat(10))
                }
                
                
                cell.weishuView.cellDelegate = self
                cell.funcView.cellDelegate = self
                cell.weishuView.cellPos = indexPath.row
                cell.funcView.cellPos = indexPath.row
                cell.toggleWeishuView(show: self.ballonDatas[indexPath.row].showWeiShuView)

                cell.initFuncView(playRuleShow:!isPlayBarHidden)
                
                if self.ballonDatas[indexPath.row].showWeiShuView{
                    cell.weishuView.setData(array: self.ballonDatas[indexPath.row].weishuInfo,playRuleShow:!isPlayBarHidden)
                }
                
                if let cr = self.codeRank{
                    if !cr.isEmpty{
                        if indexPath.row < cr.count{
                            let isColdHot = self.coolHotButton.isSelected && !self.missingNumButton.isSelected
                            cell.fillBallons(balls: self.ballonDatas[indexPath.row].ballonsInfo,codeRank: cr[indexPath.row],
                                             isColdHot:isColdHot,showCodeRank:self.showCodeRank)
                        }else{
                            cell.fillBallons(balls: self.ballonDatas[indexPath.row].ballonsInfo,showCodeRank:false)
                        }
                    }else{
                        cell.fillBallons(balls: self.ballonDatas[indexPath.row].ballonsInfo,showCodeRank:self.showCodeRank)
                    }
                }else{
                    cell.fillBallons(balls: self.ballonDatas[indexPath.row].ballonsInfo,showCodeRank:self.showCodeRank)
                }
                
                let shouldHideWeiShuView = !self.ballonDatas[indexPath.row].showWeiShuView
                let shouldHideFunctionView = !self.ballonDatas[indexPath.row].showFuncView
                cell.weishuView.isHidden = shouldHideWeiShuView
                cell.funcView.isHidden = shouldHideFunctionView
                
                return cell
            } else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "peilvCell") as? PeilvTouzhuCell  else {
                    fatalError("The dequeued cell is not an instance of peilvCell.")
                }
                cell.cellDelegate = self
                if !self.peilvListDatas.isEmpty{
                    if indexPath.row >= self.peilvListDatas.count{
                        return cell
                    }
                    let data = self.peilvListDatas[indexPath.row]
                    cell.cellRow = indexPath.row
                    cell.is_play_bar_show = !self.isPlayBarHidden
                    cell.setupData(data: data,mode:is_fast_bet_mode,specialMode: lhcLogic.isSingleLineLayout(),
                       cpCode: self.cpTypeCode,cpVerison: self.cpVersion,lotCode: self.cpBianHao)
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == PLAY_RULE_TABLVIEW_TAG{
            let select_rule = self.playRules[indexPath.row]
            self.handlePlayRuleClick(playData: select_rule,position: indexPath.row)
        }else if tableView.tag == RECENT_RESULTS_TABLEVIEW_TAG {
            recentTableViewShowOrHide()
        }
    }
    
    //侧边玩法兰列表项点击事件
    func handlePlayRuleClick(playData:BcLotteryPlay,position:Int) -> Void {
        
        selected_rule_position = position
        if playData.status != 2{
            showToast(view: self.view, txt: "该玩法已被关闭使用，开关此玩法请至平台配置")
            return
        }
        
        //当切换到其他玩法时，将保存的下注注单清空
        if playData.code != self.subPlayCode{
            YiboPreference.saveTouzhuOrderJson(value: "" as AnyObject)
        }
        self.subPlayCode = playData.code
        self.subPlayName = playData.name
        self.winExample = playData.winExample
        self.detailDesc = playData.detailDesc
        self.playMethod = playData.playMethod
        
        //更新玩法label
        update_rule_label(playname: self.subPlayName)
        update_title_label()
        
        //重新刷新投注面板
        if !isPeilvVersion(){
            refreshButtons()
            //figure out play ballons
            clearBottomValue(clearModeAndBeiShu: true)
            //根据彩票版本和玩法确定下注球列表数据
            let ballonRules = form_jianjing_pane_datasources(lotType: cpTypeCode, subCode: self.subPlayCode)
            ballonDatas.removeAll()
            self.ballonDatas = self.ballonDatas + ballonRules
            self.playPaneTableView.reloadData()
            self.scrollToTop()
            //获取奖金版玩法对应的赔率信息
            sync_official_peilvs_after_playrule_click(lotType: self.cpTypeCode, playCode: self.subPlayCode,showDialog: true)
        }else{
            //获取到玩法栏数据后，再根据选择玩法栏的所有子玩法code，获取子玩法下所有投注号码的赔率列表数据
            //开始网络获取
            self.getOddsFromAllPlayCodes(selectPlayBarPos: position, showDialog: true)
        }
        self.playRuleTableView.reloadData()
    }
    
    //根据所有玩法获取赔率列表
    func getOddsFromAllPlayCodes(selectPlayBarPos:Int,showDialog:Bool) -> Void{
        var playCodes = ""
        if playRules.isEmpty{
            return
        }
        if selectPlayBarPos < playRules.count{
            //根据每一行的玩法code，从赔率表中获取对应的号码球赔率数据集
            let play = playRules[selectPlayBarPos]
            let children:[BcLotteryPlay] = play.children
            if !children.isEmpty{
                for p in children{
                    playCodes += p.code
                    playCodes.append(",")
                }
            }
            if playCodes.hasSuffix(","){
                playCodes = (playCodes as NSString).substring(to: playCodes.count - 1)
            }
            sync_honest_plays_odds_obtain(lotCategoryType: self.cpTypeCode, subPlayCode: playCodes, showDialog: showDialog)
        }
    }
    
    func update_rule_label(playname:String) -> Void {
        current_play_label.text = playname
    }
    
    func update_title_label(){
        let title:String = self.cpVersion == VERSION_1 ? "官方下注" : "信用下注"
        titleBtn.setTitle(title, for: .normal)
        
//        let navigationBarApperance = UINavigationBar.appearance()
//        navigationBarApperance.theme_tintColor = "Global.barTextColor" // navBar的文字颜色
//        navigationBarApperance.theme_barTintColor = "Global.barTintColor" // bar的背景色
        titleBtn.theme_setTitleColor("Global.barTextColor", forState: .normal)
    }
    
    //将玩法球列表滚动到第一行
    func scrollToTop() -> Void{
//        if ballonDatas.isEmpty{
//            return
//        }
        if isPeilvVersion(){
            self.playPaneTableView.scrollToRow(at: IndexPath.init(item: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
        }
    }
    
    
    //是否赔率版下注
    func isPeilvVersion() ->  Bool{
        if self.cpVersion == VERSION_2 || lhcSelect{
            return true
        }
        return false
    }
    
    //点击“万千百十个”位数按钮时的响应动作
    func clickWeiBtns(weiTag:Int,cellPos:Int,btnIndex:Int) -> Void {
        switch weiTag {
        default:
            let cell = self.playPaneTableView.cellForRow(at: IndexPath.init(row: cellPos, section: 0)) as! JianjinPaneCell
            let isSelected = self.ballonDatas[cellPos].weishuInfo?[btnIndex].isSelected
            let weiBtn = cell.viewWithTag(weiTag) as! UIButton
            print("btn tag = \(weiBtn.tag)")
            if !isSelected! {
                weiBtn.setTitleColor(UIColor.white, for: .normal)
                weiBtn.theme_backgroundColor = "Global.themeColor"
            }else{
                weiBtn.backgroundColor = UIColor.white
                weiBtn.layer.theme_borderColor = "Global.themeColor"
                weiBtn.theme_setTitleColor("Global.themeColor", forState: .normal)
            }
            
            self.ballonDatas[cellPos].weishuInfo?[btnIndex].isSelected = !isSelected!
        }
    }
    
    //点击“万千百十个”位数按钮时的响应动作
//    func clickWeiShuBtns(weiTag:Int,cellPos:Int,btnIndex:Int) -> Void {
//
//        let cell = self.playPaneTableView.cellForRow(at: IndexPath.init(row: cellPos, section: 0)) as! JianjinPaneCell
//        let isSelected = self.ballonDatas[cellPos].weishuInfo?[btnIndex].isSelected
//        let weiBtn = cell.viewWithTag(weiTag) as! UIButton
//        print("btn tag = \(weiBtn.tag)")
//
//            weiBtn.setTitleColor(UIColor.white, for: .normal)
//            weiBtn.backgroundColor = UIColor.red
//
////            weiBtn.setTitleColor(UIColor.black, for: .normal)
////            weiBtn.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
//
//    }
    
    
    //奖金版下注时--点击每个列玩法球中的辅助功能按钮的响应事件
    func onBtnsClickCallback(btnTag: Int, cellPos: Int) {
        print("the btntag = \(btnTag),the cell pos = \(cellPos)")
        
        if YiboPreference.isPlayTouzhuVolume(){
            playVolume()
        }
        switch btnTag {
        case 20,21,22,23,24://wan
            clickWeiBtns(weiTag: btnTag, cellPos: cellPos,btnIndex: btnTag - 20)
        //all
        case 10:
            let ball = self.ballonDatas[cellPos]
            for ballNumInfo in ball.ballonsInfo{
                ballNumInfo.isSelected = true
            }
            self.playPaneTableView.reloadData()
            break
        //big
        case 11:
            self.clickBigSmall(isBig: true, cellPos: cellPos)
            break
        //small
        case 12:
            self.clickBigSmall(isBig: false, cellPos: cellPos)
            break
        //single
        case 13:
            self.clickSingleDouble(isSingle: true, cellPos: cellPos)
            break
        //doule
        case 14:
            self.clickSingleDouble(isSingle: false, cellPos: cellPos)
            break
        case 15:
            let ball = self.ballonDatas[cellPos]
            for ballNumInfo in ball.ballonsInfo{
                ballNumInfo.isSelected = false
            }
            self.playPaneTableView.reloadData()
            break
        default:
            break
        }
    
//        if btnTag == 10 || btnTag == 11 || btnTag == 12 || btnTag == 13 || btnTag == 14 || btnTag == 15  {
//            clickWeiShuBtns(weiTag: btnTag, cellPos: cellPos,btnIndex: btnTag)
//        }
        
        onNumBallClickCallback(number: "", cellPos: 0)
    }
    
    //清除下注底部兰的视图数据
    func clearBottomValue(clearModeAndBeiShu: Bool,clear_orders:Bool=true) -> Void {
        if clearModeAndBeiShu {
            selectMode = "y";
            selectedBeishu = 1;//选择的倍数
        }
        selectedMoney = 0;//总投注金额
        if clear_orders{
            self.betMoneyWhenPeilv = ""
            self.honest_orders.removeAll()
            self.official_orders.removeAll()
        }
        totalPeilvMoney = 0
        clearBottomUIValue()

    }
    
    func clearBottomUIValue(){
        

        if self.selectMode == YUAN_MODE {
            modeBtn.setTitle("元", for: .normal)
            multiplyValue = 1.0
        }else if self.selectMode == JIAO_MODE {
            modeBtn.setTitle("角", for: .normal)
            multiplyValue = 0.1
        }else if self.selectMode == FEN_MODE {
            modeBtn.setTitle("分", for: .normal)
            multiplyValue = 0.01
        }
        
        if isPeilvVersion(){
//            beishu_money_input.text = ""
            creditbottomTopField.text = ""
            bottomZhushuTV.isHidden = true
            bottomMoneyTV.text = String.init(format: "共%d注,%.1f元", 0,0)
        }else{
            bottomZhushuTV.isHidden = false
            beishu_money_input.text = "1"
            bottomZhushuTV.text = "共选0注，共0.0元"
            bottomMoneyTV.text = String.init(format: "奖金0.0元")
        }
        
    }
    
    func clearAfterBetSuccess() -> Void {
        if !isPeilvVersion(){
            for ball in self.ballonDatas{
                for ballNumInfo in ball.ballonsInfo{
                    ballNumInfo.isSelected = false
                }
                if ball.showWeiShuView{
                    for weishuData in ball.weishuInfo{
                        weishuData.isSelected = false
                    }
                }
            }
        }else{
            for peilvData in self.peilvListDatas{
                let sub = peilvData.peilvs
                for item in sub{
                    item.isSelected = false
                    item.inputMoney = 0
                }
            }
        }
//        self.lhcLogic.clearAfterBetSuccess()
        self.selectNumList.removeAll()
        self.playPaneTableView.reloadData()
//        scrollToTop()
        clearBottomValue(clearModeAndBeiShu: true)
    }
    
    func playVolume() -> Void{
//        var soundID:SystemSoundID = 0
        //get volume file path

        let pathIndex = YiboPreference.getCurrentSoundEffect()
        let pathStr = SoundEffectPaths[pathIndex]
        let path = Bundle.main.path(forResource: pathStr, ofType: "mp3")
        playSoundWithPath(path: path!)
//        let baseURL = NSURL(fileURLWithPath: path!)
//        //赋值
//        AudioServicesCreateSystemSoundID(baseURL, &soundID)
//        //播放声音
//        AudioServicesPlaySystemSound(soundID)
    }
    
    
    private func playSoundWithPath(path: String){
        let url = NSURL(fileURLWithPath: path)
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url as URL)
            bombSoundEffect?.play()
        } catch {
            print("音频文件找不到了")
        }
    }
    
    func playKaiJianVolume() -> Void{
//        var soundID:SystemSoundID = 0
        //get volume file path
        let path = Bundle.main.path(forResource: "open_result", ofType: "mp3")
        playSoundWithPath(path: path!)
//        let baseURL = NSURL(fileURLWithPath: path!)
//        //赋值
//        AudioServicesCreateSystemSoundID(baseURL, &soundID)
//        //播放声音
//        AudioServicesPlaySystemSound(soundID)
    }
    
    func playVolumeWhenStartShake() -> Void {
//        var soundID:SystemSoundID = 0
        //get volume file path
        let path = Bundle.main.path(forResource: "rock", ofType: "mp3")
        playSoundWithPath(path: path!)
//        let baseURL = NSURL(fileURLWithPath: path!)
//        //赋值
//        AudioServicesCreateSystemSoundID(baseURL, &soundID)
//        //播放声音
//        AudioServicesPlaySystemSound(soundID)
    }
    
    func playVolumeWhenEndShake() -> Void {
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
//        var soundID:SystemSoundID = 0
        //get volume file path
        let path = Bundle.main.path(forResource: "rock_end", ofType: "mp3")
        playSoundWithPath(path: path!)
//        let baseURL = NSURL(fileURLWithPath: path!)
//        //赋值
//        AudioServicesCreateSystemSoundID(baseURL, &soundID)
//        //播放声音
//        AudioServicesPlaySystemSound(soundID)
    }
    
    //奖金版号码选择时回调的方法
    func onNumBallClickCallback(number: String, cellPos: Int) {
        //播放按键音
        if YiboPreference.isPlayTouzhuVolume(){
            playVolume()
        }
        //选择球的时候清除本地已选择的金额，倍数，注数等
        clearBottomValue(clearModeAndBeiShu: false)
        //开始计算投注号码串及注数
        calc_bet_orders(selectedDatas: self.ballonDatas)
//        dobet_when_click(selectedDatas: ballonDatas, czCode: self.cpTypeCode, subCode: self.subPlayCode,cellPos: cellPos)
    }
    
    private func convertYJFModeToInt(mode:String) -> Int {
        if mode == YUAN_MODE {return 1}
        else if mode == JIAO_MODE {return 10}
        else if mode == FEN_MODE {return 100}
        else {return 1}
    }
    
    /**
     * 开始计算投注号码串及注数
     * @param selectedDatas 非机选投注时，用户已经选择完投注球的球列表数据
     * @param cpVersion 彩票版本
     * @param czCode 彩种代号
     * @param subCode 小玩法
     */
    func calc_bet_orders(selectedDatas:[BallonRules]) -> Void {
        DispatchQueue.global().async {
            
            
//            let orders = LotteryOrderManager.calcOrders(list: selectedDatas, rcode: self.subPlayCode, lotType: Int(self.cpTypeCode)!, rateback: 0, mode: 1, beishu: self.selectedBeishu, oddsList: self.officail_odds)
            let modeInt = self.convertYJFModeToInt(mode: self.selectMode)
            
            let orders = LotteryOrderManager.calcOrders(list: selectedDatas, rcode: self.subPlayCode, lotType: Int(self.cpTypeCode)!, rateback: 0, mode: modeInt, beishu: self.selectedBeishu, oddsList: self.officail_odds)
            
            DispatchQueue.main.async {
                self.official_orders.removeAll()
                self.official_orders = self.official_orders + orders
                
                //更新一些特殊玩法的拖动条
                if self.subPlayCode == "qwxczw" || self.subPlayCode == "qwxdds" ||
                    self.subPlayCode == "k3hz2"{
                    self.update_slide_when_user_select_number()
                }
                self.updateBottomUI()
            }
        }
    }
//
//    func updateSeekbarWithUserSelect(results:[PeilvWebResult],selectData:[OfficialOrder]){
//        if results.isEmpty || selectData.isEmpty{
//            CustomSlider
//            return
//        }
//    }
    
    /**
     * 开始计算投注号码串及注数(赔率版)
     * @param datasAfterSelected 非机选投注时，用户已经选择完投注号码的所有赔率列表数据
     */
    func calc_bet_orders_for_honest(datasAfterSelected:[BcLotteryPlay]) -> Void {
        DispatchQueue.global().async {
            self.selectNumList.removeAll()
            for play in self.peilvListDatas{
                if !play.peilvs.isEmpty{
                    for result in play.peilvs{
                        if result.isSelected{
                            self.selectNumList.append(result)
                        }
                    }
                }
            }
            print("select num count = ",self.selectNumList.count)
            let datas = self.lhcLogic.calcOrder(selectDatas: self.selectNumList)
            DispatchQueue.main.async {
                self.honest_orders.removeAll()
                self.honest_orders = self.honest_orders + datas
                self.updateBottomUI()
            }
        }
    }
    
    //准备住单数据并进入主单列表页
    func formBetDataAndEnterOrderPage(order:[OfficialOrder]) {
        let order = fromBetOrder(official_orders: order, subPlayName: self.subPlayName, subPlayCode: self.subPlayCode, selectedBeishu: self.selectedBeishu, cpTypeCode: self.cpTypeCode, cpBianHao: self.cpBianHao, current_rate: self.current_rate, selectMode: self.selectMode)
        clearAfterBetSuccess()
        openBetOrderPage(controller: self, data: order,lotCode: self.cpBianHao,lotName: self.cpName,subPlayCode: self.subPlayCode,subPlayName: self.subPlayName,cpTypeCode: self.cpTypeCode,cpVersion:self.cpVersion,officail_odds:self.officail_odds,icon: self.lotteryICON,meminfo:self.meminfo)
    }
    
    func formPeilvBetDataAndEnterOrderPage(order:[PeilvOrder],peilvs:[BcLotteryPlay],lhcLogic:LHCLogic2) {
        let datas = fromPeilvBetOrder(peilv_orders: order, subPlayName: self.subPlayName, subPlayCode: self.subPlayCode, cpTypeCode: self.cpTypeCode, cpBianHao: self.cpBianHao, current_rate: self.current_rate)
        clearAfterBetSuccess()
        openPeilvBetOrderPage(controller: self, order: datas, peilvs: peilvs, lhcLogic: lhcLogic, subPlayName: subPlayName, subPlayCode: self.subPlayCode, cpTypeCode: self.cpTypeCode, cpBianHao: self.cpBianHao, current_rate: self.current_rate, cpName: self.cpName,cpversion: self.cpVersion,icon:self.lotteryICON)
    }
    
    func syncWinLost() -> Void {
        request(frontDialog: true, method: .get, url:WIN_LOST_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = WinLostWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            guard let content = result.content else {return}
                            self.showWinLostDialog(result:  content)
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                                return
                            }
                        }
                    }
        })
        
    }
    
    func showWinLostDialog(result:WinLost) -> Void {
        if !isViewVisible{
            return
        }
        let message = String.init(format: "今日消费:%.3f元\n今日中奖:%.3f元\n今日盈亏:%.3f元", result.allBetAmount,result.allWinAmount,result.yingkuiAmount)
        let alertController = UIAlertController(title: "今日输赢",
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //更新底部视图数据
    func updateBottomUI() -> Void {
        if !isPeilvVersion(){
            var zhushu = 0
            var total_money:Float = 0.0
            let currend_mode:Int = convertPostMode(mode: self.selectMode)
            if !self.official_orders.isEmpty{
                for item in self.official_orders{
                    zhushu += item.n
                    if currend_mode > 0{
//                        let money = Float((zhushu*self.selectedBeishu*2)/currend_mode)
//                        total_money += item.a
                    }
                }
            }
            total_money = (Float(zhushu) * Float(self.selectedBeishu) * Float(2))
//                / Float(currend_mode)
//            let total_win = current_odds - Float(zhushu*2)
            bottomZhushuTV.isHidden = false
            
            let total_moneyStr = String.init(format: "%.3f",(total_money * multiplyValue))
            if let total_moneyFloat = Float(total_moneyStr) {
                betShouldPayMoney = Double(total_moneyFloat)
                bottomZhushuTV.text = String.init(format: "共选%d注,共%.2f元",zhushu,total_moneyFloat)
            }
            
            let bottomMoneyStr = String.init(format: "%.3f",current_odds * multiplyValue * Float(selectedBeishu))
            if let bottomMoneyFloat = Double(bottomMoneyStr) {
                bottomMoneyTV.text = String.init(format: "奖金\(bottomMoneyFloat)元")
            }
            
            let awardStr = String.init(format: "%.3f", self.current_odds * multiplyValue)
            if let awardFloat = Double(awardStr) {
                currentOddTV.text = "\(awardFloat)元"
            }
            
        }else{
            
            var zhushu = 0
            var total_money:Float = 0.0
            if !self.honest_orders.isEmpty{
                for item in self.honest_orders{
                    zhushu += 1
                    if is_fast_bet_mode && !isEmptyString(str: self.betMoneyWhenPeilv){
                        total_money += Float(self.betMoneyWhenPeilv)!
                        betShouldPayMoney = Double(total_money)
                    }else{
                        total_money += item.a
                    }
                }
            }
            bottomZhushuTV.isHidden = true
            bottomMoneyTV.text = String.init(format: "%d注,%.3f元", zhushu,total_money)
        }
    }
    
    func clickBigSmall(isBig:Bool,cellPos:Int) -> Void{
        let ball = self.ballonDatas[cellPos]
        for index in 0...ball.ballonsInfo.count-1{
            if index >= ball.ballonsInfo.count/2{
                ball.ballonsInfo[index].isSelected = isBig ? true : false
            }else{
                ball.ballonsInfo[index].isSelected = isBig ? false : true
            }
        }
        self.playPaneTableView.reloadData()
    }
    
    func clickSingleDouble(isSingle:Bool,cellPos:Int) -> Void {
        let ball = self.ballonDatas[cellPos]
        for ballInfo in ball.ballonsInfo{
            if isPurnInt(string: ballInfo.num){
                let scanner = Scanner(string: ballInfo.num)
                scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
                var number :Int = 0
                scanner.scanInt(&number)
                if !isSingle{
                    if number % 2 == 0{
                        ballInfo.isSelected = true
                    }else{
                        ballInfo.isSelected = false
                    }
                }else{
                    if number % 2 == 0{
                        ballInfo.isSelected = false
                    }else{
                        ballInfo.isSelected = true
                    }
                }
            }else{
                ballInfo.isSelected = false
            }
        }
        self.playPaneTableView.reloadData()
    }
    
    /**
     * 开始获取当前期号离结束投注倒计时
     * @param bianHao 彩种编号
     * @param lotVersion 彩票版本
     */
    func getCountDownByCpcode(bianHao:String,lotVersion:String,controller:BaseController) -> Void {
        request(frontDialog: false, url:LOTTERY_COUNTDOWN_URL,params:["lotCode":bianHao,"version":lotVersion],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取当前期号失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        self.currentQihao = "????";
                        self.countDownUI.text = "00 : 00 : 00"
                        self.currentQihaoUI.text = self.currentQihao
                        return
                    }
                    if let result = LocCountDownWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            //更新当前这期离结束投注的倒计时显示
                            if let value = result.content{
                                self.updateCurrenQihaoCountDown(countDown: value)
                            }
                        }else{
                            self.currentQihao = "????";
                            self.currentQihaoUI.text = self.currentQihao
                            self.countDownUI.text = "00 : 00 : 00"
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取当前期号失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    private func updateCurrenQihao() {
        let lotteryStr = String.init(format: "距第 %@期", trimQihao(currentQihao: self.currentQihao))
        if isPeilvVersion() {
            let attributeString = NSMutableAttributedString(string: lotteryStr)
            attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSMakeRange(0, 3))
            
            let themeColor = self.getColorWithThemeChange()
            
            attributeString.addAttribute(NSAttributedStringKey.foregroundColor, value: themeColor, range: NSMakeRange(3, (lotteryStr.length - 3)))
            
            self.currentQihaoUI.attributedText = attributeString
        }else {
            self.currentQihaoUI.textColor = UIColor.white
            self.currentQihaoUI.text = lotteryStr
        }
    }
    
    func updateCurrenQihaoCountDown(countDown:CountDown) -> Void {
        //创建开奖周期倒计时器
        let serverTime = countDown.serverTime;
        let activeTime = countDown.activeTime;
        let value = abs(activeTime) - abs(serverTime)
        self.endBetDuration = Int(abs(value))/1000

        self.endBetTime = self.endBetDuration
        self.currentQihao = countDown.qiHao
        let dealDuration = getFormatTime(secounds: TimeInterval(Int64(self.endBetDuration)))
        self.countDownUI.text = String.init(format:"%@", dealDuration)

        
        updateCurrenQihao()
        
        if let timer = self.endlineTouzhuTimer{
            timer.invalidate()
        }
        self.createEndBetTimer()
    }
    
    private func getColorWithThemeChange() -> UIColor {
        
        let themeBgName = YiboPreference.getCurrentThmeByName()
        if themeBgName == "FrostedOrange" {
            return UIColor.white
        }else {
            return UIColor.red
        }
    }
    
    
//    @objc func onShakeStart(info:NSNotification)->Void{
//        if !YiboPreference.getShakeTouzhuStatus(){
//            return
//        }
//        playVolumeWhenStartShake()
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//    }
    
    
//    @objc func onEndShake(info:NSNotification)->Void{
//        if !YiboPreference.getShakeTouzhuStatus(){
//            onRandomBetClick()
//            return
//        }
//        playVolumeWhenEndShake()
//        //选择球的时候清除本地已选择的金额，倍数，注数等
//        clearBottomValue(clearModeAndBeiShu: false)
//        //开始计算投注号码串及注数
////        dobet_when_click(selectedDatas: ballonDatas, czCode: self.cpTypeCode, subCode: self.subPlayCode)
//    }
    
    
    //摇一摇结束的通知   let theViewControllerYouSee = UIViewController.currentViewController()
    @objc func onShakEnd(nofi : Notification){
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
//        let theViewControllerYouSee = UIViewController.c
//        if nofi.name.rawValue == "shakeEnd" {
            playVolumeWhenEndShake();
            self.startRandomBet(orderCount: 1)
//        }
    }
    
    //摇一摇开始的通知
    @objc func onShakeStart(nofi : Notification){
        if !YiboPreference.getShakeTouzhuStatus(){
            return
        }
//        if nofi.name.rawValue == "shakeBegin" {
            playVolumeWhenStartShake()
//        }
    }
    
    
    private func update_slide_when_peilvs_obtain(){
        if !isPeilvVersion(){
            //这里根据赔率列表来决定是否显示返水拖动条
            if officail_odds.isEmpty{
                return
            }
            var rightResult:PeilvWebResult!
            for odd in self.officail_odds{
                if rightResult != nil{
                    if odd.maxOdds > rightResult.maxOdds{
                        rightResult = odd
                    }
                }else{
                    rightResult = odd
                }
            }
            if rightResult != nil{
                oddSlider.isHidden = false
                oddSlider.setupLogic(odd: rightResult)
                
                creditbottomTopSlider.isHidden = false
                creditbottomTopSlider.setupLogic(odd: rightResult)
            }else{
//                oddSlider.isHidden = true
            }
        }
    }
    
    private func update_slide_when_user_select_number(){
        if !isPeilvVersion(){
            //这里根据赔率列表来决定是否显示返水拖动条
            if officail_odds.isEmpty{
                return
            }
            var rightMaxOdds:Float = 0.0;
            var rightMinOdds:Float = 0.0;
            var rightRakeback:Float = 0.0;
            
            for order in self.official_orders{
                var peilv:PeilvWebResult!
                for result in self.officail_odds{
                    if order.i == result.code{
                        peilv = result
                        break;
                    }
                }
                if peilv == nil && !self.officail_odds.isEmpty{
                    peilv = self.officail_odds[0]
                }
                if peilv != nil{
                    if peilv.maxOdds > rightMaxOdds{
                        rightMaxOdds = peilv.maxOdds
                    }
                    if peilv.minOdds > rightMinOdds{
                        rightMinOdds = peilv.minOdds
                    }
                    rightRakeback = peilv.rakeback
                }
            }
            if rightRakeback > 0{
                oddSlider.isHidden = false
                oddSlider.setupLogic(maxRakeback: rightRakeback, maxOdds: rightMaxOdds, minOdds: rightMinOdds)
            }else{
                oddSlider.isHidden = true
            }
        }
    }
    
    //根据侧边大玩法对应的所有小玩法列表，来取出最大的返水比例
    func update_honest_seekbar(selectPlay:BcLotteryPlay,odds:[HonestResult]){
        //这里根据赔率列表来决定是否显示返水拖动条
        if isEmptyString(str: cpTypeCode) || isEmptyString(str: selectedSubPlayCode){
            return
        }
        var maxOddResult:PeilvWebResult!
        if !odds.isEmpty{
            for subPlay in selectPlay.children{
                for result in odds{
                    if subPlay.code == result.code{
                        for odd in result.odds{
                            if maxOddResult == nil{
                                maxOddResult = odd
                            }else{
                                if odd.rakeback > maxOddResult.rakeback{
                                    maxOddResult = odd
                                }
                            }
                        }
                        break
                    }
                }
            }
        }
        oddSlider.setupLogic(odd: maxOddResult)
        creditbottomTopSlider.setupLogic(odd: maxOddResult)
    }
    
    /**
     * 根据小玩法及彩种编码获取奖金版对应的赔率信息
     * @param lotCategoryType 彩种类型编码
     * @param playCode 玩法代号
     * @param showDialog
     */
//    func sync_official_peilvs_after_playrule_click(lotType:String,playCode:String,showDialog:Bool) -> Void{
//
//        let params:Dictionary<String,AnyObject> = ["playCode":playCode as AnyObject,"lotType":lotType as AnyObject,"version":VERSION_1 as AnyObject]
//
//        request(frontDialog: showDialog, loadTextStr:"赔率获取中..",url:GET_JIANJIN_ODDS_URL,params:params,
//                callback: {(resultJson:String,resultStatus:Bool)->Void in
//                    if !resultStatus {
//                        if resultJson.isEmpty {
//                            showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
//                        }else{
//                            showToast(view: self.view, txt: resultJson)
//                        }
//                        return
//                    }
//                    if let result = PeilvWebResultWraper.deserialize(from: resultJson){
//                        if result.success{
//                            YiboPreference.setToken(value: result.accessToken as AnyObject)
//                            self.officail_odds.removeAll()
//                            self.officail_odds = self.officail_odds + result.content
//                            //选出返水比例值并同步拖动条
//                            self.update_slide_when_peilvs_obtain()
//                        }else{
//                            self.print_error_msg(msg: result.msg)
//                            if result.code == 0{
//                                loginWhenSessionInvalid(controller: self)
//                            }
//                        }
//                    }
//        })
//    }
    

    
    func sync_official_peilvs_after_playrule_click(lotType:String,playCode:String,showDialog:Bool) -> Void{

        let params:Dictionary<String,AnyObject> = ["playCode":playCode as AnyObject,"lotType":lotType as AnyObject,"version":VERSION_1 as AnyObject]

        expandRequest(frontDialog: showDialog, loadTextStr:"赔率获取中..",url:GET_JIANJIN_ODDS_URL,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = PeilvWebResultWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            self.officail_odds.removeAll()
                            self.officail_odds = self.officail_odds + result.content
                            //选出返水比例值并同步拖动条
                            self.update_slide_when_peilvs_obtain()
                        }else{
                            self.print_error_msg(msg: result.msg)
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }

    
    /**
     * 根据小玩法及彩种编码获取赔率信息
     * @param lotCategoryType 彩种类型编码
     * @param subPlayCode 玩法代号
     * @param showDialog
     */
//    func sync_honest_plays_odds_obtain(lotCategoryType:String,subPlayCode:String,showDialog:Bool) -> Void {
//        request(frontDialog: showDialog, loadTextStr:"赔率获取中..",url:GET_HONEST_ODDS_URL,
//                params:["playCodes":subPlayCode,"lotType":lotCategoryType,"version":self.cpVersion],
//                callback: {(resultJson:String,resultStatus:Bool)->Void in
//                    if !resultStatus {
//                        if resultJson.isEmpty {
//                            showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
//                        }else{
//                            showToast(view: self.view, txt: resultJson)
//                        }
//                        return
//                    }
//                    if let result = PeilvHonestResultWrapper.deserialize(from: resultJson){
//                        if result.success{
//                            YiboPreference.setToken(value: result.accessToken as AnyObject)
//                            //更新赔率面板号码区域赔率等数据
//                            self.honest_odds.removeAll()
//                            self.honest_odds = self.honest_odds + result.content
//                            self.selectPlay = self.playRules[self.selected_rule_position]
//                            self.refresh_page_after_honest_odds_obtain(selected_play: &self.selectPlay, odds: self.honest_odds)
////                            self.updatePeilvPlayArea(result: result.content)
//                            //清除底部UI及变量
//                            self.clearBottomValue(clearModeAndBeiShu: false)
//                            self.updateBottomUI()
//                            self.scrollToTop()
//                        }else{
//                            if !isEmptyString(str: result.msg){
//                                self.print_error_msg(msg: result.msg)
//                            }else{
//                                showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
//                            }
//                            if result.code == 0{
//                                loginWhenSessionInvalid(controller: self)
//                            }
//                        }
//                    }
//        })
//    }
    
    func sync_honest_plays_odds_obtain(lotCategoryType:String,subPlayCode:String,showDialog:Bool) -> Void {
        expandRequest(frontDialog: showDialog, loadTextStr:"赔率获取中..",url:GET_HONEST_ODDS_URL,
                params:["playCodes":subPlayCode,"lotType":lotCategoryType,"version":self.cpVersion],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = PeilvHonestResultWrapper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            //更新赔率面板号码区域赔率等数据
                            self.honest_odds.removeAll()
                            self.honest_odds = self.honest_odds + result.content
                            self.selectPlay = self.playRules[self.selected_rule_position]
                            
                            self.refresh_page_after_honest_odds_obtain(selected_play: &self.selectPlay, odds: self.honest_odds)
                            //                            self.updatePeilvPlayArea(result: result.content)
                            //清除底部UI及变量
                            self.clearBottomValue(clearModeAndBeiShu: false)
                            self.updateBottomUI()
                            self.scrollToTop()
                        }else{
                            if !isEmptyString(str: result.msg){
                                self.print_error_msg(msg: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取赔率失败"))
                            }
                            if result.code == 0 || result.code == 10000{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    /**
     * 计算出对应玩法下的号码及赔率面板区域显示数据
     *
     * @param peilvWebResults 赔率数据
     */
    func prapare_peilv_datas_for_tableview(peilvWebResults:[BcLotteryPlay]){
        if peilvWebResults.isEmpty{
            return;
        }
        self.peilvListDatas.removeAll()
        self.peilvListDatas = self.peilvListDatas + peilvWebResults
    }
    
    func bind_and_sync_list_when_special_play(play:BcLotteryPlay,position:Int){
        if play.children.isEmpty{
            return
        }
        let item = play.children[position]
        var list = [BcLotteryPlay]()
        list.append(item)
        clearBottomValue(clearModeAndBeiShu: false)
        prapare_peilv_datas_for_tableview(peilvWebResults: list)
        playPaneTableView.reloadData()
    }
    
    /**
    * 根据玩法栏选择好的玩法，刷新列表数据
    * @param selected_play 用户选择的侧边玩法数据
    * @param odds  选择的侧边玩法对应的所有子玩法对应的所有赔率项数据
    */
    func refresh_page_after_honest_odds_obtain(selected_play: inout BcLotteryPlay?,odds:[HonestResult]) -> Void{
        
        if selected_play == nil{
            peilvListDatas.removeAll()
            playPaneTableView.reloadData()
            return
        }
        if isEmptyString(str: cpBianHao) || isEmptyString(str: subPlayCode){
            return
        }
        //给子玩法列表下的每项玩法添加对应的赔率项列表数据
        PeilvLogic.insertOddsToPlayDatas(selectPlay: &selected_play, odds: odds)
        selectedSubPlayCode = (selected_play?.code)!
        choosedPlay = selected_play
        //若是连码等特殊玩法时，展示附加条件选择条
        lhcLogic.initializeIndexTitle()
        
        guard let play = selected_play else{return}
        if play.children.isEmpty{
            return
        }
        if let headerView = lhcLogic.createHeaderView(controller: self, playCode: selectedSubPlayCode){
            
            var headerFrame = headerView.frame
            headerFrame.size =  CGSize(width:isPlayBarHidden ? KSCREEN_WIDTH : KSCREEN_WIDTH * 0.68, height: headerFrame.size.height)
            playPaneTableView.tableHeaderView = headerView
            if let selectedPlay = self.choosedPlay{
                let map = lhcLogic.getListWhenSpecialClick(play: selectedPlay)
                lhcLogic.setFixFirstNumCountWhenLHC(fixCount: (map?.keys.contains("fixFirstCount"))! ? map!["fixFirstCount"] as! Int : 0)
                let list = (map?.keys.contains("datas"))! ? map!["datas"] : ([] as AnyObject)
                prapare_peilv_datas_for_tableview(peilvWebResults:list as! [BcLotteryPlay]);
                playPaneTableView.reloadData()
                self.clearBottomValue(clearModeAndBeiShu: true)
            }
        }else{
            lhcLogic.playName = (selected_play?.name)!
            playPaneTableView.tableHeaderView = nil
            prapare_peilv_datas_for_tableview(peilvWebResults:(selected_play?.children)!);
            playPaneTableView.reloadData()
            self.clearBottomValue(clearModeAndBeiShu: true)
        }
        scrollToTop()
        if isPeilvVersion(){
            update_honest_seekbar(selectPlay: selected_play!, odds: odds)
        }
    }
    
    func onConfirm() {
        click_bet_button()
    }
    
    func convert_index_to_mode(index:Int) -> String {
        if index == 0{
            return YUAN_MODE
        }else if index == 1{
            return JIAO_MODE
        }else if index == 2{
            return FEN_MODE
        }
        return YUAN_MODE
    }
    
    func click_lottery_record_history() {
        var lotName = ""
        if let lotNameValue = lotData?.name{
            lotName = lotNameValue
        }
        openTouzhuRecord(controller: self,title: lotName,code: self.cpBianHao, recordType: isSixMark(lotCode: cpBianHao) ? MenuType.LIUHE_RECORD : MenuType.CAIPIAO_RECORD)
    }
    
    func refreshPaneAndClean(noClearView:Bool) -> Void {
        self.playPaneTableView.reloadData()
        if !noClearView{
            clearBottomValue(clearModeAndBeiShu: noClearView)
        }
    }
    
    //在直接赔率项输入项中输入金额后，回调此方法来计算注数
    func callAsyncCalcZhushu(data: PeilvWebResult, cellIndex: Int, row: Int, volume: Bool) {
        onCellSelect(data: data, cellIndex: cellIndex, row: row,volume:volume)
    }
    
    //赔率cellviewview cell点击回调
    func onCellSelect(data: PeilvWebResult, cellIndex: Int,row:Int,volume:Bool=true) {
        //播放按键音
        if volume{
            if YiboPreference.isPlayTouzhuVolume(){
                playVolume()
            }
        }
        let mCell = self.playPaneTableView.cellForRow(at: IndexPath.init(row: row, section: 0))
        if mCell == nil{
            return
        }
        let cell:PeilvTouzhuCell = mCell as! PeilvTouzhuCell
        var cell2:PeilvCollectionViewCell!
        
        if let s = cell.tableContent.cellForItem(at: IndexPath.init(row: cellIndex, section: 0)){
            cell2 = s as! PeilvCollectionViewCell
        }
        if cell2 == nil{
            return
        }
        let clickData = self.peilvListDatas[row].peilvs[cellIndex]
        if !clickData.checkbox{
            if clickData.isSelected{
                if !isEmptyString(str: self.betMoneyWhenPeilv){
                    cell2.moneyInputTV.text = self.betMoneyWhenPeilv
                    clickData.inputMoney = Float(self.betMoneyWhenPeilv)!
                }
            }else{
                cell2.moneyInputTV.text = ""
                clickData.inputMoney = 0
            }
        }else{
            //.......
        }
        //开始计算投注号码串及注数
        self.calc_bet_orders_for_honest(datasAfterSelected: self.peilvListDatas)
        
    }
    
    //彩种切换后的回调
    func onLotSelect(lotData:LotteryData) {
        lotWindow.dismiss()
//        toggleTouzhuModeSwitchAndPlayRuleIntroduce()
        self.lotData = lotData
        self.updateLocalConstants(lotData: self.lotData)
        if !isSixMark(lotCode: lotData.code!){
            lhcSelect = false
        }
        
        self.clearBottomValue(clearModeAndBeiShu: true)
        self.swtichTouzhuHeader()
        self.toggleTouzhuModeSwitchAndPlayRuleIntroduce()
        //快乐彩情况下只有信用下注,不用在标题上切换
        if (self.cpTypeCode == "9") {
            self.titleIndictor.isHidden = true
        }
        //重新选择彩票后，需要重新获取彩种对应的玩法
        self.sync_playrule_from_current_lottery(lotType: self.cpTypeCode, lotCode: self.cpBianHao, lotVersion: self.cpVersion)
    }
    
    func showNoticeDialog(title:String,content:String) -> Void {
        let qrAlert = PopupAlert.init(title: title, message: content, cancelButtonTitle: nil, sureButtonTitle: "我知道了")
        qrAlert.show()
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
            if model.isBet {
                models.append(model)
            }
        }
        
        if models.count > 0 {
            let weblistView = WebviewList.init(noticeResuls: models)
            weblistView.show()
        }
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
    
}

extension TouzhController : PlayButtonDelegate{
    func onButtonDelegate() {
        if let play = self.choosedPlay{
            let map = lhcLogic.getListWhenSpecialClick(play: play)
            lhcLogic.setFixFirstNumCountWhenLHC(fixCount: (map?.keys.contains("fixFirstCount"))! ? map!["fixFirstCount"] as! Int : 0)
            let list = (map?.keys.contains("datas"))! ? map!["datas"] : ([] as AnyObject)
            prapare_peilv_datas_for_tableview(peilvWebResults:list as! [BcLotteryPlay]);
            playPaneTableView.reloadData()
            self.clearBottomValue(clearModeAndBeiShu: true)
        }
    }
    
    //MARK: - 主题相关 && UI初始设置
    private func setupUI() {
        coolHotButton.isSelected = true
        fastModeButton.isSelected = true
        creditBottomTopBar.isHidden = true
        
        modeBtn.layer.cornerRadius = 3.0
        modeBtn.layer.masksToBounds = true
        beishu_money_input.layer.cornerRadius = 3.0
        beishu_money_input.layer.masksToBounds = true
        clearBtn.layer.masksToBounds = true
        clearBtn.layer.cornerRadius = 3.0
        betBtn.layer.cornerRadius = 3.0
        betBtn.layer.masksToBounds = true
        creditbottomTopField.layer.cornerRadius = 3.0
        creditbottomTopField.layer.masksToBounds = true
        
        creditBottomHistoryButton.addTarget(self, action: #selector((betRecordClickEvent(_:))), for: .touchUpInside)
    }
    
    private func setupTheme() {
        
        
        setupNoPictureAlphaBgView(view: self.touzhuHeaderBgView)
        
        creditBottomHistoryImg.theme_image = "TouzhOffical.SwiftPopMenu.firstImage"
        
        playRuleTableView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        playRuleTableView.layer.borderWidth = 1.0
        playRuleTableView.layer.theme_borderColor = "FrostedGlass.Touzhu.separateLineColor"
        
        playPaneTableView.layer.borderWidth = 1.0
        playPaneTableView.layer.theme_borderColor = "FrostedGlass.Touzhu.separateLineColor"
        
        verticalLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        
        bottomLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        bottomViewTopLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        
        bottomDottedLine.backgroundColor = UIColor.clear
        topDottedLine.backgroundColor = UIColor.clear
        drawDashLine(lineView: bottomDottedLine)
        drawDashLine(lineView: topDottedLine)
        
        lot_name_button.layer.cornerRadius = 3.0
        lot_name_button.theme_backgroundColor = "Global.themeColor"
        
        recent_open_result_button.layer.masksToBounds = true
        recent_open_result_button.theme_setBackgroundImage("TouzhOffical.dropDownHisLotteryBtnBackImg", forState: .normal)
        random_bet_button.theme_setImage("TouzhOffical.robot_bet_button", forState: .normal)
//        
    }
    
    private func refreshBottomBar() {
        if isPeilvVersion() {
            bottomBgBarHeight.constant = 90
            creditBottomTopBar.isHidden = false
            creditSliderBgBar.isHidden = true
            money_beishu_mode_view.isHidden = true
        }else {
            bottomBgBarHeight.constant = 110
            creditBottomTopBar.isHidden = true
            creditSliderBgBar.isHidden = false
            money_beishu_mode_view.isHidden = false
        }
    }
    
    private func refreshLotteryTime() {
        if isPeilvVersion() {
            betDeadlineDesLabel.textColor = UIColor.black
        }else {
            betDeadlineDesLabel.textColor = UIColor.white
        }
    }
    
    private func refreshButtons() {
        if isPeilvVersion() {
            coolHotButton.isHidden = true
            missingNumButton.isHidden = true
            coolHotButton.isHidden = true
            missingNumButton.isHidden = true
            fastModeButton.isHidden = false
            normalModeButton.isHidden = false
        }else {
            if LotteryPlayLogic.showCoolMissingPlays(playCode: subPlayCode){
                coolHotButton.isHidden = false
                missingNumButton.isHidden = false
                self.showCodeRank = true
            }else{
                coolHotButton.isHidden = true
                missingNumButton.isHidden = true
                self.showCodeRank = false
            }
            fastModeButton.isHidden = true
            normalModeButton.isHidden = true
        }
    }
    
    private func drawDashLine(lineView: UIView)
    {
        // 创建对象
        let shapeLayer = CAShapeLayer.init()
        // 设置路径
        shapeLayer.path = self.drawDashLine().cgPath
        // 设置路径的颜色
        shapeLayer.theme_strokeColor = "Global.themeColor"
        // 设置虚线的间隔
        shapeLayer.lineDashPattern = [3.0,1.5];
        // 设置路径的宽度
        shapeLayer.lineWidth = 1.5
        // 路径的渲染
        lineView.layer.addSublayer(shapeLayer)
    }
    
    // MARK: 虚线绘制
    func drawDashLine() -> UIBezierPath {
        let BzPath = UIBezierPath.init()
        BzPath.move(to: CGPoint.init(x: 0, y: 0))
        BzPath.addLine(to: CGPoint.init(x: kScreenWidth, y: 0))
        return BzPath
    }

    override func viewDidLayoutSubviews() {

        sizeHeaderToFit()
//        super.viewDidLayoutSubviews()
    }
    
    func sizeHeaderToFit() {
        
        guard let headerView = playPaneTableView.tableHeaderView else {return}
//        headerView.setNeedsLayout()
//        headerView.layoutIfNeeded()
        
        var headerFrame = headerView.frame
        headerFrame.size =  CGSize(width:isPlayBarHidden ? KSCREEN_WIDTH : KSCREEN_WIDTH * 0.68, height: headerFrame.size.height)
    }
    
    
    
}
