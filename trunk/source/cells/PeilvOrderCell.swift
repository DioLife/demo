//
//  PeilvOrderCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/16.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

protocol PeilvOrderDelegate {
    func onMoneyChange(money:Float,row:Int)
    func updateTableAction()
}

class PeilvOrderCell: UITableViewCell ,UITextFieldDelegate{

    @IBOutlet weak var playUI:UILabel!
    @IBOutlet weak var numUI:UILabel!
    @IBOutlet weak var input:CustomFeildText!
    @IBOutlet weak var deleteUI:UIButton!
    var delegate:PeilvOrderDelegate?
    var row = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: self)
        input.delegate = self
        input.addTarget(self, action: #selector(onMoneyChange(ui:)), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let delegate = self.delegate{
            delegate.updateTableAction()
        }
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data:OrderDataInfo,row:Int) -> Void {
        self.row = row
        playUI.text = String.init(format: "%@-%@", data.subPlayName,data.oddsName)
        numUI.text = !isEmptyString(str: data.numbers) ? data.numbers : "暂无号码"
        if data.money > 0{
            let m = Int(data.money)
            input.text = String.init(format: "%d", m)
        }else{
            input.text = ""
        }
    }
    
    @objc func onMoneyChange(ui:UITextField){
        let moneyValue = ui.text!
        if isEmptyString(str: moneyValue){
            return
        }
        
//        if isPurnInt(string: <#T##String#>)
        
        if moneyValue.starts(with: "0") && moneyValue.count > 0{
            input.text = (moneyValue as NSString).substring(from: 1)
            return
        }
        if let delegate = self.delegate{
            delegate.onMoneyChange(money: Float(moneyValue)!, row: self.row)
        }
    }

}
