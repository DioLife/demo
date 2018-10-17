//
//  WeishuFuncView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class WeishuFuncView: UIView {

    var isFuncView = true
    var cellDelegate:CellBtnsDelegate?
    var cellPos:Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setData(array: [BallListItemInfo],funcView:Bool=true,playRuleShow:Bool) {
        self.backgroundColor = UIColor.white
        self.isFuncView = funcView
        createView(array:array,playRuleShow:playRuleShow)
    }
    
    func initData(array:[String],playRuleShow:Bool) -> Void {
        self.backgroundColor = UIColor.white
        self.isFuncView = true
        createViewWithArray(array:array,playRuleShow:playRuleShow)
    }
    
    func createViewWithArray(array:[String],playRuleShow:Bool) -> Void {
        //这里的总宽度是指 = (总宽度-左边玩法栏(1/4屏宽)-伸缩杆view(1/20屏宽))*0.75(因为1/4的宽度被玩法uilabel占用) - 10（功能view与玩法label的左间隔10）
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let totalWidth = (playRuleShow ? kScreenWidth*0.7 : kScreenWidth*0.95)*0.75 - 10 - 5
        for index in 0...array.count-1{
            let cellWidth = totalWidth/CGFloat(array.count)
            let btn = UIButton.init(frame: CGRect.init(x: cellWidth*CGFloat(index)-0.5, y: self.bounds.origin.y, width: cellWidth-0.5, height: 30))
            btn.tag = 10+index
            btn.addTarget(self, action: #selector(onViewClick), for: .touchUpInside)
            btn.setTitle(array[index], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
            if index == 0{
                let path = UIBezierPath(roundedRect: btn.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 5, height: 5))
                let layer = CAShapeLayer()
                layer.frame = btn.bounds
                layer.path = path.cgPath
                btn.layer.mask = layer
            }else if index == array.count - 1{
                let path = UIBezierPath(roundedRect: btn.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 5, height: 5))
                let layer = CAShapeLayer()
                layer.frame = btn.bounds
                layer.path = path.cgPath
                btn.layer.mask = layer
            }
            self.addSubview(btn)
        }
    }
    
    func createView(array:[BallListItemInfo],playRuleShow:Bool) -> Void {
        //这里的总宽度是指 = (总宽度-左边玩法栏(1/4屏宽)-伸缩杆view(1/20屏宽))*0.75(因为1/4的宽度被玩法uilabel占用) - 10（功能view与玩法label的左间隔10）
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let totalWidth = (playRuleShow ? kScreenWidth*0.7 : kScreenWidth*0.95)*0.75 - 10 - 5
        for index in 0...array.count-1{
            let cellWidth = totalWidth/CGFloat(array.count)
            let btn = UIButton.init(frame: CGRect.init(x: cellWidth*CGFloat(index)-0.5, y: self.bounds.origin.y, width: cellWidth-1, height: 30))
            btn.tag = 20+index
            btn.addTarget(self, action: #selector(onViewClick), for: .touchUpInside)
            btn.setTitle(array[index].num, for: .normal)
            
            if array[index].isSelected{
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = UIColor.red
            }else{
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
            }
            self.addSubview(btn)
        }
    }
    
    func onViewClick(ui:UIButton) -> Void {
        if let delegate = self.cellDelegate{
            delegate.onBtnsClickCallback(btnTag: ui.tag, cellPos: self.cellPos)
        }
    }

}
