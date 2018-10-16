//
//  GroupMainTableCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/26.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Kingfisher

class GroupMainTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupNoPictureAlphaBgView(view: leftItemView)
        setupNoPictureAlphaBgView(view: rightItemView)
    }
    
    let identyfy = "SecondCategoryCollectionViewCell"
    var delegate:GroupTableCellItemViewDelegate?
    
    @IBOutlet weak var leftItemView:GroupTableCellItemView!
    @IBOutlet weak var rightItemView:GroupTableCellItemView!
    @IBOutlet weak var collectionView:UICollectionView!
    
    var secondDatas:[LotteryData] = []
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func bingDelegate(delegate:GroupTableCellItemViewDelegate?){
        leftItemView.viewDelegate = delegate
        rightItemView.viewDelegate = delegate
        self.delegate = delegate
        leftItemView.cell = self
        rightItemView.cell = self
        leftItemView.viewIndexOfTableCell = 0
        rightItemView.viewIndexOfTableCell = 1
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
    }
    
    func upateLotImage(imageview:UIImageView,groupLotCode:String,lotteryIcon: String){
        if isEmptyString(str: lotteryIcon) {
            let imageURL = URL(string: BASE_URL + PORT + "/native/resources/images/" + groupLotCode + ".png")
            if let url = imageURL{
                imageview.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }else {
            if let url = URL(string: lotteryIcon) {
                imageview.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "default_lottery"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    func updateViewPerLine(viewIndex:Int,lottery:LotteryData?){
        if countPerLineOfTableView == 0{
            return
        }
        if let data = lottery{
            if let code = data.code{
                let lotteryIcon = data.lotteryIcon
                if viewIndex == 0{
                    upateLotImage(imageview: leftItemView.grouLotImage, groupLotCode: code, lotteryIcon: lotteryIcon)
                    leftItemView.labelTV.text = data.name
                    leftItemView.indictor.isHidden = false
                    leftItemView.twoTagLeftImg.isHidden = false
                    if String(data.lotVersion) == VERSION_2{
                        leftItemView.twoTagLeftImg.image = UIImage(named: "homeCreditTag")
                    }else{
                        leftItemView.twoTagLeftImg.image = UIImage(named: "homeOfficalTag")
                    }
                }else if viewIndex == 1{
                    upateLotImage(imageview: rightItemView.grouLotImage, groupLotCode: code, lotteryIcon: lotteryIcon)
                    rightItemView.labelTV.text = data.name
                    rightItemView.indictor.isHidden = false
                    rightItemView.twoTagRightImg.isHidden = false
                    if String(data.lotVersion) == VERSION_2{
                        rightItemView.twoTagRightImg.image = UIImage(named: "homeCreditTag")
                    }else{
                        rightItemView.twoTagRightImg.image = UIImage(named: "homeOfficalTag")
                    }
                }
            }
        }else{
            if viewIndex == 0{
                leftItemView.grouLotImage.image = nil
                leftItemView.indictor.image = nil
                leftItemView.twoTagLeftImg = nil
                leftItemView.labelTV.text = ""
            }else if viewIndex == 1{
                rightItemView.grouLotImage.image = nil
                rightItemView.indictor.image = nil
                rightItemView.twoTagRightImg = nil
                rightItemView.labelTV.text = ""
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func subLotColumns() ->Int{
        var columns = 3
        let count = self.secondDatas.count
        if count <= 3{
            columns = count
        }else if count > 3{
            columns = 4
        }
        return columns
    }

}

extension GroupMainTableCell: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (kScreenWidth - 24 * 2 - 8 * 3) / CGFloat(subLotColumns());
        return CGSize.init(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 16, left: 24, bottom: 16, right: 24)
    }
    
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secondDatas.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identyfy, for: indexPath) as! SecondCategoryCollectionViewCell
        let data = self.secondDatas[indexPath.row]
        if let code = data.code{
            upateLotImage(imageview: cell.img, groupLotCode: code, lotteryIcon: data.lotteryIcon)
        }
        cell.txt.text = data.name!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = self.delegate{
            let lottery = self.secondDatas[indexPath.row]
            delegate.onSubLotClick(lottery: lottery)
        }
    }
    
    
}
