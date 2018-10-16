//
//  MarqueeView.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

protocol MarqueeDelegate {
    func onDelegate()
}

class MarqueeView: UIView {
    private var marqueeTitle:String?
    
    var marqueeType: JXMarqueeType?
    private let marqueeView = JXMarqueeView()
    var delegate:MarqueeDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    func setupView(title:String,htmlTxt:Bool = false,txtColor:UIColor = UIColor.darkGray) -> Void {

        marqueeTitle = "\(title)"
        self.clipsToBounds = true
        let lab = UILabel()
        lab.frame = CGRect.zero
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        if htmlTxt{
            do{
                let attrStr = try NSAttributedString.init(data: marqueeTitle!.description.data(using: String.Encoding.unicode)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                lab.attributedText = attrStr
            }catch{
                print(error)
            }
        }else{
            let labWidth = String.getStringWidth(str: marqueeTitle!, strFont: 14, h: 29)
            //        let spaceStr = String(repeating: "&#x2007", count: 5)
            let spaceStr = String(repeating: " ", count: 5)
            if labWidth < self.width {
                let count = Int(self.width / labWidth + 1)
                for _ in 0..<count {
                    marqueeTitle = marqueeTitle! + spaceStr + marqueeTitle!
                }
            }
            
            lab.text = marqueeTitle
        }
        
        marqueeView.frame = CGRect(x:0, y:0, width: self.width, height: self.height)
        marqueeView.contentView = lab
        marqueeView.backgroundColor = UIColor.clear
        marqueeView.contentMargin = 50
        marqueeView.marqueeType = .left
        self.addSubview(marqueeView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onMarClick))
        self.addGestureRecognizer(tap)
    }
    
    @objc func onMarClick() -> Void {
        if let delegate = self.delegate{
            delegate.onDelegate()
        }
    }
}
