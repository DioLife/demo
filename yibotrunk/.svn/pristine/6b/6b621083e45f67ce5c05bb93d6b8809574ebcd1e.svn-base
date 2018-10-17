//
//  GameCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//每场赛事子单元表格cell
class GameCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var gameTime:UILabel!
    @IBOutlet weak var scoreUI:UILabel!
    @IBOutlet weak var qiuDuiUI:UILabel!
    @IBOutlet weak var tableHeader:SportTableHeader!
    @IBOutlet weak var gameView:UICollectionView!
    var gameDatas:[SportBean] = []
    var sportItemDelegate:SportGameItemDelegate?
    var columns:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gameView.delegate = self
        gameView.dataSource = self
        gameView.showsVerticalScrollIndicator = false
        
//        let headerMaskPath = UIBezierPath(roundedRect: tableHeader.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: 10, height: 10))
//        let headerLayer = CAShapeLayer()
//        headerLayer.frame = tableHeader.bounds
//        headerLayer.path = headerMaskPath.cgPath
//        tableHeader.layer.mask = headerLayer
        
        gameView.layer.borderColor = UIColor.lightGray.cgColor
        gameView.layer.borderWidth = 0.5
        
    }
    

    func setupDataAndReload(datas:[SportBean],columns:Int) -> Void {
        self.gameDatas = datas
        self.columns = columns
        //设置横向间距
        (gameView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 0.5
//        //设置纵向间距-行间距
        (gameView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 1
        gameView.reloadData()
        self.gameView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = kScreenWidth - 40
        var height = 50
        let gameData = self.gameDatas[indexPath.row]
        if gameData.isHeader{
            height = 30
        }
        return CGSize.init(width: Int((width)/CGFloat(columns)), height: height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = sportItemDelegate{
            delegate.onGameItemClick(sport: self.gameDatas[indexPath.row])
        }
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCollectionCell", for: indexPath) as! GameCollectionCell
        let gameData = self.gameDatas[indexPath.row]
        if gameData.isHeader{
            cell.backgroundColor = UIColor.init(hex: 0xC8A670)
            cell.peilvUI.textColor = UIColor.black
        }else{
            cell.backgroundColor = UIColor.white
            cell.peilvUI.font = UIFont.boldSystemFont(ofSize: 14)
        }
        var peilv = gameData.peilv
        let txt = gameData.txt
        var showTxt = ""
        if !isEmptyString(str: peilv){
            let peilvFloat = Float(peilv);
            peilv = String.init(format: "%.2f", peilvFloat!)
        }
        if !isEmptyString(str: txt) && !isEmptyString(str: peilv){
            showTxt = String.init(format: "%@\n%@", txt,peilv)
            cell.peilvUI.textColor = UIColor.red
        }else if isEmptyString(str: txt) && !isEmptyString(str: peilv){
            showTxt = peilv
            cell.peilvUI.textColor = UIColor.red
        }else if !isEmptyString(str: txt) && isEmptyString(str: peilv){
            showTxt = txt
            cell.peilvUI.textColor = UIColor.black
        }else if isEmptyString(str: txt) && isEmptyString(str: peilv){
            showTxt = ""
            cell.peilvUI.textColor = UIColor.black
        }
        if gameData.fakeItem {
            cell.peilvUI.textColor = UIColor.black
            cell.peilvUI.font = UIFont.systemFont(ofSize: 14)
        }
        cell.peilvUI.text = showTxt
        return cell
    }
}
