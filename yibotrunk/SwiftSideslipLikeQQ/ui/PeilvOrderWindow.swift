//
//  PeilvOrderWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/16.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class PeilvOrderWindow: UIView,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var titleUI:UILabel!
    @IBOutlet weak var curQihaoUI:UILabel!
    @IBOutlet weak var totalMoney:UILabel!
    @IBOutlet weak var tableView:UITableView!
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    var orderDatas:[OrderDataInfo] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "peilv_order_cell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tableView.register(nib, forCellReuseIdentifier: "peilvOrderCell")
        self.tableView.tableFooterView = UIImageView.init(image: UIImage.init(named: "history_back_foot"))
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
        
        self.frame = CGRect.init(x:0, y:UIScreen.main.bounds.size.height/2, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.size.height/2)
        
        UIView.animate(withDuration: 0.4, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        })
    }
    
    func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
            self.frame = CGRect.init(x:0, y:UIScreen.main.bounds.size.height/2 , width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.size.height/2)
        }) { (finished) in
            self._window = nil
        }
    }
    
    func setData(order:[PeilvPlayData],currentQihao:String,calZhushu:Int,calcPeilv:Float,totalMoney:Float,
                 playName:String,subName:String){
        curQihaoUI.text = String.init(format: "当前期号:%@", currentQihao)
        titleUI.text = String.init(format: "注单明细(%d)", calZhushu)
        self.totalMoney.text = String.init(format: "下注金额: %.2f元", totalMoney)
        if order.isEmpty{
            return
        }
        let isMultiSelect = order[0].checkbox
        var numberWhenMultiSelect = ""
        if isMultiSelect{
            var numbers = [String]()
            for data in order{
                numbers.append(data.number)
            }
            for index in 0...numbers.count-1{
                let num = numbers[index]
                numberWhenMultiSelect.append(num)
                if index != numbers.count - 1{
                    numberWhenMultiSelect.append(",")
                }
            }
        }
        
        var rOrders = [OrderDataInfo]()
        for data in order{
            if !isSelectedNumber(data: data){
                break
            }
            let info = OrderDataInfo()
            if isMultiSelect{
                info.rate = Double(calcPeilv)
                info.zhushu = calZhushu
                info.money = Double(totalMoney)
                info.numbers = numberWhenMultiSelect
                info.playData = data
            }else{
                info.rate = Double(data.peilvData.odds)
                info.zhushu = 1
                info.money = Double(data.money>0 ? data.money : (totalMoney/Float(calZhushu)))
                info.numbers = getPeilvPostNumbers(data: data)
                info.playData = data
            }
            info.playName = playName
            info.subPlayName = subName
            rOrders.append(info)
            if isMultiSelect{
                break
            }
        }
        orderDatas.removeAll()
        orderDatas = orderDatas + rOrders
        tableView.reloadData()
    }
    
    func dismiss() {
        hidden()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "peilvOrderCell") as? PeilvOrderCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        let data = self.orderDatas[indexPath.row]
        cell.playUI.text = String.init(format: "%@-%@", data.playName,data.subPlayName)
        cell.numbersUI.text = data.numbers
        cell.peilvUI.text = String.init(format: "赔率: %.2f", data.rate)
        cell.zhuMoneyUI.text = String.init(format: "%d注 金额: %.2f元", data.zhushu,data.money)
        return cell
    }

    
}
