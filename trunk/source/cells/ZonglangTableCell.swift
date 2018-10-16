//
//  ZonglangTableCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/8/7.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

//个人或团队总览
class ZonglangTableCell: UITableViewCell ,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var txtBgView: UIView!
    @IBOutlet weak var txt:UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    var data:[GerenOverviewBean] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setThemeLabelTextColorGlassWhiteOtherBlack(label: txt)
        setThemeViewNoTransparentDefaultGlassBlackOtherGray(view: txtBgView)
        collectionView.delegate = self
        collectionView.dataSource = self
        setViewBackgroundColorTransparent(view: collectionView)
        collectionView.register(GerenOverViewCell.self, forCellWithReuseIdentifier:"gerenCell")
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func setDatas(data:[GerenOverviewBean],label:String){
        txt.text = label
        self.data.removeAll()
        self.data = self.data + data
        collectionView.reloadData()
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (kScreenWidth-0.5*6)/3, height: 80)
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gerenCell", for: indexPath) as! GerenOverViewCell
        let data = self.data[indexPath.row]
        cell.setupData(data: data)
        return cell
    }

}
