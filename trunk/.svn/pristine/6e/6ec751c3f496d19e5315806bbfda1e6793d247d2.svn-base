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
//        self.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     Nums:号码数组
     Offset:整个号码球视图与左边的间距
     lotTypeCode: 彩种类型编号
     cpVersion: 彩票版本
     ballWidth:每个球的宽度
     small:球上的小字号是否显示小字号
     grivity_bottom:球是否居底部显示
     ballsViewWidth:所有球所占的视图宽度
     forBetPageBelow:是否只针对投注页中的最近开奖号码
    **/
    func setupBalls(nums:[String],offset:Int,lotTypeCode:String,cpVersion:String,ballWidth:CGFloat=35,
                    small:Bool=false,gravity_bottom:Bool=true,ballsViewWidth: CGFloat,forBetPageBelow:Bool=false) -> Void {
        
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let ballW = ballWidth
//        let ballViewWidth = kScreenWidth - 100 - 8 - 5 // 期号label宽度为100，self与前后控件间距为 8，5
//        let offset:Float = Float(self.bounds.width/2) - Float(nums.count)*Float(ballW)/2
        var offset:Float = 0 //整个号码球视图与左边的间距
        let offsetBetweenBalls:Float = 3.0//两个号码球之前的间距
        
        var ballsViewWidth2 = ballsViewWidth
        if offsetBetweenBalls > 0 && !forBetPageBelow{
            ballsViewWidth2 = ballsViewWidth - CGFloat(offsetBetweenBalls*Float(nums.count+1))
        }
        
        //若时投注页开奖结果列表里的号码view，不需要将号码view居中
        if !forBetPageBelow{
            offset = Float(ballsViewWidth2/2) - Float(nums.count)*Float(ballW)/2
        }
        
        for index in 0...nums.count-1{
            
            let ball = UIButton.init(frame: CGRect.init(x: CGFloat(Float(ballW*CGFloat(index)) + offset + Float(offsetBetweenBalls*Float(index))), y: !gravity_bottom ? (self.bounds.height - ballW)/2 : (self.bounds.height - ballW), width: ballW, height: ballW))
            ball.contentMode = .scaleAspectFill
            ball.isUserInteractionEnabled = false
            
            let (image,showTitle) = figureImgeByCpCode(cpCode: lotTypeCode, cpVersion: cpVersion, num: nums[index],forBetPageBelow:forBetPageBelow)
            if showTitle{
                ball.setTitle(nums[index], for: .normal)
                ball.setTitleColor((lotTypeCode == "6" || lotTypeCode == "66" || isKuai3(lotType: lotTypeCode)) ? UIColor.black : UIColor.white, for: .normal)
                ball.titleLabel?.font = UIFont.boldSystemFont(ofSize: small ? 10 : 14)
            }
            
            //Shaw-NOTYET,需要切换完成所有的 figureImgeByCpCode()方法会返回的图片，否则crash
            // 不需要主题
            if cpVersion == VERSION_2 && lotTypeCode == "9" {
                ball.setBackgroundImage(UIImage(named: image), for: .normal)
            }else if lotTypeCode == "6" || lotTypeCode == "66" {
                ball.setBackgroundImage(UIImage(named: image), for: .normal)
            }else if lotTypeCode == "4" || lotTypeCode == "3"{
                ball.setBackgroundImage(UIImage(named: image), for: .normal)
            }else {
                ball.theme_setBackgroundImage(ThemeImagePicker.init(keyPath: image), forState: .normal)
            }
            self.addSubview(ball)
        }
    }
    
    func getKuai3NumImage(num:String) -> (image:String,showTitle:Bool) {
        
        switch num {
        case "1":
            return ("kuai3_bg_one",false)
        case "2":
            return ("kuai3_bg_two",false)
        case "3":
            return ("kuai3_bg_three",false)
        case "4":
            return ("kuai3_bg_four",false)
        case "5":
            return ("kuai3_bg_five",false)
        case "6":
            return ("kuai3_bg_six",false)
        default:
            break
        }
        return ("kuai3_bg_empty",true)
    }
    
    func figurePceggImage(num:String) -> String {
//        let images = ["ffc_yellow_bg","ffc_red_bg","ffc_green_bg","ffc_blue_bg","ffc_light_blue_bg"]
//        let i = Int(arc4random() % UInt32(images.count))
//        return images[i]
        return "open_result_ball"
    }
    
    func figureLhcImages(num:String) -> String {
        let redBO = ["01","02","07","08","12","13","18","19","23","24","29","30","34","35","40","45","46"]
        let blueBO = ["03","04","09","10","14","15","20","25","26","31","36","37","41","42","47","48"]
        let greenBO = ["05","06","11","16","17","21","22","27","28","32","33","38","39","43","44","49"]
        if redBO.contains(num){
            return "lhc_red_bg"
        }else if blueBO.contains(num){
            return "lhc_blue_bg"
        }else if greenBO.contains(num){
            return "lhc_green_bg"
        }
        return "lhc_red_bg"
    }
    
    func figureSaiCheImage(num:String) -> (image:String,showTitle:Bool) {
        if num == "?"{
            return ("open_result_ball",true)
        }
        return (String.init(format: "sc_%@_title",num ),false)
    }
    
    func figureXYNCImage
        (num:String) -> (image:String,showTitle:Bool) {
        if num == "?"{
            return ("open_result_ball",true)
        }
        return (String.init(format: "xync_%@",num ),false)
    }
    
    func figureImgeByCpCode(cpCode:String,cpVersion:String,num:String,forBetPageBelow:Bool=false) -> (image:String,showTitle:Bool) {
        
        var image = "TouzhOffical.recentResult"
        var showTitle = false
        
        switch cpVersion {
        case VERSION_2:
            switch cpCode{
            case "4"://快三
                let (images,showTitles) = getKuai3NumImage(num: num)
                image = images
                showTitle = showTitles
            case "9"://重庆幸运农场,湖南快乐十分,广东快乐十分
                let (images,showTitles) = figureXYNCImage(num: num)
                image = images
                showTitle = showTitles
            case "3"://极速赛车，北京赛车，幸运飞艇
                let (images,showTitles) = figureSaiCheImage(num: num)
                image = images
                showTitle = showTitles
            case "5","8","7","1","2"://11选5,福彩3D，排列三,pc蛋蛋，加拿大28
                showTitle = true
                if forBetPageBelow{
                    image = "TouzhOffical.recentResult"
                }else{
                    image = "TouzhOffical.ballDark"
                }
            case "6","66"://六合彩，十分六合彩
                image = figureLhcImages(num: num)
                showTitle = true
            default:
                break
            }
        case VERSION_1:
            switch cpCode{
                case "4"://快三
                    let (images,showTitles) = getKuai3NumImage(num: num)
                    image = images
                    showTitle = showTitles
                case "3"://极速赛车，北京赛车，幸运飞艇
                    let (images,showTitles) = figureSaiCheImage(num: num)
                    image = images
                    showTitle = showTitles
                case "5","8","7","1","2"://11选5,福彩3D，排列三,pc蛋蛋，加拿大28
                    showTitle = true
                    if forBetPageBelow{
                        image = "TouzhOffical.recentResult"
                    }else{
                        image = "TouzhOffical.ballDark"
                    }
                case "6","66"://六合彩，十分六合彩
                    image = figureLhcImages(num: num)
                    showTitle = true
                default:
                    break
                }
        default:
            break
        }
        return (image:image,showTitle:showTitle)
    }
}
