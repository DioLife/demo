//
//  TitlePopCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class TitlePopCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTextView(title:String){
        let txt = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 35))
        txt.text = title
        txt.textAlignment = NSTextAlignment.center
        txt.textColor = UIColor.lightGray
        txt.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        self.addSubview(txt)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
    
    func updateBorder(selected:Bool) -> Void {
        if !selected{
            self.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            self.layer.borderColor = UIColor.red.cgColor
        }
    }
    
}
