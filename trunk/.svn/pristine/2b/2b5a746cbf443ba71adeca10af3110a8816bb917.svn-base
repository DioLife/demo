//
//  JifenFilterView.swift
//  gameplay
//
//  Created by William on 2018/8/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class JifenFilterView: UIView {

    private let button_dateEnd = UIButton()//结束时间
    private let button_dateStart = UIButton()//开始时间
    
    private let button_Cancel = UIButton()//取消
    private let button_Confirm = UIButton()//确认
    
    private let button_Selecter = UIButton()//选择彩种类型的框
    private let textField_UserName = CustomFeildText()//输入用户名的框
    
    var controller:UIViewController!
    
    lazy var  start_Timer:CustomDatePicker = {
        let datePick = CustomDatePicker()
        datePick.tag = 101
        return datePick
    }()//开始时间选择器02
    
    lazy var end_Timer:CustomDatePicker = {
        let datePick = CustomDatePicker()
        datePick.tag = 102
        return datePick
    }()//结束时间选择器02
    
    
    private var startTime:String = ""
    private var endTime:String = ""
    
    convenience init(height: CGFloat,controller:UIViewController) {
        self.init()
        
        self.backgroundColor = UIColor.white
        self.controller = controller
        
        addSubview(button_dateEnd)
        button_dateEnd.whc_Top(35).whc_Width(120).whc_Height(40).whc_Right(30, toView: self)
        //.whc_Width(110) .whc_Left(220, toView: self)
        button_dateEnd.setTitleColor(UIColor.cc_136(), for: .normal)
        button_dateEnd.setTitle(self.endTime, for: .normal)
        button_dateEnd.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button_dateEnd.layer.borderColor = UIColor.cc_224().cgColor
        button_dateEnd.layer.borderWidth = 0.5
        button_dateEnd.layer.cornerRadius = 3
        button_dateEnd.clipsToBounds = true
        button_dateEnd.addTarget(self, action: #selector(button_EndTimeClickHandle), for: .touchUpInside)
        
        let label = UILabel()
        addSubview(label)
        label.whc_CenterYEqual(button_dateEnd).whc_WidthAuto().whc_Height(5).whc_Right(3, toView: button_dateEnd)
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = UIColor.black
        label.text = "--"
        
        addSubview(button_dateStart)
        button_dateStart.whc_CenterYEqual(button_dateEnd).whc_Right(3, toView: label).whc_WidthEqual(button_dateEnd).whc_HeightEqual(button_dateEnd)
        button_dateStart.setTitle(self.startTime, for: .normal)
        button_dateStart.setTitleColor(UIColor.cc_136(), for: .normal)
        button_dateStart.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button_dateStart.layer.borderWidth = 0.5
        button_dateStart.layer.borderColor = UIColor.cc_224().cgColor
        button_dateStart.layer.cornerRadius = 3
        button_dateStart.clipsToBounds = true
        button_dateStart.isHidden = false
        button_dateStart.addTarget(self, action: #selector(button_StartTimeClickHandle), for: .touchUpInside)
        
        let label_DateTitle = UILabel()
        addSubview(label_DateTitle)
        label_DateTitle.whc_CenterYEqual(button_dateStart).whc_Right(7, toView: button_dateStart).whc_Height(12).whc_WidthAuto()
        label_DateTitle.textAlignment = .right
        label_DateTitle.font  = UIFont.systemFont(ofSize: 12)
        label_DateTitle.textColor = UIColor.cc_51()
        label_DateTitle.text = "日期："
        
        addSubview(button_Selecter)
        button_Selecter.whc_Top(5, toView: button_dateEnd).whc_RightEqual(button_dateEnd).whc_LeftEqual(button_dateStart).whc_Height(35)
        button_Selecter.setTitle("全部", for: .normal)
        button_Selecter.setTitleColor(UIColor.black, for: .normal)
        button_Selecter.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button_Selecter.setImage(UIImage(named: "pulldown"), for: .normal)
        button_Selecter.imageEdgeInsets = UIEdgeInsetsMake(0, 200 - 20, 0, 0)
        button_Selecter.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 120)
        button_Selecter.setTitleShadowColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .highlighted)
        button_Selecter.addTarget(self, action: #selector(button_SelectorClickHandle), for: .touchUpInside)
        button_Selecter.whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
        button_Selecter.layer.borderColor = UIColor.cc_224().cgColor
        button_Selecter.layer.borderWidth = 1.0
        button_Selecter.layer.cornerRadius = 3
        button_Selecter.clipsToBounds = true
        
        let labal_Type = UILabel()
        addSubview(labal_Type)
        labal_Type.whc_CenterYEqual(button_Selecter)
            .whc_RightEqual(label_DateTitle).whc_LeftEqual(label_DateTitle).whc_Height(15)
        labal_Type.font = UIFont.systemFont(ofSize: 12)
        labal_Type.textColor = UIColor.cc_51()
        labal_Type.text = "状态:"
        
        addSubview(button_Confirm)
        button_Confirm.whc_Top(9, toView: button_Selecter).whc_RightEqual(button_Selecter).whc_Width(50).whc_Height(30)
        addSubview(button_Cancel)
        button_Cancel.whc_TopEqual(button_Confirm).whc_Right(8, toView: button_Confirm).whc_Width(50).whc_Height(30)
        
        button_Confirm.setTitle("确认", for: .normal)
        button_Confirm.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button_Confirm.backgroundColor = UIColor.mainColor()
        button_Confirm.setTitleColor(UIColor.white, for: .normal)
        button_Confirm.layer.cornerRadius = 3
        button_Confirm.clipsToBounds = true
        button_Confirm.addTarget(self, action: #selector(button_ConfirmClickHandle), for: .touchUpInside)
        
        button_Cancel.setTitle("取消", for: .normal)
        button_Cancel.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button_Cancel.backgroundColor = UIColor.white
        button_Cancel.setTitleColor(UIColor.cc_136(), for: .normal)
        button_Cancel.layer.cornerRadius = 3
        button_Cancel.clipsToBounds = true
        button_Cancel.layer.borderWidth = 0.5
        button_Cancel.layer.borderColor = UIColor.lightGray.cgColor
        button_Cancel.addTarget(self, action: #selector(button_CancelClickHandle), for: .touchUpInside)
    }
    
    @objc private func button_SelectorClickHandle() {
        let selectedView = JifenFilterSelectView(dataSource: lotteryTypes, viewTitle: "彩种类型")
        selectedView.selectedIndex = selectIndex
        //点击弹出框 回传的信息
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.button_Selecter.setTitle(selectedView.kLenny_InsideDataSource[index].name, for: .normal)
            self?.selectIndex = index
//            self?.selectLotCode = selectedView.kLenny_InsideDataSource[index].code!
            self?.selectLotCode = "\(content.type!)"
        }
        window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func initializeDate(start:String,end:String){
        self.startTime = start
        self.endTime = end
        button_dateStart.setTitle(self.startTime, for: .normal)
        button_dateEnd.setTitle(self.endTime, for: .normal)
    }
    
    //MARK:打开时间选择
    func openDatePick(tag:Int)  {
        if tag == 101{
            self.start_Timer.canButtonReturnB = {
                self.controller.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
            }
            self.start_Timer.sucessReturnB = { returnValue in
                self.startTime = returnValue
                self.controller.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
                let task = delay(0.5){
                    self.button_dateStart.titleLabel?.lineBreakMode = .byTruncatingHead
                    self.button_dateStart.setTitle(returnValue, for: .normal)
                }
                //                cancel(task)
            }
            self.gototargetView(_targetView:self.start_Timer)
        }else if tag == 102{
            self.end_Timer.canButtonReturnB = {
            self.controller.view
                .ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
            }
            self.end_Timer.sucessReturnB = { returnValue in
                self.endTime = returnValue
                self.controller.view
                    .ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
                _ = delay(0.5){
                    self.button_dateEnd.titleLabel?.lineBreakMode = .byTruncatingHead
                    self.button_dateEnd.setTitle(returnValue, for: .normal)
                }
                //                cancel(task)
            }
            self.gototargetView(_targetView:self.end_Timer)
        }
    }
    
    @objc private func button_StartTimeClickHandle() {
        openDatePick(tag: 101)
    }
    
    @objc private func button_EndTimeClickHandle() {
        openDatePick(tag: 102)
    }
    
    //MARK:打开底部弹出view
    
    func gototargetView(_targetView:UIView)  {
        controller.view.ttPresentFramePopupView(_targetView, animationType: TTFramePopupViewSlideBottomTop) {
            debugPrint("我要消失了")
        }
        _targetView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(controller.view)
            make.height.equalTo(250)
        }
    }
    
    //过滤view中点击确定时的响应方法
    @objc private func button_ConfirmClickHandle() {
        let username = textField_UserName.text != nil ? textField_UserName.text! : ""
        didClickConfirmButton?(username, self.selectLotCode,self.startTime,self.endTime)
        
    }
    @objc private func button_CancelClickHandle() {
        didClickCancleButton?()
    }
    
    var didClickCancleButton: ( () -> Void)?
    var didClickConfirmButton: ( (String, String,String,String) -> Void)?
    var lotteryTypes: [JifenRow]!//所有彩种信息
    
    var selectIndex: Int = 0
    var selectLotCode: String = ""
    
    override func didMoveToWindow() {
//        button_Selecter.isEnabled = false
//        if LennyModel.allLotteryTypesModel == nil {
//            LennyNetworkRequest.obtainAllLotteryTypes(version: 0) { [weak self](model) in
//                self?.button_Selecter.isEnabled = true
//                self?.lotteryTypes = [AllLotteryTypesSubData]()
//
//                for sub: AllLotteryTypesSubData in (model?.obtainAllLotteryWithIndex())! {
//                    self?.lotteryTypes.append(sub)
//                    print(sub.name! + "----" + sub.code!)
//                }
//                if self?.lotteryTypes.count == 0 { return }
//            }
//        }else {
//            self.lotteryTypes = [AllLotteryTypesSubData]()
//            for sub: AllLotteryTypesSubData in (LennyModel.allLotteryTypesModel?.obtainAllLotteryWithIndex())! {
//                self.lotteryTypes.append(sub)
//            }
//            button_Selecter.isEnabled = true
//        }
        
        let vc = BaseController()
        vc.request(frontDialog: false, url:SCORE_HISTORY_TYPES,
                   callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
//                    print(resultJson)
                    self.lotteryTypes = Array<JifenRow>()
//                    let oneModel = JifenRow()
//                    oneModel.name = "全部"
//                    oneModel.type = 0
//                    self.lotteryTypes.append(oneModel)
                    if let result = JifenModel.deserialize(from: resultJson){
                        if result.success{
                            for item in result.content! {
                                self.lotteryTypes.append(item)
                            }
                        }
                    }
        })
    }

}
