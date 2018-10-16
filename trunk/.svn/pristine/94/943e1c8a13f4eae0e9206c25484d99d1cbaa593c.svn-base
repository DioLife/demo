//
//  CustomSlider.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/10.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

protocol SeekbarChangeEvent {
    func onSeekbarEvent(currentRate:Float,currentWin:Float,progressRate:Float)
}

class CustomSlider: UISlider {
    
    var currentOdds:Float = 0;//当前奖金或賠率
    var currentRateback:Float = 0;//当前返水比例
    var maxRakeback:Float = 0;//最大返水
    var maxOdds:Float = 0;//最大奖金或賠率
    var minOdds:Float = 0;//最小獎金或賠率
    var isOfficialVersion = true;//是否奖金版本
    var delegate:SeekbarChangeEvent?
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
    }
    
    func setupLogic(odd:PeilvWebResult?){
        if odd == nil{
            return
        }
        self.maxRakeback = (odd?.rakeback)!
        self.maxOdds = (odd?.maxOdds)!
        self.minOdds = (odd?.minOdds)!
        self.currentOdds = maxOdds
        currentRateback = 0
        if let callback = delegate{
            callback.onSeekbarEvent(currentRate: currentRateback, currentWin: currentOdds, progressRate: 0)
        }
        self.value = 1
        
    }
    
    func setupLogic(maxRakeback:Float,maxOdds:Float,minOdds:Float){
        self.maxRakeback = maxRakeback
        self.maxOdds = maxOdds
        self.minOdds = minOdds
        self.currentOdds = maxOdds
        self.currentRateback = 0
        if let callback = delegate{
            callback.onSeekbarEvent(currentRate: currentRateback, currentWin: currentOdds, progressRate: 0)
        }
        self.value = 1
    }
    
    func changeSeekbar(currentProgress:Float){
        let progressRate = 1 - currentProgress
        self.currentRateback = progressRate*maxRakeback
        self.currentOdds = maxOdds - progressRate*abs(maxOdds - minOdds)
//        currentRateTV.setText(String.format("%.2f",currentRateback)+"%");
//        currentJianjinTV.setText(String.format("%.2f",currentOdds));
        if let callback = delegate{
            callback.onSeekbarEvent(currentRate: currentRateback, currentWin: currentOdds, progressRate: progressRate)
        }
    }
    
    
    

}
