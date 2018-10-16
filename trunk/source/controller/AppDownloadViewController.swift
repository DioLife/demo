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
    @IBOutlet weak var companyLogoImage: UIImageView!
    @IBOutlet weak var QRCodeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "APP下载"
        self.title = "APP下载"
        updateImges()
    }
    
    
     func updateImges() {
        self.companyLogoImage.contentMode = .scaleAspectFit
        self.QRCodeImage.contentMode = .scaleAspectFit
        
        guard let sys = getSystemConfigFromJson() else{return}
        let logoImg = sys.content.lottery_page_logo_url
        let qrcodeImg = sys.content.app_qr_code_link_ios
        
        if !isEmptyString(str: logoImg) {
            let logoURL = formatUrl(str: logoImg)
            
            companyLogoImage.kf.setImage(with: ImageResource(downloadURL: logoURL), placeholder: UIImage.init(named: "placeHolder_companyLogo"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        if !isEmptyString(str: qrcodeImg) {
            let qrcodeURL = formatUrl(str: qrcodeImg)
            
            QRCodeImage.kf.setImage(with: ImageResource(downloadURL: qrcodeURL), placeholder: UIImage.init(named: "placeHolder_qrcode"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    private func formatUrl(str: String) -> URL{
        var strP = str
        //这里的logo地址有可能是相对地址
        if strP.contains("\t"){
            let strs = strP.components(separatedBy: "\t")
            if strs.count >= 2{
                strP = strs[1]
            }
        }
        strP = strP.trimmingCharacters(in: .whitespaces)
        if !strP.hasPrefix("https://") && !strP.hasPrefix("http://"){
            strP = String.init(format: "%@/%@", BASE_URL,strP)
        }
        
        let imgUrl = URL(string: strP)
        return imgUrl!
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


//private func updateCompanyLogo() {
//
//    guard let sys = getSystemConfigFromJson() else{return}
//    var logoImg = sys.content.lottery_page_logo_url
//    var qrcodeImg = sys.content.app_qr_code_link_ios
//    if !isEmptyString(str: logoImg){
//        //这里的logo地址有可能是相对地址
//        if logoImg.contains("\t"){
//            let strs = logoImg.components(separatedBy: "\t")
//            if strs.count >= 2{
//                logoImg = strs[1]
//            }
//        }
//        logoImg = logoImg.trimmingCharacters(in: .whitespaces)
//        if !logoImg.hasPrefix("https://") && !logoImg.hasPrefix("http://"){
//            logoImg = String.init(format: "%@/%@", BASE_URL,logoImg)
//        }
//        let imageURL = URL(string: logoImg)
//
//        companyLogoImage.kf.setImage(with: ImageResource(downloadURL: imageURL!))
//    }
//}
