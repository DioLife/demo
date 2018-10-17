//
//  SubChargeImageCell.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/7/3.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import Kingfisher

class SubChargeImageCell: UITableViewCell {

    @IBOutlet weak var qrcode:UIImageView!
    var controller:UIViewController!
    
    func setupData(data:ChargPayBean,controller:UIViewController){
        
        self.controller = controller
        let imgUrl = data.imgUrl
        
        if !isEmptyString(str: imgUrl) {
            let imageURL = URL(string: imgUrl)
            if let url = imageURL{
                qrcode.contentMode = UIViewContentMode.scaleAspectFit
                qrcode?.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "default_placeholder_picture"), options: nil, progressBlock: nil, completionHandler: nil)
            }
            addLongPressGestureRecognizer()
        }else{
            qrcode.image = UIImage.init(named: "default_placeholder_picture")
        }
    }

    func addLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressClick))
        self.qrcode.isUserInteractionEnabled = true
        self.qrcode.contentMode = UIViewContentMode.scaleAspectFit
        self.qrcode.addGestureRecognizer(longPress)
    }
    
    func longPressClick(){
        let alert = UIAlertController(title: "请选择", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction.init(title: "保存到相册", style: .default, handler: {(action:UIAlertAction) in
            UIImageWriteToSavedPhotosAlbum(self.qrcode.image!, self, #selector(self.save_image(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let action2 = UIAlertAction.init(title: "识别二维码图片", style: .default, handler: {(action:UIAlertAction) in
            if self.qrcode.image == nil{
                return
            }
            UIImageWriteToSavedPhotosAlbum(self.qrcode.image!, self, #selector(self.readQRcode(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(cancel)
        controller.present(alert, animated: true, completion: nil)
    }
    
    @objc func readQRcode(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer){
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let imageCI = CIImage.init(image: self.qrcode.image!)
        let features = detector?.features(in: imageCI!)
        guard (features?.count)! > 0 else { return }
        let feature = features?.first as? CIQRCodeFeature
        let qrMessage = feature?.messageString
        
        guard var code = qrMessage else{
            showToast(view: controller.view, txt: "请确认二维码图片是否正确")
            return
        }
        if !isEmptyString(str: code){
            var appname = ""
            code = code.lowercased()
            if code.starts(with:"wxp"){
                appname = "微信"
            }else if code.contains("alipay"){
                appname = "支付宝"
            }else{
                showToast(view: controller.view, txt: "请确认二维码图片是否正确的收款二维码")
            }
            if error == nil {
                let ac = UIAlertController.init(title: "保存成功",
                                                message: String.init(format: "您可以打开%@,从相册选取并识别此二维码", appname), preferredStyle: .alert)
                ac.addAction(UIAlertAction(title:"去扫码",style: .default,handler: {(action:UIAlertAction) in
                    // 跳转扫一扫
                    if appname == "微信"{
                        if UIApplication.shared.canOpenURL(URL.init(string: "weixin://")!){
                            openBrower(urlString: "weixin://")
                        }else{
                            showToast(view: self.controller.view, txt: "您未安装微信，无法打开扫描")
                        }
                    }else if appname == "支付宝"{
                        if UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!){
                            openBrower(urlString: "alipay://")
                        }else{
                            showToast(view: self.controller.view, txt: "您未安装支付宝，无法打开扫描")
                        }
                    }
                }))
                controller.present(ac, animated: true, completion: nil)
            } else {
                let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                controller.present(ac, animated: true, completion: nil)
            }
        }else{
            showToast(view: controller.view, txt: "请确认二维码图片是否正确的收款二维码")
            return
        }
    }
    
    //保存二维码
    @objc func save_image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error == nil {
            //            let ac = UIAlertController(title: "保存成功", message: "请打开微信识别二维码", preferredStyle: .alert)
            //            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            //            self.present(ac, animated: true, completion: nil)
            showToast(view: controller.view, txt: "保存图片成功")
        } else {
            let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            controller.present(ac, animated: true, completion: nil)
        }
    }
}
