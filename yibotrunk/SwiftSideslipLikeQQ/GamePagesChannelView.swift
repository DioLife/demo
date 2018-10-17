//
//  GamePagesChannelView.swift
//  YiboGameIos
//
//  Created by admin on 2018/6/30.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

let kChannelMargin:CGFloat = 10

protocol GamePagesChannelDelegate {
    func gamePagesChannelTap(_ channelView: GamePagesChannelView, forItemAt index: Int)
}

class GamePagesChannelView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectedIndex = 0 {
        didSet {
//            let oldLabel = self.scrollView.subviews[oldSelectedTag - 10000] as! UILabel
//            oldLabel.textColor = UIColor.black
//
//            // 点击的 label,改变其属性
//            labelView.textColor = UIColor.red
            print("当前选择的index：\(selectedIndex)")
            
            let oldLabel = self.scrollView.subviews[oldSelectedTag - 10000] as! UILabel
            oldLabel.textColor = UIColor.black
            
            let currentLabel = self.scrollView.subviews[selectedIndex] as! UILabel
            currentLabel.textColor = UIColor.red
            
            oldSelectedTag = selectedIndex + 10000
        }
    }

    var delegate: GamePagesChannelDelegate?
   
    var oldSelectedTag: Int = 10000

    var channels: Array<String> = Array<String>() {
        didSet {
            // 外部设置 channels就会执行下面代码
            // 。。。
            setChannels(channels: channels)
        }
    }
    
    // 外部设置 cahnnels，需要执行的操作
    func setChannels(channels: Array<String>) {
        var offsetX: CGFloat = kChannelMargin
        
        // 初始化每个 label
        for (index,contents) in channels.enumerated() {
            
            let label = UILabel()
            label.tag = 10000 + index
            
            let labelWidth:CGFloat = ((kScreenWidth - (CGFloat)(channels.count - 1) * kChannelMargin ) / ((CGFloat)(channels.count)) )
            
            label.text = contents
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            
            if index == 0 {
                label.textColor = UIColor.red
            }
            
            var frame = label.frame
            frame.origin.x = offsetX
            frame.size.height = 36
            frame.size.width = labelWidth
            label.frame = frame
            
            // 给label添加点击手势
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(withGesture:)))
            label.addGestureRecognizer(tapGesture)
            label.isUserInteractionEnabled = true
            
            scrollView.addSubview(label)
            
            offsetX += label.frame.size.width + kChannelMargin
        }

        // 设置滚动视图的 contnetSize
        scrollView.contentSize = CGSize(width: offsetX, height: 36)
    }
    
    func labelTapped(withGesture getsture:UITapGestureRecognizer) {
        print("点击了label")
        guard let label = getsture.view,
            let labelIndex: Int = label.tag - 10000
        else {return}
        
        selectedIndex = labelIndex
        
        let labelView = label as! UILabel
        
        // 其他 label，恢复其属性 || 或者上一个被点击的处理 || 或者先全部恢复，然后处理被点击的 .后期优化处理)
        let oldLabel = self.scrollView.subviews[oldSelectedTag - 10000] as! UILabel
        oldLabel.textColor = UIColor.black
        
        // 点击的 label,改变其属性
        labelView.textColor = UIColor.red
        
        oldSelectedTag = label.tag
        
        // 使用守护语法判断，是否遵守和实现了协议
        guard let delegate = self.delegate
            else {return}
        // 代理去执行操
        delegate.gamePagesChannelTap(self, forItemAt: labelIndex)
    }

}
