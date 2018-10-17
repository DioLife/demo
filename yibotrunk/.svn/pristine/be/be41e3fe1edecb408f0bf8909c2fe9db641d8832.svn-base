//
//  PayMethodWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/29.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher


protocol PayMethodDelegate {
    func onPayMethod(selectPay:Int,selectPos:Int)
}

class PayMethodWindow: UIView,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var titleUI:UILabel!
    @IBOutlet weak var tableView:UITableView!
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    
    var datas:[[AnyObject]] = [[]]
    var selectPayType = PAY_METHOD_ONLINE
    var selectPosition = 0
    var delegate:PayMethodDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "pay_method_cell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableView.register(nib, forCellReuseIdentifier: "payMethodCell")
    }
    
    func cancelAction(){
        dismiss()
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
        
        self.frame = CGRect.init(x:0, y:kScreenHeight/3, width:UIScreen.main.bounds.width, height:kScreenHeight*2/3)
        UIView.animate(withDuration: 0.4, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        })
    }
    
    func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
            self.frame = CGRect.init(x:0, y:kScreenHeight/3 , width:UIScreen.main.bounds.width, height:kScreenHeight*2/3)
        }) { (finished) in
            self._window = nil
        }
    }
    
    
    /**
     * @param payMethodResult 支付方式数据
     * @param type 方式类型 0-在线支付 1-快捷支付 2-银行支付
     * @param position 支付方式列表中选择过的position
     */
    func setData(order:PayMethodResult,selectPay:Int,selectPosition:Int){
        
        self.datas.removeAll()
        self.selectPayType = selectPay
        self.selectPosition = selectPosition
        
        //在线充值
        let onlines = order.online
        datas.append(onlines)
        //快速充值
        let fasts = order.fast
        datas.append(fasts)
        //快速充值
        let banks = order.bank
        datas.append(banks)
        tableView.reloadData()
    }
    
    func dismiss() {
        hidden()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "在线充值"
        }else if section == 1{
            return "快速充值"
        }else if section == 2{
            return "线下充值"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            selectPayType = PAY_METHOD_ONLINE
        }else if indexPath.section == 1{
            selectPayType = PAY_METHOD_FAST
        }else if indexPath.section == 2{
            selectPayType = PAY_METHOD_BANK
        }
        if let del = delegate{
            del.onPayMethod(selectPay: selectPayType, selectPos: indexPath.row)
        }
        dismiss()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datas[section].count
        
    }
    
    func fixPayIconWithPayType(payType:String) -> String {
        if isEmptyString(str: payType){
            return ""
        }
        switch payType {
        case "3":
            return "/native/resources/images/weixin.jpg"
        case "4":
            return "/native/resources/images/zhifubao.jpg"
        case "5":
            return "/native/resources/images/qqpay.png"
        case "6":
            return "/native/resources/images/jdpay.jpg"
        case "7":
            return "/native/resources/images/baidu.jpg"
        case "8":
            return "/native/resources/images/union.jpg"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "payMethodCell") as? PayMethodCell else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        
        var payStr = ""
        if indexPath.section == 0{
            let data = self.datas[indexPath.section][indexPath.row] as! OnlinePay
//            payStr = !isEmptyString(str: data.payName) ? data.payName : "暂无支付名称"
            payStr = payStr + String.init(format: "(最小充值金额%d元)", data.minFee)
            cell.imgUI?.contentMode = UIViewContentMode.scaleAspectFit
            if !isEmptyString(str: data.icon){
                data.icon = data.icon.trimmingCharacters(in: .whitespaces)
                let imageURL = URL(string: data.icon)!
                cell.imgUI?.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
            }else{
                let icon = fixPayIconWithPayType(payType: data.payType)
                if isEmptyString(str: icon){
                    cell.imgUI.image = UIImage.init(named: "default_pay_icon")
                }else{
                    let fixurl = String.init(format: "%@%@%@", BASE_URL,PORT,icon)
                    let imageURL = URL(string: fixurl)!
                    cell.imgUI?.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }else if indexPath.section == 1{
            let data = self.datas[indexPath.section][indexPath.row] as! FastPay
            
            payStr = !isEmptyString(str: data.payName) ? data.payName : "暂无支付名称"
            payStr = payStr + String.init(format: "(最小充值金额%d元)", data.minFee)
            cell.imgUI?.contentMode = UIViewContentMode.scaleAspectFit
            if !isEmptyString(str: data.icon){
                data.icon = data.icon.trimmingCharacters(in: .whitespaces)
                if data.icon.hasPrefix("https://") || data.icon.hasPrefix("http://"){
                    let imageURL = URL(string: data.icon)!
                    cell.imgUI?.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }else if indexPath.section == 2{
            let data = self.datas[indexPath.section][indexPath.row] as! BankPay
            payStr = !isEmptyString(str: data.payName) ? data.payName : "暂无支付名称"
            payStr = payStr + String.init(format: "(最小充值金额%d元)", data.minFee)
            cell.imgUI?.contentMode = UIViewContentMode.scaleAspectFit
            if !isEmptyString(str: data.icon){
                data.icon = data.icon.trimmingCharacters(in: .whitespaces)
                if ValidateUtil.URL(data.icon).isRight{
                    let imageURL = URL(string: data.icon)!
                    cell.imgUI?.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: UIImage(named: "default_pay_icon"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
        cell.payNameUI.text = payStr
        
        if selectPayType == indexPath.section{
            if selectPosition == indexPath.row{
                cell.checkboxUI.image = UIImage.init(named: "checkbox_press")
            }else{
                cell.checkboxUI.image = UIImage.init(named: "checkbox_normal")
            }
        }else{
            cell.checkboxUI.image = UIImage.init(named: "checkbox_normal")
        }
        return cell
    }
    
    
}
