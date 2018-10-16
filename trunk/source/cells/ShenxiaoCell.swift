//
//  ShenxiaoCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/16.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class ShenxiaoCell: UITableViewCell {

    var shenxiaoTV:UILabel!
    var nums:BallsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(hex: 0x3B945C)
        shenxiaoTV = UILabel.init(frame: CGRect.init(x: 10, y: 7, width: 20, height: 30))
        shenxiaoTV.textColor = UIColor.white
        nums = BallsView.init(frame: CGRect.init(x: 20+10, y: 0, width: self.bounds.width - 80, height: self.bounds.height))
        self.addSubview(shenxiaoTV)
        self.addSubview(nums)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func convert_to_array(nums:String) -> [String]{
        if isEmptyString(str: nums){
            return []
        }
        return nums.components(separatedBy: ",")
    }
    
    func setupData(shenxiao:String,cpCode:String,cpVersion:String){
        if isEmptyString(str: shenxiao){
            return
        }
        let array = shenxiao.components(separatedBy: "|")
        shenxiaoTV.text = array[0]
        nums.setupBalls(nums: convert_to_array(nums: array[1]), offset: 0, lotTypeCode: cpCode, cpVersion: cpVersion,small:false,gravity_bottom:false,ballsViewWidth: nums.width)
    }

}
