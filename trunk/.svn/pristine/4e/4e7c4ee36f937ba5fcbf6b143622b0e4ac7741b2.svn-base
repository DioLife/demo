//
//  LZDHeader.swift
//  MyGTMRefresh
//
//  Created by William on 2018/7/25.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit
import GTMRefresh
import Kingfisher

//protocol LZDDelegate:NSObjectProtocol {
//    //设置协议方法
//    func jumpToNext(value:VisitRecords)
//}

class LZDHeader: GTMRefreshHeader, SubGTMRefreshHeaderProtocol, UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate {

//    weak var delegate:LZDDelegate?
    private var longPress:UILongPressGestureRecognizer!
    private var deleteBtn:UIButton!
    
    var layout:UICollectionViewFlowLayout!
    var collectionView:UICollectionView!
    var dataArray:[VisitRecords]!
    
    var resultData = Array<VisitRecords>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getData()
        setUp()
    }
    
    func updateData() {
        getData()
    }
    
    func getData() {
        resultData.removeAll()//先清空数组
        let jsonStr:String = YiboPreference.getLotterys()
        let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false)
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
//            print("json:\n",json)
            let dic = json as! NSDictionary //转化成字典
            let arr = dic["content"] as! NSArray // 取出里面的数组
            for item in arr { //遍历数组中的字典
                //                print(item)
                let dict = item as! NSDictionary
                if dict["subData"] != nil { //json 中有子类 subData
                    //                    print("success")
                    let arr2 = dict["subData"] as! Array<NSDictionary>
//                    resultData.removeAll()//先清空数组
                    for vv in arr2{
                        let record:VisitRecords = VisitRecords()
                        record.cpName = vv["name"] as? String //名字
                        let value:Int = vv["lotType"] as! Int
                        record.czCode = String(value) //类型
                        record.ago = "0" // 时间差 传默认值
                        record.cpBianHao = vv["code"] as? String //编号
                        record.lotType = String(value) //类型
                        let v2:Int = vv["lotVersion"] as! Int
                        record.lotVersion = String(v2) //版本
                        record.num = "1"
                        record.icon = vv["lotteryIcon"] as? String
                        
                        resultData.append(record)
                    }
                }
                
            }
        } catch {
            print("error:\t",error)
        }
        
        for item in self.resultData {
            if item.icon != nil{
                print(item.cpName!,"\t\t\t",item.czCode!,"\t",item.ago!,"\t",
                      item.cpBianHao!,"\t",item.lotType!,"\t",
                      item.lotVersion!,"\t\t\t\t",item.num!,"\t\t\ticon:",item.icon!)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUp() {
        dataArray = Array()
        
        layout = UICollectionViewFlowLayout()

        collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width:frame.width, height: 80), collectionViewLayout: layout)
//        print(self.center)
        collectionView.center.y = self.center.y
        contentView.addSubview(collectionView)
        
        setupNoPictureAlphaBgView(view: contentView)
        
        deleteBtn = UIButton()
        deleteBtn.titleLabel?.text = "删除"
        deleteBtn.backgroundColor = UIColor.yellow
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = CGSize(width:90,height:80)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal //水平滚动
        
        
        setViewBackgroundColorTransparent(view: collectionView)
        collectionView.showsHorizontalScrollIndicator = false //是否展示下划线
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HotCell.self, forCellWithReuseIdentifier:"HotCell")
        
        //绑定对长按的响应
        longPress =  UILongPressGestureRecognizer(target:self,action:#selector(tableviewCellLongPressed(gestureRecognizer:)))
        //代理
        longPress.delegate = self
        longPress.minimumPressDuration = 1.0
        //将长按手势添加到需要实现长按操作的视图里
//        collectionView.addGestureRecognizer(longPress)
    }
    
    //单元格长按事件响应
    @objc func tableviewCellLongPressed(gestureRecognizer:UILongPressGestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerState.ended){//长按结束时触发
            print("UIGestureRecognizerStateEnded");
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataArray!.count + 1)
    }
    
    //自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotCell", for: indexPath) as! HotCell
        if self.dataArray.count == 0 {
            cell.imageView.image = UIImage.init(named: "moreicon")
            cell.label.text = "添加常玩游戏"
        }else{
            if indexPath.row == self.dataArray.count {
                cell.imageView.image = UIImage.init(named: "moreicon")
                cell.label.text = "添加常玩游戏"
            } else{
                if self.dataArray[indexPath.row].lotVersion == "1" {
                    cell.label.text = self.dataArray[indexPath.row].cpName! + "[官]"
                }else if self.dataArray[indexPath.row].lotVersion == "2" {
                    cell.label.text = self.dataArray[indexPath.row].cpName! + "[信]"
                }

                let lotCode = self.dataArray[indexPath.row].cpBianHao!
                var imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + lotCode + ".png")
//                if self.dataArray[indexPath.row].icon != nil && self.dataArray[indexPath.row].icon != "" {//如果有,优先以icon作为图片地址
//                    imageURL = URL(string: self.dataArray[indexPath.row].icon!)
//                }
                let icon = compare(cpBianHao: lotCode, lotVersion: self.dataArray[indexPath.row].lotVersion!)
                if  icon != "" {
                    imageURL = URL(string: icon)
                }
                cell.imageView.kf.setImage(with: ImageResource(downloadURL: imageURL!), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        return cell
    }
    
    func compare(cpBianHao:String, lotVersion:String) -> String {
        for item in self.resultData {
//            print("cpBianHao:",item.cpBianHao!,"\t\tlotVersion:",item.lotVersion!)
            if cpBianHao == item.cpBianHao! && lotVersion == item.lotVersion! { // && item.lotVersion == lotVersion
                if item.icon != nil && item.icon != ""  {
                    return item.icon!
                }
            }
        }
        return ""
    }

    
    @objc func deleteCell(gestureRecognizer:UILongPressGestureRecognizer) {
        print((gestureRecognizer.view?.tag)!)
        let indexPath = IndexPath(row: (gestureRecognizer.view?.tag)!, section: 0)
        let cell = self.collectionView.cellForItem(at: indexPath)
//        setViewBackgroundColorTransparent(view: cell)
        
        deleteBtn.tag = (gestureRecognizer.view?.tag)!
        cell?.addSubview(deleteBtn)
        deleteBtn.whc_Top(0)
        deleteBtn.whc_Right(0)
        deleteBtn.whc_Width(10)
        deleteBtn.whc_Width(10)
        deleteBtn.addTarget(self, action: #selector(execDeleteCell(btn:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc func execDeleteCell(btn:UIButton){
        print(btn.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("go didSelectItemAt collectionView")
        //执行协议
        if self.dataArray.count == 0 {
            let record = VisitRecords()
            record.cpName = "nodata"
//            delegate?.jumpToNext(value: record)
            NotificationCenter.default.post(name: NSNotification.Name("commonUseRecord"), object: self, userInfo: ["value":record])
        }else{
            if indexPath.row == self.dataArray.count {
                let record = VisitRecords()
                record.cpName = "nodata"
//                delegate?.jumpToNext(value: record)
                NotificationCenter.default.post(name: NSNotification.Name("commonUseRecord"), object: self, userInfo: ["value":record])
            }else{
//                delegate?.jumpToNext(value: self.dataArray[indexPath.row])
                NotificationCenter.default.post(name: NSNotification.Name("commonUseRecord"), object: self, userInfo: ["value":self.dataArray[indexPath.row]])
            }
        }
    }
    
    
    func contentHeight()->CGFloat{
        return frame.height
    }
    
}
