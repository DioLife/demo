//
//  ActiveController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/12.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher
import MJRefresh
//优惠活动页
class ActiveController: BaseMainController,UITableViewDelegate,UITableViewDataSource{

    var datas:[ActiveResult] = []
    var isAttachInTabBar = true
    var cellHeightArray = [CGFloat]()
    @IBOutlet weak var tableView:UITableView!
    
    let refreshHeader = MJRefreshNormalHeader()
    let refreshFooter = MJRefreshBackNormalFooter()
    
    //MARK: - 刷新
    private func setupRefreshView() {
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.tableView.mj_header = refreshHeader
        self.tableView.mj_footer = refreshFooter
    }
    
    @objc fileprivate func headerRefresh() {
        
        self.tableView.mj_header.endRefreshing(completionBlock: {
            
        })
    }
    
    @objc fileprivate func footerRefresh() {
        
        self.tableView.mj_footer.endRefreshing(completionBlock: {
        
        })
        
    }
    
    //MARK: -生命周期
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        self.navigationItem.title = "优惠活动"
        
        if !isAttachInTabBar{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        }
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//        setupRefreshView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.adjustRightBtn()
        
        if datas.count == 0 {
            loadDatas()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        if !isAttachInTabBar{
            tableView.frame  = CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64)
        }else {
            if #available(iOS 11, *) {} else {
                tableView.frame  = CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight - 64 - 49)
            }
        }
    }
    
    override func adjustRightBtn() -> Void {
        if !isAttachInTabBar{
            self.navigationItem.rightBarButtonItems?.removeAll()
            return
        }
        super.adjustRightBtn()
        if YiboPreference.getLoginStatus(){
            self.navigationItem.rightBarButtonItems?.removeAll()
            let menuBtn = UIBarButtonItem.init(image: UIImage.init(named: "icon_menu"), style: .plain, target: self, action: #selector(BaseMainController.actionMenu))
            self.navigationItem.rightBarButtonItems = [menuBtn]
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
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.datas[indexPath.row]
        //设置为已读
        if data.readFlag == 0{
            syncRead(id: data.id)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
                                let imageWidth = screenWidth - 2 * 10 //活动image的宽度
                                let imageHeight = imageWidth / 6.5
                                for _ in 0..<self.datas.count {
                                    self.cellHeightArray.append((imageHeight + 46))
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeightArray[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "activeCell") as? ActiveCell  else {
            fatalError("The dequeued cell is not an instance of JianjinPaneCell.")
        }

//        var a:Dictionary<String,AnyObject> = [:]
        
        
        let data = self.datas[indexPath.row]
        cell.activeName.text = data.title
        //            let startTime = timeStampToString(timeStamp: Int64(data.updateTime), format: "MM-dd")
        let endTime = timeStampToString(timeStamp: Int64(data.overTime), format: "yyyy-MM-dd")
        let duration:String = String.init(format: "截止时间:%@", endTime)
        cell.activeDuration.text = duration
     
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
                        let shouldHeight = ((screenWidth - 20) * imageSize.height / imageSize.width) + 46
                        
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
        }else {
            cell.activeImg.image = UIImage.init(named: "activeDiscount_default")
        }
        return cell
    }

}
