//
//  NewChargeMoneyController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit

//新充值页
class NewChargeMoneyController: BaseController {
    
    
    @IBOutlet weak var headerBgImage: UIImageView!
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var headerImg:UIImageView!
    @IBOutlet weak var accountTV:UILabel!
    @IBOutlet weak var balanceTV:UILabel!
    @IBOutlet weak var tableView:UITableView!
    var meminfo:Meminfo?
    var payMethods:PayMethodResult!
    var selectPayType = PAY_METHOD_ONLINE;//已选择的支付方式
    
    var datas:[Dictionary<String,String>] = [["img":"topup_zaixianzhifu","text":"在线支付"],["img":"topup_weixinzhifu","text":"微信支付"],["img":"topup_zhifubaozhifu","text":"支付宝支付"],["img":"topup_yinhangkazhifu","text":"银行卡转账支付"]]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnnounce(controller: self)
    }
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setupthemeBgView(view: self.view,alpha: 0)
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        self.title = "充值"
        headerBgImage.theme_image = "General.personalHeaderBg"
        headerImg.theme_image = "General.placeHeader"
        headerBgImage.contentMode = .scaleAspectFill
        headerBgImage.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        if self.meminfo == nil{
            syncAccount()
        }else{
            //赋值帐户名及余额
            self.updateAccount(memInfo: self.meminfo!)
            self.syncPayMethod()
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        headerView.isUserInteractionEnabled = true
        addGestureRecognizer(headerView: headerView)
    }
    
    private func addGestureRecognizer(headerView:UIView) {
        let longPress = UITapGestureRecognizer(target: self, action: #selector(self.pressClick))
        headerView.isUserInteractionEnabled = true
        headerView.addGestureRecognizer(longPress)
    }
    
    @objc func pressClick(){
        self.navigationController?.pushViewController(UserInfoController(), animated: true)
    }
    
    func updateAccount(memInfo:Meminfo) -> Void {
        var accountNameStr = ""
        var leftMoneyName = ""
        if !isEmptyString(str: memInfo.account){
            accountNameStr = memInfo.account
        }else{
            accountNameStr = "暂无名称"
        }
        accountTV.text = accountNameStr
        if !isEmptyString(str: memInfo.balance){
            leftMoneyName = "余额:\(memInfo.balance)"
        }else{
            leftMoneyName = "0"
        }
        balanceTV.text = String.init(format: "%@元",  leftMoneyName)
    }
    
    func showNoticeDialog(title:String,content:String) -> Void {
        let qrAlert = PopupAlert.init(title: title, message: content, cancelButtonTitle: nil, sureButtonTitle: "我知道了")
        qrAlert.show()
    }
    
    
    // 遍历数组,取出公告赋值
    private func forArrToAlert(notices: Array<NoticeResult>) {
        
        var noticesP = notices
        noticesP = noticesP.sorted { (noticesP1, noticesP2) -> Bool in
            return noticesP1.sortNum < noticesP2.sortNum
        }
        
        var models = [NoticeResult]()
        for index in 0..<noticesP.count {
            let model = noticesP[index]
            if model.isDeposit {
                models.append(model)
            }
        }
        
        if models.count > 0 {
            let weblistView = WebviewList.init(noticeResuls: models)
            weblistView.show()
        }
    }
    
    
    
    private func showAnnounce(controller:BaseController) {
        if YiboPreference.isShouldAlert_isAll() == "" {
            YiboPreference.setAlert_isAll(value: "on" as AnyObject)
        }
        
        if YiboPreference.isShouldAlert_isAll() == "off"{
            return
        }
        //获取公告弹窗内容
        controller.request(frontDialog: false, url:ACQURIE_NOTICE_POP_URL,params:["code":19],
                           callback: {(resultJson:String,resultStatus:Bool)->Void in
                            if !resultStatus {
                                return
                            }
                            
                            if let result = NoticeResultWraper.deserialize(from: resultJson){
                                if result.success{
                                    YiboPreference.setToken(value: result.accessToken as AnyObject)
                                    if let notices = result.content{
                                        //显示公告内容
                                        if notices.isEmpty{
                                            return
                                        }else {
                                            
                                            self.forArrToAlert(notices: notices)
                                        }
                                    }
                                }
                            }
        })
    }
}

extension NewChargeMoneyController{
    
    func syncAccount() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "同步帐号信息...",url:MEMINFO_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    if let result = MemInfoWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let memInfo = result.content{
                                //赋值帐户名及余额
                                self.updateAccount(memInfo: memInfo)
                                self.syncPayMethod()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "同步帐户信息失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func updatePayListAfterSyncMethods(){
        if self.payMethods == nil{
            return
        }
        self.datas.removeAll()
        if !self.payMethods.online.isEmpty{
            self.datas.append(["img":"topup_zaixianzhifu","text":"在线支付"])
        }
        if !self.payMethods.fast.isEmpty{
            self.datas.append(["img":"topup_weixinzhifu","text":"微信支付"])
        }
        if !self.payMethods.fast2.isEmpty{
            self.datas.append(["img":"topup_zhifubaozhifu","text":"支付宝支付"])
        }
        if !self.payMethods.fast_qq.isEmpty{
            self.datas.append(["img":"qqfu","text":"QQ支付"])
        }
        if !self.payMethods.fast_ysf.isEmpty{
            self.datas.append(["img":"yunshanfu","text":"云闪付"])
        }
        if !self.payMethods.bank.isEmpty{
            self.datas.append(["img":"topup_yinhangkazhifu","text":"银行卡转账支付"])
        }
        self.tableView.reloadData()
    }
    
    func syncPayMethod() -> Void {
        request(frontDialog: true,method: .get,loadTextStr: "获取充值方式中...",url:GET_PAY_METHODS_URL,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        return
                    }
                    if let result = PayMethodWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let payMethods = result.content{
                                self.payMethods = payMethods
                                self.updatePayListAfterSyncMethods()
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取充值方式失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    
}

extension NewChargeMoneyController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "payCell") as? PayListCell  else {
            fatalError("The dequeued cell is not an instance of PayListCell.")
        }
        cell.setModel(model: self.datas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let data = self.datas[row]
        let name = data["text"]
        if let methods = self.payMethods{
            if name == "在线支付"{
                goOnlinePayController(onlines: methods.online)
            }else if name == "微信支付"{
                goWeixinPayController(weixins: methods.fast)
            }else if name == "支付宝支付"{
                goAlipayPayController(alipays: methods.fast2,title: name!)
            }else if name == "银行卡转账支付"{
                goBankPayController(banks: methods.bank)
            }else if name == "QQ支付"{
                goAlipayPayController(alipays: methods.fast_qq,title: name!)
            }else if name == "云闪付"{
                goAlipayPayController(alipays: methods.fast_ysf,title: name!)
            }
        }
    }
    
    private func goWeixinPayController(weixins:[FastPay]){
        let vc = UIStoryboard(name: "fast_pay_info_page",bundle:nil).instantiateViewController(withIdentifier: "fast_pay_info") as! FastPayInfoController
        vc.fasts = weixins
        vc.is_wx = true
        vc.meminfo = meminfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goAlipayPayController(alipays:[FastPay],title: String){
        let vc = UIStoryboard(name: "fast_pay_info_page",bundle:nil).instantiateViewController(withIdentifier: "fast_pay_info") as! FastPayInfoController
        vc.payFunction = title
        vc.fasts = alipays
        vc.is_wx = false
        vc.meminfo = meminfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goBankPayController(banks:[BankPay]){
        let vc = UIStoryboard(name: "bank_pay_info_page",bundle:nil).instantiateViewController(withIdentifier: "bank_pay_info") as! BankPayInfoController
        vc.banks = banks
        vc.meminfo = meminfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func goOnlinePayController(onlines:[OnlinePay]){
        let vc = UIStoryboard(name: "online_pay_info_page",bundle:nil).instantiateViewController(withIdentifier: "online_pay") as! OnlinePayInfoController
        vc.onlines = onlines
        vc.meminfo = meminfo
        let abc = meminfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}












