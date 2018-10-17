//
//  PeilvTouzhuCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/12.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//赔率版投注cell
class PeilvTouzhuCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,PeilvMoneyInputDelegate {
   
    @IBOutlet weak var tagUI:  UILabel!
    @IBOutlet weak var tableContent:  UICollectionView!
    var peilvData = PeilvData()
    var collectionColumnCount = DEFAULT_COLUMNS
    var currentPlayCode:String = ""
    var cellDelegate:PeilvCellDelegate?
    var cellRow:Int = 0
    var cpCode:String = ""
    var cpVersion:String = ""
    var isPlayBarHidden = false  //左边导航栏是否隐藏
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableContent.delegate = self
        tableContent.dataSource = self
        if let json = getSystemConfigFromJson(){
            if json.content != nil{
                let colorHex = json.content.touzhu_color
                tagUI.backgroundColor = UIColor.init(hexString: colorHex)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func figureTableHeaderItemData(peilvData:PeilvPlayData) -> PeilvPlayData {
        let subData = PeilvPlayData()
        subData.allDatas = peilvData.allDatas
        subData.appendTag = peilvData.appendTag
        subData.checkbox = peilvData.checkbox
        subData.filterSpecialSuffix = peilvData.filterSpecialSuffix
        subData.focusDrawable = peilvData.focusDrawable
        subData.helpNumber = peilvData.helpNumber
        subData.isSelected = peilvData.isSelected
        subData.itemName = peilvData.itemName
        subData.money = peilvData.money
        subData.number = peilvData.number
        subData.peilv = peilvData.peilv
        subData.peilvData = peilvData.peilvData
        return subData
    }
    
    func setupViewAccordingData(peilvData:PeilvData,playPaneIsShow:Bool,playCode:String,row:Int,cpCode:String,
                                cpVersion:String) -> Void {
        
        self.peilvData.appendTag = peilvData.appendTag
        self.peilvData.postTagName = peilvData.postTagName
        self.peilvData.subData = peilvData.subData
        self.peilvData.tagName = peilvData.tagName
        self.currentPlayCode = playCode
        self.cellRow = row
        self.cpCode = cpCode
        self.cpVersion = cpVersion
        
        collectionColumnCount = figureOutColumnCount(peilvData: self.peilvData)
        (tableContent.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: (playPaneIsShow ? (kScreenWidth*0.7 - 1) : (kScreenWidth - kScreenWidth*0.06) - 1)/CGFloat(collectionColumnCount), height: 50)
        (tableContent.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 0
        (tableContent.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 0
        //在显示网格赔率项时需要显示表格头部，这里将添加1-2项PeilvPlayData到数组中，即将数组前面1-2项peilvPlayData当头部
        for index in 0...collectionColumnCount-1{
            if !self.peilvData.subData.isEmpty{
                let data = figureTableHeaderItemData(peilvData: self.peilvData.subData[0])
                self.peilvData.subData.insert(data, at: index)
            }
        }
        self.tableContent.reloadData()
        self.tableContent.collectionViewLayout.invalidateLayout()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.peilvData.subData.count
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peilvCollectionCell", for: indexPath) as! PeilvCollectionViewCell
        
        cell.moneyDelegate = self
        cell.posInListView = cellRow
        cell.posInGridview = indexPath.row
        setupCellectonCellUI(cell: cell, for: indexPath.row,cpCode: self.cpCode,cpVersion: self.cpVersion)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && collectionColumnCount == 1{
            return
        }
        if (indexPath.row == 0 || indexPath.row == 1) && collectionColumnCount == DEFAULT_COLUMNS{
            return
        }
        let cell = self.tableContent.cellForItem(at: indexPath) as! PeilvCollectionViewCell
        let data = self.peilvData.subData[indexPath.row]
        data.isSelected = !data.isSelected
        if data.isSelected {
//            cell.backgroundColor = UIColor.init(red: 249/255, green: 224/255, blue: 224/255, alpha: 1)
            cell.backgroundColor = UIColor.init(hex: 0xABABAB)
        }else{
            cell.backgroundColor = UIColor.white
        }
        if let delegate = self.cellDelegate{
            delegate.onCellSelect(data: data, cellIndex: indexPath.row,row: cellRow,headerColumns:collectionColumnCount,volume:true)
        }
    }
    
    func onMoneyChange(money: String, gridPos: Int, listViewPos: Int) {
        if gridPos == 0 && collectionColumnCount == 1{
            return
        }
        if (gridPos==0 || gridPos == 1) && collectionColumnCount == DEFAULT_COLUMNS{
            return
        }
        let cell = self.tableContent.cellForItem(at: IndexPath.init(row: gridPos, section: 0)) as! PeilvCollectionViewCell
        let data = self.peilvData.subData[gridPos]
        if !isEmptyString(str: money){
            data.isSelected = true
            data.money = Float(money)!
        }else{
            data.isSelected = false
            data.money = Float(0)
        }
        if data.isSelected {
            cell.backgroundColor = UIColor.init(hex: 0xABABAB)
//            cell.backgroundColor = UIColor.init(red: 249/255, green: 224/255, blue: 224/255, alpha: 1)
        }else{
            cell.backgroundColor = UIColor.white
        }
        if let delegate = self.cellDelegate{
            delegate.callAsyncCalcZhushu()
        }
    }
    
    
    func setupCellectonCellUI(cell:PeilvCollectionViewCell,for position:Int,cpCode:String,cpVersion:String) -> Void {
        //如果是前面1-2项，则将显示文字，如”类型”，“号码”，“赔率”
        let subData = self.peilvData.subData[position]
        if (collectionColumnCount == 1 && position == 0)||(collectionColumnCount == 2 && (position == 0||position == 1)){
            cell.updateHeader(data:subData,playCode: currentPlayCode)
        }else{
            for item in cell.subviews{
                item.removeFromSuperview()
            }
            cell.updateContent(data:subData,playCode: currentPlayCode,cpCode:cpCode,cpVersion:cpVersion, isPlayBarHidden:isPlayBarHidden)
        }
    }

}
