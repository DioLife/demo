//
//  TrendChartSaiCheCell.swift
//  gameplay
//
//  Created by Lenny's Macbook Air on 2018/5/31.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class TrendChartSaiCheCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    var periodHeightWidth:CGFloat = 30
    
    private let label_Title = UILabel()
    private let stackView = WHC_StackView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNoPictureAlphaBgView(view: self)
        
//        self.isSkeletonable = true
//        contentView.isSkeletonable = true
        contentView.addSubview(label_Title)
        
        let periodHeaderWidth:CGFloat = 80
        
        periodHeightWidth = (screenWidth - periodHeaderWidth) / CGFloat(10)
        label_Title.whc_Top(0).whc_Bottom(0).whc_Left(0).whc_Height(periodHeightWidth).whc_Width(CGFloat(periodHeaderWidth))
        label_Title.font = UIFont.boldSystemFont(ofSize: 14)
        label_Title.numberOfLines = 1
        label_Title.adjustsFontSizeToFitWidth = true
//        label_Title.textColor = UIColor.gray
        label_Title.theme_textColor = "FrostedGlass.normalDarkTextColor"
        label_Title.text = "5250988"
        label_Title.textAlignment = .center
//        label_Title.isSkeletonable = true
        
        contentView.addSubview(stackView)
        stackView.whc_Top(0).whc_Bottom(0).whc_Left(0, toView: label_Title).whc_Right(0)
        stackView.whc_Column = 10
        stackView.whc_Orientation = .all
        stackView.whc_SegmentLineSize = 0.45
        stackView.whc_SegmentLineColor = UIColor.cc_224()
//        stackView.isSkeletonable = true
        for _ in 0 ..< 10 {
            let label = UILabel()
            stackView.addSubview(label)
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.cc_136()
            label.theme_textColor = "FrostedGlass.normalDarkTextColor"
            label.textAlignment = .center
        }
        stackView.whc_StartLayout()
        
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
            if i == winNumber - 1{
                label.layer.cornerRadius = periodHeightWidth * 0.5
                label.backgroundColor = UIColor.mainColor()
                label.clipsToBounds = true
                label.text = String(winNumber)
                label.textColor = UIColor.white
                label.tag = 1023
                if associatedContrller.brokenLineItems == nil { associatedContrller.brokenLineItems = [label] }
                else { associatedContrller.brokenLineItems?.append(label)}
            }
        }
    }
    
    func drawLinesWith(currentPointerIndex: Int, nextPointerIndex: Int, lastPointerIndex: Int) {
        
        let pointer = stackView.viewWithTag(1023)?.center
        var nextPointer = CGPoint.init(x: pointer!.x + CGFloat(nextPointerIndex - currentPointerIndex) * periodHeightWidth, y: pointer!.y + periodHeightWidth)
        var lastPointer = CGPoint.init(x: pointer!.x + CGFloat(lastPointerIndex - currentPointerIndex) * periodHeightWidth, y: pointer!.y - periodHeightWidth)
        if currentPointerIndex == lastPointerIndex { lastPointer = pointer! }
        if currentPointerIndex == nextPointerIndex { nextPointer = pointer!}
        print( pointer,"----- ", nextPointer)
        let line_beizer = UIBezierPath.init()
        line_beizer.move(to: lastPointer)
        line_beizer.addLine(to: pointer!)
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
