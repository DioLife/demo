//
//  PeilvTableCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/15.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
/*
 赔率版每一行中的table cell
 */
class PeilvTableCell: UITableViewCell {
    
    @IBOutlet weak var numberTV:UILabel!
    @IBOutlet weak var peilvTV:UILabel!
    @IBOutlet weak var ballviews:BallsView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: self)
    }
    
    func setupData(data:PeilvWebResult?,cpCode:String,cpVersion:String,num:String){
        if data == nil{
            return
        }
        numberTV.text = data?.numName
        if (data?.currentOdds)! > Float(0){
            peilvTV.text = String.init(format: "%.3f", (data?.currentOdds)!)
        }else{
            peilvTV.text = String.init(format: "%.3f", (data?.maxOdds)!)
        }
        if (data?.isSelected)! {
            self.theme_backgroundColor = "TouzhOffical.betSelectedCellColor"
        }else{
            self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        }
        if !num.isEmpty{
            let array = num.components(separatedBy: ",")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.ballviews.setupBalls(nums: array, offset: 0, lotTypeCode: cpCode, cpVersion: cpVersion,small:false,gravity_bottom:false,ballsViewWidth: self.ballviews.width)
            }
            
        }
    }
}
