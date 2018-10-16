//
//  PeilvTouzhuCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/12.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
//赔率版投注cell
class PeilvTouzhuCell: UITableViewCell,PeilvMoneyInputDelegate {
   
    
    @IBOutlet weak var tagBottomLine: UIView!
    @IBOutlet weak var tagUI:  UILabel!
    @IBOutlet weak var tagUIHeightConstant:NSLayoutConstraint!
    @IBOutlet weak var tableContent:  UICollectionView!
    @IBOutlet weak var tableListViewContent:  UITableView!
    var currentPlayCode:String = ""
    var cellDelegate:PeilvCellDelegate?
    var cellRow:Int = 0
    var is_fast_bet_mode = true
    var is_play_bar_show = true
    var data:BcLotteryPlay?
    var cpCode:String = ""
    var lotCode:String = ""
    var cpVerison:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        tableContent.delegate = self
        tableContent.dataSource = self
        tableContent.backgroundColor = UIColor.white.withAlphaComponent(0)
        tableListViewContent.delegate = self
        tableListViewContent.dataSource = self
        tableListViewContent.separatorColor = UIColor.init(hex: 0x0184C15)
        tableListViewContent.isScrollEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupData(data:BcLotteryPlay,mode:Bool,specialMode:Bool,
                   cpCode:String,cpVerison:String,lotCode:String) -> Void{
        
        self.cpCode = cpCode
        self.cpVerison = cpVerison
        self.is_fast_bet_mode = mode
        self.lotCode = lotCode
        self.data = data
        tagUI.text = data.name
        tagUI.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        tagBottomLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
        
        if specialMode{
            tableListViewContent.isHidden = false
            tableContent.isHidden = true
            tableListViewContent.reloadData()
        }else{
            tableListViewContent.isHidden = true
            tableContent.isHidden = false
            tableContent.reloadData()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func onMoneyChange(money: String, gridPos: Int, listViewPos: Int) {
        let cell = self.tableContent.cellForItem(at: IndexPath.init(row: gridPos, section: 0)) as! PeilvCollectionViewCell
        let data = self.data?.peilvs[gridPos]
        if !isEmptyString(str: money){
            data?.isSelected = true
            //定位crash
            data?.inputMoney = Float(money)!
        }else{
            data?.isSelected = false
            data?.inputMoney = Float(0)
        }
//        //Shaw-NOTYET 点击选中的颜色,已测，未用到
        if (data?.isSelected)! {
//            cell.backgroundColor = UIColor.init(hex: 0xA9A9A9)
//            cell.backgroundColor = UIColor.white.withAlphaComponent(1)
            cell.theme_backgroundColor = "TouzhOffical.betSelectedCellColor"
        }else{
//            cell.backgroundColor = UIColor.init(hex: 0x3B945C)
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        }
        
        if let delegate = self.cellDelegate{
            delegate.callAsyncCalcZhushu(data: data!, cellIndex: gridPos,row: listViewPos,volume:false)
        }
    }
    
    
    func setupCellectonCellUI(cell:PeilvCollectionViewCell,for position:Int) -> Void {
//        if position > (self.data?.peilvs.count)! - 1 {
//            return
//        }
        let subData = self.data?.peilvs[position]
        cell.setupData(data: subData,mode:is_fast_bet_mode,lotCode: self.lotCode,lotType: self.cpCode)
    }

}

extension PeilvTouzhuCell : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataP = self.data {
            return dataP.peilvs.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "peilv_cell") as? PeilvTableCell  else {
            fatalError("The dequeued cell is not an instance of PeilvTableCell.")
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if (self.data?.peilvs.count)! > 0{
            if indexPath.row > (self.data?.peilvs.count)!-1{
                return cell
            }
            let data = self.data?.peilvs[indexPath.row]
            if let mdata = data{
                cell.setupData(data: data,cpCode: self.cpCode,cpVersion: self.cpVerison,num: mdata.helpNumber)
            }
        }
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PeilvTableCell
        let data = self.data?.peilvs[indexPath.row]
        data?.isSelected = !(data?.isSelected)!
        if let name = self.data?.name{
            data?.itemName = name
        }
        
        if (data?.isSelected)! {
            cell.theme_backgroundColor = "TouzhOffical.betSelectedCellColor"
        }else{
            cell.backgroundColor = UIColor.white.withAlphaComponent(0)
        }
        
        if let delegate = self.cellDelegate{
            delegate.onCellSelect(data: data!, cellIndex: indexPath.row,row: cellRow,volume:true)
        }
    }
    
}

extension PeilvTouzhuCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("PeilvTouzhuCell.count.第 \(section)组的个数: \((self.data?.peilvs.count)!)")
        return (self.data?.peilvs.count)!
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peilvCollectionCell", for: indexPath) as! PeilvCollectionViewCell
        
        let data = self.data?.peilvs[indexPath.row]
        cell.moneyDelegate = self
        cell.posInListView = cellRow
        cell.posInGridview = indexPath.row
        
        cell.topLine.isHidden = true
//        if (indexPath.row % 2 == 0)   {
////            cell.rightLine.isHidden = true
//            cell.leftLine.isHidden = true
//        }
        
        if (data?.isSelected)! {
//            cell.backgroundColor = UIColor.white.withAlphaComponent(1)
            cell.theme_backgroundColor = "TouzhOffical.betSelectedCellColor"
        }else{
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        }
        setupCellectonCellUI(cell: cell, for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth: CGFloat = collectionView.bounds.size.width
        let num:CGFloat = 2.0
        let value : CGFloat = 1.0
        let width: CGFloat =  collectionWidth / num
        
        if (indexPath.row % 2 == 0)   {
            if indexPath.row != (self.data?.peilvs.count)! - 1 {
                let realWidth = collectionWidth - floor(width) * (num - value)
                return CGSize.init(width: realWidth, height: is_fast_bet_mode ? 46 : 75)
            }else {
                return CGSize.init(width: collectionWidth, height: is_fast_bet_mode ? 46 : 75)
            }
            
        }else {
            return CGSize.init(width: floor(width), height: is_fast_bet_mode ? 46 : 75)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.tableContent.cellForItem(at: indexPath) as! PeilvCollectionViewCell
//        cell.layer.borderWidth = 0.5
//        cell.layer.theme_borderColor = "TouzhOffical.betSelectedCellColor"
        
        let data = self.data?.peilvs[indexPath.row]
        data?.isSelected = !(data?.isSelected)!
        if (data?.isSelected)! {
//            cell.backgroundColor = UIColor.white.withAlphaComponent(1)
            cell.theme_backgroundColor = "TouzhOffical.betSelectedCellColor"
        }else{
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        }
        
        cell.numberLabelTV.textColor = UIColor.black
        cell.peilvTV.textColor = UIColor.black
        cell.peilvTV.textColor = UIColor.black
        
        if let name = self.data?.name{
            data?.itemName = name
        }
        if let delegate = self.cellDelegate{
            delegate.onCellSelect(data: data!, cellIndex: indexPath.row,row: cellRow,volume:true)
        }
    }

}
