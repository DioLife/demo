//
//  CPViewCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/12.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class CPViewCell: UICollectionViewCell {
    
//    var indictorLabel : UILabel?//指示label
    var tagImg: UIImageView!
    var indictor:UIButton!
    var imgView : UIImageView?//lottery 图片
    var titleLabel:UILabel?//lottery title
    //宽度要减去与两边的我间距20,再减去单元项间距0.5*6
    let screen_width = UIScreen.main.bounds.size.width - 0.5*6//获取屏幕宽
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化各种控件
        
        setupNoPictureAlphaBgView(view: self)
        
        indictor = UIButton.init(frame: CGRect.init(x: self.bounds.width - 20, y: 0, width: 20, height: 20))
        indictor.titleLabel?.textColor = UIColor.white
        indictor.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(indictor)
        imgView = UIImageView(frame: CGRect(x: screen_width/6 - 30, y: 15, width: 60, height: 60))
        self .addSubview(imgView!)
        tagImg = UIImageView(frame: CGRect(x: (imgView?.frame.size.width)! * CGFloat(0.75) + (imgView?.frame.origin.x)!, y:(imgView?.frame.origin.y)! , width: 20, height: 20))
        self.addSubview(tagImg)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 15+60+10, width: screen_width/3, height: 30))
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
//        titleLabel?.textColor = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        titleLabel?.theme_textColor = "FrostedGlass.normalDarkTextColor"
        titleLabel?.textAlignment = NSTextAlignment.center
        self .addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update_indictor(modulecode:Int,lotVersion:String){
        if modulecode == CAIPIAO_MODULE_CODE && lotVersion == VERSION_1{
//            indictor.setBackgroundImage(UIImage.init(named: "icon_guang"), for: .normal)
        }else if modulecode == CAIPIAO_MODULE_CODE && lotVersion == VERSION_2{
//            indictor.setBackgroundImage(UIImage.init(named: "icon_xin"), for: .normal)
        }else if modulecode == SPORT_MODULE_CODE{
            tagImg.image = UIImage(named: "homePhysicalTag")
//            indictor.setBackgroundImage(UIImage.init(named: "icon_ti"), for: .normal)
        }else if modulecode == GAME_MODULE_CODE{
//            indictor.setBackgroundImage(UIImage.init(named: "icon_dian"), for: .normal)
            tagImg.image = UIImage(named: "homeElectricTag")
        }else if modulecode == REAL_MODULE_CODE{
            tagImg.image = UIImage(named: "homeHumanTag")
//            indictor.setBackgroundImage(UIImage.init(named: "icon_zhen"), for: .normal)
        }
    }
    
    func setupData(data:LotteryData){
        if let lotName = data.name{
            titleLabel?.text = lotName
        }else{
            titleLabel?.text = "暂无名称"
        }
        update_indictor(modulecode: data.moduleCode, lotVersion: String(data.lotVersion))
        if data.moduleCode == CAIPIAO_MODULE_CODE {
            guard let lotCode = data.code else {
                imgView?.image = UIImage(named: "default_lottery")
                return
            }
            if isEmptyString(str: data.lotteryIcon) {
                let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + lotCode + ".png")
                imgView?.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
            }else {
                if let url = URL.init(string: data.lotteryIcon) {
                    imgView?.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }else{
            let imgUrl = data.imgUrl
            if !isEmptyString(str: imgUrl) {
                let imageURL = URL(string: BASE_URL + PORT + imgUrl)
                if let url = imageURL{
                    downloadImage(url: url, imageUI: imgView!)
                }
            }else{
                var defaultIcon = UIImage.init(named: "icon_ft")
                if data.moduleCode == SPORT_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_ft")
                } else if data.moduleCode == REAL_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_real")
                } else if data.moduleCode == GAME_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_game")
                }
                imgView?.image = defaultIcon
            }
        }
    }
}
