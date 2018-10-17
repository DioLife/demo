//
//  GameListController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/24.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class SportListViewController: BaseController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collections:UICollectionView!
    var datas = [LotteryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "体育列表"
        collections.delegate = self
        collections.dataSource = self
        collections.register(OtherPageCell.self, forCellWithReuseIdentifier: "gameListCell")
        collections.showsVerticalScrollIndicator = false
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: ( kScreenWidth-2-0.5*6)/3, height: 150)
        //设置横向间距
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 0.5
        //设置纵向间距-行间距
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 1
        self.collections.reloadData()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameListCell", for: indexPath) as! OtherPageCell
        let data = self.datas[indexPath.row]
        if !isEmptyString(str: data.name!) {
            cell.titleLabel?.text = data.name!
        }else{
            cell.titleLabel?.text = "暂无名称"
        }
        let imgUrl = BASE_URL + PORT + data.imgUrl
        if isEmptyString(str: imgUrl){
            return cell
        }
        let uRL = URL(string: imgUrl)
        if let url = uRL{
            downloadImage(url: url, imageUI: cell.imgView!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lotData = self.datas[indexPath.row]
        if lotData.czCode == "hgty"{
            let vc = UIStoryboard(name: "sport_page", bundle:nil).instantiateViewController(withIdentifier: "sport")
            let sport = vc as! SportController
            self.navigationController?.pushViewController(sport, animated: true)
        }else if lotData.czCode == "sbty"{
            requestSbSportUrl()
        }
    }
    
    
    func requestSbSportUrl(){
        request(frontDialog: true,method: .post, loadTextStr:"正在跳转...", url:SPSPORT_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = SBSportForwardWrapper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.content){
                                openBrower(urlString: result.content)
                            }else{
                                showToast(view: self.view, txt: "没有链接，无法打开")
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                                if result.msg == "超时" || result.msg == "登录"{
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取跳转链接失败"))
                            }
                        }
                    }
        })
    }
    
}
