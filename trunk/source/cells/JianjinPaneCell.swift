//
//  JianjinPaneCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/17.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class JianjinPaneCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var ruleUI:  UIButton!
    @IBOutlet weak var ruleUIConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var weishuView:WeishuFuncView!
    @IBOutlet weak var weishViewConstraint:NSLayoutConstraint!
    @IBOutlet weak var funcView:WeishuFuncView!
    @IBOutlet weak var ballsGridView:UICollectionView!
    
    var cpTypeCode: String = ""
    var playCode: String = ""
    
    var balls:[BallListItemInfo] = []
    var codeRanks:CodeRankModel!
    var isColdHot:Bool = true
    var showCodeRank = true
    weak var  btnsDelegate: CellBtnsDelegate?
    
    var clickPos = -1//the pos user last clicked

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupNoPictureAlphaBgView(view: self)
        self.ballsGridView.delegate = self
        self.ballsGridView.dataSource = self
        bottomLine.theme_backgroundColor = "FrostedGlass.Touzhu.separateLineColor"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillBallons(balls:[BallListItemInfo],codeRank:CodeRankModel,isColdHot:Bool,showCodeRank:Bool=true) -> Void {
        self.balls.removeAll()
        self.balls = self.balls + balls
        self.isColdHot = isColdHot
        self.codeRanks = codeRank
        self.showCodeRank = showCodeRank
        ballsGridView.reloadData()
    }
    
    func fillBallons(balls:[BallListItemInfo],showCodeRank:Bool=false) -> Void {
        self.balls.removeAll()
        self.balls = self.balls + balls
        self.showCodeRank = showCodeRank
        ballsGridView.reloadData()
    }
    
    func fillWeishuViewWithDatas(data:[BallListItemInfo],playRuleShow:Bool) -> Void {
        self.weishuView.setData(array: data,playRuleShow:playRuleShow)
    }
    
    func initFuncView(playRuleShow:Bool) -> Void {
        self.funcView.initData(array: ["全","大","小","单","双","清"],playRuleShow:playRuleShow)
    }
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.balls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: 40, height: 40)
        
        let collectionWidth: CGFloat = collectionView.bounds.size.width
        let num:CGFloat = 5.0
        let height: CGFloat = 44.0
        let value : CGFloat = 1.0
        let width: CGFloat =  collectionWidth / num
        
        let ballsNum = self.balls[indexPath.row].num
//        print(ballsNum)
        
        if ballsNum.length >= 3 {
            var strWidth = String.getStringWidth(str: ballsNum, strFont: CGFloat(20.0), h: 30) + 10
            if width >  strWidth {strWidth = width}
            return CGSize.init(width: strWidth, height: height)
        }
        
//        if indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 10{
//            let realWidth = collectionWidth - floor(width) * (num - ((CGFloat)1.0))
        if indexPath.row % 5 == 0 {
            let realWidth = collectionWidth - floor(width) * (num - value)
            return CGSize.init(width: realWidth, height: height)
        }else {
            return CGSize.init(width: floor(width), height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ballCell", for: indexPath) as! PaneBallCell
        
        let ballData = self.balls[indexPath.row]
        let num = self.balls[indexPath.row].num
        if self.showCodeRank{
            if self.codeRanks != nil{
                if indexPath.row < codeRanks.CodeNums.count{
                    let data = self.codeRanks.CodeNums[indexPath.row]
                    if data.Code == Int(num){
                        cell.codeRankUI.isHidden = false
                        if self.isColdHot{
                            cell.codeRankUI.text = String(data.AC)
                        }else{
                            cell.codeRankUI.text = data.MC
                        }
                    }else{
                        cell.codeRankUI.isHidden = true
                    }
                }else{
                    cell.codeRankUI.isHidden = true
                }
            }else{
                cell.codeRankUI.isHidden = true
            }
        }else{
            cell.codeRankUI.isHidden = true
        }
        
        if isSpeicalOfficalBall(playCode: playCode, lotType: cpTypeCode) || cpTypeCode == "4"{
            if ballData.isSelected {
                cell.rectAngleBtn.theme_backgroundColor = "Global.themeColor"
                cell.rectAngleBtn.setTitleColor(UIColor.white, for: .normal)
            }else{
                cell.rectAngleBtn.theme_backgroundColor = "TouzhOffical.rectangleBtnLightColor"
                cell.rectAngleBtn.setTitleColor(UIColor.init(hexString: "#7a7a7a"), for: .normal)
            }
            cell.rectAngleBtn.layer.cornerRadius = 3
            cell.ballBtn.isHidden = true
            cell.rectAngleBtn.isHidden = false
            cell.rectAngleBtn.setTitle(self.balls[indexPath.row].num, for: .normal)
            
            cell.contentView.layer.borderWidth = 0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
        }else{
            if ballData.isSelected {
//                cell.ballBtn.setBackgroundImage(UIImage(named: "ballDark_red"), for: .normal)
                cell.ballBtn.setBackgroundImage(UIImage(named: "ballDarkSelected_red"), for: .normal)
                cell.ballBtn.setTitleColor(UIColor.white, for: .normal)
            }else{
                cell.ballBtn.setBackgroundImage(UIImage(named: "betBallNotSeleted_all"), for: .normal)
                cell.ballBtn.setTitleColor(UIColor.init(hexString: "#7a7a7a"), for: .normal)
            }
            cell.ballBtn.isHidden = false
            cell.rectAngleBtn.isHidden = true
            cell.ballBtn.setTitle(self.balls[indexPath.row].num, for: .normal)
            
            cell.contentView.layer.borderWidth = 0.35
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = ballsGridView.cellForItem(at: indexPath) as! PaneBallCell
        let ballData = self.balls[indexPath.row]
        ballData.isSelected = !ballData.isSelected
        
        if isSpeicalOfficalBall(playCode: playCode, lotType: cpTypeCode) || cpTypeCode == "4"{
            if ballData.isSelected {
                cell.rectAngleBtn.theme_backgroundColor = "Global.themeColor"
            }else{
                cell.rectAngleBtn.theme_backgroundColor = "TouzhOffical.rectangleBtnLightColor"
            }
        }else{
            if ballData.isSelected {
//                cell.ballBtn.setBackgroundImage(UIImage(named: "ballDark_red"), for: .normal)
                cell.ballBtn.setBackgroundImage(UIImage(named: "ballDarkSelected_red"), for: .normal)
                cell.ballBtn.setTitleColor(UIColor.white, for: .normal)
            }else{
                cell.ballBtn.setBackgroundImage(UIImage(named: "betBallNotSeleted_all"), for: .normal)
                cell.ballBtn.setTitleColor(UIColor.init(hexString: "#7a7a7a"), for: .normal)
            }
        }
        btnsDelegate?.onNumBallClickCallback(number: ballData.num, cellPos: indexPath.row)
    }
    
    func toggleWeishuView(show:Bool) -> Void {
        if !show{
            weishuView.isHidden = true
            weishViewConstraint.constant = -30
        }else{
            weishuView.isHidden = false
            weishViewConstraint.constant = 30
        }
    }
    
    //返回button所在的UITableViewCell
    func superUITableViewCell(of:UIButton) -> UITableViewCell? {
        for view in sequence(first: of.superview, next: {$0?.superview}){
            if let cell = view as? JianjinPaneCell{
                return cell
            }
        }
        return nil
    }
    
    func onButtonClick(sender:UIButton) -> Void{
        print("on func click,tag =\(sender.tag)")
        let cell = superUITableViewCell(of: sender) as? JianjinPaneCell
        let table = cell?.superview as! UITableView
        let index = table.indexPath(for: cell!)
        btnsDelegate?.onBtnsClickCallback(btnTag: sender.tag, cellPos: (index?.row)!)
        
    }
}
