//
//  PeilvOrderWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/16.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//体育注单窗

protocol SportWindowDelegate {
    func onSportWindowCallback(acceptBestPeilv:Bool,inputMoney:String,notAutoPop:Bool,datas:[SportBean])
    func onSportWindowClose(acceptBestPeilv:Bool,inputMoney:String,notAutoPop:Bool,datas:[SportBean])
}

class SportPopWindow: UIView,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var clearGameBtn:UIButton!
    @IBOutlet weak var autoSwitch:UISwitch!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var inputMoneyUI:CustomFeildText!
    @IBOutlet weak var winMoneyUI:UILabel!
    @IBOutlet weak var minMoneyUI:UILabel!
    @IBOutlet weak var acceptSwitch:UISwitch!
    
    @IBOutlet weak var cancelBtn:UIButton!
    @IBOutlet weak var touZhuBtn:UIButton!
    
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    var orderDatas:[SportBean] = []
    var windowDelegate:SportWindowDelegate?
    var keyBoardNeedLayout: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "sport_order_cell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableView.register(nib, forCellReuseIdentifier: "sportOrderCell")
        inputMoneyUI.addTarget(self, action: #selector(onTextChange(ui:)), for: UIControlEvents.editingChanged)
        inputMoneyUI.delegate = self
        cancelBtn.addTarget(self, action: #selector(dismiss), for: UIControlEvents.touchUpInside)
        touZhuBtn.addTarget(self, action: #selector(onTouzhuClick), for: UIControlEvents.touchUpInside)
        clearGameBtn.addTarget(self, action: #selector(onGameDeleteClick), for: UIControlEvents.touchUpInside)
        
        //当键盘弹起的时候会向系统发出一个通知，
        //这个时候需要注册一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func onTextChange(ui:UITextField) -> Void {
        if let txt = ui.text{
            if judgmentInput(inputNum: txt, inputUI: inputMoneyUI) {
                calcTotalWinMoneyWhenAdjustInputMoney(inputMoney: txt)
            }else {
                showToast(view: self, txt: "输入数值过大")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func calcTotalWinMoneyWhenAdjustInputMoney(inputMoney:String) -> Void {
        var money = 0
        if !isEmptyString(str: inputMoney){
            money = Int(inputMoney)!
        }
        if money == 0 {
            return
        }
        var totalPeilv = 0.0
        for sport in orderDatas{
            let peilv = !isEmptyString(str: sport.peilv) ? Float(sport.peilv) : 0.0
            totalPeilv = totalPeilv + Double(peilv!)
        }
        let moneyValue = totalPeilv*Double(money)
        winMoneyUI.text = String.init(format: "可赢金额:%.2f", moneyValue)
    }
    
    private func judgmentInput(inputNum: String,inputUI: CustomFeildText) -> Bool{
        let max = Int.max
        if let doubleSvalue:Double = Double(inputNum) {
            if doubleSvalue > Double(max) {
                
                let numSubStr = inputNum.subString(start: 0, length: inputNum.length - 1)
                inputUI.text = numSubStr
                
                return false
            }else {
                return true
            }
        }else {
            return true
        }
    }
    
    @objc func cancelAction(){
        dismiss()
    }
    
    @objc func onTouzhuClick() -> Void {
        if let delegate = windowDelegate{
            delegate.onSportWindowCallback(acceptBestPeilv: acceptSwitch.isOn, inputMoney: inputMoneyUI.text!,notAutoPop: autoSwitch.isOn,datas:self.orderDatas)
        }
        cancelAction()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    func setData(items:[SportBean],acceptPeilv:Bool,inputMoney:String,notAutoPop:Bool){
        orderDatas.removeAll()
        orderDatas = orderDatas + items
        tableView.reloadData()
        
        self.tableView.setEditing(false, animated: true);
        self.clearGameBtn.setTitle("删除", for: .normal)
        self.clearGameBtn.tag = 10
        
        if !orderDatas.isEmpty{
            clearGameBtn.isHidden = false
        }else{
            clearGameBtn.isHidden = true
        }
        acceptSwitch.isOn = acceptPeilv
        inputMoneyUI.text = inputMoney
        autoSwitch.isOn = notAutoPop
        minMoneyUI.text = "单注最低:10元"
        inputMoneyUI.text = inputMoney
        calcTotalWinMoneyWhenAdjustInputMoney(inputMoney: inputMoneyUI.text!)
    }
    
    @objc func onGameDeleteClick(){
        if self.clearGameBtn.tag == 10{
            self.tableView.setEditing(true, animated: true);
            self.clearGameBtn.setTitle("完成", for: .normal)
            self.clearGameBtn.tag = 20
        }else{
            self.tableView.setEditing(false, animated: true);
            self.clearGameBtn.setTitle("删除", for: .normal)
            self.clearGameBtn.tag = 10
        }
    }
    
    @objc func dismiss() {
        hidden()
        if let delegate = windowDelegate{
            delegate.onSportWindowClose(acceptBestPeilv: acceptSwitch.isOn, inputMoney: self.inputMoneyUI.text!, notAutoPop: autoSwitch.isOn,datas:self.orderDatas)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //删除数据源的对应数据
        self.orderDatas.remove(at: indexPath.row)
        //删除对应的cell
        self.tableView?.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
        if !orderDatas.isEmpty{
            clearGameBtn.isHidden = false
        }else{
            clearGameBtn.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sportOrderCell") as? SportOrderCell  else {
            fatalError("The dequeued cell is not an instance of SportOrderCell.")
        }
        let data = self.orderDatas[indexPath.row]
        cell.leagueUI.text = data.lianSaiName
        cell.teamUI.text = data.teamNames
        var peilv = data.peilv
        if !isEmptyString(str: peilv){
            let peilvFloat = Float(peilv);
            peilv = String.init(format: "%.2f", peilvFloat!)
        }
        cell.projectAndPeilv.text = String.init(format: "%@ @ %@", data.project,peilv)
        cell.categoryUI.text = data.gameCategoryName
        return cell
    }
    
    
    //键盘弹起响应
    @objc func keyboardWillShow(notification: NSNotification) {
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
                               animations: {
                                self.frame = CGRect.init(x:0,y:CGFloat(60-80*(self.orderDatas.count-1)),width:self.bounds.width,height:self.bounds.height)
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
                           animations: { 
                            self.frame = CGRect.init(x:0,y:y,width:self.bounds.width,height:self.bounds.height)
                            self.keyBoardNeedLayout = true
                            self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}

