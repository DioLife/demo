//
//  QrcodeViewController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/2.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class QrcodeViewController: BaseController {
    
    @IBOutlet weak var qrcode:UIImageView!
    @IBOutlet weak var clickBtn:UIButton!

    var downloadUrl = ""
    var qrcodeUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "APP二维码"
        self.navigationItem.title = "APP二维码"
        clickBtn.addTarget(self, action: #selector(onBtnClick), for: UIControlEvents.touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        let sysConfig = getSystemConfigFromJson()
        if let sysValue = sysConfig{
            let sys = sysValue.content
            if let iosUrl = sys?.app_download_link_ios{
                self.downloadUrl = iosUrl
            }
            if let qrCodeUrl = sys?.app_qr_code_link_ios{
                self.qrcodeUrl = qrCodeUrl
            }
        }
        if !isEmptyString(str: qrcodeUrl){
            downloadImage(url: URL.init(string: qrcodeUrl)!, imageUI: qrcode)
        }else{
            showToast(view: self.view, txt: "您还未在后台配置二维码图片地址")
        }
    }

    @objc func onBtnClick() -> Void {
        if !isEmptyString(str: downloadUrl){
            openBrower(urlString: downloadUrl)
        }else{
            showToast(view: self.view, txt: "没有苹果APP下载地址，请检查后台是否已经配置")
        }
    }
    
}
