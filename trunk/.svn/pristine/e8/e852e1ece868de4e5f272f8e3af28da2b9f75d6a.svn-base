//
//  TopupFilterView.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/3.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class TopupFilterView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
    }
    
    convenience init() {
        
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var startDate: UITextField!
    private var endDate: UITextField!
    private var orderNumber: UITextField!
    
    private func setViews() {
        
        let label_Title = UILabel()
        self.addSubview(label_Title)
        label_Title.whc_Top(20).whc_Left(10).whc_Height(15).whc_WidthAuto()
        label_Title.font = UIFont.systemFont(ofSize: 15)
        label_Title.text = "日期："
        label_Title.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        
        let stackView = WHC_StackView()
        self.addSubview(stackView)
        stackView.whc_Top(10, toView: label_Title).whc_Left(20).whc_Right(20).whc_Height(35)
        stackView.whc_Column = 2
        stackView.whc_Orientation = .all
        stackView.whc_HSpace = 35
        startDate = UITextField()
        startDate.borderStyle = .roundedRect
        stackView.addSubview(startDate)
        endDate = UITextField()
        endDate.borderStyle = .roundedRect
        stackView.addSubview(endDate)
        stackView.whc_StartLayout()
        
        let label = UILabel()
        self.addSubview(label)
        label.whc_Center(0, y: 0, toView: stackView).whc_Height(10).whc_WidthAuto()
        label.textAlignment = .center
        label.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
        label.text = "--"
        
        let label_OrderNumber = UILabel()
        self.addSubview(label_OrderNumber)
        label_OrderNumber.whc_Top(10, toView: stackView).whc_Left(10).whc_Height(15).whc_WidthAuto()
        label_OrderNumber.font = UIFont.systemFont(ofSize: 15)
        label_OrderNumber.text = "订单号："
        
        orderNumber = UITextField()
        self.addSubview(orderNumber)
        orderNumber.whc_Top(10, toView: label_OrderNumber).whc_Left(20).whc_Right(20).whc_Height(30)
        orderNumber.borderStyle = .roundedRect
        
        let button_Confirm = UIButton()
        self.addSubview(button_Confirm)
        button_Confirm.whc_Top(10, toView: orderNumber).whc_Right(20).whc_Width(60).whc_Height(30)
        button_Confirm.layer.cornerRadius = 5
        button_Confirm.clipsToBounds = true
        button_Confirm.setTitle("确认", for: .normal)
        button_Confirm.setTitleColor(UIColor.white, for: .normal)
        button_Confirm.backgroundColor = UIColor.ccolor(with: 236, g: 40, b: 40)
        
        let button_Cancel = UIButton()
        self.addSubview(button_Cancel)
        button_Cancel.whc_Top(10, toView: orderNumber).whc_Right(20, toView: button_Confirm).whc_Width(60).whc_Height(30)
        button_Cancel.layer.cornerRadius = 5
        button_Cancel.clipsToBounds = true
        button_Cancel.setTitle("取消", for: .normal)
        button_Cancel.setTitleColor(UIColor.ccolor(with: 136, g: 136, b: 136), for: .normal)
        button_Cancel.backgroundColor = UIColor.ccolor(with: 224, g: 224, b: 224)
    }
    
    override func didMoveToSuperview() {
        layoutSubviews()
    }
}
