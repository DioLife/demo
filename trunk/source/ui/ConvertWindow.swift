//
//  ConvertWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/2.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol ConvertDelegate {
    func onConvert(code:String,fromSys:Bool,money:String)
}

class ConvertWindow: UIView ,UITextFieldDelegate{

    @IBOutlet weak var inputMoneyUI:CustomFeildText!
    @IBOutlet weak var tapUI:UILabel!
    @IBOutlet weak var cancelBtn:UIButton!
    @IBOutlet weak var convertBtn:UIButton!
    
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    var convertDelegate:ConvertDelegate?
    var keyBoardNeedLayout: Bool = true
    
    var fromSys:Bool = false
    var gameCode = ""
    var gameTitle = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        
        inputMoneyUI.delegate = self
        cancelBtn.addTarget(self, action: #selector(dismiss), for: UIControlEvents.touchUpInside)
        convertBtn.addTarget(self, action: #selector(onConvertClick), for: UIControlEvents.touchUpInside)
        
//        当键盘弹起的时候会向系统发出一个通知，
//        这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   @objc func cancelAction(){
        dismiss()
    }
    
    @objc func onConvertClick() -> Void {
        if let delegate = self.convertDelegate{
            let moneyStr = inputMoneyUI.text!
            delegate.onConvert(code: gameCode, fromSys: fromSys, money: moneyStr)
        }
        cancelAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setData(code:String,title:String,convertIn:Bool) -> Void {
        self.fromSys = convertIn
        self.gameCode = code
        self.gameTitle = title
        if convertIn{
            self.tapUI.text = String.init(format: "从 系统 转到 %@", title)
        }else{
            self.tapUI.text = String.init(format: "从 %@ 转到 系统", title)
        }
    }
    
    func show() {
        if _shareViewBackground == nil{
            _shareViewBackground = UIView.init(frame: UIScreen.main.bounds)
            _shareViewBackground.backgroundColor = UIColor.clear
            _shareViewBackground.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cancelAction)))
        }
        _window = UIWindow.init(frame: UIScreen.main.bounds)
        _window.windowLevel = UIWindowLevelAlert+1
        _window.backgroundColor = UIColor.clear
        _window.isHidden = true
        _window.isUserInteractionEnabled = true
        _window.addSubview(_shareViewBackground)
        _window.addSubview(self)
        _window.isHidden = false
        
        let windowHeight = kScreenHeight/2
        self.frame = CGRect.init(x:0, y:kScreenHeight/2, width:UIScreen.main.bounds.width, height:windowHeight)
        UIView.animate(withDuration: 0.4, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        })
        
    }
    
    func hidden() {

        self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
        self.frame = CGRect.init(x:0, y:kScreenHeight/2, width:kScreenWidth, height:kScreenHeight/2)
        self._window = nil
        //        UIView.animate(withDuration: 0.4, animations: {
        //            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
        //            self.frame = CGRect.init(x:0, y:y, width:kScreenWidth, height:windowHeight)
        //        }) { (finished) in
        //            self._window = nil
        //        }
    }
    
    @objc func dismiss() {
        hidden()
    }

    //键盘弹起响应
    @objc func keyboardWillShow(notification: NSNotification) {
        print("show")
        if let userInfo = notification.userInfo,
                        let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue

            let selfY = kScreenHeight - frame.size.height - self.bounds.size.height
            if keyBoardNeedLayout {
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: {
                                self.frame = CGRect.init(x:0,y:CGFloat(selfY),width:self.bounds.width,height:self.bounds.height)
                                self.keyBoardNeedLayout = false
                                self.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    //键盘隐藏响应
    @objc func keyboardWillHide(notification: NSNotification) {
        print("hide")
        if let userInfo = notification.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let y = kScreenHeight - self.bounds.height
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: {
                            self.frame = CGRect.init(x:0,y:y,width:self.bounds.width,height:self.bounds.height)
                            self.keyBoardNeedLayout = true
                            self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    

}
