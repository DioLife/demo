//
//  JianjinPaneCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2017/12/17.
//  Copyright © 2017年 com.lvwenhan. All rights reserved.
//

import UIKit

class JianjinPaneCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var ruleUI:  UIButton!
    @IBOutlet weak var weishuView:WeishuFuncView!
    @IBOutlet weak var weishViewConstraint:NSLayoutConstraint!
    @IBOutlet weak var funcView:WeishuFuncView!
    @IBOutlet weak var ballsGridView:UICollectionView!
    
    var balls:[BallListItemInfo] = []
    weak var  btnsDelegate: CellBtnsDelegate?
    
    var clickPos = -1//the pos user last clicked
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ballsGridView.delegate = self
        self.ballsGridView.dataSource = self
        if let json = getSystemConfigFromJson(){
            if json.content != nil{
                let colorHex = json.content.touzhu_color
                weishuView.backgroundColor = UIColor.init(hexString: colorHex)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillBallons(balls:[BallListItemInfo]) -> Void {
        self.balls.removeAll()
        self.balls = self.balls + balls
        ballsGridView.reloadData()
        self.ballsGridView.collectionViewLayout.invalidateLayout()
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
        return CGSize.init(width: 40, height: 40)
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ballCell", for: indexPath) as! PaneBallCell
        cell.ballBtn.setTitle(self.balls[indexPath.row].num, for: .normal)
        let ballData = self.balls[indexPath.row]
        if ballData.isSelected {
            cell.ballBtn.setBackgroundImage(UIImage.init(named: "BetRedBall"), for: .normal)
            cell.ballBtn.setTitleColor(UIColor.white, for: .normal)
        }else{
            cell.ballBtn.setBackgroundImage(UIImage.init(named: "BetGrayBall"), for: .normal)
            cell.ballBtn.setTitleColor(UIColor.init(red: 49/255, green: 141/255, blue: 250/255, alpha: 1), for: .normal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = ballsGridView.cellForItem(at: indexPath) as! PaneBallCell
        let ballData = self.balls[indexPath.row]
        ballData.isSelected = !ballData.isSelected
        if ballData.isSelected {
            cell.ballBtn.setBackgroundImage(UIImage.init(named: "BetRedBall"), for: .normal)
            cell.ballBtn.setTitleColor(UIColor.white, for: .normal)
        }else{
            cell.ballBtn.setBackgroundImage(UIImage.init(named: "BetGrayBall"), for: .normal)
            cell.ballBtn.setTitleColor(UIColor.init(red: 49/255, green: 141/255, blue: 250/255, alpha: 1), for: .normal)
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
