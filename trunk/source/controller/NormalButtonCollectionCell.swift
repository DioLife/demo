//
//  NormalButtonCollectionCell.swift
//  gameplay
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit

class NormalButtonCollectionCell: UICollectionViewCell {
    @IBOutlet weak var normalButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: self)
        // Initialization code
    }

    
    
}
