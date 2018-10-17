//
//  BallsView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class BallsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupBalls(nums:[String],offset:Int,lotTypeCode:String,cpVersion:String,
                    viewPlaceHoldWidth:CGFloat,ballWidth:CGFloat=30,small:Bool=false,summary:Bool=false) -> Void {
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let ballW = ballWidth
        let totalBallWidth = ballW * CGFloat(nums.count)
        if totalBallWidth >= viewPlaceHoldWidth{
            let leftBallWidth = Int(totalBallWidth)%Int(viewPlaceHoldWidth)
            var secondBalls = CGFloat(leftBallWidth)/ballWidth
            let vInt = Int(secondBalls)
            //if有小数点的剩余个数,+1
            if Float(secondBalls) > Float(vInt){
                secondBalls = secondBalls + 1
            }
            let firstLineCount = nums.count - Int(secondBalls)
            for index in 0...firstLineCount-1{
                let ball = UIButton.init(frame: CGRect.init(x: ballW*CGFloat(index), y: 5, width: ballW, height: ballW))
                if !summary{
                    let (image,showTitle) = LotteryImageUtils.figureImgeByCpCode(cpCode: lotTypeCode, cpVersion: cpVersion, num: nums[index],index:index)
                    if showTitle{
                        ball.setTitle(nums[index], for: .normal)
                        ball.setTitleColor(UIColor.lightGray, for: .normal)
                        ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: small ? 14 : 14)
                    }
                    ball.setBackgroundImage(UIImage.init(named: image), for: .normal)
                }else{
                    ball.setTitle(nums[index], for: .normal)
                    ball.setTitleColor(UIColor.lightGray, for: .normal)
                    ball.setBackgroundImage(nil, for: .normal)
                }
                self.addSubview(ball)
            }
            if firstLineCount == nums.count{
                return
            }
            
            for index in firstLineCount...nums.count-1{
                print("secon index = \(index)")
                let height = ballW + CGFloat(offset) + 5
                let ball = UIButton.init(frame: CGRect.init(x: ballW*CGFloat(nums.count-1-index), y: height, width: ballW, height: ballW))
                ball.isUserInteractionEnabled = false
                let (image,showTitle) = LotteryImageUtils.figureImgeByCpCode(cpCode: lotTypeCode, cpVersion: cpVersion, num: nums[index],index: index)
                if showTitle{
                    ball.setTitle(nums[index], for: .normal)
                    ball.setTitleColor(UIColor.lightGray, for: .normal)
                    ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: small ? 14 : 14)
                }
                ball.setBackgroundImage(UIImage.init(named: image), for: .normal)
                self.addSubview(ball)
            }
        }else{
            for index in 0...nums.count-1{
                let ball = UIButton.init(frame: CGRect.init(x: ballW*CGFloat(index), y: 5, width: ballW, height: ballW))
                ball.isUserInteractionEnabled = false
                if !summary{
                    let (image,showTitle) = LotteryImageUtils.figureImgeByCpCode(cpCode: lotTypeCode, cpVersion: cpVersion, num: nums[index],index: index)
                    if showTitle{
                        ball.setTitle(nums[index], for: .normal)
                        ball.setTitleColor(UIColor.lightGray, for: .normal)
                        ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: small ? 14 : 14)
                    }
                    ball.setBackgroundImage(UIImage.init(named: image), for: .normal)
                }else{
                    ball.setTitle(nums[index], for: .normal)
                    ball.setTitleColor(UIColor.lightGray, for: .normal)
                    ball.setBackgroundImage(nil, for: .normal)
                }
                self.addSubview(ball)
            }
        }
    }
    
}
