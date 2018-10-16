//
//  LennyFilterView.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

enum LennyFilterViewType: Int {
    case Normal
    case SubInput
    case SubSelecter
    case GouCaiQuery
}

class LennyFilterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private let button_dateEnd = UIButton()
    private let button_dateStart = UIButton()
    
    private let button_Cancel = UIButton()
    private let button_Confirm = UIButton()
    
    private let textField = UITextField()
    private let button_Selecter = UIButton()
    private let textField_UserName = UITextField()
    
    convenience init(type: LennyFilterViewType) {
        self.init()
        
        backgroundColor = UIColor.ccolor(with: 240, g: 240, b: 240)
        self.theme_backgroundColor = "FrostedGlass.filterViewColor"
        addSubview(button_dateEnd)
        button_dateEnd.whc_Top(14).whc_Right(62).whc_Height(25)
//        .whc_Width(97)
        button_dateEnd.setTitleColor(UIColor.cc_136(), for: .normal)
        button_dateEnd.setTitle("2018-04-02", for: .normal)
        button_dateEnd.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button_dateEnd.layer.borderColor = UIColor.cc_224().cgColor
        button_dateEnd.layer.borderWidth = 0.5
        button_dateEnd.layer.cornerRadius = 3
        button_dateEnd.clipsToBounds = true
        
        let label = UILabel()
        addSubview(label)
        label.whc_CenterYEqual(button_dateEnd).whc_WidthAuto().whc_Height(5).whc_Right(3, toView: button_dateEnd)
        label.font = UIFont.systemFont(ofSize: 9)
        label.textColor = UIColor.black
        label.text = "--"
        
        addSubview(button_dateStart)
        button_dateStart.whc_TopEqual(button_dateEnd).whc_CenterYEqual(button_dateEnd).whc_Right(3, toView: label).whc_Width(97).whc_Height(25)
        button_dateStart.setTitle("2018-04-02", for: .normal)
        button_dateStart.setTitleColor(UIColor.cc_136(), for: .normal)
        button_dateStart.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button_dateStart.layer.borderWidth = 0.5
        button_dateStart.layer.borderColor = UIColor.cc_224().cgColor
        button_dateStart.layer.cornerRadius = 3
        button_dateStart.clipsToBounds = true
        
        let label_DateTitle = UILabel()
        addSubview(label_DateTitle)
        label_DateTitle.whc_Top(18).whc_Right(7, toView: button_dateStart).whc_Height(12).whc_WidthAuto()
        label_DateTitle.textAlignment = .right
        label_DateTitle.font  = UIFont.systemFont(ofSize: 12)
        label_DateTitle.textColor = UIColor.cc_51()
        label_DateTitle.text = "日期："
        
        switch type {
        case .Normal:
            
            break
        case .SubInput:
            
            isSubInput = true
            addSubview(textField)
            textField.whc_Top(7, toView: button_dateEnd).whc_RightEqual(button_dateEnd).whc_LeftEqual(button_dateStart).whc_Height(30)
            textField.layer.cornerRadius = 3;
            textField.clipsToBounds = true
            textField.layer.borderColor = UIColor.cc_224().cgColor
            textField.layer.borderWidth = 0.5
            
            let label_Input = UILabel()
            addSubview(label_Input)
            label_Input.whc_CenterYEqual(textField).whc_Right(7, toView: textField).whc_Height(12).whc_WidthAuto()
            label_Input.font = UIFont.systemFont(ofSize: 12)
            label_Input.textColor = UIColor.cc_51()
            label_Input.text = "订单号:"
            label_Input.textAlignment = .right
            
            break
        case .SubSelecter:
            
            isSubSelecter = true
            addSubview(button_Selecter)
            button_Selecter.whc_Top(7, toView: button_dateEnd).whc_RightEqual(button_dateEnd).whc_LeftEqual(button_dateStart).whc_Height(30)
            button_Selecter.layer.cornerRadius = 3
            button_Selecter.clipsToBounds = true
            button_Selecter.layer.borderWidth = 0.5
            button_Selecter.layer.borderColor = UIColor.cc_224().cgColor
            
            let label_s = UILabel()
            addSubview(label_s)
            label_s.whc_CenterYEqual(button_Selecter).whc_Right(7, toView: button_Selecter).whc_Height(12).whc_WidthAuto()
            label_s.font = UIFont.systemFont(ofSize: 12)
            label_s.textAlignment = .right
            label_s.textColor = UIColor.cc_51()
            label_s.text = "彩种选择"
            break
        case .GouCaiQuery:
            
            for v in subviews { v.removeFromSuperview() }
            addSubview(textField_UserName)
            textField_UserName.whc_Top(19).whc_Right(64).whc_Width(200).whc_Height(25)
            textField_UserName.borderStyle = .roundedRect
            textField_UserName.font = UIFont.systemFont(ofSize: 12)
            let label_Name = UILabel()
            addSubview(label_Name)
            label_Name.whc_CenterYEqual(textField_UserName).whc_Right(10, toView: textField_UserName).whc_WidthAuto().whc_Height(15)
            label_Name.font = UIFont.systemFont(ofSize: 12)
            label_Name.textColor = UIColor.cc_51()
            label_Name.text = "用户名:"
            
            addSubview(button_Selecter)
            button_Selecter.whc_Top(5, toView: textField_UserName).whc_RightEqual(textField_UserName).whc_Width(200).whc_Height(26)
            button_Selecter.setTitle("所有", for: .normal)
            button_Selecter.setTitleColor(UIColor.black, for: .normal)
            button_Selecter.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button_Selecter.setImage(UIImage(named: "pulldown"), for: .normal)
            button_Selecter.imageEdgeInsets = UIEdgeInsetsMake(0, 200 - 30, 0, 0)
            button_Selecter.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 150)
            button_Selecter.setTitleShadowColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .highlighted)
            button_Selecter.addTarget(self, action: #selector(button_SelectorClickHandle), for: .touchUpInside)
            button_Selecter.whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
            button_Selecter.layer.borderColor = UIColor.cc_224().cgColor
            button_Selecter.layer.borderWidth = 1.0
            button_Selecter.layer.cornerRadius = 3
            button_Selecter.clipsToBounds = true
            
            let labal_Type = UILabel()
            addSubview(labal_Type)
            labal_Type.whc_CenterYEqual(button_Selecter).whc_Right(10, toView: button_Selecter).whc_WidthAuto().whc_Height(15)
            labal_Type.font = UIFont.systemFont(ofSize: 12)
            labal_Type.textColor = UIColor.cc_51()
            labal_Type.text = "彩种类型："
            
            addSubview(button_dateEnd)
            button_dateEnd.whc_Top(5, toView: button_Selecter).whc_RightEqual(button_Selecter).whc_Width(97).whc_Height(25)
            button_dateEnd.setTitleColor(UIColor.cc_136(), for: .normal)
            button_dateEnd.setTitle("2018-04-02", for: .normal)
            button_dateEnd.titleLabel?.font = UIFont.systemFont(ofSize: 9)
            button_dateEnd.layer.borderColor = UIColor.cc_224().cgColor
            button_dateEnd.layer.borderWidth = 0.5
            button_dateEnd.layer.cornerRadius = 3
            button_dateEnd.clipsToBounds = true
            
            let label = UILabel()
            addSubview(label)
            label.whc_CenterYEqual(button_dateEnd).whc_WidthAuto().whc_Height(5).whc_Right(3, toView: button_dateEnd)
            label.font = UIFont.systemFont(ofSize: 9)
            label.textColor = UIColor.black
            label.text = "--"
            
            addSubview(button_dateStart)
            button_dateStart.whc_CenterYEqual(button_dateEnd).whc_RightEqual(button_Selecter).whc_WidthEqual(button_dateEnd).whc_HeightEqual(button_dateEnd)
            button_dateStart.frame = CGRect.init(x: 50, y: 110, width: 60, height: 60)
            button_dateStart.setTitle("2018-04-00", for: .normal)
            button_dateStart.setTitleColor(UIColor.cc_136(), for: .normal)
            button_dateStart.titleLabel?.font = UIFont.systemFont(ofSize: 9)
            button_dateStart.layer.borderWidth = 0.5
            button_dateStart.layer.borderColor = UIColor.cc_224().cgColor
            button_dateStart.layer.cornerRadius = 3
            button_dateStart.clipsToBounds = true
            button_dateStart.isHidden = false
            
            let label_DateTitle = UILabel()
            addSubview(label_DateTitle)
            label_DateTitle.whc_CenterYEqual(button_dateStart).whc_Right(7, toView: button_dateStart).whc_Height(12).whc_WidthAuto()
            label_DateTitle.textAlignment = .right
            label_DateTitle.font  = UIFont.systemFont(ofSize: 12)
            label_DateTitle.textColor = UIColor.cc_51()
            label_DateTitle.text = "日期："
            break
        default:
            break
        }
        addBottomButton()
    }
    @objc private func button_SelectorClickHandle() {
        
        let selectedView = LennySelectView(dataSource: kLenny_LotteryTypes, viewTitle: "彩种类型")
        selectedView.selectedIndex = 0
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.button_Selecter.setTitle(selectedView.kLenny_InsideDataSource[index], for: .normal)
            
        }
        window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    private var isSubInput: Bool = false
    private var isSubSelecter: Bool = false
    
    private func addBottomButton() {
        if isSubInput {
            
            addSubview(button_Confirm)
            button_Confirm.whc_Top(9, toView: textField).whc_RightEqual(button_dateEnd).whc_Width(34).whc_Height(21)
            addSubview(button_Cancel)
            button_Cancel.whc_TopEqual(button_Confirm).whc_Right(8, toView: button_Confirm).whc_Width(34).whc_Height(21)
        }else if isSubSelecter {
            
            addSubview(button_Confirm)
            button_Confirm.whc_Top(9, toView: button_Selecter).whc_RightEqual(button_dateEnd).whc_Width(34).whc_Height(21)
            addSubview(button_Cancel)
            button_Cancel.whc_TopEqual(button_Confirm).whc_Right(8, toView: button_Confirm).whc_Width(34).whc_Height(21)
        }else {
            
            addSubview(button_Confirm)
            button_Confirm.whc_Top(9, toView: button_dateEnd).whc_RightEqual(button_dateEnd).whc_Width(34).whc_Height(21)
            addSubview(button_Cancel)
            button_Cancel.whc_TopEqual(button_Confirm).whc_Right(8, toView: button_Confirm).whc_Width(34).whc_Height(21)
        }
        
        button_Confirm.setTitle("确认", for: .normal)
        button_Confirm.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button_Confirm.backgroundColor = UIColor.mainColor()
        button_Confirm.setTitleColor(UIColor.white, for: .normal)
        button_Confirm.layer.cornerRadius = 3
        button_Confirm.clipsToBounds = true
        button_Confirm.addTarget(self, action: #selector(button_ConfirmClickHandle), for: .touchUpInside)
        
        button_Cancel.setTitle("取消", for: .normal)
        button_Cancel.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        button_Cancel.backgroundColor = UIColor.white
        button_Cancel.setTitleColor(UIColor.cc_136(), for: .normal)
        button_Cancel.layer.cornerRadius = 3
        button_Cancel.clipsToBounds = true
        button_Cancel.addTarget(self, action: #selector(button_CancelClickHandle), for: .touchUpInside)
    }
    
    @objc private func button_ConfirmClickHandle() {
        didClickConfirmButton?("", "")
    }
    @objc private func button_CancelClickHandle() {
        didClickCancleButton?()
    }
    
    var didClickCancleButton: ( () -> Void)?
    var didClickConfirmButton: ( (String, String) -> Void)?
}
