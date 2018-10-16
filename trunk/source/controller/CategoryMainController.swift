//
//  CategoryMainController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/25.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

//分组模式的主界面
//type-type2
let countPerLineOfTableView = 3
let heightOfTableView:CGFloat = 121
let subCollectionViewHeight:CGFloat = 150

class CategoryMainController: BaseController {
    
    @IBOutlet weak var tableView:UITableView!
    var gameDatas:[LotteryData] = []
    let tableview_identifier = "groupCell"
    var tempGroupData:LotteryData?
    var tempIndexpath:IndexPath?
    var viewIndex:Int = 0

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViewBackgroundColorTransparent(view: tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
//        self.tableView.separatorColor = UIColor.white.withAlphaComponent(0)
//        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 1.5, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print("sub main page appear ---")
    }
    
    func reload(){
        self.tableView.reloadData()
    }
    
}

extension CategoryMainController : UITableViewDelegate,UITableViewDataSource,GroupTableCellItemViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var line = gameDatas.count/countPerLineOfTableView
        if gameDatas.count % countPerLineOfTableView != 0{
            line = line + 1
        }
        return line
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //type-type2
//        return twoCellsStyleFactory(tableView: tableView, cellForRowAt: indexPath)
        return threeCellsStyleFactory(tableView: tableView, cellForRowAt: indexPath)
    }
    
    //- -
    // 把方法 “func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell”中的body单独拿出来
    // 写两个方法，一个返回 GroupMainTableCell，一个返回 GroupMainTableStyleTwoCell
    func twoCellsStyleFactory(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableview_identifier) as? GroupMainTableCell  else {
            fatalError("The dequeued cell is not an instance of GroupMainTableCell.")
        }
        cell.bingDelegate(delegate: self)
        var selectdViewIndex = -1
        for index in 0...countPerLineOfTableView{
            let dataIndex = indexPath.row*countPerLineOfTableView + index
            if dataIndex < self.gameDatas.count{
                let data = self.gameDatas[dataIndex]
                if data.needShowSecondClassification{
                    selectdViewIndex = index
                }
            }
        }
        print("the select index = ",selectdViewIndex)
        if selectdViewIndex >= 0{
            self.configSelectedCell(cell: cell, indexPath: indexPath, selectedIndex: selectdViewIndex)
            if selectdViewIndex == 0{
                cell.leftItemView.icon_sjx.isHidden = false
                cell.rightItemView.icon_sjx.isHidden = true
            }else if selectdViewIndex == 1{
                cell.leftItemView.icon_sjx.isHidden = true
                cell.rightItemView.icon_sjx.isHidden = false
            }
        }else{
            //            self.configNormalCell(cell: cell, indexPath: indexPath)
            cell.leftItemView.icon_sjx.isHidden = true
            cell.rightItemView.icon_sjx.isHidden = true
        }
        
        cell.selectionStyle = .none
        for index in 0...countPerLineOfTableView-1{
            let rowIndex = indexPath.row * countPerLineOfTableView + index
            if rowIndex < self.gameDatas.count{
                let data = self.gameDatas[rowIndex]
                cell.updateViewPerLine(viewIndex: index, lottery: data)
            }else{
                cell.updateViewPerLine(viewIndex: index, lottery: nil)
            }
        }
        return cell
    }
    
    
    func threeCellsStyleFactory(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableview_identifier) as? GroupMainTableStyleTwoCell else {
            fatalError("The dequeued cell is not an instance of GroupMainTableStyleTwoCell.")
        }
        cell.bingDelegate(delegate: self)
        var selectdViewIndex = -1
        for index in 0...countPerLineOfTableView{
            let dataIndex = indexPath.row*countPerLineOfTableView + index
            if dataIndex < self.gameDatas.count{
                let data = self.gameDatas[dataIndex]
                if data.needShowSecondClassification{
                    selectdViewIndex = index
                }
            }
        }
        print("the select index = ",selectdViewIndex)
        if selectdViewIndex >= 0{
            self.configSelectedCell(cell: cell, indexPath: indexPath, selectedIndex: selectdViewIndex)
//            if selectdViewIndex == 0{
//                cell.leftItemView.icon_sjx.isHidden = false
//                cell.rightItemView.icon_sjx.isHidden = true
//            }else if selectdViewIndex == 1{
//                cell.leftItemView.icon_sjx.isHidden = true
//                cell.rightItemView.icon_sjx.isHidden = false
//            }
            if selectdViewIndex == 0{
                cell.leftItemView.icon_sjx.isHidden = false
                cell.middleItemView.icon_sjx.isHidden = true
                cell.rightItemView.icon_sjx.isHidden = true
            }else if selectdViewIndex == 1{
                cell.middleItemView.icon_sjx.isHidden = false
                cell.leftItemView.icon_sjx.isHidden = true
                cell.rightItemView.icon_sjx.isHidden = true
            }else if selectdViewIndex == 2{
                cell.rightItemView.icon_sjx.isHidden = false
                cell.leftItemView.icon_sjx.isHidden = true
                cell.middleItemView.icon_sjx.isHidden = true
            }
        }else{
            //            self.configNormalCell(cell: cell, indexPath: indexPath)
            cell.leftItemView.icon_sjx.isHidden = true
            cell.middleItemView.icon_sjx.isHighlighted = true
            cell.rightItemView.icon_sjx.isHidden = true
        }
        
        cell.selectionStyle = .none
        for index in 0...countPerLineOfTableView-1{
            let rowIndex = indexPath.row * countPerLineOfTableView + index
            if rowIndex < self.gameDatas.count{
                let data = self.gameDatas[rowIndex]
                cell.updateViewPerLine(viewIndex: index, lottery: data)
            }else{
                cell.updateViewPerLine(viewIndex: index, lottery: nil)
            }
        }
        
        return cell
    }
    
    
    func configSelectedCell(cell:GroupMainTableCell,indexPath:IndexPath,selectedIndex:Int){
        
        // 给CollectionView加载对应的数据  selectedIndex传的是具体的 0 1 2哪一个被点击了
        let idx = indexPath.row * countPerLineOfTableView + selectedIndex;
        let data = self.gameDatas[idx];
        cell.secondDatas = data.subData;
        cell.collectionView.reloadData()
    }
    
    func configSelectedCell(cell:GroupMainTableStyleTwoCell,indexPath:IndexPath,selectedIndex:Int){
        
        // 给CollectionView加载对应的数据  selectedIndex传的是具体的 0 1 2哪一个被点击了
        let idx = indexPath.row * countPerLineOfTableView + selectedIndex;
        let data = self.gameDatas[idx];
        cell.secondDatas = data.subData;
        cell.collectionView.reloadData()
    }
    
    func configNormalCell(cell:GroupMainTableCell,indexPath:IndexPath){
        
    }
    
    func configNormalCell(cell:GroupMainTableStyleTwoCell,indexPath:IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let index = indexPath.row * countPerLineOfTableView + self.viewIndex;
        if index >= self.gameDatas.count{
            return heightOfTableView
        }
        let groupData = self.gameDatas[index];
        if groupData.needShowSecondClassification{
            var columns = 3
            let count = groupData.subData.count
            if count <= 3{
                columns = count
            }else if count > 3{
                columns = 4
            }
            let a = groupData.subData.count / columns
            let collectionHeight = groupData.subData.count % columns == 0 ? a : a + 1
            let totalHeight = CGFloat(collectionHeight*(80+32))
            return heightOfTableView + totalHeight
        }
        return heightOfTableView
    }
    
    func onSubLotClick(lottery: LotteryData) {
        
        if !YiboPreference.getLoginStatus() {
            loginWhenSessionInvalid(controller: self)
            return
        }
        
        let touzhuController = UIStoryboard(name: "touzh_page",bundle:nil).instantiateViewController(withIdentifier: "touzhu")
        let touzhuPage = touzhuController as! TouzhController
        touzhuPage.lotData = lottery
        self.navigationController?.pushViewController(touzhuPage, animated: true)
    }
    
    func onGroupTableItemViewClick(categoryNormalTableViewCell: GroupMainTableCell, viewIndex: NSInteger) {
        
        // 获取到那个Indexpath
        let indexpath = self.tableView.indexPath(for: categoryNormalTableViewCell)
        if let ip = indexpath{
            // 获取到数组里面的第几个
            let index = ip.row * countPerLineOfTableView + viewIndex;
            print("点击了 ==== ",index)
            // 获取对象
            if index >= self.gameDatas.count{
                return
            }
            let groupData = self.gameDatas[index];
            // 修改字段
            // 点击同一个
            if (self.tempGroupData?.code == groupData.code){
                groupData.needShowSecondClassification = !groupData.needShowSecondClassification;
            }else{
                groupData.needShowSecondClassification = true;
            }
            
            // 点击的每一次事件，都要让上一次存储的对象的需要展开变为NO
            if (self.tempGroupData != nil){
                // 如果是同一行的情况下
                if (ip.row  == self.tempIndexpath?.row)
                {
                    // 如果是同一个产品
                    if (self.tempGroupData?.code == groupData.code)
                    {
                        
                        
                    }else // 不同一个产品
                    {
                        self.tempGroupData?.needShowSecondClassification = false;
                    }
                    self.tempIndexpath = indexpath;
                    self.viewIndex = viewIndex
                    self.tempGroupData = groupData;
                    self.tableView.reloadRows(at: [ip], with: .automatic)
                    return;
                    
                }
                else // 不是同一行的时候
                {
                    self.tempGroupData?.needShowSecondClassification = false;
                    self.tableView.reloadRows(at: [ip], with: .automatic)
                }
            }
            self.tempIndexpath = indexpath;
            self.viewIndex = viewIndex
            self.tempGroupData = groupData;
            self.tableView.reloadRows(at: [ip], with: .automatic)
            self.tableView.scrollToRow(at: ip, at: .top, animated: true)
        }
    }
    
    func onGroupTableItemViewClick(categoryNormalTableViewTypeTwoCell: GroupMainTableStyleTwoCell, viewIndex: NSInteger) {
        
        // 获取到那个Indexpath
        let indexpath = self.tableView.indexPath(for: categoryNormalTableViewTypeTwoCell)
        if let ip = indexpath{
            // 获取到数组里面的第几个
            let index = ip.row * countPerLineOfTableView + viewIndex;
            print("点击了 ==== ",index)
            // 获取对象
            if index >= self.gameDatas.count{
                return
            }
            let groupData = self.gameDatas[index];
            // 修改字段
            // 点击同一个
            if (self.tempGroupData?.code == groupData.code){
                groupData.needShowSecondClassification = !groupData.needShowSecondClassification;
            }else{
                groupData.needShowSecondClassification = true;
            }
            
            // 点击的每一次事件，都要让上一次存储的对象的需要展开变为NO
            if (self.tempGroupData != nil){
                // 如果是同一行的情况下
                if (ip.row  == self.tempIndexpath?.row)
                {
                    // 如果是同一个产品
                    if (self.tempGroupData?.code == groupData.code)
                    {
                        
                        
                    }else // 不同一个产品
                    {
                        self.tempGroupData?.needShowSecondClassification = false;
                    }
                    self.tempIndexpath = indexpath;
                    self.viewIndex = viewIndex
                    self.tempGroupData = groupData;
                    self.tableView.reloadRows(at: [ip], with: .automatic)
                    return;
                    
                }
                else // 不是同一行的时候
                {
                    self.tempGroupData?.needShowSecondClassification = false;
                    self.tableView.reloadRows(at: [ip], with: .automatic)
                }
            }
            self.tempIndexpath = indexpath;
            self.viewIndex = viewIndex
            self.tempGroupData = groupData;
            self.tableView.reloadRows(at: [ip], with: .automatic)
            self.tableView.scrollToRow(at: ip, at: .top, animated: true)
        }
    }
    
}
