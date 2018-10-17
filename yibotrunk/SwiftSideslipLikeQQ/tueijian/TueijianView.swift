//
//  TueijianView.swift
//  gameplay
//
//  Created by William on 2018/8/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class TueijianView: UIView {

    @IBOutlet weak var mytext: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
