//
//  SportHeader.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class NewSportHeader: UIView {
    
    var timeUI:UILabel!
    var leagueUI:UILabel!
    var indictor:UIImageView!
    var headerSection = 0
    
    var sportHeaderDelegate:NewSportHeaderDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeUI = UILabel.init(frame: CGRect.init(x: 10, y: (self.bounds.height)/2-10, width: 40, height: 20))
        timeUI.textColor = UIColor.lightGray
        timeUI.font = UIFont.systemFont(ofSize: 14)
        leagueUI = UILabel.init(frame: CGRect.init(x: 60, y: (self.bounds.height)/2-10, width: self.bounds.width - 60-32, height: 20))
        leagueUI.textColor = UIColor.lightGray
        leagueUI.font = UIFont.systemFont(ofSize: 14)
        indictor = UIImageView.init(frame: CGRect.init(x: self.bounds.width - 22, y: (self.bounds.height)/2-6, width: 18, height:12))
        let line = UIView.init(frame: CGRect.init(x: 0, y: self.bounds.height-0.5, width: self.bounds.width, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        self.addSubview(timeUI)
        self.addSubview(leagueUI)
        self.addSubview(indictor)
        self.addSubview(line)
        
        setThemeLabelTextColorGlassWhiteOtherGray(label: timeUI)
        setThemeLabelTextColorGlassWhiteOtherGray(label: leagueUI)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onHeaderClickEvent(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func setupSection(section:Int) -> Void {
        self.headerSection = section
    }
    
    func updateIndictor(expand:Bool) -> Void {
        if expand{
            indictor.image = UIImage.init(named: "pushup")
        }else{
            indictor.image = UIImage.init(named: "pulldown")
        }
    }
    
    @objc func onHeaderClickEvent(_ recongnizer: UIPanGestureRecognizer) {
        if let delegate = self.sportHeaderDelegate{
            delegate.onHeaderClick(section: headerSection)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
