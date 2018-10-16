//
//  SpreadVC.swift
//  gameplay
//
//  Created by William on 2018/8/8.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class SpreadVC: BaseController, UITableViewDelegate,UITableViewDataSource,DelegateSpreadTBCell {

    @IBOutlet weak var myTableView: UITableView!
    var result:SpreadModel = SpreadModel()
    
    var isFirst = true
    var tueiguangIndexs:[Int] = Array<Int>()//删除推广时，序号不马上刷新，重进页面再刷新数据
    
    override func viewWillAppear(_ animated: Bool) {
        tueiguangIndexs = Array<Int>()
        isFirst = true
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "推广链接"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新建推广", style: UIBarButtonItemStyle.plain, target: self, action: #selector(createMethod))
        
        myTableView.delegate = self
        myTableView.dataSource = self
        let identify = "SwiftCell"
        myTableView.register(UINib.init(nibName: "SpreadTBCell", bundle: nil), forCellReuseIdentifier: identify)
    }
    
    @objc func createMethod(){
        let vc = CreateSpreadVC2()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData() { //"/native/agent_reg_promotionList.do"
        request(frontDialog: true, method: .post, loadTextStr: "正在加载...", url: agent_reg_promotionList) { (resultJson:String, resultStatus:Bool) in
            
            if !resultStatus {
                if resultJson.isEmpty {
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }else{
                    showToast(view: self.view, txt: resultJson)
                }
                return
            }
            
            if let result = SpreadModel.deserialize(from: resultJson) {
                if result.success{
                    self.result = result
                    if self.isFirst {
                        self.isFirst = false
                        if let count:Int = self.result.content?.rows?.count {
                            for i in 0..<count{
                                self.tueiguangIndexs.append(count - i - 1)
                            }
                        }
                    }
                    self.myTableView.reloadData()
                }else{
                    if isEmptyString(str: result.msg){
                        showToast(view: self.view, txt: result.msg)
                    }else{
                        showToast(view: self.view, txt: "获取失败")
                    }
                }
            }
        }
    }
    
    //只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.result.content?.rows?.count != nil {
            return (self.result.content?.rows?.count)!
        }
        return 0
    }
    
    //cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 268
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify = "SwiftCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! SpreadTBCell
        cell.backgroundColor = UIColor.brown
        
        if self.result.content?.rows?.count != nil {
            let model:DailiModel = (result.content?.rows![indexPath.row])!
            cell.addMst(model: model, num: self.tueiguangIndexs[indexPath.row])
        }
        
        cell.selectionStyle = .none //选中状态的模式(无颜色变化)
        cell.delegate = self
        return cell
    }
    
    func queryDetail(datasoure: [String]) {
        if datasoure.isEmpty{
            return
        }
        let dialog = DetailListDialog(dataSource: datasoure, viewTitle: "推广详情")
        dialog.selectedIndex = 0
        self.view.window?.addSubview(dialog)
        dialog.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(dialog.kHeight)
        dialog.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            dialog.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func deleteUrl(index: Int, num:Int) { // "/native/agent_delete_prom_link.do"
        let alertController = UIAlertController(title:"温馨提示",message:"你确定要删除吗？",preferredStyle: .alert);
        let canceAction = UIAlertAction(title:"取消",style:.cancel,handler:nil);
        let okAciton = UIAlertAction(title:"确定",style:.default,handler: {
            action in
            var tueiguangIndex = 0
            for i in 0..<self.tueiguangIndexs.count{
                if self.tueiguangIndexs[i] == num{
                    tueiguangIndex = i
                }
            }
            self.tueiguangIndexs.remove(at: tueiguangIndex)
            self.sureDelete(index: index)
        })
        alertController.addAction(canceAction);
        alertController.addAction(okAciton);
        self.present(alertController, animated: true, completion: nil)
    }
    
    func sureDelete(index: Int) {
        request(frontDialog: true, method: .post, loadTextStr: "正在删除...", url: agent_delete_prom_link, params: ["id":index]) { (resultJson:String, resultStatus:Bool) in
            if !resultStatus {
                return
            }
            self.getData()
        }
    }

}
