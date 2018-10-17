//
//  TouzhuWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol TouzhuWindowDelegate {
    func onCancelClick(notPop:Bool)
    func onAdustResult(data:AdjustData,notPop:Bool)
}

class TouzhuWindow: UIView {

    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    var _delegate            :TouzhuWindowDelegate!
    var _adjustData          :AdjustData?
    
    @IBOutlet weak var jianBtn:UIButton!
    @IBOutlet weak var addBtn:UIButton!
    @IBOutlet weak var beishuInput:CustomFeildText!
    @IBOutlet weak var yuanModeBtn:UIButton!
    @IBOutlet weak var jiaoModeBtn:UIButton!
    @IBOutlet weak var fenModeBtn:UIButton!
    @IBOutlet weak var autoPopBtn:UISwitch!
    @IBOutlet weak var singleMoney:UILabel!
    @IBOutlet weak var totalZhushu:UILabel!
    @IBOutlet weak var totalMoney:UILabel!
    @IBOutlet weak var laterBtn:UIButton!
    @IBOutlet weak var touzhuBtn:UIButton!
    
    var selectModeIndex = 0;//选择的金额模式-索引，0-元，1-角 2-分
    var selectZhushu = 0;
    var selectBeishu = 0;
    var selectMoney = 0.0;//金额，单位为元
    
    var notPopLater = false
    var keyBoardNeedLayout: Bool = true
    
    func setData(data:AdjustData,notTipLater:Bool) -> Void {
        self._adjustData = data
        self.notPopLater = notTipLater
        autoPopBtn.isOn = self.notPopLater
        if let data = self._adjustData{
            
            self.selectModeIndex = data.modeIndex
            self.selectBeishu = data.beishu
            self.selectMoney = data.money
            self.selectZhushu = data.zhushu
            
            self.beishuInput.text = String.init(describing: data.beishu)
            self.totalZhushu.text = String.init(format: "下注注数:%d注", data.zhushu)
            self.singleMoney.text = String.init(format: "单注奖金: %.2f元", data.jianjian)
            self.totalMoney.text = String.init(format: "下注金额: %.2f元", data.money)
            self.switchMode(selectedMode: data.modeIndex)
            
        }
    }
    
    override func awakeFromNib() {
        self.beishuInput.addTarget(self, action: #selector(textFieldTextChange(textField:)), for: UIControlEvents.editingChanged)
        self.autoPopBtn.addTarget(self, action: #selector(switchAction(sender:)), for: UIControlEvents.valueChanged)
        
        //当键盘弹起的时候会向系统发出一个通知，
        //这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let maskPath = UIBezierPath(roundedRect: jianBtn.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 15, height: 15))
        let jianMaskLayer = CAShapeLayer()
        jianMaskLayer.frame = jianBtn.bounds
        jianMaskLayer.path = maskPath.cgPath
        jianBtn.layer.mask = jianMaskLayer
        
        let addMaskPath = UIBezierPath(roundedRect: addBtn.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        let addMaskLayer = CAShapeLayer()
        addMaskLayer.frame = addBtn.bounds
        addMaskLayer.path = addMaskPath.cgPath
        addBtn.layer.mask = addMaskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func switchMode(selectedMode:Int) -> Void {
        let yjfMode = YiboPreference.getYJFMode()
        let defaultColor = UIColor.init(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        switch yjfMode {
        case YUAN_MODE:
            yuanModeBtn.isHidden = false
            jiaoModeBtn.isHidden = true
            fenModeBtn.isHidden = true
            yuanModeBtn.backgroundColor = UIColor.red
            jiaoModeBtn.backgroundColor = defaultColor
            fenModeBtn.backgroundColor = defaultColor
            yuanModeBtn.setTitleColor(UIColor.white, for: .normal)
        case JIAO_MODE:
            yuanModeBtn.isHidden = false
            jiaoModeBtn.isHidden = false
            fenModeBtn.isHidden = true
            if selectedMode == 0{
                yuanModeBtn.backgroundColor = UIColor.red
                jiaoModeBtn.backgroundColor = defaultColor
                fenModeBtn.backgroundColor = defaultColor
                jiaoModeBtn.setTitleColor(UIColor.red, for: .normal)
                yuanModeBtn.setTitleColor(UIColor.white, for: .normal)
                fenModeBtn.setTitleColor(UIColor.white, for: .normal)
            } else if selectedMode == 1{
                yuanModeBtn.backgroundColor = defaultColor
                jiaoModeBtn.backgroundColor = UIColor.red
                fenModeBtn.backgroundColor = defaultColor
                yuanModeBtn.setTitleColor(UIColor.red, for: .normal)
                jiaoModeBtn.setTitleColor(UIColor.white, for: .normal)
                fenModeBtn.setTitleColor(UIColor.white, for: .normal)
            }
        case FEN_MODE:
            
            yuanModeBtn.isHidden = false
            jiaoModeBtn.isHidden = false
            fenModeBtn.isHidden = false
            
            if selectedMode == 0{
                yuanModeBtn.backgroundColor = UIColor.red
                jiaoModeBtn.backgroundColor = defaultColor
                fenModeBtn.backgroundColor = defaultColor
                yuanModeBtn.setTitleColor(UIColor.white, for: .normal)
                jiaoModeBtn.setTitleColor(UIColor.red, for: .normal)
                fenModeBtn.setTitleColor(UIColor.red, for: .normal)
            } else if selectedMode == 1{
                yuanModeBtn.backgroundColor = defaultColor
                jiaoModeBtn.backgroundColor = UIColor.red
                fenModeBtn.backgroundColor = defaultColor
                yuanModeBtn.setTitleColor(UIColor.red, for: .normal)
                jiaoModeBtn.setTitleColor(UIColor.white, for: .normal)
                fenModeBtn.setTitleColor(UIColor.red, for: .normal)
            } else if selectedMode == 2{
                yuanModeBtn.backgroundColor = defaultColor
                jiaoModeBtn.backgroundColor = defaultColor
                fenModeBtn.backgroundColor = UIColor.red
                yuanModeBtn.setTitleColor(UIColor.red, for: .normal)
                jiaoModeBtn.setTitleColor(UIColor.red, for: .normal)
                fenModeBtn.setTitleColor(UIColor.white, for: .normal)
            }
        default:
            break
        }
    }
    
    @IBAction func cancelAction(){
        dismiss()
        if self._delegate != nil{
            self._delegate.onCancelClick(notPop: notPopLater)
        }
    }
    
    @IBAction func touzhuAction(){
        dismiss()
        if self._delegate != nil{
            if self._adjustData != nil{
                self._adjustData?.modeIndex = selectModeIndex
                self._adjustData?.money = selectMoney
                self._adjustData?.zhushu = selectZhushu
                self._adjustData?.beishu = selectBeishu
                self._delegate.onAdustResult(data: self._adjustData!,notPop: notPopLater)
            }
        }
    }
    
    @IBAction func jianAction(){
        let jian = beishuInput.text
        if let jianValue = jian{
            if isEmptyString(str: jianValue){
                showToast(view: self, txt: "请输入倍数")
                return
            }
            if !isPurnInt(string: jianValue){
                showToast(view: self, txt: "请输入正确的倍数格式")
                return
            }
            var bsInt = Int(jianValue)
            bsInt = bsInt! - 1
            if bsInt! <= 0{
                return
            }
            beishuInput.text = String.init(describing: bsInt!)
            selectBeishu = bsInt!
            adjustMoney(beishu: selectBeishu, zhushu: selectZhushu, selectModeIndex: selectModeIndex)
        }
    }
    
    func adjustMoney(beishu:Int,zhushu:Int,selectModeIndex:Int) -> Void {
        var money:Double = (self._adjustData?.basicMoney)!
        money = money*Double(beishu*zhushu)
        if selectModeIndex == 0{
            
        }else if selectModeIndex == 1{
            money = money/10
        }else if selectModeIndex == 2{
            money = money/100
        }
        selectMoney = money
        totalMoney.text = String.init(format: "下注金额: %.2f元", selectMoney)
    }
    
    @IBAction func yuanModeClick(){
        selectModeIndex = 0;
        switchMode(selectedMode: selectModeIndex)
        adjustMoney(beishu: selectBeishu, zhushu: selectZhushu, selectModeIndex: selectModeIndex)
    }
    
    @IBAction func jiaoModeClick(){
        selectModeIndex = 1;
        switchMode(selectedMode: selectModeIndex)
        adjustMoney(beishu: selectBeishu, zhushu: selectZhushu, selectModeIndex: selectModeIndex)
    }
    
    @IBAction func fenModeClick(){
        selectModeIndex = 2;
        switchMode(selectedMode: selectModeIndex)
        adjustMoney(beishu: selectBeishu, zhushu: selectZhushu, selectModeIndex: selectModeIndex)
    }
    
    @IBAction func addAction(){
        let add = beishuInput.text
        if let addValue = add{
            if isEmptyString(str: addValue){
                showToast(view: self, txt: "请输入倍数")
                return
            }
            if !isPurnInt(string: addValue){
                showToast(view: self, txt: "请输入正确的倍数格式")
                return
            }
            var addInt = Int(addValue)
            addInt = addInt! + 1
            beishuInput.text = String.init(describing: addInt!)
            selectBeishu = addInt!
            adjustMoney(beishu: selectBeishu, zhushu: selectZhushu, selectModeIndex: selectModeIndex)
        }
    }
    
    func show() {
        
        if _shareViewBackground == nil{
            _shareViewBackground = UIView.init(frame: UIScreen.main.bounds)
            _shareViewBackground.backgroundColor = UIColor.clear
            _shareViewBackground.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(TouzhuWindow.cancelAction)))
        }
        self.frame = CGRect.init(x:0, y:kScreenHeight/2, width:UIScreen.main.bounds.width, height:kScreenHeight/2)
        
        _window = UIWindow.init(frame: UIScreen.main.bounds)
        _window.windowLevel = UIWindowLevelAlert+1
        _window.backgroundColor = UIColor.clear
        _window.isHidden = true
        _window.isUserInteractionEnabled = true
        _window.addSubview(_shareViewBackground)
        _window.addSubview(self)
        
        _window.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        })
    }
    
    func switchAction(sender:UISwitch) -> Void {
        let isOn = sender.isOn
        notPopLater = isOn
    }
    
    func textFieldTextChange(textField:UITextField)->Void{
        let s = textField.text
        if let svalue = s{
            if isEmptyString(str: svalue){
                self.selectBeishu = 1
                adjustMoney(beishu: selectBeishu, zhushu: selectZhushu, selectModeIndex: selectModeIndex)
                return
            }
            if !isPurnInt(string: svalue){
                return
            }
            let bsInt = Int(svalue)
            if bsInt! <= 0{
                return
            }
            self.selectBeishu = bsInt!
            adjustMoney(beishu: selectBeishu, zhushu: selectZhushu, selectModeIndex: selectModeIndex)
        }
    }
    
    func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
            self.frame = CGRect.init(x:0, y:UIScreen.main.bounds.size.height , width:UIScreen.main.bounds.width, height:240)
        }) { (finished) in
            self._window = nil
        }
    }
    
    
    func dismiss() {
        hidden()
    }
    
    
    
    //键盘弹起响应
    func keyboardWillShow(notification: NSNotification) {
        print("show")
        if let userInfo = notification.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            if keyBoardNeedLayout {
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: { _ in
                                self.frame = CGRect.init(x:0,y:10,width:self.bounds.width,height:kScreenHeight/2)
                                self.keyBoardNeedLayout = false
                                self.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    //键盘隐藏响应
    func keyboardWillHide(notification: NSNotification) {
        print("hide")
        if let userInfo = notification.userInfo,
//            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: { _ in
                            self.frame = CGRect.init(x:0,y:kScreenHeight/2,width:self.bounds.width,height:kScreenHeight/2)
                            self.keyBoardNeedLayout = true
                            self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    

}
