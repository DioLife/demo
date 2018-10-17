//
//  MenuDownPopWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/5.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

protocol MenuPopWindowDelegate {
    func onMenuItemClick(key:String,value:String)
    func onMenuDismiss()
}

enum Menu_Data {
    case status,time,sportTime,caizhong,qiuzhong,game_platform,real_platform,goucai
}

class MenuDownPopWindow: UIView,UITableViewDelegate,UITableViewDataSource {
    
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    @IBOutlet weak var tablview:UITableView!
    
    var menuData:Menu_Data?
    var itemClickDelegate:MenuPopWindowDelegate?
    var statusDatas:[[String]] = [["all","全部"],["init","未开奖"],["win","已中奖"],["lost","未中奖"],["follow","追号中"]]
    var timeDatas:[[String]] = [["today","今天"],["yesterday","昨天"],["week","近一周"],["month","近30天"],["monthbefore","30天以前"]]
    var sporTimeDatas:[[String]] = [["1","今天"],["2","昨天"],["3","近一周"],["4","近30天"]]
    var gameDatas:[[String]] = [["全部"],["PT"],["QT"]]
    var realDatas:[[String]] = [["全部"],["AG"],["MG"],["BBIN"],["ALLBET"],["OG"],["DS"]]
    var caizhongDatas:[[String]] = [[]]
    var qiuzhongDatas:[[String]] = [["0","全部"],["1","足球"],["2","篮球"]]
    var goucai_categorys:[[String]] = [["0","全部"],["1","高频彩"],["2","低频彩"]]
    var globalData:[[String]] = [[]]
    
    override func awakeFromNib() {
        
        tablview.dataSource = self
        tablview.delegate = self
        self.globalData = statusDatas

        if _shareViewBackground == nil{
            _shareViewBackground = UIView.init(frame: UIScreen.main.bounds)
            _shareViewBackground.backgroundColor = UIColor.clear
            _shareViewBackground.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        }
//        self.tablview.register(RecordMenuCell.self, forCellReuseIdentifier: "recordMenu")
        let nib = UINib(nibName: "RecordMenuCell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.tablview.register(nib, forCellReuseIdentifier: "recordMenu")
    }
    
    func setupLotteryArrayWhenCaipiaoRecord() -> [[String]] {
        //获取存储在本地preference中的彩种信息
        let lotterysJson = YiboPreference.getLotterys()
        if !isEmptyString(str: lotterysJson){
            guard let lotWraper = JSONDeserializer<LotterysWraper>.deserializeFrom(json: lotterysJson) else {return [[]]}
            // 从字符串转换为对象实例
            if !lotWraper.success{
                return [[]]
            }
            guard let datas = lotWraper.content else {return [[]]}
            var cpDatas = [[String]](repeating:[], count:datas.count)
            if !datas.isEmpty{
                for index in 0...datas.count-1{
                    let lotteryData = datas[index]
                    if lotteryData.moduleCode != 3{
                        continue
                    }
                    cpDatas[index] = [lotteryData.code!,lotteryData.name!]
                }
            }
            return cpDatas
        }
        return [[]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setMenuDataType(menuData:Menu_Data) -> Void {
        self.menuData = menuData
        switch menuData {
        case .status:
            self.globalData = statusDatas
        case .time:
            self.globalData = timeDatas
        case .sportTime:
            self.globalData = sporTimeDatas
        case .caizhong:
            if caizhongDatas[0].isEmpty{
                let czDatas = setupLotteryArrayWhenCaipiaoRecord()
                caizhongDatas.removeAll()
                caizhongDatas = caizhongDatas + czDatas
            }
            self.globalData = caizhongDatas
        case .game_platform:
            self.globalData = gameDatas
        case .real_platform:
            self.globalData = realDatas
        case .qiuzhong:
            self.globalData = qiuzhongDatas
        case .goucai:
            self.globalData = goucai_categorys
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = itemClickDelegate{
            var value = ""
            var key = ""
            if self.globalData[indexPath.row].count == 2{
                key = self.globalData[indexPath.row][0]
                value = self.globalData[indexPath.row][1]
            }else if self.globalData[indexPath.row].count == 1 {
                value = self.globalData[indexPath.row][0]
            }
            delegate.onMenuItemClick(key: key, value: value)
            dismiss()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RecordMenuCell = tableView.dequeueReusableCell(withIdentifier: "recordMenu", for: indexPath) as! RecordMenuCell
        let count = self.globalData[indexPath.row].count
        if count == 0{
            return cell
        }
        if count == 2{
            cell.txt.text = self.globalData[indexPath.row][1]
        }else{
            cell.txt.text = self.globalData[indexPath.row][0]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func show() {
        
        self.frame = CGRect.init(x:0, y:44+45+22, width:Int(kScreenWidth), height:Int(kScreenHeight-44-22-45))
        
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
        })
        self.tablview.reloadData()
    }
    
    func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
        }) { (finished) in
            self._window = nil
            if let delegate = self.itemClickDelegate{
                delegate.onMenuDismiss()
            }
        }
    }
    
    
    func dismiss() {
        hidden()
    }

    
    
}
