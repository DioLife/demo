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
class ConfirmPayController: BaseController ,NewSelectViewDelegate{

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
    @IBOutlet weak var qrcodeAreaConstraint:NSLayoutConstraint!
    @IBOutlet weak var qrcodeImgUI:UIImageView!
    @IBOutlet weak var commitBtn:UIButton!
    
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
    
    var shunpayArr:[String] = []
    var scanpayArr:[String] = []
    var wappayArr:[String] = []
    var straightArr:[String] = []
    
    var selectBrowserIndex = 0
    var currentPayUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitBtn.layer.cornerRadius = 22.5
        orderView.layer.borderWidth = 0.5
        orderView.layer.borderColor = UIColor.lightGray.cgColor
        orderView.layer.cornerRadius = 5
        
        commitBtn.addTarget(self, action: #selector(onCommitClick), for: UIControlEvents.touchUpInside)
        
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
            commitBtn.isHidden = false
            orderNoUI.isHidden = true
        }else{
            commitBtn.isHidden = true
            orderNoUI.isHidden = false
        }
        
        if !isEmptyString(str: qrcodeUrl){
            qrcodeArea.isHidden = false
            qrcodeAreaConstraint.constant = 0
            fillImage(url: qrcodeUrl)
        }else{
            qrcodeArea.isHidden = true
            qrcodeAreaConstraint.constant = -kScreenHeight/3
        }
        
        self.shunpayArr = self.shunpayArr + shunpayFilterArr
        self.scanpayArr = self.scanpayArr + scanpayFilterArr
        self.wappayArr = self.wappayArr + wappayFilterArr
        self.straightArr = self.straightArr + straightFilterArr
        //进入时必需先同步最新的支付方式
        syncSysPayMethod()
    }
    
    //发起支付
    func onCommitClick() -> Void {
        
        if YiboPreference.getAccountMode() == ACCOUNT_PLATFORM_TEST_GUEST{
            showToast(view: self.view, txt: "试玩帐号无法进行充值")
            return
        }
        
        let account = YiboPreference.getUserName()
        if isEmptyString(str: payJson){
            showToast(view: self.view, txt: "支付信息不完整，无法支付")
           return
        }
        
        let onlinePay = JSONDeserializer<OnlinePay>.deserializeFrom(json: payJson)
        if let pay = onlinePay{
            // payType 支付方式： 1-收银台，2-银行直连，3-单微信，4-单支付宝
            let iconCss = pay.iconCss
            let payType = pay.payType
            let chargeMoney = money
            let payId = pay.id
            
            if shunpayArr.contains(iconCss) && payType != "3" && payType != "4" && payType != "5" && payType != "6"
                && payType != "7" && payType != "8" && payType != "9" && payType != "10"{
                var url = String.init(format: "%@%@/shunpay/pay.do?amount=%@&payId=%d&verifyCode=undefined", BASE_URL,PORT,chargeMoney,payId)
                if !isEmptyString(str: account){
                    url = url + "&account=" + account;
                }
//                openBrower(urlString: url)
                self.openInBrowser(url: url)
                self.navigationController?.popViewController(animated: true)
                //如果是上一个页面present过来的，则需要以同样的方式退出
                self.dismiss(animated: true, completion: nil)
                return
            }else if scanpayArr.contains(iconCss) && (payType == "3" || payType == "4" || payType == "5" || payType == "6" || payType == "7" || payType == "8" || payType == "10"){
//                if scanpanWithRedirectFilterArr.contains(iconCss){
//
//                }else{
                    var url = String.init(format: "%@%@/scanpay/pay.do?amount=%@&payId=%d&verifyCode=undefined", BASE_URL,PORT,chargeMoney,payId)
                    if !isEmptyString(str: account){
                        url = url + "&account=" + account;
                    }
//                    openBrower(urlString: url)
                self.openInBrowser(url: url)
                    self.navigationController?.popViewController(animated: true)
                    //如果是上一个页面present过来的，则需要以同样的方式退出
                    self.dismiss(animated: true, completion: nil)
//                }
                return
            }else{
                var bankCode = ""
                if payType == "3"{
                    bankCode = "WEIXIN";
                }else if payType == "4"{
                    bankCode = "ALIPAY";
                }else if payType == "5"{
                    bankCode = "QQPAY";
                }else if payType == "6"{
                    bankCode = "JDPAY";
                }else if payType == "7"{
                    bankCode = "BAIDU";
                }else if payType == "8"{
                    bankCode = "UNION";
                    if iconCss == "wh5zhifu"{
                        self.straightArr.append("wh5zhifu")
                    }
                }else if payType == "9"{
                    bankCode = "QUICKPAY"
                }else if payType == "10"{
                    bankCode = "MTPAY"
                }
                else if wappayArr.contains(iconCss){
                    showToast(view: self.view, txt: "此支付不支持网银版本")
                    return
                }
                postPay(money: money, payId: payId, vertifyCode: "", bankCode: bankCode)
            }
        }
    }
    
    func postPay(money:String,payId:Int,vertifyCode:String,bankCode:String){
        
        let params = ["amount":money,"payId":payId,"verifyCode":vertifyCode,"bankcode":bankCode] as [String : Any]
        request(frontDialog: true,method: .post,loadTextStr: "支付中...",url:ONLINE_PAY_URL,params:params,
            callback: {(resultJson:String,resultStatus:Bool)->Void in
                if !resultStatus {
                    showToast(view: self.view, txt: convertString(string: "在线支付失败"))
                    return
                }
                
                if isEmptyString(str: resultJson){
                    showToast(view: self.view, txt: "在线支付请求失败")
                    return
                }
                
                let resultWraper = OnlinePayResultWraper.deserialize(from: resultJson)
                if let result = resultWraper{
                    if !result.success{
                        showToast(view: self.view, txt: !isEmptyString(str: result.msg) ? result.msg : "在线支付请求失败")
                        return
                    }
                    if isEmptyString(str: self.payJson){
                        return
                    }
                    let onlinePay = OnlinePay.deserialize(from: self.payJson)
                    let iconCss = onlinePay?.iconCss
                    ////若是网银直连本地网银时，需要跳转第三方网银地址（第三方提供收银台，收银台需要我们后台再发起表单请求生成并返回收银台地址）
                    var paramsJson = ""
                    var payReferer = ""
                    var redirectUrl = ""
                    if self.straightArr.contains(iconCss!){
                        //组装请求参数，请求支付二维码接口
                        guard let data = resultJson.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
                            showToast(view: self.view, txt: "支付数据错误，请重试！")
                            return
                        }
                        //把Data对象转换回JSON对象
                        guard let json = try? JSONSerialization.jsonObject(with: data,options:.allowFragments) as! [String: Any] else{
                            showToast(view: self.view, txt: "支付数据错误，请重试！")
                            return
                        }
                        if (json.keys.contains("data")){
                            let data = json["data"] as! [String:Any]
                            if (data.keys.contains("formParams")){
                                var formParams = data["formParams"] as! [String:Any]
                                if (formParams.keys.contains("redirectUrl")){
                                    redirectUrl = formParams["redirectUrl"] as! String
                                    formParams.removeValue(forKey: "redirectUrl")
                                }
                                do{
                                    let jsonData = try JSONSerialization.data(withJSONObject: formParams, options: JSONSerialization.WritingOptions.prettyPrinted)
                                    paramsJson = String.init(data: jsonData, encoding: String.Encoding.utf8)!
                                }catch{
                                    print(error)
                                }
                            }
                            if (data.keys.contains("payReferer")){
                                payReferer = data["payReferer"] as! String
                            }
                        }
                        
                        print("the pay referer == ",payReferer)
                        print("the pay params == ",paramsJson)
                        let payId = onlinePay?.id
                        //发起获取扫码的二维码请求
                        self.postQRCode(iconCss: iconCss!, redirectUrl: redirectUrl, payId: payId!, redirectParams: paramsJson, payReferer: payReferer)
                    }else{
                        let postResult = resultJson
                        print("post result = \(postResult)")
                        
                        let data = resultJson.data(using: String.Encoding.utf8, allowLossyConversion: true)
                        //把Data对象转换回JSON对象
                        let json = try? JSONSerialization.jsonObject(with: data!,
                                                                     options:.allowFragments) as! [String: Any]
                        var formActionStr = ""
                        if (json?.keys.contains("data"))!{
                            let data = json?["data"] as! [String:Any]
                            if (data.keys.contains("formAction")){
                                formActionStr = data["formAction"] as! String
                            }
                            if (data.keys.contains("formParams")){
                                let formParams = data["formParams"] as! [String:Any]
                                var params = ""
                                var isPost = true
                                for key in formParams.keys{
                                    params = params + String.init(format: "%@=%@&", key,formParams[key] as! String)
//                                    if key == "form_s_method" && formParams[key] as! String == "get"{
//                                        isPost = false
//                                    }
                                }
                                if params.count > 0{
                                    params = params + String.init(format: "%@=%@&", "onlinepayType",iconCss!)
                                    let index = params.index(params.endIndex, offsetBy:-1)
                                    params = params.substring(to: index)
                                    params = params.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    print("the strrrrr = \(params)")
                                    let url = String.init(format: "%@?%@", formActionStr,params)
                                    print("the final open address = \(url)")
//                                    if !isPost{
//                                        openBrower(urlString: url)
                                        self.openInBrowser(url: url)
//                                    }else{
////                                        openWebPay(controller: self, url: formActionStr, params: formParams)
//                                        print("the formActionstr",formActionStr)
//                                        print("formParams ==",formParams)
////
////                                        Urls.BASE_URL+Urls.PORT+Urls.PAY_TRANSLATE_URL + "?url=" +
////                                            formActionStr+"&data="+ URLEncoder.encode(postJson,"utf-8");
//                                        self.postPayForSafari(url: formActionStr, params: formParams)
//                                        return
//                                    }
                                }
                                self.navigationController?.popViewController(animated: true)
                                //如果是上一个页面present过来的，则需要以同样的方式退出
                                self.dismiss(animated: true, completion: nil)
                                return
                            }
                        }
                    }
                }
            })
    }
    
    func syncSysPayMethod(){
        request(frontDialog: true,method: .get,loadTextStr: "正在同步支付数据中...",url:SYNC_PAY_METHODS,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        showToast(view: self.view, txt: convertString(string: "同步失败"))
                        return
                    }
                    if isEmptyString(str: resultJson){
                        showToast(view: self.view, txt: "同步失败")
                        return
                    }
                    let resultWraper = SyncPayMethodWraper.deserialize(from: resultJson)
                    if let result = resultWraper{
                        if !result.success{
                            showToast(view: self.view, txt: !isEmptyString(str: result.msg) ? result.msg : "同步失败")
                            return
                        }
                        guard let content = result.content else{return}
                        if let shunpay = content.shunpay{
                            self.shunpayArr.removeAll()
                            self.shunpayArr = self.shunpayArr + shunpay.content
                        }
                        if let scanpay = content.scanpay{
                            self.scanpayArr.removeAll()
                            self.scanpayArr = self.scanpayArr + scanpay.content
                        }
                        if let starightpay = content.straightpay{
                            self.straightArr.removeAll()
                            self.straightArr = self.straightArr + starightpay.content
                        }
                        if let wappay = content.wappay{
                            self.wappayArr.removeAll()
                            self.wappayArr = self.wappayArr + wappay.content
                        }
                        print("sync pay methods success---------")
                    }
        })
    }
    
    func postPayForSafari(url:String,params:Dictionary<String,Any>) -> Void {
        
        let data : NSData! = try? JSONSerialization.data(withJSONObject: params, options: []) as NSData
        let paramStr = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
//        let mparams = ["url":url,"params":paramStr] as [String : Any]
        guard let param = paramStr else{return}
//        guard let p = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        guard var escapedString = param.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        //将特殊字符替换成转义后的编码
        escapedString = escapedString.replacingOccurrences(of: "=", with: "%3D")
        escapedString = escapedString.replacingOccurrences(of: "&", with: "%26")
        let url = String.init(format: "%@%@%@?url=%@&data=%@", BASE_URL,PORT,PAY_RESULT_SAFARI,url,escapedString)
        print("the open url = ",url)
        
        openInBrowser(url: url)
    }
    
    func gotoBrowerWithType(type: Int, allways: Bool) {
        if allways {
            YiboPreference.setDefault_brower_type(value: type as AnyObject)
        }
        realOpenPayUrl(url: self.currentPayUrl,browerType:type)
    }
    
    private func realOpenPayUrl(url:String,browerType:Int){
        
        //如果支付链接以大写的HTTPS,HTTP开头先见前缀改为小写
        var realUrl = url
        if realUrl.starts(with: "HTTPS://"){
            realUrl = url.replacingOccurrences(of: "HTTPS", with: "https")
        }else if realUrl.starts(with: "HTTP://"){
            realUrl = url.replacingOccurrences(of: "HTTP", with: "http")
        }
        
        if browerType == BROWER_TYPE_UC {
            if UIApplication.shared.canOpenURL(URL.init(string: "ucbrowser://")!){
                let openUrl = String.init(format: "%@%@", "ucbrowser://",url)
                openBrower(urlString: openUrl)
            }else {
                showToast(view: view, txt: "未安装“UC”浏览器")
            }
        }else if browerType == BROWER_TYPE_QQ {
            if UIApplication.shared.canOpenURL(URL.init(string: "mttbrowser://")!){
                let openUrl = String.init(format: "%@%@", "mttbrowser://",url)
                openBrower(urlString: openUrl)
            }else {
                showToast(view: view, txt: "未安装“QQ”浏览器")
            }
        }else if browerType == BROWER_TYPE_GOOGLE {
            if UIApplication.shared.canOpenURL(URL.init(string: "googlechromes://")!){
                let urlString = url.replacingOccurrences(of: "https", with: "googlechromes")
                openBrower(urlString: urlString)
            }else if UIApplication.shared.canOpenURL(URL.init(string: "googlechrome://")!) {
                let urlFinalString = url.replacingOccurrences(of: "http", with: "googlechrome")
                openBrower(urlString: urlFinalString)
            }else {
                showToast(view: view, txt: "未安装“谷歌”浏览器")
            }
        }else if browerType == BROWER_TYPE_SAFARI {
            openBrower(urlString: url)
        }else if browerType == BROWER_TYPE_FIREFOX {
            if UIApplication.shared.canOpenURL(URL.init(string: "firefox://")!){
                let openUrl = String.init(format: "%@%@", "firefox://",url)
                openBrower(urlString: openUrl)
            }else {
                showToast(view: view, txt: "未安装“火狐”浏览器")
            }
        }
    }
    
    //MARK: 弹窗显示浏览器选择
    private func showBrowerSelectedView(url:String) {
        let tupeArray = [("Browser_safari","Safari浏览器"),("Browser_uc","UC浏览器"),
                         ("Browser_qq","QQ浏览器"),("Browser_google","谷歌浏览器"),
                         ("Browser_firefox","火狐浏览器")]
        let selectedView = Bundle.main.loadNibNamed("NewSelectBrowserWindow", owner: nil, options: nil)?.first as! NewSelectView
        selectedView.initSource(dataSource: tupeArray, viewTitle: "请选择浏览器")
        let y = kScreenHeight/2 - selectedView.kHeight/2
        selectedView.frame = CGRect.init(x: kScreenWidth*0.125, y: y, width: kScreenWidth*0.75, height: selectedView.kHeight)
        selectedView.delegate = self
        selectedView.selectedIndex = selectBrowserIndex
        self.currentPayUrl = url
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.selectBrowserIndex = index
        }
        self.view.window?.addSubview(selectedView)
    }
    
    func openInBrowser(url:String){
        //多浏览器选择框
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let multi_broswer = config.content.multi_broswer
                if multi_broswer == "on"{
                    let browerType = YiboPreference.getDefault_brower_type()
                    if browerType == -1 {
                        self.showBrowerSelectedView(url: url)
                    }else {
                        self.realOpenPayUrl(url: url,browerType: YiboPreference.getDefault_brower_type())
                    }
                }else{
                    openBrower(urlString: url)
                }
            }
        }
    }
    
    /**
     * 发起获取支付二维码
     * @param iconCss
     * @param redirectUrl
     * @param payId
     * @param redirectParams
     * @param payReferer
     */
    func postQRCode(iconCss:String,redirectUrl:String,payId:Int,redirectParams:String,payReferer:String) -> Void {
        
        let params = ["iconCss":iconCss,"redirectUrl":redirectUrl,"payId":payId,"redirectParams":redirectParams,"payReferer":payReferer] as [String : Any]
        request(frontDialog: true,method: .post,loadTextStr: "支付码生成中...",url:PAY_QRCODE_URL ,params: params,callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取二维码失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
            
                    if isEmptyString(str: resultJson){
                        showToast(view: self.view, txt: convertString(string: "获取二维码失败"))
                        return
                    }
            
                    if let result = ScanQRCodeWraper.deserialize(from: resultJson){
                        if result.success{
                            let qrcodeUrl = result.qrcodeUrl
                            print("the qrcode url = \(qrcodeUrl)")
                            ////当商户返回的链接是Html内容时，要将内容传到后台做一次转发，并返回地址
                            if qrcodeUrl.hasPrefix("<form")||qrcodeUrl.hasPrefix("<html")||qrcodeUrl.hasPrefix("<!DOCTYPE") ||
                            qrcodeUrl.hasPrefix("<meta"){
//                                let data : NSData! = try? JSONSerialization.data(withJSONObject: qrcodeUrl, options: []) as NSData
//                                let content = NSString(data:data as Data, encoding: String.Encoding.utf8.rawValue)
//                                guard let param = content else{return}
//                                let url = String.init(format: "%@%@%@?content=%@", BASE_URL,PORT,PAY_RESULT_SPECIAL_SAFARI,param)
//                                print("the open url = ",url)
//                                self.openInBrowser(url: url)
                                openActiveDetail(controller: self, title: "", content: qrcodeUrl)
                                return
                            }
//                            openBrower(urlString: qrcodeUrl)
                            self.openInBrowser(url: qrcodeUrl)
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取二维码失败"))
                            }
                        }
                    }
        })
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
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
}
