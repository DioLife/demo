//
//  OnlinePayInputWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/1.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol OnlinePayDelegate {
    func onPayClick(money:String,online:OnlinePay)
}

class OnlinePayInputWindow: UIView ,UITextFieldDelegate,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var delegate:OnlinePayDelegate?
    var controller:UIViewController!

    @IBOutlet weak var minFeeUI:UILabel!
    @IBOutlet weak var moneyTipUI:UILabel!
    @IBOutlet weak var input:CustomFeildText!
    @IBOutlet weak var cancelBtn:UIButton!
    @IBOutlet weak var czBtn:UIButton!
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var gridview:UICollectionView!
    @IBOutlet weak var gridviewHeight:NSLayoutConstraint!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!
    var moneys:[String] = []
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    var orderDatas:[SportBean] = []
    var windowDelegate:SportWindowDelegate?
    var keyBoardNeedLayout: Bool = true
    var online:OnlinePay?
    
    var selectedPos = -1
    

    override func awakeFromNib() {
        input.delegate = self
        cancelBtn.addTarget(self, action: #selector(hidden), for: UIControlEvents.touchUpInside)
        czBtn.addTarget(self, action: #selector(onPayClick), for: UIControlEvents.touchUpInside)
        
        gridview.delegate = self
        gridview.dataSource = self
        
        gridview.register(FixMoneyCell.self, forCellWithReuseIdentifier:"mycell")
        gridview.showsVerticalScrollIndicator = false
        
        //当键盘弹起的时候会向系统发出一个通知，
        //这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setData(online:OnlinePay?){
        self.online = online
        self.selectedPos = -1
        self.moneys.removeAll()
        if let o = self.online{
            minFeeUI.text = String.init(format: "最小充值金额:%d元", o.minFee)
            if let config = getSystemConfigFromJson(){
                if config.content != nil{
                    let payNameSwitch = config.content.onlinepay_name_switch
                    if payNameSwitch == "on"{
                        title.text = String.init(format: "%@", !isEmptyString(str: o.payName) ? o.payName : "在线充值")
                    }else{
                        title.text = "在线支付"
                    }
                }
            }
        }
        if let data = online{
            if !isEmptyString(str: data.fixedAmount) && data.fixedAmount.contains(","){
                let moneys = data.fixedAmount.components(separatedBy: ",")
                if !moneys.isEmpty{
                    moneyTipUI.isHidden = true
                    input.isHidden = true
                    gridview.isHidden = false
                    self.gridviewHeight.constant = 140
                    self.viewHeight.constant = 250
                    self.moneys.removeAll()
                    self.moneys = self.moneys + moneys
                    gridview.reloadData()
                    return
                }
            }
        }
        moneyTipUI.isHidden = false
        input.isHidden = false
        gridview.isHidden = true
        self.gridviewHeight.constant = 0
        self.viewHeight.constant = 110
    }
    
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moneys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth-0.5*6)/4, height: 30)
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! FixMoneyCell
        let data = self.moneys[indexPath.row]
        
        var isSelect = false
        if selectedPos == -1{
            isSelect = false
        }else{
            isSelect = selectedPos == indexPath.row
        }
        cell.setData(txt: data,isSelect: isSelect)
        cell.moneyBtn.tag = indexPath.row
        cell.moneyBtn.addTarget(self, action: #selector(onMoneyClick(ui:)), for: .touchUpInside)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let lotData = self.moneys[indexPath.row]
//
//    }
    
    @objc func onMoneyClick(ui:UIButton){
        if self.moneys.isEmpty{
            return
        }
        selectedPos = ui.tag
        self.gridview.reloadData()
    }
    
    
    @objc func onPayClick() -> Void {
        
        var money = ""
        if !self.moneys.isEmpty{
            if selectedPos != -1{
                money = self.moneys[selectedPos]
            }
        }else{
            guard let mmoney = input.text else{return}
            money = mmoney
        }
        if isEmptyString(str: money){
            showToast(view: controller.view, txt: "请输入金额")
            return
        }
        if let delegate = self.delegate{
            delegate.onPayClick(money: money,online: self.online!)
        }
        hidden()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func cancelAction(){
        hidden()
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
        
        var windowHeight = CGFloat(245+self.orderDatas.count*80)
        windowHeight = windowHeight > kScreenHeight ? kScreenHeight : windowHeight
        let y = kScreenHeight - windowHeight
        
        self.frame = CGRect.init(x:0, y:y, width:UIScreen.main.bounds.width, height:windowHeight)
        UIView.animate(withDuration: 0.4, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.5)
        })
        
    }
    
    func hidden() {
        
        var windowHeight = CGFloat(245+self.orderDatas.count*80)
        windowHeight = windowHeight > kScreenHeight ? kScreenHeight : windowHeight
        let y = kScreenHeight - windowHeight
        
        self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
        self.frame = CGRect.init(x:0, y:y, width:kScreenWidth, height:windowHeight)
        self._window = nil
        
        //        UIView.animate(withDuration: 0.4, animations: {
        //            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
        //            self.frame = CGRect.init(x:0, y:y, width:kScreenWidth, height:windowHeight)
        //        }) { (finished) in
        //            self._window = nil
        //        }
    }
    
    //键盘弹起响应
    func keyboardWillShow(notification: NSNotification) {
        print("show")
        if let userInfo = notification.userInfo,
            //            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            //            let frame = value.cgRectValue
            //            let intersection = frame.intersection(self.frame)
            //            let deltaY = intersection.height-21-44
            if keyBoardNeedLayout {
                UIView.animate(withDuration: duration, delay: 0.0,
                               options: UIViewAnimationOptions(rawValue: curve),
                               animations: { _ in
                                self.frame = CGRect.init(x:0,y:CGFloat(60-80*(self.orderDatas.count-1)),width:self.bounds.width,height:self.bounds.height)
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
            //            let frame = value.cgRectValue
            //            let intersection = frame.intersection(self.frame)
            //            let deltaY = intersection.height+21+44
            var windowHeight = CGFloat(245+self.orderDatas.count*80)
            windowHeight = windowHeight > kScreenHeight ? kScreenHeight : windowHeight
            let y = kScreenHeight - windowHeight
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve),
                           animations: { _ in
                            self.frame = CGRect.init(x:0,y:y,width:self.bounds.width,height:self.bounds.height)
                            self.keyBoardNeedLayout = true
                            self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}
