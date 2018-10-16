//
//  GameVersionChooseController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/28.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class GameVersionChooseController: UIViewController {
    
    @IBOutlet weak var officeBtn:UIButton!
    @IBOutlet weak var honestBtn:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        officeBtn.layer.cornerRadius = 22.5
        honestBtn.layer.cornerRadius = 22.5
        officeBtn.addTarget(self, action: #selector(onOfiiceClick), for: .touchUpInside)
        honestBtn.addTarget(self, action: #selector(onHonestClick), for: .touchUpInside)
    }
    
    @objc func onOfiiceClick() -> Void {
        BASE_URL = "https://skyy001.yb876.com"
        goPage()
    }
    
    @objc func onHonestClick() -> Void {
        BASE_URL = "https://skyy002.yb876.com"
        goPage()
    }
    
    func goPage() -> Void {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "startup_page")
        let recordPage = loginVC as! StartupController
        self.present(recordPage, animated: true, completion: nil)
    }
    
}
