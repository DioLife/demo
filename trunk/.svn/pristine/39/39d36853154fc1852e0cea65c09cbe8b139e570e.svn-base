//
//  PopupAlert.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class PopupAlert: UIView {

    var titleUI:UILabel!
    var contenUI:UIWebView!
    var cancelBtn:UIButton!
    var sureBtn:UIButton!
    
    typealias clickAlertClosure = (_ index: Int) -> Void //声明闭包，点击按钮传值
    
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    //为闭包设置调用函数
    func clickIndexClosure(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    let Bgtap = UITapGestureRecognizer()
    
//    init(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?) {
//        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
//        createAlertView()
//        self.titleUI.text = title
//        if let msg = message{
//            contenUI.loadHTMLString(msg, baseURL: URL.init(string: BASE_URL))
//        }
//        self.sureBtn.setTitle(sureButtonTitle, for: UIControlState())
//    }
    
    init(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        createAlertView()
        self.titleUI.text = title
        if let msg = message{
            contenUI.loadHTMLString(msg, baseURL: URL.init(string: BASE_URL))
        }
//        self.sureBtn.setTitle(sureButtonTitle, for: UIControlState())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAlertView() {
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        Bgtap.addTarget(self, action: #selector(dismiss))
        self.addGestureRecognizer(Bgtap)
        
        let alert = UIView.init(frame: CGRect.init(x: kScreenWidth/8, y: kScreenHeight/4,
                                                   width: kScreenWidth*0.75, height: kScreenHeight/2 - 40))
        alert.backgroundColor = UIColor.white
        alert.layer.cornerRadius = 10
        self.addSubview(alert)

        titleUI = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: alert.bounds.width, height: 40))
        titleUI.backgroundColor = UIColor.init(hexString: "c81011")
        titleUI.textColor = UIColor.white
        titleUI.clipsToBounds = true
        titleUI.textAlignment = NSTextAlignment.center
        let tpath = UIBezierPath(roundedRect: titleUI.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let tlayer = CAShapeLayer()
        tlayer.frame = titleUI.bounds
        tlayer.path = tpath.cgPath
        titleUI.layer.mask = tlayer
        alert.addSubview(titleUI)
        
        let closeButton = UIButton()
        alert.addSubview(closeButton)
        closeButton.whc_Top(10).whc_Trailing(5).whc_Width(20).whc_Height(20)
        closeButton.setImage(UIImage(named: "closeButtonImg"), for: .normal)
        closeButton.isUserInteractionEnabled = false
        
        //内容
        contenUI = UIWebView.init(frame: CGRect(x: alert.bounds.origin.x, y: alert.bounds.origin.y+50,
                                              width: alert.bounds.width, height: alert.bounds.height - 60))
//        contenUI.numberOfLines = 0
//        contenUI.textColor = UIColor.black
//        contenUI.textAlignment = NSTextAlignment.natural
//        contenUI.font = UIFont.systemFont(ofSize: 17)
        alert.addSubview(contenUI)

        //确认按钮
        sureBtn = UIButton.init(frame: CGRect(x: alert.bounds.origin.x , y: alert.bounds.height - 50,
                                              width: alert.bounds.width, height: 0))
//        sureBtn.backgroundColor = UIColor.red
//        sureBtn.setTitleColor(UIColor.white, for: UIControlState())
//        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        sureBtn.clipsToBounds = true
//        sureBtn.tag = 2
//        let spath = UIBezierPath(roundedRect: sureBtn.bounds, byRoundingCorners: [UIRectCorner.bottomRight, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
//        let slayer = CAShapeLayer()
//        slayer.frame = titleUI.bounds
//        slayer.path = spath.cgPath
//        sureBtn.layer.mask = slayer
//        sureBtn.addTarget(self, action: #selector(clickBtnAction(ui:)), for: .touchUpInside)
//        alert.addSubview(sureBtn)
        
    }
    
    @objc func clickBtnAction(ui:UIButton) -> Void {
        if (clickClosure != nil) {
            clickClosure!(ui.tag)
        }
        dismiss()
    }
    
    //MARK:消失
    @objc func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    

}
