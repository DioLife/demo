//
//  AlertView.swift
//  Swift_UI
//
//  Created by William on 2018/8/16.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class AlertView: UIView,UITableViewDataSource,UITableViewDelegate {
    
    var didSelected: ( ( Int, String) -> Void)?
    
    @IBOutlet weak var mytitle: UILabel!
    @IBOutlet weak var mybalance: UILabel!
    @IBOutlet weak var jifen: UILabel!
    @IBOutlet weak var signDays: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    var dataArray:[QiandaoRows]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    let indentifier = "cell"  //cell标识
    override func awakeFromNib() {
        super.awakeFromNib()
        getData()
        
         mytitle.text = YiboPreference.getUserName()//设置用户名
        //设置数据源
        self.myTableView.dataSource = self
        //设置代理
        self.myTableView.delegate = self
        self.myTableView.tableFooterView = UIView()
        self.myTableView.register(UINib.init(nibName: "AlertCell", bundle: nil), forCellReuseIdentifier: indentifier)
    }
    
    func getData() {
        //加载余额 和 积分
        let vc = BaseController()
        vc.request(frontDialog: false, url:MEMINFO_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    print(resultJson)
                    if let result = Qiandao2.deserialize(from: resultJson){
                        if result.success{
                            if let memInfo = result.content{
                                //积分
                                self.jifen.text = "\(memInfo.score!)"
                                //更新余额等信息
                                self.mybalance.text = "\(memInfo.balance!)元"
                            }
                        }
                    }
        })
    }
    
    func numberOfSections(in tableView:UITableView) ->Int {
        return 2
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) ->Int {
        if section == 0 {
            return 1
        }
        if  self.dataArray != nil {
            return dataArray.count
        }
        return 10
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) ->UITableViewCell {
        let cell:AlertCell? = tableView.dequeueReusableCell(withIdentifier: indentifier) as? AlertCell
        
        if  indexPath.section == 0 {
            cell?.signDate.text = "签到日期"
            cell?.signDate.textColor = UIColor.white
            cell?.signDays.text = "连续签到天数"
            cell?.signDays.textColor = UIColor.white
            cell?.jifen.text = "积分奖励"
            cell?.jifen.textColor = UIColor.white
            cell?.backgroundColor = UIColor.init(r: 148, g: 137, b: 252)
        }else if indexPath.section == 1{
            if self.dataArray != nil {
                let model = self.dataArray[indexPath.row]
                cell?.signDate.text = changeDate(timestamp: model.signDate!)
                cell?.signDays.text = "\(model.signDays!)"
                cell?.jifen.text = "\(model.score!)"
            }
            cell?.backgroundColor = UIColor.white
        }
        
        return cell!
    }
    //把时间戳转换成想要的日期格式
    func changeDate(timestamp:Int64) -> String {
        let d1 = Date(timeIntervalSince1970: (TimeInterval(timestamp / 1000)))
        
        let timeZone = TimeZone.init(identifier: "GTM")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: d1)
//        print(date)
        return date
    }
    
    //设置cell行高
    func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) ->CGFloat {
        return 45
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        didSelected?(12, "212")
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
