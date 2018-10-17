//
//  GamePageChildController.swift
//  YiboGameIos
//
//  Created by admin on 2018/7/2.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class GamePageChildController: BaseController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    var bindShakeDelegate:EnterTouzhuDelegate?
    
    var lastContentOffset: CGFloat = 0.0
    
    var gameDatas = [LotteryData]()
    var allGameDatas = [LotteryData]()
    
    var dataCode = CAIPIAO_MODULE_CODE
    
    @IBOutlet weak var gridview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridview.delegate = self
        gridview.dataSource = self
        gridview.register(CPViewCell.self, forCellWithReuseIdentifier:"cell")
        gridview.showsVerticalScrollIndicator = false
        
        loadGameDatas()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.post(name:NSNotification.Name(rawValue: "childViewWillDisappear"),
                                        object: nil,
                                        userInfo:["message":0])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;

        if (self.lastContentOffset > scrollView.contentOffset.y) {
            //正在向下滚动
            if offsetY <= 0 {
                self.gridview.isScrollEnabled = false

                NotificationCenter.default.post(name:NSNotification.Name(rawValue: "collectionOffetYChange"),
                                                object: nil,
                                                userInfo:["message":0])
            }else {}
            
        } else if (self.lastContentOffset < scrollView.contentOffset.y) {
            //正在向上滚动
        }
        
        self.lastContentOffset = scrollView.contentOffset.y;
    }
    
    @objc func changeDataSource(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            // message用于 过滤数据
            let message  = userInfo["message"] as? Int else {
                 print("No userInfo found in notification")
                return
        }
        
        self.gameDatas .removeAll()

        for model in self.allGameDatas {
            if model.moduleCode == message {
                self.gameDatas.append(model)
            }
        }

        gridview.reloadData()
    }
    
    //加载彩种等所有数据
    func loadGameDatas() {
        request(frontDialog: true, loadTextStr:"获取中...", url:ALL_GAME_DATA_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LotterysWraper.deserialize(from: resultJson){
                        if result.success{
                            if let lotterysValue = result.content{
                                
                                self.allGameDatas.removeAll()
                                self.allGameDatas = self.allGameDatas + lotterysValue
                                
                                self.gameDatas .removeAll()
                                
                                for model in self.allGameDatas {
                                    if model.moduleCode == self.dataCode {
                                        self.gameDatas.append(model)
                                    }
                                }
                            }
                            
                            if let token = result.accessToken{
                                YiboPreference.setToken(value: token as AnyObject)
                            }
                            //save system config to user default
                            YiboPreference.saveLotterys(value: resultJson as AnyObject)
                            //更新scrollview的contentSize大小
                            //                            self.updateScrollHeight()
                            self.gridview.reloadData()
                        }else{
                            if let errorMsg = result.msg{
                                showToast(view: self.view, txt: errorMsg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CPViewCell
        
        cell.backgroundColor = UIColor.white
        cell.titleLabel?.backgroundColor = UIColor.white
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: (kScreenWidth-0.5*6)/3, height: 130)
        
        cell.sizeToFit()
        
        if let lotName = self.gameDatas[indexPath.row].name{
            cell.titleLabel?.text = lotName
        }else{
            cell.titleLabel?.text = "暂无名称"
        }
        let data = self.gameDatas[indexPath.row]
        if data.moduleCode == CAIPIAO_MODULE_CODE{
            guard let lotCode = data.code else {
                cell.imgView?.image = UIImage(named: "default_lottery")
                return cell
            }
            // set lottery picture
            let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + lotCode + ".png")
            // YD 这里报错 ，ImageResource 未定义
            cell.imgView?.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            let imgUrl = data.imgUrl
            if !isEmptyString(str: imgUrl) {
                let imageURL = URL(string: BASE_URL + PORT + imgUrl)
                if let url = imageURL{
                    downloadImage(url: url, imageUI: cell.imgView!)
                }
            }else{
                var defaultIcon = UIImage.init(named: "icon_ft")
                if data.moduleCode == SPORT_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_ft")
                } else if data.moduleCode == REAL_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_real")
                } else if data.moduleCode == GAME_MODULE_CODE {
                    defaultIcon = UIImage.init(named: "icon_game")
                }
                cell.imgView?.image = defaultIcon
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lotData = self.gameDatas[indexPath.row]
        print("click pos = ",indexPath.row)
        let data = self.gameDatas[indexPath.row]
        if data.moduleCode == CAIPIAO_MODULE_CODE{
            guard let code = lotData.code else {return}
            syncLotteryPlaysByCode(controller: self, lotteryCode: code, shakeDelegate: self.bindShakeDelegate)
        }else{
            guard let dCode = lotData.czCode else {return}
            if lotData.moduleCode == SPORT_MODULE_CODE{
                if dCode == "hgty"{
                    let vc = UIStoryboard(name: "sport_page", bundle:nil).instantiateViewController(withIdentifier: "sport")
                    let sport = vc as! SportController
                    self.navigationController?.pushViewController(sport, animated: true)
                }
            }else if lotData.moduleCode == REAL_MODULE_CODE{
                forwardReal(controller: self, requestCode: 0, playCode: dCode)
            }else if lotData.moduleCode == GAME_MODULE_CODE{
                forwardGame(playCode: dCode)
            }
        }
    }
    
    //获取电子游戏转发数据
    func forwardGame(playCode:String) -> Void {
        var url = ""
        var params:Dictionary<String,AnyObject> = [:]
        if playCode == "ag"{
            url = url + REAL_AG_URL
            params["h5"] = 0 as AnyObject
            params["gameType"] = 6 as AnyObject
        }else if playCode == "mg" || playCode == "pt"{
            //MG,PT电子是先在自已应用内部展示游戏列表，点列表项再请求数据
            actionOpenGameList(controller: self,gameCode: playCode,title: playCode == "mg" ? "MG电子游戏" : "PT电子游戏")
        }else if playCode == "qt"{//BBIN真人娱乐
            showToast(view: self.view, txt: "即将开放")
            return;
        }
        request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:url,
                params: params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = RealPlayWraper.deserialize(from: resultJson){
                        if result.success{
                            //AG,MG,AB,OG,DS都返回跳转链接
                            //BBIN 返回的是一段html内容
                            if !isEmptyString(str: result.url){
                                openBrower(urlString: result.url)
                            }else if !isEmptyString(str: result.html){
                                openBBINDetail(controller: self, content: result.html)
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                                if result.msg == "超时" || result.msg == "其他"{
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                            }
                        }
                    }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
