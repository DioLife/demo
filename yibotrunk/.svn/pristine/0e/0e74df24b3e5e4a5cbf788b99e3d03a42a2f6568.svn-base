//
//  AppDownloadViewController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/2/2.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class AppDownloadViewController: UIViewController {

    @IBOutlet weak var appStoreBtn:UIButton!
    @IBOutlet weak var androidBtn:UIButton!
    @IBOutlet weak var iosQrcode:UIImageView!
    @IBOutlet weak var androidQrcode:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "APP下载"
        self.title = "APP下载"
        updateLogo(img: iosQrcode, ios: true)
        updateLogo(img: androidQrcode, ios: false)
    }
    
    func updateLogo(img:UIImageView,ios:Bool) -> Void {
        guard let sys = getSystemConfigFromJson() else{return}
        var logoImg = ios ? sys.content.app_qr_code_link_ios : sys.content.app_qr_code_link_android
        if !isEmptyString(str: logoImg){
            if logoImg.contains("\t"){
                let strs = logoImg.components(separatedBy: "\t")
                if strs.count >= 2{
                    logoImg = strs[1]
                }
            }
            logoImg = logoImg.trimmingCharacters(in: .whitespaces)
            if !logoImg.hasPrefix("https://") && !logoImg.hasPrefix("http://"){
                logoImg = String.init(format: "%@/%@", BASE_URL,logoImg)
            }
            let imageURL = URL(string: logoImg)
            if let url = imageURL{
                img.contentMode = UIViewContentMode.scaleAspectFit
                img.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage.init(named: "default_placeholder_picture"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
    
    @IBAction func onAppStoreClick(view:UIButton){
        viewUrl(isApple: true)
    }
    
    @IBAction func onAndroidClick(view:UIButton){
        viewUrl(isApple: false)
    }
    
    func viewUrl(isApple:Bool) -> Void {
        let sysConfig = getSystemConfigFromJson()
        if let sysValue = sysConfig{
            let sys = sysValue.content
            
            if isApple{
                if let iosUrl = sys?.app_download_link_ios{
                    if !isEmptyString(str: iosUrl){
                        openBrower(urlString: iosUrl)
                    }else{
                        showToast(view: self.view, txt: "没有配置苹果APP下载地址")
                    }
                }
            }else{
                if let androidUrl = sys?.app_download_link_android{
                    if !isEmptyString(str: androidUrl){
                        openBrower(urlString: androidUrl)
                    }else{
                        showToast(view: self.view, txt: "没有配置安卓APP下载地址")
                    }
                }
            }
        }
    }

}
