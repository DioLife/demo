//
//  QRCodeView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class QRCodeView: UIView {
    
    var contenUI:UIImageView!
    typealias clickAlertClosure = (_ index: Int) -> Void //声明闭包，点击按钮传值
    
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    //为闭包设置调用函数
    func clickIndexClosure(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    let Bgtap = UITapGestureRecognizer()
    
    init(link: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        createAlertView()
        guard let msg = link else{return}
        downloadImage(url: URL.init(string: msg)!, imageUI: contenUI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAlertView() {
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        Bgtap.addTarget(self, action: #selector(dismiss))
        self.addGestureRecognizer(Bgtap)
        
        let delete = UIButton.init(frame: CGRect.init(x: kScreenWidth*0.75, y: CGFloat(kScreenHeight/2-kScreenWidth*0.25) - 50,
                                                      width: 24, height: 24))
        delete.addTarget(self, action: #selector(dismiss), for: UIControlEvents.touchUpInside)
        delete.setTitleColor(UIColor.white, for: .normal)
        delete.backgroundColor = UIColor.white
        delete.setImage(UIImage.init(named: "delete"), for: .normal)
        delete.layer.cornerRadius = 12
        self.addSubview(delete)
        
        let alert = UIView.init(frame: CGRect.init(x: kScreenWidth/4, y: CGFloat(kScreenHeight/2-kScreenWidth*0.25),
                                                   width: kScreenWidth*0.50, height: kScreenWidth*0.50))
        alert.backgroundColor = UIColor.lightGray
        self.addSubview(alert)
        
        //内容
        contenUI = UIImageView.init(frame: CGRect(x: alert.bounds.origin.x, y: alert.bounds.origin.y,
                                                width: alert.bounds.width, height: alert.bounds.height))
        contenUI.image = UIImage.init(named: "qr")
        alert.addSubview(contenUI)
        
        let title1 = UILabel.init(frame: CGRect.init(x: -kScreenWidth/4, y: alert.bounds.height+20, width: kScreenWidth, height: 30))
        title1.textColor = UIColor.white
        title1.backgroundColor = UIColor.clear
        title1.text = "1,长按二维码添加图片"
        title1.textAlignment = NSTextAlignment.center
        title1.font = UIFont.systemFont(ofSize: 14)
        alert.addSubview(title1)
        
        let title2 = UILabel.init(frame: CGRect.init(x: -kScreenWidth/4, y: alert.bounds.height + 50 , width: kScreenWidth, height: 30))
        title2.textColor = UIColor.white
        title2.backgroundColor = UIColor.clear
        title2.text = "2,您可以截图并打开微信扫描二维码打开"
        title2.textAlignment = NSTextAlignment.center
        title2.font = UIFont.systemFont(ofSize: 14)
        alert.addSubview(title2)
        
    }
    
    func clickBtnAction(ui:UIButton) -> Void {
        if (clickClosure != nil) {
            clickClosure!(ui.tag)
        }
        dismiss()
    }
    
    //MARK:消失
    func dismiss() {
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

