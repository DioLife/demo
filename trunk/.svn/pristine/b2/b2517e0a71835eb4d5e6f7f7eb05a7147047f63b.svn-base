//
//  GameMallController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/11/20.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import MBProgressHUD
import HandyJSON

//新版简约四模块风格界面代码,moduleStyle=2
class GameMallSimpleController: BaseMainController,MainViewDelegate {
    
    @IBOutlet weak var header:UIView!
    @IBOutlet weak var usualBtn:UsualGameBtn!
    //彩票，体育，真人，电子
    @IBOutlet weak var caipiaoBtn: UIImageView!
    @IBOutlet weak var caipiaoWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var caipiaoHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var sportBtn: UIImageView!
    @IBOutlet weak var sportWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var sportHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var realPersonBtn: UIImageView!
    @IBOutlet weak var realPersonWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var realPersonHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var gameBtn: UIImageView!
    @IBOutlet weak var gameWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var gameHeightConstraint:NSLayoutConstraint!
    
    var showCaipiao = true
    var showSport = true
    var showZhenren = true
    var showGame = true
    
    //    var actionButton: ActionButton!//悬浮按钮
    
    func clickFunc(tag: Int) {
        switch tag {
        case 100,101:
            //            self.tabBarController?.selectedIndex = 3
            if let delegate = self.menuDelegate{
                delegate.menuEvent(isRight: true)
            }
        case 102:
            openAPPDownloadController(controller:self)
        case 103:
            openContactUs(controller: self)
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap5 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        let tap6 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        let tap7 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        let tap8 = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(_:)))
        
        caipiaoBtn.isUserInteractionEnabled = true
        sportBtn.isUserInteractionEnabled = true
        realPersonBtn.isUserInteractionEnabled = true
        gameBtn.isUserInteractionEnabled = true
        
        caipiaoBtn.addGestureRecognizer(tap5)
        sportBtn.addGestureRecognizer(tap6)
        realPersonBtn.addGestureRecognizer(tap7)
        gameBtn.addGestureRecognizer(tap8)
        
        //        actionButton = createFAB(controller:self)
        
        let headerView = Bundle.main.loadNibNamed("main_header", owner: nil, options: nil)?.first as? MainHeaderView
        headerView?.mainDelegate = self
        if let view = headerView{
            self.header.addSubview(view)
            //同步主界面头部的数据
            view.syncSomeWebData(controller: self)
        }
        //根据后台彩票，电子，真人，体育开关判断是否显示对应模块
        toggleModules()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adjustRightBtn()
    }
    
    override func adjustRightBtn() -> Void {
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
            self.navigationItem.rightBarButtonItems = [menuBtn]
        }
    }
    
    func toggleModules(){
        if let sys = getSystemConfigFromJson(){
            showCaipiao = !isEmptyString(str: sys.content.onoff_lottery_game) && sys.content.onoff_lottery_game == "on"
            showSport = !isEmptyString(str: sys.content.onoff_sports_game) && sys.content.onoff_sports_game == "on"
            showZhenren = !isEmptyString(str: sys.content.onoff_zhen_ren_yu_le) && sys.content.onoff_zhen_ren_yu_le == "on"
            showGame = !isEmptyString(str: sys.content.onoff_dian_zi_you_yi) && sys.content.onoff_dian_zi_you_yi == "on"
            
            //体育开关关闭时
            //            if showCaipiao && !showSport && showZhenren && showGame{
            //                caipiaoBtn.isHidden = false
            //                sportBtn.isHidden = true
            //                realPersonBtn.isHidden = false
            //                gameBtn.isHidden = false
            //                caipiaoWidthConstraint.constant = (kScreenWidth - 30)/2
            //                sportWidthConstraint.constant = -(kScreenWidth - 30)/2
            //            }
            //
            //            //真人开关关闭时
            //            if showCaipiao && showSport && !showZhenren && showGame{
            //                caipiaoBtn.isHidden = false
            //                sportBtn.isHidden = false
            //                realPersonBtn.isHidden = true
            //                gameBtn.isHidden = false
            //                realPersonWidthConstraint.constant = -(kScreenWidth - 30)/2
            //                gameWidthConstraint.constant = (kScreenWidth - 30)/2
            //            }
            //
            //            //电子开关关闭时
            //            if showCaipiao && showSport && showZhenren && !showGame{
            //                caipiaoBtn.isHidden = false
            //                sportBtn.isHidden = false
            //                realPersonBtn.isHidden = false
            //                gameBtn.isHidden = true
            //                realPersonWidthConstraint.constant = (kScreenWidth - 30)/2
            //                gameWidthConstraint.constant = -(kScreenWidth - 30)/2
            //            }
            //
            //            //真人和体育都开关关闭时
            //            if showCaipiao && !showSport && !showZhenren && showGame{
            //                caipiaoBtn.isHidden = false
            //                sportBtn.isHidden = true
            //                realPersonBtn.isHidden = true
            //                gameBtn.isHidden = false
            //                caipiaoWidthConstraint.constant = (kScreenWidth - 30)/2
            //                sportWidthConstraint.constant = -(kScreenWidth - 30)/2
            //                realPersonWidthConstraint.constant = -(kScreenWidth - 30)/2
            //                gameWidthConstraint.constant = (kScreenWidth - 30)/2
            //            }
            //
            //            //体育，真人，电子都关时
            //            if showCaipiao && !showSport && !showZhenren && !showGame{
            //                caipiaoBtn.isHidden = false
            //                sportBtn.isHidden = true
            //                realPersonBtn.isHidden = true
            //                gameBtn.isHidden = true
            //                caipiaoWidthConstraint.constant = (kScreenWidth - 30)/2
            //                caipiaoHeightConstraint.constant = caipiaoBtn.bounds.height
            //            }
            //
            //            //真人，电子都关时
            //            if showCaipiao && showSport && !showZhenren && !showGame{
            //                caipiaoBtn.isHidden = false
            //                sportBtn.isHidden = false
            //                realPersonBtn.isHidden = true
            //                gameBtn.isHidden = true
            //                caipiaoHeightConstraint.constant = caipiaoBtn.bounds.height
            //                sportHeightConstraint.constant = sportBtn.bounds.height
            //            }
        }
    }
    
    @objc func tapEvent(_ recongnizer: UIPanGestureRecognizer) {
        let tag = recongnizer.view!.tag
        print("tagggg = ",tag)
        switch tag {
        case 104:
//            if !showCaipiao{
//                showToast(view: self.view, txt: "请先在后台开启彩票开关")
//                return
//            }
//            let caipiaoMainController = UIStoryboard(name: "caipiao_main", bundle:nil).instantiateViewController(withIdentifier: "caipiao")
//            let vc:CpMainController = caipiaoMainController as! CpMainController
//            vc.bindShakeDelegate = self.navigationController as? EnterTouzhuDelegate
//            self.navigationController?.pushViewController(caipiaoMainController, animated: true)
            break;
        case 105:
            if !showSport{
                showToast(view: self.view, txt: "请先在后台开启体育开关")
                return
            }
            let vc = UIStoryboard(name: "sport_page", bundle:nil).instantiateViewController(withIdentifier: "sport")
            let sport = vc as! SportController
            self.navigationController?.pushViewController(sport, animated: true)
        case 106:
            if !showZhenren{
                showToast(view: self.view, txt: "请先在后台开启真人开关")
                return
            }
            let vc = UIStoryboard(name: "other_page", bundle:nil).instantiateViewController(withIdentifier: "otherPage")
            let other = vc as! OtherPageController
            other.isRealPerson = true
            other.code = REAL_MODULE_CODE
            self.navigationController?.pushViewController(other, animated: true)
        case 107:
            if !showGame{
                showToast(view: self.view, txt: "请先在后台开启游戏开关")
                return
            }
            let vc = UIStoryboard(name: "other_page", bundle:nil).instantiateViewController(withIdentifier: "otherPage")
            let other = vc as! OtherPageController
            other.isRealPerson = false
            other.code = GAME_MODULE_CODE
            self.navigationController?.pushViewController(other, animated: true)
        default:
            break;
        }
    }
}
