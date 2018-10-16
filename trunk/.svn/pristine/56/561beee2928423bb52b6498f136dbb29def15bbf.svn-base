//
//  CalenderCell.swift
//  gameplay
//
//  Created by William on 2018/8/14.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class CalenderCell: UICollectionViewCell {

    var label:UILabel!
    var myDot:UIView!//小红点
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp() {
        label = UILabel()
        self.addSubview(label)
        
        myDot = UIView()
        self.addSubview(myDot)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
        label.textAlignment = .center;
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = true;
        
        myDot.snp.makeConstraints { (make) in
            make.width.equalTo(4)
            make.height.equalTo(4)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-5)
        }
        myDot.backgroundColor = UIColor.red
        myDot.layer.cornerRadius = 2
        myDot.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
