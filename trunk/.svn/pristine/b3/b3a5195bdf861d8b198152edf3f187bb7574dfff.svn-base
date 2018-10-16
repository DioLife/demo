//
//  LotteryOpenResultController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class LotteryOpenResultController: BaseTableViewController,UITableViewDelegate,UITableViewDataSource {
    
//    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    var cpName:String?
    var cpBianMa :String?
    var cpTypeCode = ""
    var pageNo = 1;
    let pageSize = 20;
    var datas:[OpenResultDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cpNameValue = cpName{
            self.navigationItem.title = cpNameValue
        }
        
        loadDatas()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datas.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ballWidth:CGFloat = 30
        let data = self.datas[indexPath.row]
        let totalBallWidth = ballWidth * CGFloat(data.haoMaList.count)
        let viewPlaceHoldWidth = kScreenWidth - 32
        //如果ballview占位宽度不大于实际号码宽度，则需要换行处理
        if totalBallWidth > viewPlaceHoldWidth{
            return 110
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "openResult") as? OpenResultCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        let item = self.datas[indexPath.row]
        cell.qishuUI.text = String.init(format: "第%@期", item.qiHao)
        cell.timeUI.text = item.date + " " + item.time
        cell.ballView.setupBalls(nums: item.haoMaList, offset: 0,lotTypeCode: self.cpTypeCode, cpVersion: VERSION_1,ballsViewWidth: cell.ballView.width)

        return cell
    }
    
    func loadDatas() -> Void {
        
        let dataUrl = OPEN_RESULT_DETAIL_URL
        let params:Dictionary<String,AnyObject> = ["lotCode":cpBianMa as AnyObject,"page":pageNo as AnyObject,"rows":pageSize as AnyObject]
        
        request(frontDialog: true, loadTextStr:"获取记录中", url:dataUrl,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    self.parseWebResult(resultJson: resultJson)
        })
    }
    
    func parseWebResult(resultJson:String) -> Void {
        if let result = OpenResultDetailWraper.deserialize(from: resultJson){
            if result.success{
                YiboPreference.setToken(value: result.accessToken as AnyObject)
                if  self.pageNo == 1{
                    self.datas.removeAll()
                }
                if result.content != nil{
                    self.datas += result.content
                    self.tableView.reloadData()
                    //self.pageIndex = self.pageIndex + 1
                }
            }else{
                if !isEmptyString(str: result.msg){
                    showToast(view: self.view, txt: result.msg)
                }else{
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }
                if (result.code == 0) {
                    loginWhenSessionInvalid(controller: self)
                }
            }
        }
    }
    
}
