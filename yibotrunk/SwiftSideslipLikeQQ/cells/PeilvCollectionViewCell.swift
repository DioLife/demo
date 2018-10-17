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
    
    var categoryUI:UIView!
    var categoryTextUI:UILabel!
    var numberUI:UIView!
    var numberTextUI:UIButton!
    var peilvUI:UIView!
    var peilvTextUI:UILabel!
    var moneyOrSelectUI:UIView!
    var moneyTextUI:CustomFeildText!
    var moneyTextHeadUI:UILabel!
    var checkboUI:UIImageView!
    var mycolor:UIColor!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        mycolor = UIColor.init(hexString: SystemConfig().touzhu_color)
    }

    
    func updateHeader(data:PeilvPlayData,playCode:String) -> Void {
        let itemCount = getItemCount(data: data,playCode: playCode)
        var showCount = 0
        if !isEmptyString(str: data.helpNumber) {
            let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
            categoryUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
            categoryUI.backgroundColor = UIColor.init(red: 252/255, green: 227/255, blue: 227/255, alpha: 1.0)
            categoryUI.layer.borderWidth = 0.5
            categoryUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
            categoryTextUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
            categoryTextUI.text = "类型"
            categoryTextUI.font = UIFont.systemFont(ofSize: 12)
            categoryTextUI.textAlignment = NSTextAlignment.center
            categoryUI.addSubview(categoryTextUI)
            self.addSubview(categoryUI)
            showCount = showCount + 1
        }
        
        if !isEmptyString(str: data.number){
            let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
            numberUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
            numberUI.backgroundColor = UIColor.init(red: 252/255, green: 227/255, blue: 227/255, alpha: 1.0)
            numberUI.layer.borderWidth = 0.5
            numberUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
            numberTextUI = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
//            numberTextUI.text = "号码"
            numberTextUI.setTitle("号码", for: .normal)
            numberTextUI.setImage(nil, for: .normal)
            numberTextUI.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            numberTextUI.setTitleColor(UIColor.black, for: .normal)
            if mycolor != nil{
                numberUI.backgroundColor = mycolor
            }
//            numberTextUI.textAlignment = NSTextAlignment.center
//            print("data.number:",data.number)
            numberUI.addSubview(numberTextUI)
            self.addSubview(numberUI)
            showCount = showCount + 1
        }

        if data.checkbox{
            //dont show peilv view when it has checkbox property
            //当这个赔率项是有checkbox属性时，不加一列,但如果helpnum 有值的话，需要显示赔率项
            print(data.checkbox)
            if !isEmptyString(str: data.helpNumber) {
                if !isEmptyString(str: data.peilv){
                    let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
                    peilvUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                    peilvUI.backgroundColor = UIColor.init(red: 252/255, green: 227/255, blue: 227/255, alpha: 1.0)
                    peilvUI.layer.borderWidth = 0.5
                    peilvUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
                    peilvTextUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                    peilvTextUI.text = itemCount == 2 ? "选择":"赔率"
                    peilvTextUI.font = UIFont.systemFont(ofSize: 12)
                    if mycolor != nil {
                        peilvUI.backgroundColor = mycolor
                    }
                    peilvTextUI.textAlignment = NSTextAlignment.center
                    peilvUI.addSubview(peilvTextUI)
                    self.addSubview(peilvUI)
                    showCount = showCount + 1
                }
            }
        }else{
            if !isEmptyString(str: data.peilv){
                let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
                peilvUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                peilvUI.backgroundColor = UIColor.init(red: 252/255, green: 227/255, blue: 227/255, alpha: 1.0)
                peilvUI.layer.borderWidth = 0.5
                peilvUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
                peilvTextUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                peilvTextUI.text = "赔率"
                peilvTextUI.font = UIFont.systemFont(ofSize: 12)
                if mycolor != nil {
                    peilvUI.backgroundColor = mycolor
                }
                peilvTextUI.textAlignment = NSTextAlignment.center
                peilvUI.addSubview(peilvTextUI)
                self.addSubview(peilvUI)
                showCount = showCount + 1
            }
        }
        let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
        moneyOrSelectUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
        moneyOrSelectUI.backgroundColor = UIColor.init(red: 252/255, green: 227/255, blue: 227/255, alpha: 1.0)
        moneyOrSelectUI.layer.borderWidth = 0.5
        moneyOrSelectUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
        
        moneyTextHeadUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
        moneyTextHeadUI.font = UIFont.systemFont(ofSize: 12)
        if data.checkbox{
            moneyTextHeadUI.text = "选择"
        }else{
            moneyTextHeadUI.text = "金额"
            if mycolor != nil {
                moneyOrSelectUI.backgroundColor = mycolor
            }
        }
        moneyTextHeadUI.textAlignment = NSTextAlignment.center
        moneyOrSelectUI.addSubview(moneyTextHeadUI)
        self.addSubview(moneyOrSelectUI)
    }
    
    func updateContent(data:PeilvPlayData,playCode:String,cpCode:String,cpVersion:String, isPlayBarHidden:Bool) -> Void {
        let itemCount = getItemCount(data: data,playCode: playCode)
        var showCount = 0
        if data.isSelected {
            self.backgroundColor = UIColor.init(hex: 0xABABAB)
        }else{
            self.backgroundColor = UIColor.white
        }
        
        //辅助号码项
        if !isEmptyString(str: data.helpNumber) {
            let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
            categoryUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
            categoryUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
            categoryUI.layer.borderWidth = 0.5
            categoryTextUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
            categoryTextUI.text = data.number
            categoryTextUI.font = UIFont.systemFont(ofSize: 12)
            categoryTextUI.textAlignment = NSTextAlignment.center
            categoryUI.addSubview(categoryTextUI)
            self.addSubview(categoryUI)
            showCount = showCount + 1
        }
        
        
        //号码项
        if !isEmptyString(str: data.number){
            var helpNumStr = ""
            if !isEmptyString(str: data.helpNumber){
                helpNumStr = data.helpNumber
            }
            let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
            numberUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
            numberUI.layer.borderWidth = 0.5
            numberUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
            
            let name = !isEmptyString(str: helpNumStr) ? helpNumStr : data.number
            //如果号码不是数字，或者辅助号码不为空，将显示区域占满cell
            if !isEmptyString(str: helpNumStr) || !isPurnInt(string: name){
                numberTextUI = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
            }else{
                let xx = self.bounds.width/CGFloat(itemCount)/2 - 12.5
                let yy = 12.5
                numberTextUI = UIButton.init(frame: CGRect.init(x: xx, y: CGFloat(yy), width: 25, height: 25))
            }
            numberTextUI.isUserInteractionEnabled = false
            let version = YiboPreference.getVersion()
            let (images,showTitles) = LotteryImageUtils.figureImgeByCpCode(cpCode: cpCode, cpVersion: version, num: data.number, index: 0)
            if showTitles{
                numberTextUI.setTitle(name, for: .normal)
            }
            if isPurnInt(string: name){
                numberTextUI.setBackgroundImage(UIImage.init(named: images), for: .normal)
            }else{
                numberTextUI.setBackgroundImage(nil, for: .normal)
            }
            numberTextUI.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            if !isPlayBarHidden {
                numberTextUI.titleLabel?.font = UIFont.systemFont(ofSize: 9)
            }
            numberTextUI.setTitleColor(UIColor.black, for: .normal)
            numberUI.addSubview(numberTextUI)
            print("helpNumber:",data.helpNumber)
            self.addSubview(numberUI)
            showCount = showCount + 1
        }
        
        
        //赔率项
        if data.checkbox{
            //dont show peilv view when it has checkbox property
            //当这个赔率项是有checkbox属性时，不加一列,但如果helpnum 有值的话，需要显示赔率项
            if !isEmptyString(str: data.helpNumber) {
                if !isEmptyString(str: data.peilv){
                    let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
                    peilvUI = UILabel.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                    peilvUI.layer.borderWidth = 0.5
                    peilvUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
                    peilvTextUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                    if let p = Float(data.peilv){
                        peilvTextUI.text = "\(p)"
                    }else{
                        peilvTextUI.text = "0"
                    }
//                    peilvTextUI.text = data.peilv
                    peilvTextUI.font = UIFont.systemFont(ofSize: 12)
                    peilvTextUI.textAlignment = NSTextAlignment.center
                    peilvUI.addSubview(peilvTextUI)
                    self.addSubview(peilvUI)
                    showCount = showCount + 1
                }
            }
        }else{
            if !isEmptyString(str: data.peilv){
                let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
                peilvUI = UILabel.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                peilvUI.layer.borderWidth = 0.5
                peilvUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
                peilvTextUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
                if let p = Float(data.peilv){
                    peilvTextUI.text = "\(p)"
                }else{
                    peilvTextUI.text = "0"
                }
                peilvTextUI.font = UIFont.systemFont(ofSize: 12)
                peilvTextUI.textAlignment = NSTextAlignment.center
                peilvUI.addSubview(peilvTextUI)
                self.addSubview(peilvUI)
                showCount = showCount + 1
            }
        }
        
        //金额或checkbox项
        let x = self.bounds.width/CGFloat(itemCount)*CGFloat(showCount)
        moneyOrSelectUI = UIView.init(frame: CGRect.init(x: x, y: 0, width: self.bounds.width/CGFloat(itemCount), height: 50))
        moneyOrSelectUI.layer.borderWidth = 0.5
        moneyOrSelectUI.layer.borderColor = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1.0).cgColor
        if data.checkbox{
            checkboUI = UIImageView.init(frame: CGRect.init(x: moneyOrSelectUI.bounds.width/2-4, y: moneyOrSelectUI.bounds.height/2-4, width: 8, height: 8))
            if data.isSelected{
                checkboUI.image = UIImage.init(named: "checkbox_press")
            }else{
                checkboUI.image = UIImage.init(named: "checkbox_normal")
            }
            moneyOrSelectUI.addSubview(checkboUI)
        }else{
            moneyTextUI = CustomFeildText.init(frame: CGRect.init(x: 2.5, y: 5, width: self.bounds.width/CGFloat(itemCount)-5, height: 40))
            moneyTextUI.delegate = self
            moneyTextUI.addTarget(self, action: #selector(onTextChange(ui:)), for: UIControlEvents.editingChanged)
            moneyTextUI.font = UIFont.systemFont(ofSize: 12)
            moneyTextUI.keyboardType = UIKeyboardType.numberPad
            moneyTextUI.borderStyle = UITextBorderStyle.roundedRect
            moneyTextUI.textAlignment = NSTextAlignment.center
            moneyTextUI.text = data.money > 0 ? String.init(describing: data.money) : ""
            moneyOrSelectUI.addSubview(moneyTextUI)
        }
        self.addSubview(moneyOrSelectUI)
    }
    
    //金额输入框内容变化回调
    func onTextChange(ui:UITextField) -> Void {
        let moneyValue = ui.text!
        if let delegate = self.moneyDelegate{
            delegate.onMoneyChange(money: moneyValue, gridPos: posInGridview, listViewPos: posInListView)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getItemCount(data:PeilvPlayData,playCode:String) -> Int {
        if isMulSelectMode(playCode: playCode){
            if isZuxuan(playCode: playCode) || playCode == lianma_peilv_klsf || playCode == lianma ||
                playCode == quanbuzhong || playCode == syx5_renxuan || playCode == syx5_zuxuan || playCode == syx5_zhixuan{
                return 2
            }else{
                return 4
            }
        }else if playCode == yixiao_weishu || playCode == txsm{
            if !isEmptyString(str: data.helpNumber){
                return 4
            }else{
                return 3
            }
        }else{
            return 3
        }
    }
    
}

protocol PeilvMoneyInputDelegate {
    func onMoneyChange(money:String,gridPos:Int,listViewPos:Int);
}
