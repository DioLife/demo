//
//  TouzhuBottomView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/4/4.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol TouzhuBottomDelegate {
    func onClearOrRandomClick(zhushu:Int)
    func onConfirm()
    func onHistory()
    func onViewOrder()
}

class TouzhuBottomView: UIView ,UITextFieldDelegate{

    var isPeilv:Bool = false
    let BASIC_MONEY:Double = 2.0
    var modeBtn:UIButton!
    var clearBtn:UIButton!
    var beishuInput:CustomFeildText!
    var zhushuLable:UILabel!
    var moneyLabel:UILabel!
    
    var zhushuBtn:UIButton!
    var viewBtn:UIButton!
    var moneyBtn:UIButton!
    
    var delegate:TouzhuBottomDelegate?
    var controller:UIViewController!
    
    var zhushu:Int = 0
    var money:Float = 0.0
    var rate:Float = 0.0
    var beishu = 1
    var selectModeIndex = 0
    var randomZhushu = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createView(controller:UIViewController,isPeilv:Bool) {
        self.isPeilv = isPeilv
        self.controller = controller
        if !self.subviews.isEmpty{
            for view in self.subviews{
                view.removeFromSuperview()
            }
        }
        if self.isPeilv{
            let detailView = UIView.init(frame: CGRect.init(x: 0, y: 0,
                                                            width: kScreenWidth, height: 60))
            self.addSubview(detailView)
            detailView.backgroundColor = UIColor.init(hexString: "0XF6F6F6")
            let clearBtn = UIButton.init(frame: CGRect.init(x: 10, y: 15, width: 60, height: 30))
            clearBtn.setTitle("清除", for: .normal)
            clearBtn.addTarget(self, action: #selector(onClearClick), for: .touchUpInside)
            clearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            clearBtn.setTitleColor(UIColor.lightGray, for: .normal)
            clearBtn.backgroundColor = UIColor.clear
            clearBtn.layer.cornerRadius = 5
            clearBtn.layer.borderWidth = 1
            clearBtn.layer.borderColor = UIColor.lightGray.cgColor
            detailView.addSubview(clearBtn)
            
            let confirmBtn = UIButton.init(frame: CGRect.init(x: kScreenWidth - 70, y: 15, width: 60, height: 30))
            confirmBtn.setTitle("投注", for: .normal)
            confirmBtn.addTarget(self, action: #selector(onConfirmClick), for: .touchUpInside)
            confirmBtn.backgroundColor = UIColor.init(hex: 0xEC2829)
            confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            confirmBtn.layer.cornerRadius = 5
            detailView.addSubview(confirmBtn)
            
            //zhushu button
            zhushuBtn = UIButton.init(frame: CGRect.init(x: kScreenWidth/2-90-1, y: 15, width: 60, height: 30))
            zhushuBtn.setTitle("0注", for: .normal)
            zhushuBtn.addTarget(self, action: #selector(onViewDetail), for: .touchUpInside)
//            zhushuBtn.backgroundColor = UIColor.init(hex: 0xFFE2DA)
            if let json = getSystemConfigFromJson(){
                if json.content != nil{
                    let colorHex = json.content.touzhu_color
                    zhushuBtn.backgroundColor = UIColor.init(hexString: colorHex)
                }
            }
            zhushuBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            zhushuBtn.setTitleColor(UIColor.init(hex: 0xEC2829), for: .normal)
            let maskPath = UIBezierPath(roundedRect: zhushuBtn.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 5, height: 5))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = zhushuBtn.bounds
            maskLayer.path = maskPath.cgPath
            zhushuBtn.layer.mask = maskLayer
            detailView.addSubview(zhushuBtn)
            
            //money button
            moneyBtn = UIButton.init(frame: CGRect.init(x: kScreenWidth/2-30, y: 15, width: 60, height: 30))
            moneyBtn.setTitle("0元", for: .normal)
            moneyBtn.setTitleColor(UIColor.init(hex: 0xEC2829), for: .normal)
            moneyBtn.addTarget(self, action: #selector(onViewDetail), for: .touchUpInside)
//            moneyBtn.backgroundColor = UIColor.init(hex: 0xFFE2DA)
            if let json = getSystemConfigFromJson(){
                if json.content != nil{
                    let colorHex = json.content.touzhu_color
                    moneyBtn.backgroundColor = UIColor.init(hexString: colorHex)
                }
            }
            moneyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            detailView.addSubview(moneyBtn)
            
            //view button
            viewBtn = UIButton.init(frame: CGRect.init(x: kScreenWidth/2+30 + 1, y: 15, width: 60, height: 30))
            viewBtn.setTitle("查看", for: .normal)
            viewBtn.setTitleColor(UIColor.init(hex: 0xEC2829), for: .normal)
            viewBtn.addTarget(self, action: #selector(onViewDetail), for: .touchUpInside)
//            viewBtn.backgroundColor = UIColor.init(hex: 0xFFE2DA)
            if let json = getSystemConfigFromJson(){
                if json.content != nil{
                    let colorHex = json.content.touzhu_color
                    viewBtn.backgroundColor = UIColor.init(hexString: colorHex)
                }
            }
            viewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            let viewPath = UIBezierPath(roundedRect: viewBtn.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 5, height: 5))
            let viewLayer = CAShapeLayer()
            viewLayer.frame = viewBtn.bounds
            viewLayer.path = viewPath.cgPath
            viewBtn.layer.mask = viewLayer
            detailView.addSubview(viewBtn)
            
        }else{
            let adjustView = UIView.init(frame: CGRect.init(x: 0, y: 0,
                                                       width: kScreenWidth, height: 40))
            self.addSubview(adjustView)
            adjustView.backgroundColor = UIColor.init(hexString: "0XF6F6F6")
            modeBtn = UIButton.init(frame: CGRect.init(x: 10, y: 5, width: 50, height: 30))
            modeBtn.setTitle("元", for: .normal)
            modeBtn.addTarget(self, action: #selector(onModeClick), for: .touchUpInside)
            modeBtn.backgroundColor = UIColor.white
            modeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            modeBtn.setTitleColor(UIColor.lightGray, for: .normal)
            modeBtn.layer.cornerRadius = 5
            modeBtn.layer.borderWidth = 1
            modeBtn.layer.borderColor = UIColor.lightGray.cgColor
            adjustView.addSubview(modeBtn)
            
            let modeText = UILabel.init(frame: CGRect.init(x: 65, y: 5, width: 30, height: 30))
            modeText.text = "模式"
            modeText.font = UIFont.systemFont(ofSize: 14)
            modeText.textAlignment = NSTextAlignment.center
            adjustView.addSubview(modeText)
            
            beishuInput = CustomFeildText.init(frame: CGRect.init(x: 100, y: 5, width: 50, height: 30))
            beishuInput.delegate = self
            beishuInput.placeholder = "1"
            beishuInput.backgroundColor = UIColor.white
            beishuInput.layer.cornerRadius = 5
            beishuInput.layer.borderWidth = 1
            beishuInput.textAlignment = NSTextAlignment.center
            beishuInput.keyboardType = UIKeyboardType.numberPad
            beishuInput.layer.borderColor = UIColor.lightGray.cgColor
            beishuInput.addTarget(self, action: #selector(beishuTextChange), for: UIControlEvents.editingChanged)
            adjustView.addSubview(beishuInput)
            
            let beishuText = UILabel.init(frame: CGRect.init(x: 150, y: 5, width: 30, height: 30))
            beishuText.text = "倍"
            beishuText.font = UIFont.systemFont(ofSize: 14)
            beishuText.textAlignment = NSTextAlignment.center
            adjustView.addSubview(beishuText)
            
            //赔率调整滚动条,暂不支持
            //历史投注
            let historyText = UIButton.init(frame: CGRect.init(x: kScreenWidth - 100, y: 5, width: 80, height: 30))
            historyText.setTitle("历史投注", for: .normal)
            historyText.addTarget(self, action: #selector(showHistoryTouzhu), for: .touchUpInside)
            historyText.setTitleColor(UIColor.black, for: .normal)
            historyText.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            historyText.titleLabel?.textAlignment = NSTextAlignment.right
            adjustView.addSubview(historyText)
            
            let historyIcon = UIImageView.init(frame: CGRect.init(x: kScreenWidth - 26, y: 12.5, width: 15, height: 15))
            historyIcon.image = UIImage.init(named: "account_detail_record_icon")
            adjustView.addSubview(historyIcon)
            
            
            let detailView = UIView.init(frame: CGRect.init(x: 0, y: 40,
                                                            width: kScreenWidth, height: 60))
            self.addSubview(detailView)
            detailView.backgroundColor = UIColor.black
            clearBtn = UIButton.init(frame: CGRect.init(x: 10, y: 15, width: 60, height: 30))
            clearBtn.setTitle("机选", for: .normal)
            clearBtn.addTarget(self, action: #selector(onClearClick), for: .touchUpInside)
            clearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            clearBtn.backgroundColor = UIColor.clear
            clearBtn.layer.cornerRadius = 5
            clearBtn.layer.borderWidth = 1
            clearBtn.layer.borderColor = UIColor.white.cgColor
            detailView.addSubview(clearBtn)
            
            let confirmBtn = UIButton.init(frame: CGRect.init(x: kScreenWidth - 70, y: 15, width: 60, height: 30))
            confirmBtn.setTitle("确定", for: .normal)
            confirmBtn.addTarget(self, action: #selector(onConfirmClick), for: .touchUpInside)
            confirmBtn.backgroundColor = UIColor.red
            confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            confirmBtn.layer.cornerRadius = 5
            detailView.addSubview(confirmBtn)
            
            //共选几注
            zhushuLable = UILabel.init(frame: CGRect.init(x: 80, y: 10, width: kScreenWidth - 160, height: 20))
            zhushuLable.text = String.init(format: "共选%d注", 0)
            zhushuLable.textColor = UIColor.white
            zhushuLable.font = UIFont.systemFont(ofSize: 14)
            zhushuLable.textAlignment = NSTextAlignment.center
            detailView.addSubview(zhushuLable)
            
            //共0元,盈利0元
            moneyLabel = UILabel.init(frame: CGRect.init(x: 80, y: 30, width: kScreenWidth - 160, height: 20))
            moneyLabel.text = String.init(format: "共%d元，盈利%d元", 0,0)
            moneyLabel.textColor = UIColor.white
            moneyLabel.font = UIFont.systemFont(ofSize: 14)
            moneyLabel.textAlignment = NSTextAlignment.center
            detailView.addSubview(moneyLabel)
            
        }
        
    }
    
    func updateLeftBtn(random:Bool) -> Void {
        self.clearBtn.setTitle(random ? "机选" : "清除", for: .normal)
    }
    
    func beishuTextChange(textField:UITextField)->Void{
        guard let s = textField.text else {return}
        if isEmptyString(str: s){
            self.beishu = 1
        }else{
            self.beishu = Int(s)!
        }
        self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: (self.modeBtn.titleLabel?.text!)!)
    }
    
    func showHistoryTouzhu() -> Void {
        if let delegate = self.delegate{
            delegate.onHistory()
        }
    }
    
    func adjustMoney(beishu:Int,zhushu:Int,selectMode:String) -> Void {
        var money:Double = BASIC_MONEY
        var rate:Float = self.rate
        money = money*Double(beishu*zhushu)
        if selectMode == "元"{
            
        }else if selectMode == "角"{
            money = money/10
            rate = self.rate/10
        }else if selectMode == "分"{
            money = money/100
            rate = self.rate/100
        }
        self.money = Float(money)
        if self.zhushu == 0{
            rate = 0
        }
        updateBottomMoney(money: Float(self.money), rate: rate)
    }
    
    func onModeClick() -> Void {
        
        if self.controller == nil{
            return
        }
        
        let yjfMode = YiboPreference.getYJFMode()
        print("yjfmode ==== ",yjfMode)
        let alert = UIAlertController.init(title: "请选择模式", message: nil, preferredStyle: .actionSheet)
        if yjfMode == YUAN_MODE{
            let yuanAction = UIAlertAction.init(title: "元", style: .default, handler: {(action:UIAlertAction) in
                self.modeBtn.setTitle("元", for: .normal)
                self.selectModeIndex = 0
                self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: "元")
            })
            alert.addAction(yuanAction)
        }else if yjfMode == JIAO_MODE{
            let yuanAction = UIAlertAction.init(title: "元", style: .default, handler: {(action:UIAlertAction) in
                self.modeBtn.setTitle("元", for: .normal)
                self.selectModeIndex = 0
                self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: "元")
            })
            let jiaoAction = UIAlertAction.init(title: "角", style: .default, handler: {(action:UIAlertAction) in
                self.modeBtn.setTitle("角", for: .normal)
                self.selectModeIndex = 1
                self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: "角")
            })
            alert.addAction(yuanAction)
            alert.addAction(jiaoAction)
        }else if yjfMode == FEN_MODE{
            let yuanAction = UIAlertAction.init(title: "元", style: .default, handler: {(action:UIAlertAction) in
                self.modeBtn.setTitle("元", for: .normal)
                self.selectModeIndex = 0
                self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: "元")
            })
            let jiaoAction = UIAlertAction.init(title: "角", style: .default, handler: {(action:UIAlertAction) in
                self.modeBtn.setTitle("角", for: .normal)
                self.selectModeIndex = 1
                self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: "角")
            })
            let fenAction = UIAlertAction.init(title: "分", style: .default, handler: {(action:UIAlertAction) in
                self.modeBtn.setTitle("分", for: .normal)
                self.selectModeIndex = 2
                self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: "分")
            })
            alert.addAction(yuanAction)
            alert.addAction(jiaoAction)
            alert.addAction(fenAction)
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        controller.present(alert,animated: true,completion: nil)
    }
    
    func onViewDetail() -> Void {
        if let delegate = self.delegate{
            delegate.onViewOrder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showRandomSheetDialog() -> Void {
        if self.controller == nil{
            return
        }
        let alert = UIAlertController.init(title: "请选择注数", message: nil, preferredStyle: .actionSheet)
        let yuanAction = UIAlertAction.init(title: "1注", style: .default, handler: {(action:UIAlertAction) in
            self.randomZhushu = 1
            if let delegate = self.delegate{
                delegate.onClearOrRandomClick(zhushu: self.randomZhushu)
            }
        })
        let jiaoAction = UIAlertAction.init(title: "5注", style: .default, handler: {(action:UIAlertAction) in
            self.randomZhushu = 5
            if let delegate = self.delegate{
                delegate.onClearOrRandomClick(zhushu: self.randomZhushu)
            }
        })
        let fenAction = UIAlertAction.init(title: "10注", style: .default, handler: {(action:UIAlertAction) in
            self.randomZhushu = 10
            if let delegate = self.delegate{
                delegate.onClearOrRandomClick(zhushu: self.randomZhushu)
            }
        })
        alert.addAction(yuanAction)
        alert.addAction(jiaoAction)
        alert.addAction(fenAction)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        controller.present(alert,animated: true,completion: nil)
    }
    
    
    
    func onClearClick() -> Void {
        //若注数为0，则做机选几注弹窗操作
//        if self.zhushu == 0{
//            showRandomSheetDialog()
//        }else{
            if let delegate = self.delegate{
                delegate.onClearOrRandomClick(zhushu: 0)
            }
//        }
    }
    
    func onConfirmClick() -> Void {
        if let delegate = self.delegate{
            delegate.onConfirm()
        }
    }
    
    func updateBottomDetail(zhushu:Int,money:Float,rate:Float) -> Void {
        self.zhushu = zhushu
        self.money = money
        self.rate = rate
        if !self.isPeilv{
            updateLeftBtn(random: self.zhushu > 0 ? false : true)
            self.adjustMoney(beishu: self.beishu, zhushu: self.zhushu, selectMode: (self.modeBtn.titleLabel?.text!)!)
            zhushuLable.text = String.init(format: "共选%d注", zhushu)
        }else{
            zhushuBtn.setTitle(String.init(format: "%d注", zhushu), for: .normal)
            moneyBtn.setTitle(String.init(format: "%.1f元", money), for: .normal)
            if rate > 0{
                viewBtn.setTitle(String.init(format: "赔率:%.1f", rate), for: .normal)
            }
        }
    }
    
    func updateBottomMoney(money:Float,rate:Float) -> Void {
        if !self.isPeilv{
            var rateAgain = rate
            if zhushu == 0{
                rateAgain = 0
            }
            moneyLabel.text = String.init(format: "共%.1f元，奖金%.2f元", money,rateAgain)
        }else{
            moneyBtn.setTitle(String.init(format: "%.1f元", money), for: .normal)
            if rate > 0{
                viewBtn.setTitle(String.init(format: "赔率:%.2f", rate), for: .normal)
            }
        }
    }
    
    func updateBottomPeilv(peilv:String) -> Void {
        if self.isPeilv{
            if !isEmptyString(str: peilv){
                viewBtn.setTitle(peilv, for: .normal)
            }else{
                viewBtn.setTitle("查看", for: .normal)
            }
        }
    }
    
    
    

}
