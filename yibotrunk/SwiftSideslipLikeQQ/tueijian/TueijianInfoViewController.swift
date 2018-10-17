//
//  TueijianInfoViewController.swift
//  gameplay
//
//  Created by William on 2018/8/18.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
//LennyBasicViewController
class TueijianInfoViewController: BaseController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let cell01 = "cellId01"
    let cell02 = "cellId02"
    
    var dataArray = Array<TueijianContent>()
    var dataModel = TueijianContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        //设置数据源
        self.myTableView.dataSource = self;
        //设置代理
        self.myTableView.delegate = self;
        self.myTableView.register(UINib.init(nibName: "Tueijian01TableViewCell", bundle: nil), forCellReuseIdentifier: cell01)
        self.myTableView.register(UINib.init(nibName: "Tueijian02TableViewCell", bundle: nil), forCellReuseIdentifier: cell02)
        
        
        let headerView:TueijianView = Bundle.main.loadNibNamed("TueijianView", owner: self, options: nil)?.last as! TueijianView
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 57)
        let view01 = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 57))
        view01.addSubview(headerView)
        myTableView?.tableHeaderView = view01
//        myTableView?.tableHeaderView = headerView
        
        let footerView:TueijianFooter = Bundle.main.loadNibNamed("TueijianFooter", owner: self, options: nil)?.last as! TueijianFooter
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 87)
        let view02 = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 87))
        view02.addSubview(footerView)
        myTableView.tableFooterView = view02
//        myTableView.tableFooterView = footerView
    }
    
    func getData()  {
//        let vc =  BaseController()
        request(frontDialog: true, method: .get, loadTextStr: "正在加载...", url:RECOMMAND ) { (resultJson:String, resultStatus:Bool) in
            
            print(resultJson)
            if !resultStatus {
                if resultJson.isEmpty {
                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                }else{
                    showToast(view: self.view, txt: resultJson)
                }
                return
            }
            
            if let result = Tueijain.deserialize(from: resultJson) {
                self.dataArray.removeAll()
                if result.success{
//                    self.dataArray.append(result.content!)
                    
//                    self.dataModel = result.content!
                    let username = result.content?.username!
                    let dataModel = result.content?.data!
                    self.dataModel.username = username
                    self.dataModel.data = dataModel
/*
//                    self.dataModel.accessNum = Model.accessNum
                    self.dataModel.cpRolling = Model.cpRolling
                    self.dataModel.egameRolling = Model.egameRolling
//                    self.dataModel.createTime = Model.createTime
//                    self.dataModel.egameRebate = Model.egameRebate
                    self.dataModel.id =  Model.id
                    self.dataModel.linkKey = Model.linkKey
                    self.dataModel.linkUrl = Model.linkUrl
                    self.dataModel.linkUrlEn = Model.linkUrlEn
                    self.dataModel.rType =  Model.rType
                    self.dataModel.realRolling =  Model.realRolling
                    self.dataModel.sbSportRolling =  Model.sbSportRolling
                    self.dataModel.sportRolling =  Model.sportRolling
//                    self.dataModel.realRebate = Model.realRebate
//                    self.dataModel.registerNum = Model.registerNum
//                    self.dataModel.sbSportRebate = Model.sbSportRebate
//                    self.dataModel.shortUrl1 = Model.shortUrl1
//                    self.dataModel.sportRebate = Model.sportRebate
                    self.dataModel.stationId = Model.stationId
                    self.dataModel.status =  Model.status
                    self.dataModel.type = Model.type
                    self.dataModel.userAccount = Model.userAccount
                    self.dataModel.userId = Model.userId
                    */
                    self.myTableView.reloadData()
                }else{
                    if !isEmptyString(str: result.msg){
                        showToast(view: self.view, txt: result.msg)
                    }else{
                        showToast(view: self.view, txt: "获取失败")
                    }
                    if result.code == 0{
                        loginWhenSessionInvalid(controller: self)
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) ->Int {
        return 9
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) ->UITableViewCell {

            let model = self.dataModel.data
        
            switch indexPath.row {
            case 0:
                let cell2 = tableView.dequeueReusableCell(withIdentifier: cell02, for: indexPath) as! Tueijian02TableViewCell
                cell2.mylabel1.text = "我的用户名:"
                if self.dataModel.username != nil {
                    cell2.mylabel2.text = self.dataModel.username!
                }
                return cell2
            case 1:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: cell01, for: indexPath) as! Tueijian01TableViewCell
                cell1.tueijianAddress.text = "我的推广码:"
                if model?.linkKey != nil{
                    cell1.mytext.text = "\(model!.linkKey!)"
                }
                return cell1
            case 2:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: cell01, for: indexPath) as! Tueijian01TableViewCell
                cell1.tueijianAddress.text = "App链接:"
                if let config = getSystemConfigFromJson(){
                    if config.content != nil{
                        let url = config.content.app_download_link_ios
                        cell1.mytext.text = url
                    }
                }
                return cell1
            case 3:
                 let cell2 = tableView.dequeueReusableCell(withIdentifier: cell02, for: indexPath) as! Tueijian02TableViewCell
                 cell2.mylabel1.text = "彩票返点:"
                 if model?.cpRolling != nil {
                    cell2.mylabel2.text = "一级代理:\(model!.cpRolling!)‰"
                }
                return cell2
            case 4:
                 let cell2 = tableView.dequeueReusableCell(withIdentifier: cell02, for: indexPath) as! Tueijian02TableViewCell
                 cell2.mylabel1.text = "真人返点:"
                if  model?.realRolling != nil {
                    cell2.mylabel2.text = "一级代理:\(model!.realRolling!)‰"
                }
                return cell2
            case 5:
                 let cell2 = tableView.dequeueReusableCell(withIdentifier: cell02, for: indexPath) as! Tueijian02TableViewCell
                 cell2.mylabel1.text = "电子返点:"
                if model?.egameRolling != nil {
                    cell2.mylabel2.text = "一级代理:\(model!.egameRolling!)‰"
                }
                return cell2
            case 6:
                 let cell2 = tableView.dequeueReusableCell(withIdentifier: cell02, for: indexPath) as! Tueijian02TableViewCell
                 cell2.mylabel1.text = "体育返点:"
                if model?.sportRolling != nil {
                    cell2.mylabel2.text = "一级代理:\(model!.sportRolling!)‰"
                }
                return cell2
            case 7:
                 let cell2 = tableView.dequeueReusableCell(withIdentifier: cell02, for: indexPath) as! Tueijian02TableViewCell
                 cell2.mylabel1.text = "沙巴体育返点:"
                if model?.sportRolling != nil {
                    cell2.mylabel2.text = "一级代理:\(model!.sportRolling!)‰"
                }
                return cell2
            case 8:
                let cell2 = tableView.dequeueReusableCell(withIdentifier: cell02, for: indexPath) as! Tueijian02TableViewCell
                cell2.mylabel1.text = "是否可用:"
                var isOr = ""
                if let type = model?.type {
                    isOr = (type == 2 ? "可用" : "不可用")
                }
                cell2.mylabel2.text = isOr
                return cell2
            default:
                return Tueijian01TableViewCell()
            }
    }
    
    //设置Section的表头的高
//    func tableView(_ tableView:UITableView, heightForHeaderInSection section:Int) ->CGFloat {
//        return 70
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 80
//    }
    //设置cell行高
    func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) ->CGFloat {
        return 40
    }
    
}
