//
//  GroupTableCellItemView.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/26.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

protocol GroupTableCellItemViewDelegate {
    func onGroupTableItemViewClick(categoryNormalTableViewCell:GroupMainTableCell,viewIndex:NSInteger)
    func onGroupTableItemViewClick(categoryNormalTableViewTypeTwoCell:GroupMainTableStyleTwoCell,viewIndex:NSInteger)
    func onSubLotClick(lottery:LotteryData)
}

class GroupTableCellItemView: UIView {

    @IBOutlet weak var grouLotImage:UIImageView!
    @IBOutlet weak var labelTV:UILabel!
    @IBOutlet weak var indictor:UIImageView!
    @IBOutlet weak var icon_sjx:UIImageView!
    @IBOutlet weak var threeTagLeftImg:UIImageView!
    @IBOutlet weak var threeTagMiddleImg:UIImageView!
    @IBOutlet weak var threeTagRightImg:UIImageView!
    @IBOutlet weak var twoTagLeftImg:UIImageView!
    @IBOutlet weak var twoTagRightImg:UIImageView!
    
    var viewDelegate:GroupTableCellItemViewDelegate?
    var cell:GroupMainTableCell?
    var typeTwoCell:GroupMainTableStyleTwoCell?
    var viewIndexOfTableCell:Int = 0
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onHeaderClickEvent(_:)))
        self.addGestureRecognizer(tap)
        icon_sjx.theme_image = "HomePage.lotLevelIcon"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc func onHeaderClickEvent(_ recongnizer: UIPanGestureRecognizer) {
        if let delegate = self.viewDelegate{
            
            //type-type2
//            guard let cell = self.cell else {return}
//            delegate.onGroupTableItemViewClick(categoryNormalTableViewCell: cell, viewIndex: viewIndexOfTableCell)
            
            guard let cell = self.typeTwoCell else {return}
            delegate.onGroupTableItemViewClick(categoryNormalTableViewTypeTwoCell: cell, viewIndex: viewIndexOfTableCell)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
