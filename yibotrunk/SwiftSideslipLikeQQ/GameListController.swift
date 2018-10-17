//
//  GameListController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/24.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class GameListController: BaseController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collections:UICollectionView!
    var datas = [GameItemResult]()
    var gameCode = ""
    var myTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = !isEmptyString(str: myTitle) ? myTitle : "游戏列表"
        collections.delegate = self
        collections.dataSource = self
        collections.register(OtherPageCell.self, forCellWithReuseIdentifier: "gameListCell")
        collections.showsVerticalScrollIndicator = false
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: ( kScreenWidth-2-0.5*6)/3, height: 150)
        //设置横向间距
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 0.5
        //设置纵向间距-行间距
        (collections.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 1
        loadData(code: gameCode)
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
        if !isEmptyString(str: data.DisplayName) {
            cell.titleLabel?.text = data.DisplayName
        }else{
            cell.titleLabel?.text = "暂无名称"
        }
        let imgPath = data.ButtonImagePath
        //彩种的图地址是根据彩种编码号为姓名构成的
        var imgUrl = ""
        if self.gameCode == "mg"{
            imgUrl = BASE_URL + PORT + "/common/template/third/egame/images/v2/" +
            imgPath + ".png"
        }else if self.gameCode == "pt"{
            imgUrl = BASE_URL + PORT + "/common/template/third/newEgame/images/" +
                imgPath
        }else if self.gameCode == "nb"{
            imgUrl = BASE_URL + PORT + "/common/template/third/newEgame/images/" + imgPath
        }else if self.gameCode == "qt"{
            imgUrl = BASE_URL + PORT + "/common/template/third/newEgame/images/" +
            imgPath
        }else if self.gameCode == "kyqp"{
            imgUrl = BASE_URL + PORT + "/common/template/third/kyChess/images/" +
            imgPath
        }
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
        forwardGame(controller: self, playCode: gameCode, gameCodeOrID: lotData.LapisId)
    }
    
    func loadData(code:String) {
        
        do{
            var path:String?
            if self.gameCode == "mg"{
                path = Bundle.main.path(forResource: "mg", ofType: "json")
            }else if self.gameCode == "pt"{
                path = Bundle.main.path(forResource: "pt", ofType: "json")
            }else if self.gameCode == "nb"{
                path = Bundle.main.path(forResource: "nb", ofType: "json")
            }else if self.gameCode == "qt"{
                path = Bundle.main.path(forResource: "qt", ofType: "json")
            }else if self.gameCode == "kyqp"{
                path = Bundle.main.path(forResource: "kyqp", ofType: "json")
            }
            if let pathValue = path{
                //2 获取json文件里面的内容,NSData格式
                let jsonData = NSData.init(contentsOfFile: pathValue)
                //3 解析json内容
                let json = try JSONSerialization.jsonObject(with: jsonData! as Data, options:[]) as! [AnyObject]
                self.datas.removeAll()
                for item in json{
                    let buttonImagePath = item["ButtonImagePath"] as! String
                    let displayName = item["DisplayName"] as! String
                    var typeid = 0
                    if gameCode == "nb" || gameCode == "qt" || gameCode == "kyqp"{
                        if let tid = item["typeid"]{
                            if tid != nil{
                                let value = tid as! String
                                if !isEmptyString(str: value){
                                    typeid = Int(value)!
                                }
                            }
                        }
                    }else{
                        typeid = item["typeid"] as! Int
                    }
                    let lapisId = item["LapisId"] as! String
                    print("json = \(displayName)")
                    let result = GameItemResult()
                    result.ButtonImagePath = buttonImagePath
                    result.DisplayName = displayName
                    result.typeid = typeid
                    result.LapisId = lapisId
                    self.datas.append(result)
                }
            }
            
            self.collections.reloadData()
            self.collections.collectionViewLayout.invalidateLayout()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        
    }

}
