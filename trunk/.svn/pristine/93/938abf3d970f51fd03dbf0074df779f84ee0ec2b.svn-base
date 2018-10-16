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
    var selectedTag = -1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setData(array: [BallListItemInfo],funcView:Bool=true,playRuleShow:Bool) {
        self.isFuncView = funcView
        createView(array:array,playRuleShow:playRuleShow)
    }
    
    func initData(array:[String],playRuleShow:Bool) -> Void {
        self.isFuncView = true
        createViewWithArray(array:array,playRuleShow:playRuleShow)
    }
    
    func createViewWithArray(array:[String],playRuleShow:Bool) -> Void {
        //这里的总宽度是指 = (总宽度-左边玩法栏(1/4屏宽)-伸缩杆view(1/20屏宽))*0.75(因为1/4的宽度被玩法uilabel占用) - 10（功能view与玩法label的左间隔10）
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let totalWidth = (playRuleShow ? kScreenWidth*0.68 : kScreenWidth) - 65 - 20
//        let totalWidth = self.frame.size.width
        //Shaw-NOTYET 稍后再改
        for index in 0...array.count-1{
            let cellWidth = totalWidth/CGFloat(array.count)
            let btn = UIButton.init(frame: CGRect.init(x: cellWidth*CGFloat(index), y: self.bounds.origin.y, width: cellWidth, height: 30))
            btn.tag = 10+index
            btn.addTarget(self, action: #selector(onViewClick), for: .touchUpInside)
            btn.setTitle(array[index], for: .normal)
            
            btn.theme_setTitleColor("Global.themeColor", forState: .normal)
            btn.setTitleColor(UIColor.white, for: .highlighted)
            btn.theme_setBackgroundImage("Global.themeColorImg", forState: .highlighted)
            
            btn.layer.borderWidth = 0.4
            btn.layer.theme_borderColor = "FrostedGlass.Touzhu.separateLineColor"
            self.addSubview(btn)
        }
    }

    
    func createView(array:[BallListItemInfo],playRuleShow:Bool) -> Void {
        //这里的总宽度是指 = (总宽度-左边玩法栏(1/4屏宽)-伸缩杆view(1/20屏宽))*0.75(因为1/4的宽度被玩法uilabel占用) - 10（功能view与玩法label的左间隔10）
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let totalWidth = (playRuleShow ? kScreenWidth*0.7 : kScreenWidth*0.95) - 40 - 15
        for index in 0...array.count-1{
            let cellWidth = totalWidth/CGFloat(array.count)
            let btn = UIButton.init(frame: CGRect.init(x: cellWidth*CGFloat(index)-0.5, y: self.bounds.origin.y, width: cellWidth, height: 30))
            btn.tag = 20+index
            btn.addTarget(self, action: #selector(WeishuFuncView.onViewClick), for: .touchUpInside)
            btn.setTitle(array[index].num, for: .normal)
            if array[index].isSelected{
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.theme_backgroundColor = "Global.themeColor"
            }else{
                btn.setTitleColor(UIColor.black, for: .normal)
                btn.theme_setTitleColor("Global.themeColor", forState: .normal)
                btn.layer.theme_borderColor = "FrostedGlass.Touzhu.separateLineColor"
                btn.backgroundColor = UIColor.white
                btn.layer.borderWidth = 0.4
            }
            self.addSubview(btn)
        }
    }
    
    @objc func onViewClick(ui:UIButton) -> Void {
        selectedTag = ui.tag
        if let delegate = self.cellDelegate{
            delegate.onBtnsClickCallback(btnTag: ui.tag, cellPos: self.cellPos)
        }
    }
}


