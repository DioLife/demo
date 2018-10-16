//
//  BankPayInfoController.swift
//  gameplay
//
//  Created by yibo-johnson on 2018/6/22.
//  Copyright © 2018年 yibo. All rights reserved.
//

import UIKit
//银行支付信息填写

class BankPayInfoController: BaseController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var isSelect = false
    var banks:[BankPay] = []
    
    var gameDatas = [FakeBankBean]()
    var currentChannelIndex:Int = 0//绑定的银行卡通道列表
    var selectedBankWayIndex:Int = 0;//选择的转账类型列表
    var selectedBankWay:Int = 0
    
    var inputMoney = ""
    var inputDeposiName = ""
    var meminfo:Meminfo?
    var bankWays:[BankWayBean] = []
    var bankWanyNames:[String] = []
    
    @IBOutlet weak var moneyLimitTV:UILabel!
    @IBOutlet weak var tablview:UITableView!
    @IBOutlet weak var confirmBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        self.title = "银行转账"
        
        tablview.delegate = self
        tablview.dataSource = self
        tablview.showsVerticalScrollIndicator = false
        tablview.tableHeaderView = self.createCollectionView()
        self.tablview.tableFooterView = UIView.init(frame: CGRect.zero)
        confirmBtn.addTarget(self, action: #selector(onCommitBtn(ui:)), for: .touchUpInside)
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.theme_backgroundColor = "Global.themeColor"
        prepareBankWays()
    
        updateContentWhenChannelChange(index: self.currentChannelIndex)
    }
    
    
    private func createCollectionView() -> UIView {
        let row = self.banks.count / 3
        var collectionViewHeight: CGFloat = 0
        
        if row == 0 {
            collectionViewHeight = CGFloat(15) * CGFloat(2) +  CGFloat(40)
        }else if self.banks.count > row * 3 {
            collectionViewHeight = CGFloat(row) * CGFloat(15) + CGFloat(15) * CGFloat(2) + (CGFloat(row) + CGFloat(1)) * CGFloat(40)
        }else {
            collectionViewHeight = (CGFloat(row) - CGFloat(1)) * CGFloat(15) + CGFloat(15) * CGFloat(2)  + CGFloat(row) * CGFloat(40)
        }
        
        
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
        setupNoPictureAlphaBgView(view: colltionView,alpha: 0.2)
        
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
        
        var fast = self.banks[indexPath.row].payName
        if isEmptyString(str: fast) {
            fast = "没有名称"
        }
        
        cell.normalButton.setTitle(fast, for: .normal)
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
        return self.banks.count
    }
    
    //点击更换通道后，更新新支付信息到view
    private func updateContentWhenChannelChange(index:Int){
        if self.banks.isEmpty{
            return
        }
        self.gameDatas.removeAll()
        let bank = self.banks[index]
        moneyLimitTV.text = String.init(format: "温馨提示: 最低充值金额%d元，最大金额%d元", bank.minFee,bank.maxFee)
        getFakeModels(bank: bank)
        self.tablview.reloadData()
    }
    
    func prepareBankWays(){
        let item1 = BankWayBean()
        item1.name = "网银转账"
        item1.type = 1
        bankWays.append(item1)
        bankWanyNames.append(item1.name)
        
        let item2 = BankWayBean()
        item2.name = "ATM入款"
        item2.type = 2
        bankWays.append(item2)
        bankWanyNames.append(item2.name)
        
        let item3 = BankWayBean()
        item3.name = "银行柜台"
        item3.type = 3
        bankWays.append(item3)
        bankWanyNames.append(item3.name)
        
        let item4 = BankWayBean()
        item4.name = "手机转账"
        item4.type = 4
        bankWays.append(item4)
        bankWanyNames.append(item4.name)
        
        let item5 = BankWayBean()
        item5.name = "支付宝"
        item5.type = 5
        bankWays.append(item5)
        bankWanyNames.append(item5.name)
        
    }
    
    func getFakeModels(bank:BankPay){
        let item1 = FakeBankBean()
        item1.text = "收款通道"
        item1.value = String.init(format: "%@", bank.payName)
        gameDatas.append(item1)
        let item2 = FakeBankBean()
        item2.text = "收款账号"
        item2.value = bank.bankCard
        gameDatas.append(item2)
        let item3 = FakeBankBean()
        item3.text = "收款人名"
        item3.value = bank.receiveName
        gameDatas.append(item3)
        let item4 = FakeBankBean()
        item4.text = "收款银行"
        item4.value = bank.payName
        gameDatas.append(item4)
        
        let item5 = FakeBankBean()
        item5.text = "转账类型"
        item5.value = self.bankWanyNames[selectedBankWay]
        gameDatas.append(item5)
        
        let item6 = FakeBankBean()
        item6.text = "汇款人名"
        item6.value = ""
        gameDatas.append(item6)
        
        let item7 = FakeBankBean()
        item7.text = "存入金额"
        item7.value = ""
        gameDatas.append(item7)
    }
    
    
    @objc func onCommitBtn(ui:UIButton){
        
        let fast = self.banks[0]
        
        if isEmptyString(str: self.inputMoney){
            showToast(view: self.view, txt: "请输入转账金额")
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
        
        if isEmptyString(str: inputDeposiName){
            showToast(view: self.view, txt: "请输入汇款人名")
            return
        }
        
        if selectedBankWay == 0{
            showToast(view: self.view, txt: "请选择转账类型")
            return
        }
        
        let payId = fast.id
        let payCode = "bank"
        let amount = self.inputMoney
//        if let dn = meminfo?.account.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
//            depositName = dn as String
//        }
        let parameter = ["payCode": payCode,"amount":amount,"payId":payId,"depositName":inputDeposiName,"bankWay":selectedBankWay,"belongsBank":""] as [String : Any]
        
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
                                    
                                    self.openConfirmPayController(orderNo: orderno, accountName: account, chargeMoney: amount, payMethodName: payName, receiveName: fast.receiveName, receiveAccount: fast.bankCard, dipositor: self.inputDeposiName, dipositorAccount: "", qrcodeUrl: "", payType: PAY_METHOD_BANK, payJson: "")
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
}

extension BankPayInfoController :UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
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
        if model.text.contains("金额") || model.text.contains("汇款人"){
            cell.inputTV.isHidden = false
            cell.valueTV.isHidden = true
            cell.inputTV.text = model.value
            cell.inputTV.placeholder = String.init(format: "请输入%@", model.text)
        }else{
            cell.inputTV.isHidden = true
            cell.valueTV.isHidden = false
            cell.valueTV.text = model.value
        }
        if model.text == "收款账号" || model.text == "收款人名" || model.text == "收款银行"{
            cell.copyBtn.isHidden = false
            cell.copyBtn.tag = indexPath.row
            cell.copyBtn.addTarget(self, action: #selector(onCopyBtn(ui:)), for: .touchUpInside)
        }else{
            cell.copyBtn.isHidden = true
        }
        
        if model.text.contains("金额"){
            cell.inputTV.keyboardType = .decimalPad
        }
        if indexPath.row == 0 || indexPath.row == 4{
            cell.accessoryType = .disclosureIndicator
        }else{
            cell.accessoryType = .none
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0
        }else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (isSelect == false) {
            isSelect = true
            
            if indexPath.row == 0{
                self.showChannelDialog()
            }else if indexPath.row == 4{
                self.showBankWayDialog()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isSelect = false
            }
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    @objc func onInput(ui:UITextField){
        let text = ui.text!
        self.gameDatas[ui.tag].value = text
        if ui.tag == 5{
            self.inputDeposiName = text
        }else if ui.tag == 6{
            self.inputMoney = text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    private func showChannelDialog(){
        
        var bankNames:[String] = []
        for bank in self.banks{
            bankNames.append(bank.payName)
        }
        
        let selectedView = LennySelectView(dataSource: bankNames, viewTitle: "请选择通道")
        selectedView.selectedIndex = self.currentChannelIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.currentChannelIndex = index
            self?.updateContentWhenChannelChange(index: index)
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
    
    private func showBankWayDialog(){
        let selectedView = LennySelectView(dataSource: self.bankWanyNames, viewTitle: "请选择转账类型")
        selectedView.selectedIndex = self.selectedBankWayIndex
        selectedView.didSelected = { [weak self, selectedView] (index, content) in
            self?.selectedBankWayIndex = index
            self?.selectedBankWay = (self?.bankWays[index].type)!
            self?.gameDatas[4].value = (self?.bankWanyNames[index])!
            self?.tablview.reloadData()
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
    
}
