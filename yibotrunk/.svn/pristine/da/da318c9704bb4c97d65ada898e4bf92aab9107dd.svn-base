//
//  ActiveController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/12.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher
//优惠活动页
class ActiveController: BaseTableViewController {

    var datas:[ActiveResult] = []
    var showTitle = true
    var showTime = true
    var cellHeightArray = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "优惠活动"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        getActiveTitleShow()
        loadDatas()
    }
    
    private func getActiveTitleShow(){
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let show = config.content.active_title_switch
                if !isEmptyString(str: show) && show == "on"{
                    showTitle = true
                }else{
                    showTitle = false
                }
                let timeShow = config.content.switch_active_deadline_time
                if !isEmptyString(str: timeShow) && timeShow == "on"{
                    showTime = true
                }else{
                    showTime = false
                }
            }
        }
    }
    
    func syncRead(id:Int) -> Void {
        request(frontDialog: false,method: .post,url:SET_ACTIVE_READ_URL,params:["id":id],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "设置已读失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = MessageResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            print("set read status ok")
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "设置已读失败"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.datas[indexPath.row]
        //设置为已读
        if data.readFlag == 0{
            syncRead(id: data.id)
        }
        openActiveDetail(controller: self,title:data.title,content:data.content)
    }
    
    func loadDatas() -> Void {
        request(frontDialog: true,method: .post, loadTextStr:"获取中...",url:ACQUIRE_ACTIVES_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败,请重试"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = ActivesResultWraper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            if let content = result.content{
                                self.datas.removeAll()
                                self.datas = self.datas + content
                                
                                self.cellHeightArray.removeAll()
                                let imageWidth = kScreenWidth - 2 * 10 //活动image的宽度
                                let imageHeight = imageWidth / 6.5
                                print("imageHeight == \(imageHeight)")
                                for _ in 0..<self.datas.count {
//                                    if !self.showTime && !self.showTitle{
//                                        self.cellHeightArray.append((imageHeight))
//                                    }else{
//                                        self.cellHeightArray.append((imageHeight + 46))
//                                    }
                                    self.cellHeightArray.append((imageHeight))
                                }
                                
                                self.tableView.reloadData()
                            }else{
                                showToast(view: self.view, txt: "获取失败")
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败,请重试"))
                            }
                            //超時或被踢时重新登录，因为后台帐号权限拦截抛出的异常返回没有返回code字段
                            //所以此接口当code == 0时表示帐号被踢，或登录超时
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if showTitle || showTime{
//            return 120
//        }
//        return 70
        print("kkkk = \(self.cellHeightArray[indexPath.row])")
        return self.cellHeightArray[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "activeCell") as? ActiveCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }
        let data = self.datas[indexPath.row]
//        cell.activeName.text = data.title
        
        var logoImg = data.titleImgUrl
        if !isEmptyString(str: logoImg){
            if logoImg.contains("\t"){
                let strs = logoImg.components(separatedBy: "\t")
                if strs.count >= 2{
                    logoImg = strs[1]
                }
            }
            logoImg = logoImg.trimmingCharacters(in: .whitespaces)
            if !logoImg.hasPrefix("https://") && !logoImg.hasPrefix("http://"){
                logoImg = String.init(format: "%@/%@", BASE_URL,logoImg)
            }
            let imageURL = URL(string: logoImg)
            if let url = imageURL{
                
                cell.activeImg.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage.init(named: "activeDiscount_default"), options: nil, progressBlock: nil, completionHandler: {
                    image, error, cacheType, imageURL in
                    
                    if let imageP = image {
                        let imageSize = imageP.size
                        let shouldHeight = ((kScreenWidth - 20) * imageSize.height / imageSize.width) + 51
                        
                        if self.cellHeightArray[indexPath.row] != shouldHeight {
                            self.cellHeightArray.remove(at: indexPath.row)
                            self.cellHeightArray.insert(shouldHeight, at: indexPath.row)
                            
                            if (tableView.indexPathsForVisibleRows?.contains(indexPath))! {
                                tableView.reloadRows(at: [IndexPath.init(row: indexPath.row, section: 0)], with: .none)
                            }
                        }
                    }
                    
                })
            }else {
                cell.activeImg.image = UIImage.init(named: "activeDiscount_default")
            }
            
//            if let url = imageURL{
//                cell.activeImg?.contentMode = UIViewContentMode.scaleAspectFit
//                cell.activeImg?.kf.setImage(with: ImageResource(downloadURL: url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
//            }
        }
        
        if self.showTitle{
            cell.activeName.isHidden = false
            cell.activeName.text = data.title
            if data.readFlag == 0{
                cell.activeName.font = UIFont.boldSystemFont(ofSize: 14)
                cell.activeName.textColor = UIColor.black
            }else{
                cell.activeName.font = UIFont.systemFont(ofSize: 14)
                cell.activeName.textColor = UIColor.darkGray
            }
        }else{
            cell.activeName.isHidden = true
        }
        
        if self.showTime{
            cell.activeDuration.isHidden = false
            //            let startTime = timeStampToString(timeStamp: Int64(data.updateTime), format: "MM-dd")
            let endTime = timeStampToString(timeStamp: Int64(data.overTime), format: "yyyy-MM-dd")
            let duration:String = String.init(format: "截止时间:%@", endTime)
            cell.activeDuration.text = duration
        }else{
            cell.activeDuration.isHidden = true
        }
        
        return cell
    }

}
