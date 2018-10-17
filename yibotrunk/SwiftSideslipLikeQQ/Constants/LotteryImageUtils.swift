//
//  LotteryImageUtils.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/8/15.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class LotteryImageUtils {
    
    static func figureImgeByCpCode(cpCode:String,cpVersion:String,num:String,index:Int)
        -> (image:String,showTitle:Bool) {
            
            var image = "ffc_blue_bg"
            var showTitle = false
            
            switch cpVersion {
            case lottery_identify_V2,lottery_identify_V4,lottery_identify_V5:
                switch cpCode{
                case "9"://时时彩
                    image = "ffc_yellow_bg"
                    showTitle = true
                case "10"://快三
                    let (images,showTitles) = getKuai3NumImage(num: num,index: index)
                    image = images
                    showTitle = showTitles
                case "11"://pc蛋蛋，加拿大28
                    image = figurePceggImage(num: num)
                    showTitle = true
                case "12"://重庆幸运农场,湖南快乐十分,广东快乐十分
                    //                let (images,showTitles) = figureXYNCImage(num: num)
                    //                image = images
                    //                showTitle = showTitles
                    image = "ffc_blue_bg"
                    showTitle = true
                case "8"://极速赛车，北京赛车，幸运飞艇
                    let (images,showTitles) = figureSaiCheImage(num: num)
                    image = images
                    showTitle = showTitles
                case "14"://11选5
                    image = "ffc_green_bg"
                    showTitle = true
                case "15"://福彩3D，排列三
                    image = "ffc_red_bg"
                    showTitle = true
                case "6","66"://六合彩，十分六合彩
                    image = figureLhcImages(num: num)
                    showTitle = true
                default:
                    break
                }
            case lottery_identify_V1:
                switch cpCode{
                case "1","2"://时时彩
                    image = "ffc_yellow_bg"
                    showTitle = true
                case "100"://快三
                    let (images,showTitles) = getKuai3NumImage(num: num,index: index)
                    image = images
                    showTitle = showTitles
                case "7"://pc蛋蛋，加拿大28
                    image = figurePceggImage(num: num)
                    showTitle = true
                case "3"://极速赛车，北京赛车，幸运飞艇
                    let (images,showTitles) = figureSaiCheImage(num: num)
                    image = images
                    showTitle = showTitles
                case "5"://11选5
                    image = "ffc_green_bg"
                    showTitle = true
                case "4"://福彩3D，排列三
                    image = "ffc_red_bg"
                    showTitle = true
                case "6","66"://六合彩，十分六合彩
                    image = figureLhcImages(num: num)
                    showTitle = true
                default:
                    break
                }
            case lottery_identify_V3:
                switch cpCode{
                case "51","52"://时时彩
                    image = "ffc_yellow_bg"
                    showTitle = true
                case "58"://快三
                    let (images,showTitles) = getKuai3NumImage(num: num,index: index)
                    image = images
                    showTitle = showTitles
                case "57"://pc蛋蛋，加拿大28
                    image = figurePceggImage(num: num)
                    showTitle = true
                case "53"://极速赛车，北京赛车，幸运飞艇
                    let (images,showTitles) = figureSaiCheImage(num: num)
                    image = images
                    showTitle = showTitles
                case "55"://11选5
                    image = "ffc_green_bg"
                    showTitle = true
                case "54"://福彩3D，排列三
                    image = "ffc_red_bg"
                    showTitle = true
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
    
    private static func getKuai3NumImage(num:String,index:Int) -> (image:String,showTitle:Bool) {
        if index < 3{
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
        }
        return ("kuai3_bg_empty",true)
    }
    
    private static func figurePceggImage(num:String) -> String {
        let images = ["ffc_yellow_bg","ffc_red_bg","ffc_green_bg","ffc_blue_bg","ffc_light_blue_bg"]
        let i = Int(arc4random() % UInt32(images.count))
        return images[i]
    }
    
    private static func figureLhcImages(num:String) -> String {
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
    
    private static func figureSaiCheImage(num:String) -> (image:String,showTitle:Bool) {
        if num == "?"{
            return ("sc_empty",false)
        }
        var numStr = num
        if !numStr.starts(with: "0") && numStr.count == 1{
            numStr = "0" + numStr
        }
        switch numStr {
        case "01","02","03","04","05","06","07","08","09","10":
            return (String.init(format: "sc_%@_title",numStr),false)
        default:
            return ("",true)
        }
    }
    
    private static func figureXYNCImage
        (num:String) -> (image:String,showTitle:Bool) {
        if num == "?"{
            return ("ffc_red_bg",true)
        }
        return (String.init(format: "xync_%@",num ),false)
    }

}
