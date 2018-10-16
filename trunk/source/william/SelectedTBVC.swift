//
//  SelectedTBVC.swift
//  swift_UI02
//
//  Created by William on 2018/7/26.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit
import Kingfisher

class SelectedTBVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var tableView:UITableView!
    
    var isFirstIn = true //是否刚进来，还未触发任何点击
    var maxIndexPathMax = 0 //滑动过的最大cell下标
    var resultData = Array<VisitRecords>()
    
    func getData() {
        let jsonStr:String = YiboPreference.getLotterys()
//        print(jsonStr)
        let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false)
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
//            print("json:\n",json)
            let dic = json as! NSDictionary //转化成字典
            let arr = dic["content"] as! NSArray // 取出里面的数组
            for item in arr { //遍历数组中的字典
                //                print(item)
                let dict = item as! NSDictionary
                if dict["subData"] != nil { //json 中有子类 subData
                    //                    print("success")
                    let arr2 = dict["subData"] as! Array<NSDictionary>
//                    resultData.removeAll()//先清空数组
                    for vv in arr2{
                        let record:VisitRecords = VisitRecords()
                        record.cpName = vv["name"] as? String //名字
                        let value:Int = vv["lotType"] as! Int
                        record.czCode = String(value) //类型
                        record.ago = "0" // 时间差 传默认值
                        record.cpBianHao = vv["code"] as? String //编号
                        record.lotType = String(value) //类型
                        let v2:Int = vv["lotVersion"] as! Int
                        record.lotVersion = String(v2) //版本
                        record.num = "1"
                        record.icon = vv["lotteryIcon"] as? String
                        
                        self.resultData.append(record)
                    }
                }
                
            }
        } catch {
            print("error:\t",error)
        }
        
        for item in self.resultData {
            if item.icon != nil{
                print(item.cpName!,"\t\t\t",item.czCode!,"\t",item.ago!,"\t",
                      item.cpBianHao!,"\t",item.lotType!,"\t",
                      item.lotVersion!,"\t\t\t\t",item.num!,"\t\t\ticon:",item.icon!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        self.getData() //进入页面先获取数据
        //UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(btnClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnClick))
        //创建表视图
        tableView = UITableView(frame: self.view.frame, style:UITableViewStyle.plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setViewBackgroundColorTransparent(view: self.tableView)
        self.view.addSubview(self.tableView)
        //创建一个重用的单元格
        self.tableView.register(UINib.init(nibName: "SelectedTBCell", bundle: nil), forCellReuseIdentifier: "SwiftCell")
        
        //设置允许单元格多选
        self.tableView.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView!.reloadData()
    }
    
    //只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultData.count
    }
    
    //cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册
        var cell:SelectedTBCell? = (tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)) as? SelectedTBCell
        if cell == nil {
            cell = (Bundle.main.loadNibNamed("SelectedTBCell", owner: self, options: nil)?.last as? SelectedTBCell)!
        }
        
        let model = self.resultData[indexPath.row]
        let lotCode = model.cpBianHao!
        var imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + lotCode + ".png")
        if model.icon != nil && model.icon != "" {//如果有,优先以icon作为图片地址
            imageURL = URL(string: model.icon!)
        }
        cell?.myImageView!.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)

        
        if model.lotVersion == "1" {
            cell?.myLabel.text = model.cpName! + "[官]"
        }else if model.lotVersion == "2" {
            cell?.myLabel.text = model.cpName! + "[信]"
        }

        
        if isFirstIn {//刚进入页面 把数据库中的已有的记录展示出来
            let exsit:NSNumber? = WHC_ModelSqlite.query(VisitRecords.self, func: "count(*)", condition: "where userName = '\(YiboPreference.getUserName())' and cpBianHao = '\(model.cpBianHao!)' AND lotVersion = '\(model.lotVersion!)'") as? NSNumber
            if exsit == nil || exsit == 0 {//如果没在数据库中
            }else{//如果在数据库中
                tableView.selectRow(at: indexPath, animated: true, scrollPosition:UITableViewScrollPosition.none)//让cell处于选中选中状态
            }
        }
        
        //如何cell处于选中状态 就在右边标记，否则不标记
        if let selectedItems = self.tableView.indexPathsForSelectedRows {
            if selectedItems.contains(indexPath){
                cell?.accessoryType = .checkmark
            }else{
                cell?.accessoryType = .none
            }
        }
        
        //记录滑动过的最大cell 标记
        maxIndexPathMax = maxIndexPathMax > indexPath.row ? maxIndexPathMax : indexPath.row
        
        cell?.selectionStyle = .none //选中状态的模式(选中颜色不改变)
        return cell!
    }
    
    //处理列表项的选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.isFirstIn = false
        let cell = self.tableView?.cellForRow(at: indexPath)//取到当前cell
        cell?.accessoryType = .checkmark
    }
    
    //处理列表项的取消选中事件
    func tableView(_ tableView: UITableView,didDeselectRowAt indexPath: IndexPath) {
        self.isFirstIn = false
        let cell = self.tableView?.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    //确定按钮点击
    @objc func btnClick() {
        var selectedIndexs = [Int]()
        if let selectedItems = tableView!.indexPathsForSelectedRows {
            for indexPath in selectedItems {
                selectedIndexs.append(indexPath.row)
            }
        }
        
        
        for i in 0..<maxIndexPathMax{
            let model = self.resultData[i]
            if selectedIndexs.contains(i){ //如果在选中列表中
                let exsit:NSNumber? = WHC_ModelSqlite.query(VisitRecords.self, func: "count(*)", condition: "where userName = '\(YiboPreference.getUserName())' AND cpBianHao = '\(model.cpBianHao!)' AND lotVersion = '\(model.lotVersion!)'") as? NSNumber
                if  exsit == nil || exsit! == 0 { //并且没有在数据库中就 加入数据库
                    model.userName = YiboPreference.getUserName()
                    model.num = "1"
                    WHC_ModelSqlite.insert(model)
                }
            }else{ //如果没有在选中列表中
                WHC_ModelSqlite.delete(VisitRecords.self, where: "userName = '\(YiboPreference.getUserName())' AND cpBianHao = '\(model.cpBianHao!)' AND lotVersion = '\(model.lotVersion!)'")
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
