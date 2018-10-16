//
//  OtherPageController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/24.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class OtherPageController: BaseController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collections:UICollectionView!
    var datas = [OtherPlay]()
    var isRealPerson = false
    var code = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isRealPerson ? "真人" : "电子"
        collections.delegate = self
        collections.dataSource = self
        collections!.register(OtherPageCell.self, forCellWithReuseIdentifier:"otherPageCell")
        collections.showsVerticalScrollIndicator = false
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: ( kScreenWidth-2-0.5*6)/3, height: 150)
        //设置横向间距
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 0.5
        //设置纵向间距-行间距
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 1
        loadData(code: code)
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherPageCell", for: indexPath) as! OtherPageCell
        if !isEmptyString(str: self.datas[indexPath.row].title) {
            cell.titleLabel?.text = self.datas[indexPath.row].title
        }else{
            cell.titleLabel?.text = "暂无名称"
        }
        
        let imgUrl = self.datas[indexPath.row].imgUrl
        if !isEmptyString(str: imgUrl) {
            let imageURL = URL(string: BASE_URL + PORT + imgUrl)
            if let url = imageURL{
                downloadImage(url: url, imageUI: cell.imgView!)
            }
        }else{
            var defaultIcon = UIImage.init(named: "icon_ft")
            if self.code == SPORT_MODULE_CODE {
                defaultIcon = UIImage.init(named: "icon_ft")
            } else if self.code == REAL_MODULE_CODE {
                defaultIcon = UIImage.init(named: "icon_real")
            } else if self.code == GAME_MODULE_CODE {
                defaultIcon = UIImage.init(named: "icon_game")
            }
            cell.imgView?.image = defaultIcon
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lotData = self.datas[indexPath.row]
        let dCode = lotData.dataCode
        if dCode == SPORT_MODULE_CODE{
            if lotData.playCode == "hgty"{
//                actionSport(item.getTitle());
            }
        }else if dCode == REAL_MODULE_CODE{
            forwardReal(controller: self, requestCode: 0, playCode: lotData.playCode)
        }else if dCode == GAME_MODULE_CODE{
            forwardGame(playCode: lotData.playCode)
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
        print("url === \(url)")
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
                                        //html内容需要自定义浏览器访问，暂时先调用外部浏览器。
                                        openBrower(urlString: result.html)
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
    
    func loadData(code:Int) {
        request(frontDialog: true, loadTextStr:"获取中...", url:GET_OTHER_PLAY_DATA,
                params:["code":code],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = OtherPlayWrapper.deserialize(from: resultJson){
                        if result.success{
                            if let lotterysValue = result.content{
                                self.datas.removeAll()
                                self.datas = self.datas + lotterysValue
                                self.collections.reloadData()
                            }
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
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
        })
    }
}
