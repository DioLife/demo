//
//  TitlePopWindow.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

protocol CaiPiaoTitleDelegate {
    func onCaiPiaoClick(data:LotteryData?)
}

/**
 * 投注页点击标题弹出菜种框
 */
class TitlePopWindow: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var _shareViewBackground :UIView!
    var _window             :UIWindow!
    
    var cpDelegate:CaiPiaoTitleDelegate?
    var globalData:[LotteryData] = []
    var lotCode = ""

    override func awakeFromNib() {
        if _shareViewBackground == nil{
            _shareViewBackground = UIView.init(frame: UIScreen.main.bounds)
            _shareViewBackground.backgroundColor = UIColor.clear
            _shareViewBackground.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismiss)))
        }
        
//        (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: ( kScreenWidth-2-0.5*6)/3, height: 35)
//        //设置横向间距
//        (self.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 0.5
        //设置纵向间距-行间距
        (self.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 5
        
        self.delegate = self
        self.dataSource = self
        let nib = UINib(nibName: "title_pop_cell", bundle: nil) //nibName指的是我们创建的Cell文件名
        self.register(nib, forCellWithReuseIdentifier: "titlePopCell")
        self.globalData = getLotteryDatas()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth - 16)/4, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TitlePopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "titlePopCell", for: indexPath) as! TitlePopCell
        let data = self.globalData[indexPath.row]
        cell.setTextView(title: data.name!)
        cell.updateBorder(selected: self.lotCode == data.code)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss()
        if let delegate = self.cpDelegate{
            delegate.onCaiPiaoClick(data: self.globalData[indexPath.row])
        }
        self.globalData.removeAll()
    }
    
    func show(lotCode:String) {
        
        self.frame = CGRect.init(x:0, y:44+22, width:Int(kScreenWidth), height:Int(kScreenHeight/2))
        _window = UIWindow.init(frame: UIScreen.main.bounds)
        _window.windowLevel = UIWindowLevelAlert+1
        _window.backgroundColor = UIColor.clear
        _window.isHidden = true
        _window.isUserInteractionEnabled = true
        _window.addSubview(_shareViewBackground)
        _window.addSubview(self)
        _window.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.2)
        })
        self.lotCode = lotCode
        self.reloadData()
    }
    
    func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self._shareViewBackground.backgroundColor = UIColor.init(white: 0.0, alpha: 0.0)
        }) { (finished) in
            self._window = nil
        }
    }
    
    func dismiss() {
        hidden()
    }
    
    func getLotteryDatas() -> [LotteryData] {
        //获取存储在本地preference中的彩种信息
        let lotterysJson = YiboPreference.getLotterys()
        var mdatas = [LotteryData]()
        if !isEmptyString(str: lotterysJson){
            if let lotWraper = JSONDeserializer<LotterysWraper>.deserializeFrom(json: lotterysJson) { // 从字符串转换为对象实例
                if lotWraper.success{
                    let datas = lotWraper.content
                    if let datasValue = datas{
                        for info in datasValue{
                            if info.moduleCode == 3{
                                mdatas.append(info)
                            }
                        }
                    }
                }
            }
        }
        return mdatas
    }

}
