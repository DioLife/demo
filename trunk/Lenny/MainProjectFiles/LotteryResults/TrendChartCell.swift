//
//  TrendChartCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/25.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class TrendChartCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var stackViewColum: Int {
        return 10
    }
    
    var stackViewGridWidth_Height: CGFloat = 30
//    var stackViewGridWidth_Height: CGFloat {
//        return 30
//    }
    
     let label_Title = UILabel()
     let stackView = WHC_StackView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNoPictureAlphaBgView(view: self)
        
        let periodHeaderW: CGFloat = 80 //期号表头宽度
        
//        self.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(label_Title)
//        label_Title.whc_Top(0).whc_Left(0).whc_Height(stackViewGridWidth_Height).whc_Bottom(0).whc_Right(CGFloat(stackViewColum) * stackViewGridWidth_Height)
        
        stackViewGridWidth_Height = (screenWidth - periodHeaderW) / CGFloat(stackViewColum)
    label_Title.whc_Top(0).whc_Left(0).whc_Height(stackViewGridWidth_Height).whc_Bottom(0).whc_Width(periodHeaderW)
        label_Title.font = UIFont.boldSystemFont(ofSize: 14)
        label_Title.numberOfLines = 1
        label_Title.adjustsFontSizeToFitWidth = true
        label_Title.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Title.text = "5250988"
        label_Title.textAlignment = .center
//        label_Title.isSkeletonable = true
        
        contentView.addSubview(stackView)
        stackView.whc_Top(0).whc_Bottom(0).whc_Left(0, toView: label_Title).whc_Right(0)
        stackView.whc_Column = stackViewColum
        stackView.whc_Orientation = .all
        stackView.whc_SegmentLineSize = 0.45
        stackView.whc_SegmentLineColor = UIColor.cc_224()
//        stackView.isSkeletonable = true
        for _ in 0 ..< stackViewColum {
            let label = UILabel()
            stackView.addSubview(label)
            label.font = UIFont.systemFont(ofSize: 15)
            label.theme_textColor = "FrostedGlass.normalDarkTextColor"
            label.textAlignment = .center
        }
        stackView.whc_StartLayout()
        
        //上方分割线
        let view = UIView()
        contentView.addSubview(view)
        view.whc_Top(0).whc_Bottom(0).whc_Right(0, toView: stackView).whc_Width(0.5)
        view.backgroundColor = UIColor.cc_224()
        whc_AddBottomLine(0.5, color: UIColor.cc_224())
        selectionStyle = .none
    }
    
    func setTitle(value: String) {
        label_Title.text = value
    }
    func setValues(values: [String], And winningNumber: String, associatedContrller: LotteryResultsTrendChartBasicController) {
        
        let winNumber = Int(winningNumber)!
        for i in 0 ..< values.count {
            if i >= 10 {return}
            let label = stackView.whc_SubViews[i] as! UILabel
            label.text = values[i]
            if i == winNumber {
                label.layer.cornerRadius = stackViewGridWidth_Height * 0.5
                label.backgroundColor = UIColor.mainColor()
                label.clipsToBounds = true
                label.text = winningNumber
                label.textColor = UIColor.white
                label.tag = 1023
                if associatedContrller.brokenLineItems == nil { associatedContrller.brokenLineItems = [label] }
                else { associatedContrller.brokenLineItems?.append(label)}
            }
        }
    }
    
    func drawLinesWith(currentPointerIndex: Int, nextPointerIndex: Int, lastPointerIndex: Int) {
        
        let mpointer = stackView.viewWithTag(1023)?.center
        guard let pointer = mpointer else {return}
        var nextPointer = CGPoint.init(x: pointer.x + CGFloat(nextPointerIndex - currentPointerIndex) * stackViewGridWidth_Height, y: pointer.y + stackViewGridWidth_Height)
        var lastPointer = CGPoint.init(x: pointer.x + CGFloat(lastPointerIndex - currentPointerIndex) * stackViewGridWidth_Height, y: pointer.y - stackViewGridWidth_Height)
        if currentPointerIndex == lastPointerIndex { lastPointer = pointer }
        if currentPointerIndex == nextPointerIndex { nextPointer = pointer}
        print( pointer,"----- ", nextPointer)
        let line_beizer = UIBezierPath.init()
        line_beizer.move(to: lastPointer)
        line_beizer.addLine(to: pointer)
        line_beizer.addLine(to: nextPointer)
        let layer_line = CAShapeLayer.init()
        layer_line.lineWidth = 1
        layer_line.strokeColor = UIColor.mainColor().cgColor
        layer_line.path = line_beizer.cgPath
        layer_line.fillColor = nil
        stackView.layer.addSublayer(layer_line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
