//
//  OnlinePayInfoController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
import HandyJSON

//在线支付信息填写页
class OnlinePayInfoController: BaseController,NewSelectViewDelegate {
    
    
    @IBOutlet weak var payMethodBgView: UIView!
    @IBOutlet weak var payMethodTV:UILabel!
    @IBOutlet weak var moneyInput:CustomFeildText!
    @IBOutlet weak var fastMoney:UICollectionView!
    @IBOutlet weak var shouyingtai:UICollectionView!
    @IBOutlet weak var payChannelCollection: UICollectionView!
    
    @IBOutlet weak var confirmBtn:UIButton!
    @IBOutlet weak var moneyLimitTV:UILabel!
    @IBOutlet weak var moneyCollectViewHeightConstrait:NSLayoutConstraint!
    @IBOutlet weak var subPayCollectViewHeightConstrait:NSLayoutConstraint!
    
    @IBOutlet weak var payChannelHeightConstrait: NSLayoutConstraint!
    
    @IBOutlet weak var tipsTextView: UITextView!
    
    var selectedIndex = 0
    lazy var moneyDatas:[String] = []
    var shouyintais:[String] = []
    var payMethodNames:[String] = []
    var currentPayIndex = 0
    var onlines:[OnlinePay] = []
    var currSubPayRow = 0
    var meminfo:Meminfo?
    var jsonData: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setThemeTextViewTextColorGlassWhiteOtherRed(textView: tipsTextView)
        setThemeLabelTextColorGlassWhiteOtherRed(label: moneyLimitTV)
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        self.title = "在线充值"
        fastMoney.delegate = self
        fastMoney.dataSource = self
        fastMoney.tag = 101
        fastMoney.register(PayInfoMoneyCell.self, forCellWithReuseIdentifier:"cell")
        fastMoney.showsVerticalScrollIndicator = false
        self.fastMoney.reloadData()
        payMethodTV.isUserInteractionEnabled = true
        
        payChannelCollection.delegate = self
        payChannelCollection.dataSource = self
        payChannelCollection.tag = 103
        let nib = UINib(nibName: "NormalButtonCollectionCell", bundle: nil)
        payChannelCollection.register(nib, forCellWithReuseIdentifier: "normalButtonCollectionCell")
        payChannelCollection.showsVerticalScrollIndicator = false
        payChannelCollection.reloadData()
        
//        payMethodTV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onPayMethodSwitch)))
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.addTarget(self, action: #selector(onConfirm(ui:)), for: .touchUpInside)
        
        confirmBtn.theme_backgroundColor = "Global.themeColor"
        
        shouyingtai.delegate = self
        shouyingtai.dataSource = self
        shouyingtai.tag = 102
        shouyingtai.register(SubPayMethodCell.self, forCellWithReuseIdentifier:"cell")
        
        if !self.onlines.isEmpty{
            let online = self.onlines[(self.currentPayIndex)]
            updateCurrentPayInfo(index: self.currentPayIndex)
            self.updateMoneyDatas(index: self.currentPayIndex)
            self.syncSysPayMethod(payId:(online.id))
        }
        
        getPayMethodNamesData()
        
        setupTipsData()
        
        setupNoPictureAlphaBgView(view: self.payMethodBgView)
        setupNoPictureAlphaBgView(view: self.shouyingtai)
        setupNoPictureAlphaBgView(view: self.payChannelCollection)
        setupNoPictureAlphaBgView(view: self.fastMoney)
        
    }
    
    func updateMoneyDatas(index:Int){
        if self.onlines.isEmpty{
            return
        }
        moneyLimitTV.text = String.init(format: "温馨提示: 最低充值金额%d元，最大金额%d元", self.onlines[index].minFee,self.onlines[index].maxFee)
//        let isFix = self.onlines[index].isFixedAmount
        self.moneyDatas.removeAll()
        
//        if isFix != 1{
        
        let moneys = self.onlines[index].fixedAmount
        if !isEmptyString(str: moneys){
            moneyInput.isUserInteractionEnabled = false
            let moneyArr = moneys.components(separatedBy: ",")
            self.moneyDatas = moneyArr
        }else {
            moneyInput.isUserInteractionEnabled = true
        }
        
//        }else {
//            moneyInput.isUserInteractionEnabled = true
//        }
        
        var lines = CGFloat(self.moneyDatas.count/4)
        if self.moneyDatas.count % 4 != 0{
            lines = lines + 1
        }
        self.moneyCollectViewHeightConstrait.constant = lines > 0 ? lines*35+10 : 0
        self.fastMoney.reloadData()
    }
    
    private func setupTipsData() {
        var tips = "温馨提示：\n由于不同第三方支付的浏览器限制造成无法正常支付，请尝试切换其他浏览器来进行支付；您也可在设置中清除您选择的默认的支付浏览器，若有其他疑问，请联系客服。"
        if let config = getSystemConfigFromJson(){
            if config.content != nil{
                let tipsContents = config.content.tip_for_multi_browser_pay
                if !isEmptyString(str: tipsContents) {
                    tips = tipsContents
                }
            }
        }
        
//        self.tipsTextView.textColor = UIColor.red
        self.tipsTextView.text = tips
    }
    
    @objc func onConfirm(ui:UIButton){
        
        if self.onlines.isEmpty{
            showToast(view: self.view, txt: "没有支付方式，无法发起支付")
            return
        }
        let money = moneyInput.text!
        if isEmptyString(str: money){
            showToast(view: self.view, txt: "请输入充值金额")
            return
        }
//        if !isPurnInt(string: money){
//            showToast(view: self.view, txt: "请输入整数金额")
//            return
//        }
        
        let minFee = self.onlines[self.currentPayIndex].minFee
        let maxFee = self.onlines[self.currentPayIndex].maxFee
        
        guard let mmoney = Float(money) else {
            showToast(view: self.view, txt: "金额格式不正确,请重新输入")
            return
        }
        if mmoney < Float(minFee){
            showToast(view: self.view, txt: String.init(format: "充值金额不能小于%d元", minFee))
            return
        }
        
        if mmoney > Float(maxFee){
            showToast(view: self.view, txt: String.init(format: "充值金额不能大于%d元", maxFee))
            return
        }
        
        if self.shouyintais.isEmpty{
            showToast(view: self.view, txt: "没有收银台数据")
            return
        }
        
        let payId = self.onlines[self.currentPayIndex].id
        let bankCode = self.shouyintais[self.currSubPayRow]
        
        if payId == 0{
            showToast(view: self.view, txt: "请选择支付通道!")
            return
        }
        
        if isEmptyString(str: bankCode){
            showToast(view: self.view, txt: "请选择支付方式!")
            return
        }
        print("bankcode ",bankCode)
        request(frontDialog: true,method: .post,loadTextStr: "正在提交中...",url:ONLINE_PAY_URL,
                params: ["payId":payId,"amount":money,"bankCode":bankCode],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if !resultStatus {
                        showToast(view: self.view, txt: convertString(string: "提交失败"))
                        return
                    }
                    if isEmptyString(str: resultJson){
                        showToast(view: self.view, txt: "提交失败")
                        return
                    }
                    
                    guard let data = resultJson.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
                        return
                    }
                    guard let json = try? JSONSerialization.jsonObject(with: data,options:.allowFragments) as! [String: Any] else{
                        return
                    }
                    
                    
                    if (json.keys.contains("success")){
                        if !(json["success"] as! Bool){
                            let msg = json["msg"] as! String
                            showToast(view: self.view, txt: json["msg"] as! String)
                            if msg.contains("其他地方"){
                                loginWhenSessionInvalid(controller: self)
                            }
                            return
                        }
                        //判断是否弹窗
                        let browerType = YiboPreference.getDefault_brower_type()
                        if browerType == -1 && shouldShowBrowsersChooseView(){
                            self.showBrowerSelectedView(json: json)
                        }else if browerType != -1 && shouldShowBrowsersChooseView(){
                            self.handleData(json: json,browerType:browerType)
                        }else {
                            self.handleData(json: json,browerType:BROWER_TYPE_SAFARI)
                        }
                    }
        })
    }
    
    func gotoBrowerWithType(type: Int, allways: Bool) {
        if let json = self.jsonData {
            if allways {
                YiboPreference.setDefault_brower_type(value: "\(type)")
            }
            self.handleData(json: json,browerType:type)
        }
    }
    
    private func handleData(json: [String: Any],browerType: Int) {
        if let type = json["returnType"]{
            let returnType = type as! String
            if returnType == "qrcodeUrl"{
                let formActionStr = BASE_URL + PORT + "/onlinePay/qrcodeRedirect4App.do"
                var formParams:Dictionary<String,Any> = [:]
                formParams["rechargeSubmitFormData"] = json["url"] as! String
                formParams["rechargeSubmitOrderId"] = json["orderId"] as! String
                formParams["rechargeSubmitPayName"] = json["payName"] as! String
                formParams["rechargeSubmitPayType"] = json["payType"] as! String
                formParams["rechargeSubmitOrderTime"] = json["orderTime"] as! String
                formParams["rechargeSubmitPayAmount"] = json["payAmount"] as! String
                formParams["rechargeSubmitPayFlag"] = json["flag"] as! String
                let params = getJSONStringFromDictionary(dictionary: formParams as NSDictionary)
                guard var escapedString = params.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
                //将特殊字符替换成转义后的编码
                escapedString = escapedString.replacingOccurrences(of: "=", with: "%3D")
                escapedString = escapedString.replacingOccurrences(of: "&", with: "%26")
                let url = String.init(format: "%@%@%@?returnType=%@&url=%@&data=%@", BASE_URL,PORT,PAY_RESULT_SAFARI,returnType,formActionStr,escapedString)
                print("the open url = ",url)
                openInBrowser(url: url,browerType:browerType,view: self.view)
                
            }else if returnType == "postSubmit"{
                let formActionStr = json["url"] as! String
                let formParams = json["dataMap"] as! [String:Any]
                let params = getJSONStringFromDictionary(dictionary: formParams as NSDictionary)
                guard var escapedString = params.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
                //将特殊字符替换成转义后的编码
                escapedString = escapedString.replacingOccurrences(of: "=", with: "%3D")
                escapedString = escapedString.replacingOccurrences(of: "&", with: "%26")
                let url = String.init(format: "%@%@%@?returnType=%@&url=%@&data=%@", BASE_URL,PORT,PAY_RESULT_SAFARI,returnType,formActionStr,escapedString)
                print("the open url = ",url)
                openInBrowser(url: url,browerType:browerType,view: self.view)
            }else{
                let formActionStr = json["url"] as! String
                let url = String.init(format: "%@%@%@?returnType=%@&url=%@&data=%@", BASE_URL,PORT,PAY_RESULT_SAFARI,returnType,formActionStr,"")
                print("the open url = ",url)
                openInBrowser(url: url,browerType:browerType,view: self.view)
            }
        }else{
            let url = json["url"] as! String
            openInBrowser(url: url,browerType:browerType,view: self.view)
        }
    }
    
    
    //MARK: 弹窗显示浏览器选择
    private func showBrowerSelectedView(json: [String: Any]) {
        let tupeArray = [("Browser_safari","Safari浏览器"),("Browser_uc","UC浏览器"),
                         ("Browser_qq","QQ浏览器"),("Browser_google","谷歌浏览器"),
                         ("Browser_firefox","火狐浏览器")]
        let selectedView = NewSelectView(dataSource: tupeArray, viewTitle: "请选择浏览器")
        selectedView.delegate = self
        selectedView.selectedIndex = selectedIndex
        self.jsonData = json
        
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.selectedIndex = index
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
    }

    
    func actionCommitOrder(amount:String,payId:Int,bankCode:String){
        
    }
    
    func openConfirmPayController(orderNo:String,accountName:String,chargeMoney:String,
                                  payMethodName:String, receiveName:String,receiveAccount:String,dipositor:String,dipositorAccount:String,qrcodeUrl:String,payType:Int,payJson:String) -> Void {
        if self.navigationController != nil{
            openConfirmPay(controller: self, orderNo: orderNo, accountName: accountName, chargeMoney: chargeMoney, payMethodName: payMethodName, receiveName: receiveName, receiveAccount: receiveAccount, dipositor: dipositor, dipositorAccount: dipositorAccount, qrcodeUrl: qrcodeUrl, payType: payType, payJson: payJson)
        }
    }
    
    private func getPayMethodNamesData() {
        if payMethodNames.isEmpty && !self.onlines.isEmpty{
            for item in self.onlines{
                if isEmptyString(str: item.payAlias) {
                    self.payMethodNames.append(item.payName)
                }else {
                    self.payMethodNames.append(item.payAlias)
                }
            }
        }
        
        let row = self.payMethodNames.count / 3
        var collectionViewHeight: CGFloat = 0
        
        if row == 0 {
            collectionViewHeight = CGFloat(15) * CGFloat(2) +  CGFloat(40)
        }else if self.payMethodNames.count > row * 3 {
            collectionViewHeight = CGFloat(row) * CGFloat(15) + CGFloat(15) * CGFloat(2) + (CGFloat(row) + CGFloat(1)) * CGFloat(40)
        }else {
            collectionViewHeight = (CGFloat(row) - CGFloat(1)) * CGFloat(15) + CGFloat(15) * CGFloat(2)  + CGFloat(row) * CGFloat(40)
        }
        
        payChannelHeightConstrait.constant = collectionViewHeight
        
        if self.payMethodNames.isEmpty {
            showToast(view: self.view, txt: "没有支付方式，请联系客服")
        }
        
        payChannelCollection.reloadData()
    }
    
    func updateCurrentPayInfo(index:Int){
        if self.onlines.isEmpty{
            return
        }
        payMethodTV.text = self.onlines[index].payName
    }
    
    private func showPayDialog(){
        let selectedView = LennySelectView(dataSource: self.payMethodNames, viewTitle: "请选择支付")
        selectedView.selectedIndex = self.currentPayIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.currentPayIndex = index
            self?.currSubPayRow = 0
            self?.updateCurrentPayInfo(index:(self?.currentPayIndex)!)
            self?.updateMoneyDatas(index: (self?.currentPayIndex)!)
            let online = self?.onlines[(self?.currentPayIndex)!]
            self?.syncSysPayMethod(payId:(online?.id)!)
        }
        self.view.window?.addSubview(selectedView)
        selectedView.whc_Center(0, y: 0).whc_Width(MainScreen.width*0.75).whc_Height(selectedView.kHeight)
        selectedView.transform =  CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, animations: {
            selectedView.transform = CGAffineTransform.identity
        }) { (_) in
            //            self.setSelected(false, animated: true)
        }
    }
    
    //获取收银台列表
    func syncSysPayMethod(payId:Int){
        request(frontDialog: true,method: .get,loadTextStr: "正在同步中...",url:SYNC_SHOUYINGTAI_LIST,params: ["payId":payId],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        showToast(view: self.view, txt: convertString(string: "同步失败"))
                        return
                    }
                    if isEmptyString(str: resultJson){
                        showToast(view: self.view, txt: "同步失败")
                        return
                    }
                    if resultJson == "{}"{
                        showToast(view: self.view, txt: "没有支付方式")
                        self.shouyintais.removeAll()
                        self.shouyingtai.reloadData()
                        return
                    }
                    
                    if resultJson.contains("登录"){
                        loginWhenSessionInvalid(controller: self)
                        return
                    }
                    
                    do {
                        let data = resultJson.data(using: String.Encoding.utf8)
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
                        print("json == ",json)
                        self.shouyintais.removeAll()
                        self.shouyintais = self.shouyintais + json
                        var lines = CGFloat(self.shouyintais.count/3)
                        if self.shouyintais.count % 3 != 0{
                            lines = lines + 1
                        }
                        if lines > 0{
                            self.subPayCollectViewHeightConstrait.constant = lines*35+10 > 150 ? 150 : lines*35+10
                        }else{
                            self.subPayCollectViewHeightConstrait.constant = 0
                        }
                        self.shouyingtai.reloadData()
                    }catch let error {
                        print("convert: error \(error)")
                    }
                    
                    
                    
        })
    }

}

extension OnlinePayInfoController : UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 101{
            return CGSize.init(width: (kScreenWidth-0.5*6)/4, height: 35)
        }else if collectionView.tag == 102{
            return CGSize.init(width: (kScreenWidth-0.5*6 - 15 * 2)/3, height: 35)
        }else {
            return CGSize.init(width: (kScreenWidth-0.5*6)/4, height: 35)
        }
    }
    
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 101{
            return moneyDatas.count
        }else if collectionView.tag == 102{
            return shouyintais.count
        }else {
            return self.payMethodNames.count
        }
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 101{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PayInfoMoneyCell
            let data = self.moneyDatas[indexPath.row]
            cell.setupBtn(money: data)
            return cell
        }else if collectionView.tag == 102{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubPayMethodCell
            let data = self.shouyintais[indexPath.row]
            cell.setupBtn(payName: data)
            if self.currSubPayRow == indexPath.row{
                cell.moneyBtn.layer.theme_borderColor = "Global.themeColor"
            }else{
                cell.moneyBtn.layer.borderColor = UIColor.lightGray.cgColor
            }
            return cell
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "normalButtonCollectionCell", for: indexPath) as! NormalButtonCollectionCell
            
            var fast = self.payMethodNames[indexPath.row]
            if isEmptyString(str: fast) {
                fast = "没有名称"
            }
            cell.normalButton.setTitle(fast, for: .normal)
            cell.backgroundColor = UIColor.clear
            
            if currentPayIndex == indexPath.row {
                cell.normalButton.setBackgroundImage(UIImage(named: "payPathSelected"), for: .normal)
            }else {
                cell.normalButton.setBackgroundImage(UIImage(named: "payPathNoamal"), for: .normal)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 101{
            let data = self.moneyDatas[indexPath.row]
            self.moneyInput.text = data
        }else if collectionView.tag == 102{
            self.currSubPayRow = indexPath.row
            collectionView.reloadData()
        }else {
            currentPayIndex = indexPath.row
            self.currSubPayRow = 0
            self.updateCurrentPayInfo(index:(self.currentPayIndex))
            self.updateMoneyDatas(index: (self.currentPayIndex))
            let online = self.onlines[(self.currentPayIndex)]
            self.syncSysPayMethod(payId:(online.id))
            payChannelCollection.reloadData()
        }
    }
    
    
    
}
