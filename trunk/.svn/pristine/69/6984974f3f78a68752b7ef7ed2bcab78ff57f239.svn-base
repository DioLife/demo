//
//  LotInfoListCell.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/21.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

class LotInfoListCell: UITableViewCell {
    
    
    
    @IBOutlet weak var limitLeftestSwparateLine: UIView!
    @IBOutlet weak var limitLeftSeparateLine: UIView!
    @IBOutlet weak var limitRightSeparateLine: UIView!
    @IBOutlet weak var leftestSeparateLine: UIView!
    @IBOutlet weak var rightSeparateLine: UIView!
    @IBOutlet weak var leftSeparateLine: UIView!
    @IBOutlet weak var bigRuleTV:UILabel!
    @IBOutlet weak var smallRuleTableView:UITableView!
    @IBOutlet weak var topMoneyTableView:UITableView!
    @IBOutlet weak var fanshuiTableView:UITableView!
    var smallRules:[String] = []
    var awards:[String] = []
    var ratebacks:[String] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupNoPictureAlphaBgView(view: self)
        
        setThemeLabelTextColorGlassBlackOtherDarkGray(label: bigRuleTV)
        
        if let leftSeparateLineP = leftSeparateLine {
            setThemeViewColorGlassWhiteOtherGray(view: leftSeparateLineP)
            setThemeViewColorGlassWhiteOtherGray(view: rightSeparateLine)
            setThemeViewColorGlassWhiteOtherGray(view: leftestSeparateLine)
        }
        
        if let limitLeftSeparateLineP = limitLeftSeparateLine {
            setThemeViewColorGlassWhiteOtherGray(view: limitLeftSeparateLineP)
            setThemeViewColorGlassWhiteOtherGray(view: limitRightSeparateLine)
            setThemeViewColorGlassWhiteOtherGray(view: limitLeftestSwparateLine)
        }
        
        smallRuleTableView.isScrollEnabled = false
        smallRuleTableView.tag = 101
        topMoneyTableView.isScrollEnabled = false
        topMoneyTableView.tag = 102
        fanshuiTableView.isScrollEnabled = false
        fanshuiTableView.tag = 103
        
        smallRuleTableView.delegate = self
        smallRuleTableView.dataSource = self
        topMoneyTableView.delegate = self
        topMoneyTableView.dataSource = self
        fanshuiTableView.delegate = self
        fanshuiTableView.dataSource = self
        
    }
    
    func setMode(limitPlay:PlayInfoBean?){
        if let mplay = limitPlay{
            bigRuleTV.text = mplay.name
            
            self.smallRules.removeAll()
            self.awards.removeAll()
            self.ratebacks.removeAll()
            
            smallRules.append(String.init(format: "%d", mplay.minBetAmount))
            awards.append(String.init(format: "%d", mplay.maxBetAmount))
            ratebacks.append(String.init(format: "%d", mplay.playMaxBetAmount))
        }
        smallRuleTableView.reloadData()
        topMoneyTableView.reloadData()
        fanshuiTableView.reloadData()
    }

    func setModel(play:PlayInfoBean?){
        if let mplay = play{
            bigRuleTV.text = mplay.name//大玩法名称
            if let subPlays = mplay.data{
                if !subPlays.isEmpty{
                    self.smallRules.removeAll()
                    self.awards.removeAll()
                    self.ratebacks.removeAll()
                    for item in subPlays{
                        smallRules.append(item.numName!)
                        let p = "\(item.maxOdds)"
                        awards.append(p)
                        if let kb = item.kickback{
                            ratebacks.append(kb)
                        }
                    }
                }
            }
        }
        smallRuleTableView.reloadData()
        topMoneyTableView.reloadData()
        fanshuiTableView.reloadData()
    }
}

extension LotInfoListCell:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101{
            return self.smallRules.count
        }else if tableView.tag == 102{
            return self.awards.count
        }else if tableView.tag == 103{
            return self.ratebacks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "lot") as? LotInfoListSmallCell  else {
            fatalError("The dequeued cell is not an instance of LotInfoListSmallCell.")
        }
        cell.selectionStyle = .none
        if tableView.tag == 101{
            cell.mytext.text = self.smallRules[indexPath.row]
        }else if tableView.tag == 102{
            cell.mytext.text = self.awards[indexPath.row]
        }else if tableView.tag == 103{
            cell.mytext.text = self.ratebacks[indexPath.row]
        }
        return cell
    }
    
}
