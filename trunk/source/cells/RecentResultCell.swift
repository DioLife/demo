//
//  ShenxiaoCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/16.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class RecentResultCell: UITableViewCell {
    
    @IBOutlet weak var qihaoTV:UILabel!
    @IBOutlet weak var numsTV:BallsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func setupData(qihao:String,nums:String,cpCode:String,cpVersion:String){
        
        let ballWidth:CGFloat = 20
        let small = true
//        if isSaiche(lotType: cpCode){
//            ballWidth = 20
//        }else if isFFSSCai(lotType:cpCode){
//            ballWidth = 30
//            small = false
//        }
        
        var shownums = convert_to_array(nums: nums)
        if !shownums.isEmpty && !shownums.contains("?"){
            //时时彩，快三，低频彩，PC蛋蛋
            if isFFSSCai(lotType: cpCode) || isKuai3(lotType: cpCode) ||
                isDPC(lotType: cpCode) || isPCEgg(lotType: cpCode){
                
                var total = 0//总和
                var bigSmall = ""//大小
                var singleDouble = ""//单双
                for value in shownums {
                    if let v = Int(value){
                        total += v
                    }
                }
                
                let maxTotal = 9*shownums.count//时时彩，快三，低频彩，PC蛋蛋最大号码为9
                if isKuai3(lotType: cpCode) {
                    bigSmall = total <= 10 ? "小" : "大"
                }else if isPCEgg(lotType: cpCode) {
                    bigSmall = total >= 14 ? "大" : "小"
                }else {
                    bigSmall = total > maxTotal/2 ? "大" : "小"
                }
                singleDouble =  total % 2 == 0 ? "双" : "单"
                
                shownums.append("=")
                shownums.append(String(total))
                shownums.append(bigSmall)
                shownums.append(singleDouble)
            }
        }
        qihaoTV.text = String.init(format: "第%@期:", trimQihao(currentQihao: qihao))
        numsTV.setupBalls(nums: shownums, offset: 0, lotTypeCode: cpCode, cpVersion: cpVersion,ballWidth: ballWidth, small:small,gravity_bottom:false,ballsViewWidth: kScreenWidth - 100 - 5 - 5,forBetPageBelow: true)
        
    }
    
}
