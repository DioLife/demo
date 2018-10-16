//
//  SendMessageController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/8.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit
//发送站内短信
class SendMessageController: LennyBasicViewController {

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view, alpha: 0)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        setViews()
    }
    
    var datas:[UserListSmallBean] = []
    var isUp:Bool = true
    var belonguserids = [String]()
    private let mainTableView = UITableView()
    
    private func setViews() {
        
        self.title = "发送站内短信"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        setViewBackgroundColorTransparent(view: mainTableView)
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.tableFooterView = footerView()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 56
        
    }
    
    private func footerView() -> UIView {
        
        let footerView = UIView()
        footerView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 200)
        
        let button_Cancel = UIButton()
        let button_Send = UIButton()
        let stackView = WHC_StackView()
        footerView.addSubview(stackView)
        stackView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        stackView.whc_Column = 2
        stackView.whc_Orientation = .all
        stackView.whc_HSpace = 50
        stackView.whc_Edge = UIEdgeInsetsMake(35, 25, 20, 25)
        stackView.whc_SubViewHeight = 35
        
        stackView.addSubview(button_Cancel)
        button_Cancel.backgroundColor = UIColor.ccolor(with: 191, g: 191, b: 191)
        button_Cancel.setTitle("取消", for: .normal)
        button_Cancel.addTarget(self, action: #selector(onBackClick), for: .touchUpInside)
        button_Cancel.setTitleColor(UIColor.white, for: .normal)
        button_Cancel.layer.cornerRadius =  5
        button_Cancel.clipsToBounds = true
        stackView.addSubview(button_Send)
        button_Send.setTitle("确定", for: .normal)
        
        button_Send.setTitleColor(UIColor.white, for: .normal)
        button_Send.addTarget(self, action: #selector(onSendClick), for: .touchUpInside)
        button_Send.theme_backgroundColor = "Global.themeColor"
        button_Send.layer.cornerRadius = 5
        button_Send.clipsToBounds = true
        stackView.whc_StartLayout()
        
        return footerView
    }
    
    private func getDownUsers(){
        let params = ["username":"","minBalance":"","maxBalance":"",
                      "start":"","end":"","pageNumber":1,"pageSize":50] as [String : Any]
        
        request(frontDialog: true, method:.get, loadTextStr:"获取中...", url:API_USERLISTDATA,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    
                    if let result = UserListBeanWraper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if result.content != nil{
                                if let datas = result.content?.rows{
                                    self.datas = datas
                                    if datas.isEmpty{
                                        showToast(view: self.view, txt: "没有下级用户")
                                        return
                                    }
                                    if !self.isUp && !datas.isEmpty{
                                        let cell = self.mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! SendMessageUserSelectCell
                                        cell.bind(controller: self, datas: self.datas)
                                    }
                                }
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                self.print_error_msg(msg: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if (result.code == 0) {
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
                    
        })
        
//        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onSendClick(){
        let cell1 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! SendMessageReceiverCell
        let up = cell1.button_SuperiorLeader.isSelected
        let cell2 = mainTableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! SendMessageTitleCell
        let title = cell2.textField.text!
        let cell3 = mainTableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! SendMessageContentCell
        let content = cell3.textView.text
        
        if isEmptyString(str: title){
            showToast(view: self.view, txt: "请输入标题")
            return
        }
        if isEmptyString(str: content!){
            showToast(view: self.view, txt: "请输入内容")
            return
        }
        
        if !up && belonguserids.isEmpty{
            showToast(view: self.view, txt: "请选择下级用户")
            return
        }
        
        //使用默认的发送类型
        var params:Dictionary<String,Any> = ["title":title,"message":content!,"sendType":"2"]
        print("has select up level = ",up)
        if up{
            params["receiveType"] = "4"
        }else{
            params["receiveType"] = "5"
            //接受者ids
            if !self.belonguserids.isEmpty{
                var names = ""
                for name in self.belonguserids{
                    names += name
                    names += ","
                }
                names = (names as NSString).substring(to: names.count - 1)
                params["receiveIds"] = names
            }
            
        }
        
        LennyNetworkRequest.commitSendMesage(params: params){
            (model) in
            if !(model?.success)!{
                if let msg = model?.msg{
                    if !isEmptyString(str: msg){
                        showToast(view: self.view, txt: msg)
                    }else{
                        showToast(view: self.view, txt: "发送失败")
                    }
                }
                if model?.code == 0{
                    loginWhenSessionInvalid(controller: self)
                }
                return
            }
            showToast(view: self.view, txt: "发送成功")
//            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension SendMessageController: UITableViewDelegate {
    
}

extension SendMessageController: DownLevelUserDelegate {
    func selectedUsed(id:String,hasData:Bool){
        if !hasData{
            getDownUsers()
            return
        }
        if isEmptyString(str: id){
            return
        }
        if !belonguserids.contains(id){
            belonguserids.append(id)
        }
    }
}

extension SendMessageController: LevelSelectDelegate{
    func onLevelDelegate(up: Bool) {
        isUp = up
        mainTableView.reloadData()
    }
}

extension SendMessageController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.isUp ? 3 : 4
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 35
        }else if indexPath.row == 1{
            return self.isUp ? 0 : 40
        }else if indexPath.row == 2{
            return 35
        }else if indexPath.row == 3{
            return 180
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: String.init(format: "cell.%d", indexPath.row))
        if cell == nil {
            if indexPath.row == 0 {
                let cell = SendMessageReceiverCell.init(style: .default, reuseIdentifier: String.init(format: "cell.%d", indexPath.row))
                cell.delegate = self
                return cell
            }
            if indexPath.row == 2 {
                cell = SendMessageTitleCell.init(style: .default, reuseIdentifier: String.init(format: "cell.%d", indexPath.row))
            }
            if indexPath.row == 3 {
                cell = SendMessageContentCell.init(style: .default, reuseIdentifier: String.init(format: "cell.%d", indexPath.row))
            }
        }
        
        if indexPath.row == 1 {
            let cell = SendMessageUserSelectCell.init(style: .default, reuseIdentifier: String.init(format: "cell.%d", indexPath.row))
            cell.updateView(isup:self.isUp)
            cell.delegate = self
            return cell
        }
        
        return cell!
    }
}
