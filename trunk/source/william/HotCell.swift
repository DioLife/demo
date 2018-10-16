//
//  HotCell.swift
//  CollectionView
//
//  Created by William on 2018/7/19.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class HotCell: UICollectionViewCell {
    
    var label:UILabel!
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp() {
        imageView = UIImageView.init(frame: CGRect(x: 15, y: 0, width: 60, height: 60))
        self.addSubview(imageView)
        
        label = UILabel.init(frame: CGRect(x: 0, y: 60, width: 90, height: 20))
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = NSTextAlignment.center
    }
    
}
