//
//  SportHeader.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/22.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit


protocol MenuLineHeaderDelegate {
    func onHeaderClick(section:Int)
}

class MenuLineHeader: UIView {
    
    var imgTV:UIImageView!
    var labelTV:UILabel!
    var indictor:UIImageView!
    var headerSection = 0
    
    var headerDelegate:MenuLineHeaderDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        imgTV = UIImageView.init(frame: CGRect.init(x: 10, y: (self.bounds.height)/2-10, width: 20, height: 20))
        labelTV = UILabel.init(frame: CGRect.init(x: 40, y: (self.bounds.height)/2-10, width: self.bounds.width - 40, height: 20))
        labelTV.font = UIFont.systemFont(ofSize: 14)
        
        indictor = UIImageView.init(frame: CGRect.init(x: self.bounds.width - 40, y: (self.bounds.height)/2-2, width: 7, height:4))
        indictor.image = UIImage.init(named: "arrow_down")
        let line = UIView.init(frame: CGRect.init(x: 0, y: self.bounds.height-0.5, width: self.bounds.width, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        self.addSubview(imgTV)
        self.addSubview(labelTV)
        self.addSubview(indictor)
        self.addSubview(line)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onHeaderClickEvent(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func setupSection(section:Int) -> Void {
        self.headerSection = section
    }
    
    func updateIndictor(expand:Bool) -> Void {
        if expand{
            indictor.image = UIImage.init(named: "arrow_up")
        }else{
            indictor.image = UIImage.init(named: "arrow_down")
        }
    }
    
    @objc func onHeaderClickEvent(_ recongnizer: UIPanGestureRecognizer) {
        if let delegate = self.headerDelegate{
            delegate.onHeaderClick(section: headerSection)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
