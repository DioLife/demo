//
//  PlayRuleController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/6.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class PlayRuleController: UIViewController {
    
    @IBOutlet weak var playIntroduce:UITextView!
    @IBOutlet weak var touzhIntroduce:UITextView!
    @IBOutlet weak var winDemo:UITextView!
    
    var playRule:String?
    var touzhuTxt:String?
    var winDemoTxt:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "玩法说明"
        
        playIntroduce.isUserInteractionEnabled = false
        touzhIntroduce.isUserInteractionEnabled = false
        winDemo.isUserInteractionEnabled = false
        
        
        if let palyRuleValue = playRule{
            playIntroduce.text = palyRuleValue
        }else{
            playIntroduce.text = ""
        }
        
        if let touzhuValue = touzhuTxt{
            touzhIntroduce.text = touzhuValue
        }else{
            touzhIntroduce.text = ""
        }
        
        if let winDemoValue = playRule{
            winDemo.text = winDemoValue
        }else{
            winDemo.text = ""
        }
    }

}
