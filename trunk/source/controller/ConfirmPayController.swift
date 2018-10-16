//
//  ConfirmPayController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/29.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit
import HandyJSON

/**
 * 再次确认充值订单提交后 订单及收款，付款帐号信息，及扫码二维码信息
 * //在线充值方式时，需要在此页面确认跳转收银台支付等操作
 */
class ConfirmPayController: BaseController {

    @IBOutlet weak var orderView:UIView!
    @IBOutlet weak var orderViewConstraint:NSLayoutConstraint!
    
    @IBOutlet weak var orderNoUI:UILabel!
    @IBOutlet weak var accountUI:UILabel!
    @IBOutlet weak var chargeMoneyUI:UILabel!
    @IBOutlet weak var chargeMethodUI:UILabel!
    
    @IBOutlet weak var receiverUI:UILabel!
    @IBOutlet weak var receiverAccountUI:UILabel!
    @IBOutlet weak var dipositorUI:UILabel!
    @IBOutlet weak var dipositorAccountUI:UILabel!
    
    @IBOutlet weak var receiverCosntraintUI:NSLayoutConstraint!
    @IBOutlet weak var receiverAccountCosntraintUI:NSLayoutConstraint!
    @IBOutlet weak var dipositorCosntraintUI:NSLayoutConstraint!
    @IBOutlet weak var dipositorAccountCosntraintUI:NSLayoutConstraint!
    
    
    @IBOutlet weak var qrcodeArea:UIView!
    @IBOutlet weak var qrcodeImgUI:UIImageView!
    
    var orderno = ""
    var account = ""
    var money = ""
    var payMethodName = ""
    var receiveName = ""
    var reeiveAccount = ""
    var dipositor = ""
    var dipositorAccount = ""
    var qrcodeUrl = ""
    var payType = PAY_METHOD_ONLINE
    var payJson = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderView.layer.borderWidth = 0.5
        orderView.layer.borderColor = UIColor.lightGray.cgColor
        orderView.layer.cornerRadius = 5
        
        
        orderNoUI.text = String.init(format: "订单号码: %@", orderno)
        accountUI.text = String.init(format: "会员帐号: %@", account)
        chargeMoneyUI.text = String.init(format: "充值金额: %@元", money)
        chargeMethodUI.text = String.init(format: "支付方式: %@", payMethodName)
        
        var items = 4
        
        if !isEmptyString(str: receiveName){
            receiverUI.text = String.init(format: "收款姓名: %@", receiveName)
            receiverUI.isHidden = false
            receiverCosntraintUI.constant = 21
            items = items + 1
        }else{
            receiverUI.isHidden = true
            receiverCosntraintUI.constant = 0
        }
        
        if !isEmptyString(str: reeiveAccount){
            receiverAccountUI.text = String.init(format: "收款帐号: %@", reeiveAccount)
            receiverAccountUI.isHidden = false
            receiverAccountCosntraintUI.constant = 21
            items = items + 1
        }else{
            receiverAccountUI.isHidden = true
            receiverAccountCosntraintUI.constant = 0
        }
        
        if !isEmptyString(str: dipositor){
            dipositorUI.text = String.init(format: "存款人名: %@", dipositor)
            dipositorUI.isHidden = false
            dipositorCosntraintUI.constant = 21
            items = items + 1
        }else{
            dipositorUI.isHidden = true
            dipositorCosntraintUI.constant = 0
        }
        
        if !isEmptyString(str: dipositorAccount){
            dipositorAccountUI.text = String.init(format: "存款帐号: %@", dipositorAccount)
            dipositorAccountUI.isHidden = false
            dipositorAccountCosntraintUI.constant = 21
            items = items + 1
        }else{
            dipositorAccountUI.isHidden = true
            dipositorAccountCosntraintUI.constant = 0
        }
        print("items count = \(items)")
        let height = items*29 + 16
        orderViewConstraint.constant = CGFloat(height)
        
        if payType == PAY_METHOD_ONLINE{
            orderNoUI.isHidden = true
        }else{
            orderNoUI.isHidden = false
        }
        
        if !isEmptyString(str: qrcodeUrl){
            qrcodeArea.isHidden = false
            fillImage(url: qrcodeUrl)
        }else{
            qrcodeArea.isHidden = true

        }
        qrcodeImgUI.contentMode = UIViewContentMode.scaleAspectFit
        addLongPressGestureRecognizer(qrcode: qrcodeImgUI)
    }
    
    private func addLongPressGestureRecognizer(qrcode:UIImageView) {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressClick))
        qrcodeImgUI.isUserInteractionEnabled = true
        qrcodeImgUI.addGestureRecognizer(longPress)
    }
    
    @objc func longPressClick(){
        let alert = UIAlertController(title: "请选择", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction.init(title: "保存到相册", style: .default, handler: {(action:UIAlertAction) in
            if self.qrcodeImgUI.image == nil{
                return
            }
            UIImageWriteToSavedPhotosAlbum(self.qrcodeImgUI.image!, self, #selector(self.save_image(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let action2 = UIAlertAction.init(title: "识别二维码图片", style: .default, handler: {(action:UIAlertAction) in
            if self.qrcodeImgUI.image == nil{
                return
            }
            UIImageWriteToSavedPhotosAlbum(self.qrcodeImgUI.image!, self, #selector(self.readQRcode(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func readQRcode(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer){
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let imageCI = CIImage.init(image: self.qrcodeImgUI.image!)
        let features = detector?.features(in: imageCI!)
        guard (features?.count)! > 0 else { return }
        let feature = features?.first as? CIQRCodeFeature
        let qrMessage = feature?.messageString
        
        guard var code = qrMessage else{
            showToast(view: self.view, txt: "请确认二维码图片是否正确")
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
                showToast(view: self.view, txt: "请确认二维码图片是否正确的收款二维码")
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
                            showToast(view: self.view, txt: "您未安装微信，无法打开扫描")
                        }
                    }else if appname == "支付宝"{
                        if UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!){
                            openBrower(urlString: "alipay://")
                        }else{
                            showToast(view: self.view, txt: "您未安装支付宝，无法打开扫描")
                        }
                    }
                }))
                self.present(ac, animated: true, completion: nil)
            } else {
                let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
            }
        }else{
            showToast(view: self.view, txt: "请确认二维码图片是否正确的收款二维码")
            return
        }
    }
    
    //保存二维码
    @objc func save_image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error == nil {
            //            let ac = UIAlertController(title: "保存成功", message: "请打开微信识别二维码", preferredStyle: .alert)
            //            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            //            self.present(ac, animated: true, completion: nil)
            showToast(view: self.view, txt: "保存图片成功")
        } else {
            let ac = UIAlertController(title: "保存失败", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func fillImage(url:String) -> Void {
        let imageURL = URL(string: url)
        if let url = imageURL{
            downloadImage(url: url, imageUI: self.qrcodeImgUI)
        }
    }

}

extension String {
    //返回字数
    var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }

}
