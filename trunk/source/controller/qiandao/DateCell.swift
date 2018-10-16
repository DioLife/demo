//
//  DateCell.swift
//  gameplay
//
//  Created by William on 2018/8/14.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {

    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel.init(frame: self.bounds)
        label.textAlignment = .center;
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
