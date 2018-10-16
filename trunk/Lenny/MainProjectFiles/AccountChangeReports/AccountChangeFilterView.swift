//
//  GerenFilterView.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/19.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class AccountChangeFilterView: UIView {
    
    private let button_dateEnd = UIButton()
    private let button_dateStart = UIButton()
    
    private let button_Cancel = UIButton()
    private let button_Confirm = UIButton()
    
    //    private let textField = UITextField()
    private let textField_UserName = UITextField()
    private let button_Selecter = UIButton()
    
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
    private var username = ""
    private var accountTypes = 0
    private var include = false
    
    convenience init(height: CGFloat,controller:UIViewController) {
        self.init()
        
        self.theme_backgroundColor = "FrostedGlass.filterViewColor"
        self.controller = controller
        
        addSubview(textField_UserName)
        textField_UserName.whc_Top(19).whc_Right(44).whc_Width(200).whc_Height(30)
        textField_UserName.borderStyle = .roundedRect
        textField_UserName.font = UIFont.systemFont(ofSize: 14)
        let label_Name = UILabel()
        addSubview(label_Name)
        label_Name.whc_CenterYEqual(textField_UserName).whc_Right(10, toView: textField_UserName).whc_WidthAuto().whc_Height(25)
        label_Name.font = UIFont.systemFont(ofSize: 14)
        label_Name.textColor = UIColor.cc_51()
        label_Name.text = "用户名:"
        
        addSubview(button_Selecter)
        button_Selecter.whc_Top(5,toView:textField_UserName).whc_Right(44).whc_Width(220).whc_Height(30)
        button_Selecter.setTitle("所有类型", for: .normal)
        button_Selecter.setTitleColor(UIColor.black, for: .normal)
        button_Selecter.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button_Selecter.setImage(UIImage(named: "pulldown"), for: .normal)
        button_Selecter.imageEdgeInsets = UIEdgeInsetsMake(0, 200 - 30, 0, 0)
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
        labal_Type.whc_CenterYEqual(button_Selecter).whc_Left(44).whc_Right(10, toView: button_Selecter).whc_WidthAuto().whc_Height(15)
        labal_Type.font = UIFont.systemFont(ofSize: 12)
        labal_Type.textColor = UIColor.cc_51()
        labal_Type.text = "账变类型:"
        
        addSubview(button_dateEnd)
        button_dateEnd.whc_Top(5, toView: button_Selecter).whc_RightEqual(button_Selecter).whc_Height(30)
//        .whc_Width(110)
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
        label.whc_CenterYEqual(button_dateEnd).whc_WidthAuto().whc_Height(5).whc_Right(0, toView: button_dateEnd)
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = UIColor.black
        label.text = "--"
        
        addSubview(button_dateStart)
        button_dateStart.whc_CenterYEqual(button_dateEnd).whc_Right(3, toView: label).whc_WidthEqual(button_dateEnd).whc_HeightEqual(button_dateEnd)
        button_dateStart.frame = CGRect.init(x: 50, y: 110, width: 60, height: 60)
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
        label_DateTitle.whc_CenterYEqual(button_dateStart).whc_LeftEqual(labal_Type, offset: 0).whc_Right(7, toView: button_dateStart).whc_Height(12).whc_WidthAuto()
        label_DateTitle.textAlignment = .right
        label_DateTitle.font  = UIFont.systemFont(ofSize: 12)
        label_DateTitle.textColor = UIColor.cc_51()
        label_DateTitle.text = "日期："
        
        addSubview(button_Confirm)
        button_Confirm.whc_Top(9, toView: button_dateEnd).whc_RightEqual(button_dateEnd).whc_Width(50).whc_Height(30)
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
        
        let selectedView = AccoutFilterSelectView(dataSource: self.changeTypes, viewTitle: "账变类型")
        selectedView.selectedIndex = selectIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.button_Selecter.setTitle(selectedView.kLenny_InsideDataSource[index].name, for: .normal)
            self?.selectIndex = index
            self?.accountTypes = selectedView.kLenny_InsideDataSource[index].type
        }
        window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func initializeDate(start:String,end:String,username:String){
        self.startTime = start
        self.endTime = end
        self.username = username
        button_dateStart.setTitle(self.startTime, for: .normal)
        button_dateEnd.setTitle(self.endTime, for: .normal)
        self.textField_UserName.text = self.username
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
                self.controller.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
            }
            self.end_Timer.sucessReturnB = { returnValue in
                self.endTime = returnValue
                self.controller.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
                let task = delay(0.5){
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
        didClickConfirmButton?(self.username,self.startTime,self.endTime,self.include,self.accountTypes)
    }
    @objc private func button_CancelClickHandle() {
        didClickCancleButton?()
    }
    
    var didClickCancleButton: ( () -> Void)?
    var didClickConfirmButton: ( (String,String,String,Bool,Int) -> Void)?
    var changeTypes: [AccountTypeBean]!//所有账变类型信息
    
    var selectIndex: Int = 0
    var selectLotCode: String = ""
    
    var resultModel:AccountTypesModel!
    
    override func didMoveToWindow() {
        
        button_Selecter.isEnabled = false
        if self.resultModel == nil {
            LennyNetworkRequest.obtainAccountChangeTypesQuery() { [weak self](model) in
                self?.resultModel = model
                self?.button_Selecter.isEnabled = true
                self?.changeTypes = [AccountTypeBean]()
                if let model = self?.resultModel{
                    guard let income = model.content?.incomeType else {return}
                    if !income.isEmpty{
                        for item in income{
                            let bean = AccountTypeBean()
                            bean.name = item.name!
                            bean.type = item.type
                            self?.changeTypes.append(bean)
                        }
                    }
                    guard let sellout = model.content?.payType else {return}
                    if !sellout.isEmpty{
                        for item in sellout{
                            let bean = AccountTypeBean()
                            bean.name = item.name!
                            bean.type = item.type
                            self?.changeTypes.append(bean)
                        }
                    }
                }
            }
        }else{
            self.button_Selecter.isEnabled = true
            self.changeTypes = [AccountTypeBean]()
            if let model = self.resultModel{
                guard let income = model.content?.incomeType else {return}
                if !income.isEmpty{
                    for item in income{
                        let bean = AccountTypeBean()
                        bean.name = item.name!
                        bean.type = item.type
                        self.changeTypes.append(bean)
                    }
                }
                guard let sellout = model.content?.payType else {return}
                if !sellout.isEmpty{
                    for item in sellout{
                        let bean = AccountTypeBean()
                        bean.name = item.name!
                        bean.type = item.type
                        self.changeTypes.append(bean)
                    }
                }
            }
        }
        
    }
}
