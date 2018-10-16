//
//  YSJShareView.swift
//  YSJSharePopView_Swift
//
//  Created by 闫树军 on 16/4/14.
//  Copyright © 2016年 闫树军. All rights reserved.
//

import UIKit

class ShareBtn: UIButton {
    var iconImageView : UIImageView!
    var nameLabel     : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconImageView = UIImageView.init(frame: CGRect.init(x:10, y:10, width:40, height:40))
        iconImageView.layer.cornerRadius = 5
        self.addSubview(iconImageView)
        
        nameLabel = UILabel.init(frame: CGRect.init(x:0, y:55, width:60, height:20))
        nameLabel.textAlignment = NSTextAlignment.center
        self.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

protocol YSJShareViewDelegate {
    func shareBtnClick(index:Int)
}


class YSJShareView: UIView {
    
    var shareViewHeight     :CGFloat!
    var _shareView          :UIView!
    var _sepWidth           :CGFloat!
    var _count              :Int = 0
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    
    var _delegate            :YSJShareViewDelegate!
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        _shareView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 240))
        self.addSubview(_shareView)
        
        _shareViewBackground = UIView.init(frame: UIScreen.main.bounds)
        _shareViewBackground.backgroundColor = UIColor.clear
        _shareViewBackground.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(YSJShareView.dismiss)))
        
        let cancenlBtn = UIButton.init(type: UIButtonType.custom)
        cancenlBtn.setTitle("取消分享", for: .normal)
        cancenlBtn.frame = CGRect.init(x:0, y:240 - 40, width:UIScreen.main.bounds.width, height:40)
        cancenlBtn.addTarget(self, action: #selector(YSJShareView.hidden), for: UIControlEvents.touchUpInside)
        self.addSubview(cancenlBtn)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addItem(title:String ,withImage:UIImage){
        print(title)
        _count += 1
        _sepWidth = 20 + ((UIScreen.main.bounds.width - 280)/3 + 60)*(CGFloat(_count - 1))
        let shareBtn = ShareBtn.init(type: UIButtonType.custom)
        shareBtn.frame = CGRect.init(x:0 + _sepWidth, y:10, width:60, height:80)
        shareBtn.nameLabel.text = title
        shareBtn.iconImageView.image = withImage
        shareBtn.addTarget(self, action: #selector(YSJShareView.share(btn:)), for: UIControlEvents.touchUpInside)
        shareBtn.tag = 1000+_count
        if _count > 4{
            _sepWidth = 20 + ((UIScreen.main.bounds.width - 280)/3 + 60)*(CGFloat(_count - 5))
            shareBtn.frame = CGRect.init(x:0 + _sepWidth, y:90, width:60, height:80)
        }
        print(shareBtn)
        _shareView.addSubview(shareBtn)
    }
    
    func show() {
        _window = UIWindow.init(frame: UIScreen.main.bounds)
        _window.windowLevel = UIWindowLevelAlert+1
        _window.backgroundColor = UIColor.clear
        _window.isHidden = true
        _window.isUserInteractionEnabled = true
        _window.addSubview(_shareViewBackground)
        _window.addSubview(self)

        _window.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
            self.frame = CGRect.init(x:0, y:UIScreen.main.bounds.size.height - 240, width:UIScreen.main.bounds.width, height:240)
            })

    }
    
        
    @objc func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
            self.frame = CGRect.init(x:0, y:UIScreen.main.bounds.size.height , width:UIScreen.main.bounds.width, height:240)
            }) { (finished) in
            self._window = nil
        }

    }
    
    
    @objc func dismiss() {
        hidden()
    }
    
    @objc func share(btn:UIButton) {
        _delegate.shareBtnClick(index: btn.tag - 1001)
        hidden()
    }
    
    
    
}
