//
//  UsualGameBtn.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/15.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class UsualGameBtn: UIView {

    var image:UIImageView!
    var txt:UILabel!
    var secTxt:UILabel!
    
    override func awakeFromNib() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        image = UIImageView.init(frame: CGRect.init(x: 5, y: 5, width: self.bounds.width-10, height: self.bounds.height-10))
        txt = UILabel.init(frame: CGRect.init(x: 5, y: self.bounds.height/2-10, width: self.bounds.width, height: 20))
        txt.textAlignment = NSTextAlignment.center
        txt.textColor = UIColor.white
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        secTxt = UILabel.init(frame: CGRect.init(x: 5, y: self.bounds.height/2+12.5, width: self.bounds.width, height: 15))
        secTxt.textColor = UIColor.white
        secTxt.textAlignment = NSTextAlignment.center
        secTxt.font = UIFont.systemFont(ofSize: 12)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickUsualGame(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func clickUsualGame(_ recongnizer: UIPanGestureRecognizer) {
        //点击的雷达效果
        print("click usual game -------")
    }
    
    func setupView(img:UIImage,mtxt:String,msecTxt:String) -> Void {
//        image.image = img
        image.backgroundColor = UIColor.red
        let imageLayer:CALayer = image.layer
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = image.frame.size.height/2
        imageLayer.borderWidth = 4
        imageLayer.borderColor = UIColor.white.cgColor
        
        let shadowView = UIView.init(frame: self.image.frame)
        shadowView.layer.shadowColor = UIColor.orange.cgColor
        shadowView.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        shadowView.layer.shadowOpacity = 4
        shadowView.layer.shadowRadius = 6.0
        shadowView.layer.cornerRadius = shadowView.frame.size.height/2
        shadowView.clipsToBounds = false
        shadowView.addSubview(image)
        self.addSubview(shadowView)
        
        if !isEmptyString(str: mtxt){
            txt.text = mtxt
            self.addSubview(txt)
        }
        
        if !isEmptyString(str: msecTxt){
            secTxt.text = msecTxt
            self.addSubview(secTxt)
        }
        
    }

}
