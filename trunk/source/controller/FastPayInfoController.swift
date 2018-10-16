//
//  FastPayInfoController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import Kingfisher

//快速支付信息填写页

class FastPayInfoController: BaseController {

    var payFunction = ""
    var fasts:[FastPay] = []
    var gameDatas = [FakeBankBean]()
    var is_wx = false
    var qrcodeImg:UIImageView!
    var inputMoney = ""
    var meminfo:Meminfo?
    
    @IBOutlet weak var moneyLimitTV:UILabel!
    @IBOutlet weak var tablview:UITableView!
    @IBOutlet weak var confirmBtn:UIButton!
    
    var currentChannelIndex = 0;//当前选择的通道索引
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        
//        self.title = is_wx ? "微信充值" : "支付宝充值"
        
        if is_wx {
            self.title = "微信充值"
        }else {
            self.title = payFunction
        }
        
        tablview.delegate = self
        tablview.dataSource = self
        tablview.showsVerticalScrollIndicator = false
        tablview.tableHeaderView = self.headerView()
        self.tablview.tableFooterView = UIView.init(frame: CGRect.zero)
        confirmBtn.addTarget(self, action: #selector(onCommitBtn(ui:)), for: .touchUpInside)
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.theme_backgroundColor = "Global.themeColor"
        updateContentWhenChannelChange(index: self.currentChannelIndex)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        //当键盘收起的时候会向系统发出一个通知，
        //这个时候需要注册另外一个监听器响应该通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //点击更换通道后，更新新支付信息到view
    private func updateContentWhenChannelChange(index:Int){
        if self.fasts.isEmpty{
            return
        }
        let fast = self.fasts[index]
        self.gameDatas.removeAll()
        getFakeModels(fast: fast)
        self.tablview.reloadData()
        updateQrcodeImage(url: fast.qrCodeImg, image: self.qrcodeImg)
        moneyLimitTV.text = String.init(format: "温馨提示: 最低充值金额%d元，最大金额%d元", fast.minFee,fast.maxFee)
    }
    
    func getFakeModels(fast:FastPay){
        let item1 = FakeBankBean()
        item1.text = "选择通道"
        item1.value = fast.frontLabel
        gameDatas.append(item1)
        let item2 = FakeBankBean()
        item2.text = "收款账号"
        item2.value = fast.receiveAccount
        gameDatas.append(item2)
        let item3 = FakeBankBean()
        item3.text = "收款人"
        item3.value = fast.receiveName
        gameDatas.append(item3)
        let item4 = FakeBankBean()
        item4.text = "收款银行"
//        item4.value = is_wx ? "微信" : "支付宝"
        if is_wx {
//            item4.value = is_wx ? "微信" : "支付宝"
            item4.value = "微信"
        }else {
            if payFunction == "支付宝支付" {
                item4.value = "支付宝"
            }else if payFunction == "QQ支付" {
                item4.value = "QQ"
            }else if payFunction == "云闪付" {
                item4.value = "云闪付"
            }
        }
        gameDatas.append(item4)
        let item5 = FakeBankBean()
        item5.text = "转账金额"
        item5.value = ""
        gameDatas.append(item5)
    }
    
    
    @objc func onCommitBtn(ui:UIButton){
        
        let fast = self.fasts[currentChannelIndex]
        
        if isEmptyString(str: self.inputMoney){
            showToast(view: self.view, txt: "请输入充值金额")
            return
        }
        
//        if !isPurnInt(string: self.inputMoney){
//            showToast(view: self.view, txt: "请输入整数金额")
//            return
//        }
        
        let minFee = fast.minFee
        let maxFee = fast.maxFee
        
        guard let money = Float(self.inputMoney) else {
            showToast(view: self.view, txt: "金额格式不正确,请重新输入")
            return
        }
        if money < Float(minFee){
            showToast(view: self.view, txt: String.init(format: "充值金额不能小于%d元", minFee))
            return
        }
        
        if money > Float(maxFee){
            showToast(view: self.view, txt: String.init(format: "充值金额不能大于%d元", maxFee))
            return
        }
        
        let payId = fast.id
        let payCode = fast.iconCss
        var depositName = ""
        if let dn = meminfo?.account.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            depositName = dn
        }
        let parameter = ["payCode": payCode,"amount":self.inputMoney,"payId":payId,"depositName":depositName] as [String : Any]
        
        self.request(frontDialog: true, method:.post, loadTextStr:"提交中...", url:API_SAVE_OFFLINE_CHARGE,params: parameter,
                     callback: {(resultJson:String,resultStatus:Bool)->Void in

                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "提交失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }

                        if let result = OfflineChargeResultWraper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                showToast(view: self.view, txt: "提交成功")
                                if let meminfo = self.meminfo{
                                    let orderno = result.content
                                    let account = meminfo.account
                                    let amount = self.inputMoney
                                    let payName = fast.payName
                                    let qrcode = fast.qrCodeImg
                                    
                                    self.openConfirmPayController(orderNo: orderno, accountName: account, chargeMoney: amount, payMethodName: payName, receiveName: "", receiveAccount: "", dipositor: "", dipositorAccount: "", qrcodeUrl: qrcode, payType: PAY_METHOD_FAST, payJson: "")
                                }
                            }else{
                                if !isEmptyString(str: result.msg){
                                    self.print_error_msg(msg: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "提交失败"))
                                }
                                if (result.code == 0) {
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }
                        }

        })
    }
    
    func openConfirmPayController(orderNo:String,accountName:String,chargeMoney:String,
                                  payMethodName:String, receiveName:String,receiveAccount:String,dipositor:String,dipositorAccount:String,qrcodeUrl:String,payType:Int,payJson:String) -> Void {
        if self.navigationController != nil{
            openConfirmPay(controller: self, orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: receiveName, receiveAccount: receiveAccount, dipositor: dipositor, dipositorAccount: dipositorAccount, qrcodeUrl: qrcodeUrl, payType: payType, payJson: payJson)
        }
    }
    
    private func addLongPressGestureRecognizer(qrcode:UIImageView) {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressClick))
        qrcode.isUserInteractionEnabled = true
        qrcode.addGestureRecognizer(longPress)
    }
    
    @objc func longPressClick(){
        let alert = UIAlertController(title: "请选择", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction.init(title: "保存到相册", style: .default, handler: {(action:UIAlertAction) in
            if self.qrcodeImg.image == nil{
                return
            }
            UIImageWriteToSavedPhotosAlbum(self.qrcodeImg.image!, self, #selector(self.save_image(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let action2 = UIAlertAction.init(title: "识别二维码图片", style: .default, handler: {(action:UIAlertAction) in
            if self.qrcodeImg.image == nil{
                return
            }
            UIImageWriteToSavedPhotosAlbum(self.qrcodeImg.image!, self, #selector(self.readQRcode(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(cancel)
        //ipad使用，不加ipad上会崩溃
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect.init(x: kScreenWidth/4, y: kScreenHeight, width: kScreenWidth/2, height: 300)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func readQRcode(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer){
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let imageCI = CIImage.init(image: self.qrcodeImg.image!)
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
                
                if payFunction == "支付宝支付" {
                    appname = "支付宝"
                }else if payFunction == "QQ支付" {
                    appname = "QQ"
                }else if payFunction == "云闪付" {
                    appname = "云闪付"
                }
                
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
                    }else if appname == "支付宝" || appname == "QQ" || appname == "云闪付"{
                        if UIApplication.shared.canOpenURL(URL.init(string: "alipay://")!){
                            openBrower(urlString: "alipay://")
                        }else{
                            
                            showToast(view: self.view, txt: "您未安装\(appname)，无法打开扫描")
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
    
    
    
}

//extension FastPayInfoController{
//
//    func headerView() -> UIView{
//        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 200))
//        header.backgroundColor = UIColor.lightGray
//        qrcodeImg = UIImageView.init(frame: CGRect.init(x: kScreenWidth/2-60, y: 25, width: 120, height: 120))
//        qrcodeImg.contentMode = UIViewContentMode.scaleAspectFit
//        let tip = UILabel.init(frame: CGRect.init(x: 30, y: 155, width: kScreenWidth-60, height: 30))
//        tip.textAlignment = NSTextAlignment.center
//        tip.textColor = UIColor.red
//        tip.font = UIFont.systemFont(ofSize: 12)
//        tip.text = self.is_wx ? "长按可保存识别,请使用微信扫描二维码或保存到本地至微信中识别" : "长按可保存识别,请使用支付宝扫描二维码或保存到本地至支付宝中识别"
//        tip.lineBreakMode = .byWordWrapping
//        tip.numberOfLines = 2
//        addLongPressGestureRecognizer(qrcode:qrcodeImg)
//        header.addSubview(qrcodeImg)
//        header.addSubview(tip)
//        return header
//    }
//
//    func updateQrcodeImage(url:String,image:UIImageView?){
//        if image == nil{
//            return
//        }
//        var qrcodeUrl = url
//        if !isEmptyString(str: qrcodeUrl){
//            //这里的logo地址有可能是相对地址
//            if qrcodeUrl.contains("\t"){
//                let strs = qrcodeUrl.components(separatedBy: "\t")
//                if strs.count >= 2{
//                    qrcodeUrl = strs[1]
//                }
//            }
//            qrcodeUrl = qrcodeUrl.trimmingCharacters(in: .whitespaces)
////            if ValidateUtil.URL(qrcodeUrl).isRight{
//                let imageURL = URL(string: qrcodeUrl)
//                if let url = imageURL{
//                    self.qrcodeImg.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage.init(named: "default_placeholder_picture"), options: nil, progressBlock: nil, completionHandler: nil)
//                }
////            }
//        }else{
//            image?.image = UIImage.init(named: "default_placeholder_picture")
//        }
//    }
//
//}


//extension
//FastPayInfoController :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

extension FastPayInfoController :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    func headerView() -> UIView{
        
        let row = self.fasts.count / 3
        var collectionViewHeight: CGFloat = 0
        
        if row == 0 {
            collectionViewHeight = CGFloat(15) * CGFloat(2) +  CGFloat(40)
        }else if self.fasts.count > row * 3 {
            collectionViewHeight = CGFloat(row) * CGFloat(15) + CGFloat(15) * CGFloat(2) + (CGFloat(row) + CGFloat(1)) * CGFloat(40)
        }else {
            collectionViewHeight = (CGFloat(row) - CGFloat(1)) * CGFloat(15) + CGFloat(15) * CGFloat(2)  + CGFloat(row) * CGFloat(40)
        }
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 200 + collectionViewHeight + 40))
//        header.backgroundColor = UIColor.groupTableViewBackground
        setupNoPictureAlphaBgView(view: header, alpha: 0.2)
        qrcodeImg = UIImageView.init(frame: CGRect.init(x: kScreenWidth/2-60, y: 25, width: 120, height: 120))
        qrcodeImg.contentMode = UIViewContentMode.scaleAspectFit
        let tip = UILabel.init(frame: CGRect.init(x: 30, y: 155, width: kScreenWidth-60, height: 30))
        tip.textAlignment = NSTextAlignment.center
        tip.textColor = UIColor.red
        tip.font = UIFont.systemFont(ofSize: 12)
        
        var payName = ""
        if payFunction == "支付宝支付"{
            payName = "支付宝"
        }else if payFunction == "QQ支付" {
            payName = "QQ"
        }
        
        tip.text = self.is_wx ? "长按可保存识别,请使用微信扫描二维码或保存到本地至微信中识别" : "长按可保存识别,请使用\(payName)扫描二维码或保存到本地至\(payName)中识别"
        
        if payFunction == "云闪付" {
            payName = "云闪付"
            tip.text = "请使用\(payName)扫描(长按可以保存)"
        }
        
        tip.lineBreakMode = .byWordWrapping
        tip.numberOfLines = 2
        addLongPressGestureRecognizer(qrcode:qrcodeImg)
        header.addSubview(qrcodeImg)
        header.addSubview(tip)
        
        let header2 = createCollectionView(collectionViewHeight: collectionViewHeight)
        header.addSubview(header2)
        
        return header
    }
    
    func updateQrcodeImage(url:String,image:UIImageView?){
        if image == nil{
            return
        }
        var qrcodeUrl = url
        if !isEmptyString(str: qrcodeUrl){
            //这里的logo地址有可能是相对地址
            if qrcodeUrl.contains("\t"){
                let strs = qrcodeUrl.components(separatedBy: "\t")
                if strs.count >= 2{
                    qrcodeUrl = strs[1]
                }
            }
            qrcodeUrl = qrcodeUrl.trimmingCharacters(in: .whitespaces)
            //            if ValidateUtil.URL(qrcodeUrl).isRight{
            let imageURL = URL(string: qrcodeUrl)
            if let url = imageURL{
                self.qrcodeImg.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage.init(named: "default_placeholder_picture"), options: nil, progressBlock: nil, completionHandler: nil)
            }
            //            }
        }else{
            image?.image = UIImage.init(named: "default_placeholder_picture")
        }
    }
    
    
    private func createCollectionView(collectionViewHeight: CGFloat) -> UIView {
        let header = UIView.init(frame: CGRect(x: 0, y: 200, width: kScreenWidth, height: collectionViewHeight + 40))
        
        let tipView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
//        tipView.backgroundColor = UIColor.white
        setupNoPictureAlphaBgView(view: tipView,alpha: 0.2)
        header.addSubview(tipView)
        
        let necessaryImg = UIImageView.init(frame: CGRect(x: 10, y: 0, width: 10, height: 40))
        tipView.addSubview(necessaryImg)
        
        let tipLable = UILabel.init(frame: CGRect(x: 10 + 10, y: 0, width: kScreenWidth -  10 - 10, height: 40))
        tipView.addSubview(tipLable)
        tipLable.text = "支付通道 : "
        tipLable.textColor = UIColor.black
        tipLable.font = UIFont.systemFont(ofSize: 16)
        
        let layout = UICollectionViewFlowLayout()
        
        let width = (kScreenWidth - CGFloat(60)) / CGFloat(3)
        layout.itemSize = CGSize(width: width, height: 40)
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
    
        let colltionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: kScreenWidth, height: collectionViewHeight), collectionViewLayout: layout)
//        colltionView.backgroundColor = UIColor.groupTableViewBackground
        setViewBackgroundColorTransparent(view: colltionView)

        let nib = UINib(nibName: "NormalButtonCollectionCell", bundle: nil)
        colltionView.register(nib, forCellWithReuseIdentifier: "normalButtonCollectionCell")
        
        colltionView.delegate = self
        colltionView.dataSource = self
        
        header.addSubview(colltionView)
        return header
    }

    //MARK: - <UICollectionViewDataSource,UICollectionViewDelegate>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "normalButtonCollectionCell", for: indexPath) as! NormalButtonCollectionCell
        
        let fast = self.fasts[indexPath.row]
        cell.normalButton.setTitle(isEmptyString(str: fast.frontLabel) ? "没有名称" : fast.frontLabel, for: .normal)
        cell.backgroundColor = UIColor.clear
        
        if currentChannelIndex == indexPath.row {
            cell.normalButton.setBackgroundImage(UIImage(named: "payPathSelected"), for: .normal)
        }else {
            cell.normalButton.setBackgroundImage(UIImage(named: "payPathNoamal"), for: .normal)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "normalButtonCollectionCell", for: indexPath) as! NormalButtonCollectionCell
//        cell.normalButton.setBackgroundImage(UIImage(named: ""), for: .normal)
        currentChannelIndex = indexPath.row
        updateContentWhenChannelChange(index: indexPath.row)
        collectionView.reloadData()
//        self.tablview.reloadData()
    }

    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var labels:[String] = []
        for fast in self.fasts{
            labels.append(fast.frontLabel)
        }
        if labels.isEmpty{
            return 0
        }
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0
        }else {
            return 44.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "add_bank_cell") as? AddBankTableCell  else {
            fatalError("The dequeued cell is not an instance of AddBankTableCell.")
        }
        let model = self.gameDatas[indexPath.row]
        cell.inputTV.delegate = self
        cell.inputTV.tag = indexPath.row
        if model.text.contains("金额"){
            cell.inputTV.isHidden = false
            cell.valueTV.isHidden = true
            cell.inputTV.text = model.value
            cell.inputTV.keyboardType = .decimalPad
            cell.inputTV.placeholder = String.init(format: "请输入%@", model.text)
        }else{
            cell.inputTV.isHidden = true
            cell.valueTV.isHidden = false
            cell.valueTV.text = model.value
        }
        if indexPath.row == 0{
            cell.accessoryType = .disclosureIndicator
        }else{
            cell.accessoryType = .none
        }
        if indexPath.row == 0 || indexPath.row == self.gameDatas.count-1{
            cell.copyBtn.isHidden = true
        }else{
            cell.copyBtn.isHidden = false
            cell.copyBtn.tag = indexPath.row
            cell.copyBtn.addTarget(self, action: #selector(onCopyBtn(ui:)), for: .touchUpInside)
        }
        cell.textTV.text = model.text
        cell.inputTV.addTarget(self, action: #selector(onInput(ui:)), for: .editingChanged)
        return cell
    }
    
    @objc private func onCopyBtn(ui:UIButton){
        if self.gameDatas.isEmpty{
            return
        }
        let data = self.gameDatas[ui.tag]
        if !isEmptyString(str: data.value){
            UIPasteboard.general.string = data.value
            showToast(view: self.view, txt: "复制成功")
        }else{
            showToast(view: self.view, txt: "没有内容,无法复制")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0{
//            self.showChannelDialog()
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    @objc func onInput(ui:UITextField){
        let text = ui.text!
        self.gameDatas[ui.tag].value = text
        self.inputMoney = text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    private func showChannelDialog(){
        
        var labels:[String] = []
        for fast in self.fasts{
            labels.append(fast.frontLabel)
        }
        if labels.isEmpty{
            return
        }
        let selectedView = LennySelectView(dataSource: labels, viewTitle: "请选择通道")
        selectedView.selectedIndex = self.currentChannelIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.currentChannelIndex = index
            self?.updateContentWhenChannelChange(index: index)
            self?.tablview.reloadData()
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            
        }
    }
    
    }
