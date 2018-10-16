//
//  BetHistoryCell.swift
//  gameplay
//
//  Created by admin on 2018/8/17.
//  Copyright © 2018 yibo. All rights reserved.
//

import UIKit

class BetHistoryCell: UITableViewCell {

    @IBOutlet weak var platformName: UILabel!
    @IBOutlet weak var gameType: UILabel!
    @IBOutlet weak var realBetMoney: UILabel!
    @IBOutlet weak var profitAndLoss: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCellWithModel(model: BetHistoryRowModel) {
        platformName.text = model.typeValueName
        gameType.text = model.gameName
        
        let realBetMoneyStr = String.init(format: "%.4f", model.realBettingMoney)
        if let realBetMoneyFloat = Float(realBetMoneyStr) {
            realBetMoney.text = "\(realBetMoneyFloat)元"
        }else {
            realBetMoney.text = "元"
        }
        
        let profitAndLossMoney = model.winMoney - model.realBettingMoney
        let profitAndLossStr = String.init(format: "%.4f", profitAndLossMoney)
        if let profitAndLossFloat = Float(profitAndLossStr) {
            profitAndLoss.text = "\(profitAndLossFloat)元"
        }else {
            profitAndLoss.text = "元"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
