//
//  PeilvCollectionViewCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/13.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//赔率版投注界面列表项我中collectionview cell
class PeilvCollectionViewCell: UICollectionViewCell,UITextFieldDelegate {
    
    var posInListView = 0
    var posInGridview = 0
    var moneyDelegate:PeilvMoneyInputDelegate?
    
    @IBOutlet weak var numberTV:UIButton!
    @IBOutlet weak var numberLabelTV:UILabel!
    @IBOutlet weak var peilvTV:UILabel!
    @IBOutlet weak var secondPeilvTV:UILabel!
    @IBOutlet weak var moneyInputTV:CustomFeildText!
    @IBOutlet weak var money_input_height_constraint:NSLayoutConstraint!
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var rightLine: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        moneyInputTV.delegate = self
        moneyInputTV.addTarget(self, action: #selector(onTextChange(ui:)), for: .editingChanged)
        moneyInputTV.background = nil
        moneyInputTV.backgroundColor = UIColor.clear
        moneyInputTV.layer.cornerRadius = 5
        moneyInputTV.layer.theme_borderColor = "FrostedGlass.Touzhu.separateLineColor"
        moneyInputTV.layer.borderWidth = 1
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        topLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        leftLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        bottomLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        rightLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
    }
    
    func setupData(data:PeilvWebResult?,mode:Bool,lotCode:String,lotType:String){
        if data == nil{
            return
        }
        
        if !isPurnInt(string: (data?.numName)!){
            numberLabelTV.isHidden = false
            numberTV.isHidden = true
            numberLabelTV.text = data?.numName
        }else{
            numberLabelTV.isHidden = true
            numberTV.isHidden = false
            numberTV.whc_Width(32).whc_Height(32)
//            numberTV.setBackgroundImage(UIImage.init(named: "bet_grey_ball"), for: .normal)
            //Shaw-NOTYET 红蓝绿波
            
            if isKuaiLeShiFeng(lotType: lotType) {
                    numberTV.setTitleColor(UIColor.red, for: .normal)
                    let imgName = figureXYNCImage(num: (data?.numName)!)
                    if !isEmptyString(str: imgName){
                        numberLabelTV.isHidden = true
                        numberTV.isHidden = false
                        numberTV.isUserInteractionEnabled = false
                        numberTV.setBackgroundImage(UIImage.init(named: imgName), for: .normal)
                        numberTV.setTitle("", for: .normal)
                    }else{
                        numberLabelTV.isHidden = false
                        numberTV.isHidden = true
                        numberLabelTV.text = data?.numName
                    }

            } else if isSaiche(lotType: lotType) {
            
                print("playCode = \(String(describing: data?.playCode))")
                
                let codeName = data?.playCode
            if codeName == "dgj" || codeName == "ddshm" || codeName == "ddsm"  || codeName == "ddsim" || codeName == "ddwm" || codeName == "ddlm" || codeName == "ddqm" || codeName == "ddbm" || codeName == "ddjm" || codeName == "dyj" {
            
                numberTV.setTitleColor(UIColor.red, for: .normal)
                let imgName = figureSaiCheImage(num: (data?.numName)!)
                if !isEmptyString(str: imgName){
                    numberLabelTV.isHidden = true
                    numberTV.isHidden = false
                    numberTV.isUserInteractionEnabled = false
                    numberTV.setBackgroundImage(UIImage.init(named: imgName), for: .normal)
                    numberTV.whc_Width(26).whc_Height(26)
                    numberTV.setTitle("", for: .normal)
                }else{
                    numberLabelTV.isHidden = false
                    numberTV.isHidden = true
                    numberLabelTV.text = data?.numName
                }
                }else {
                    numberLabelTV.isHidden = false
                    numberTV.isHidden = true
                    numberLabelTV.text = data?.numName
                }
            
           } else if isSixMark(lotCode: lotCode){
                let imgName = figureLhcImages(num: (data?.numName)!)
                numberTV.setTitleColor(UIColor.black, for: .normal)
                numberTV.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                numberTV.setBackgroundImage(UIImage.init(named: imgName), for: .normal)
                numberTV.setTitle(data?.numName, for: .normal)
            }else if isKuai3(lotType: lotType){
                let imgName = figureKuai3Images(num: (data?.numName)!)
                if !isEmptyString(str: imgName){
                    numberLabelTV.isHidden = true
                    numberTV.isHidden = false
                    numberTV.isUserInteractionEnabled = false
                    numberTV.whc_Width(26).whc_Height(26)
                    numberTV.setBackgroundImage(UIImage.init(named: imgName), for: .normal)
                    numberTV.setTitle("", for: .normal)
                }else{
                    numberLabelTV.isHidden = false
                    numberTV.isHidden = true
                    numberLabelTV.text = data?.numName
                }
            }else{
                numberTV.setTitle(data?.numName, for: .normal)
                numberTV.setTitleColor(UIColor.white, for: .normal)
                numberTV.theme_setBackgroundImage("TouzhOffical.ballDark", forState: .normal)
            }
        }
        
        if (data?.secondMaxOdds)! > Float(0){
            secondPeilvTV.isHidden = false
        }else{
            secondPeilvTV.isHidden = true
        }
        
        if (data?.currentSecondOdds)! > Float(0){
            let string = String.init(format: "%.3f", (data?.currentSecondOdds)!)
            if let floatValue = Float(string) {
                secondPeilvTV.text = "\(floatValue)"
            }else {
                secondPeilvTV.text = ""
            }
        }else{
            let string = String.init(format: "%.3f", (data?.secondMaxOdds)!)
            if let floatValue = Float(string) {
                secondPeilvTV.text = "\(floatValue)"
            }else {
                secondPeilvTV.text = ""
            }
        }

        if (data?.currentOdds)! > Float(0){
            let string = String.init(format: "%.3f", (data?.currentOdds)!)
            if let floatValue = Float(string) {
                peilvTV.text = "\(floatValue)"
            }else {
                peilvTV.text = ""
            }
        }else{
            let string = String.init(format: "%.3f", (data?.maxOdds)!)
            if let floatValue = Float(string) {
                peilvTV.text = "\(floatValue)"
            }else {
                peilvTV.text = ""
            }
        }
        if (data?.inputMoney)! > Float(0){
            moneyInputTV.text = String.init(format: "%.3f", (data?.inputMoney)!)
        }else{
            moneyInputTV.text = ""
        }
        if mode{
            moneyInputTV.isHidden = true
        }else{
            moneyInputTV.isHidden = false
        }
    }
    
    //金额输入框内容变化回调
    @objc func onTextChange(ui:UITextField) -> Void {
        var moneyValue = ui.text!
        
        if !isEmptyString(str: moneyValue) {
            let max = Int.max
            if let doubleSvalue:Double = Double(moneyValue) {
                if doubleSvalue > Double(max) {
                    
                    showToast(view: self, txt: "输入数值过大")
                    moneyValue = moneyValue.subString(start: 0, length: moneyValue.length - 1)
                    ui.text = moneyValue
                }
            }
        }
        
        if let delegate = self.moneyDelegate{
            delegate.onMoneyChange(money: moneyValue, gridPos: posInGridview, listViewPos: posInListView)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func figureLhcImages(num:String) -> String {
        let redBO = ["01","02","07","08","12","13","18","19","23","24","29","30","34","35","40","45","46"]
        let blueBO = ["03","04","09","10","14","15","20","25","26","31","36","37","41","42","47","48"]
        let greenBO = ["05","06","11","16","17","21","22","27","28","32","33","38","39","43","44","49"]
        if redBO.contains(num){
            return "lhc_red_bg"
        }else if blueBO.contains(num){
            return "lhc_blue_bg"
        }else if greenBO.contains(num){
            return "lhc_green_bg"
        }
        return "lhc_red_bg"
    }
    
    func figureKuai3Images(num:String) -> String {
        switch num {
        case "1":
            return "kuai3_bg_one"
        case "2":
            return "kuai3_bg_two"
        case "3":
            return "kuai3_bg_three"
        case "4":
            return "kuai3_bg_four"
        case "5":
            return "kuai3_bg_five"
        case "6":
            return "kuai3_bg_six"
        default:
            break
        }
        return ""
    }
    
}

func figureXYNCImage
    (num:String) -> String {
    if num == "?"{
        return ("open_result_ball")
    }
    
    var numStr = num
    if num.length == 1 {
        numStr = String.init(format: "0%@", num)
    }
    return String.init(format: "xync_%@",numStr )
}

func figureSaiCheImage(num:String) -> String {
    if num == "?"{
        return ("open_result_ball")
    }
    
    var numStr = num
    if num.length == 1 {
        numStr = String.init(format: "0%@", num)
    }
    
    return String.init(format: "sc_%@_title",numStr)
}

protocol PeilvMoneyInputDelegate {
    func onMoneyChange(money:String,gridPos:Int,listViewPos:Int);
}
