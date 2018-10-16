//
//  UserInfoController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class UserInfoController: LennyBasicViewController {

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setupthemeBgView(view: self.view, alpha: 0)
        setViews()
        loadNetRequestWithViewSkeleton(animate: true)
    }

    private var mainTableView: UITableView!
    var model:UserInfoModel!
    
    private func setViews() {
        
        self.title = "用户资料"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
//        self.navigationController?.navigationBar.barTintColor = UIColor.ccolor(with: 236, g: 40, b: 40)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        mainTableView = UITableView()
        setViewBackgroundColorTransparent(view: mainTableView)
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.delegate = self
        mainTableView.dataSource = self
//        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = .none
        mainTableView.allowsSelection = false
        
//        let footView = UIView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50))
//        let button = UIButton()
//        button.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50)
//        footView.addSubview(button)
////        button.whc_Center(0, y: 0).whc_Width(201).whc_Height(31)
////        button.layer.cornerRadius = 5
////        button.clipsToBounds = true
////        button.backgroundColor = UIColor.ccolor(with: 236, g: 40, b: 40)
//        button.setTitle("提交", for: .normal)
//        button.isHidden = false
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.theme_backgroundColor = "Global.themeColor"
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
//        button.addTarget(self, action: #selector(UserInfoController.commitAction), for: .touchUpInside)
//        mainTableView.tableFooterView = footView
    }
    
    
    private func showAlertController(index: Int) {
        
        var title = ""
        var typeContents = ""
        if index == 2 {title = "手机号修改";typeContents = "phone"}
        else if index == 3 {title = "邮箱修改";typeContents = "email"}
        else if index == 4 {title = "QQ修改";typeContents = "QQ"}
        else if index == 5 {title = "微信修改";typeContents = "wechat"}
        
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction.init(title: "确定", style: .default) { _ in
            print("确定")
            if let originalContents = alert.textFields![0].text {
                
               if let newContents = alert.textFields![1].text {
                
//                if newContents.length == 0{showToast(view: self.view, txt: "未填写修改内容");return}
                
                   if let confirmContents = alert.textFields![2].text {
                    
//                    if newContents.length == 0{showToast(view: self.view, txt: "未填写确认内容");return}
                    
                    if confirmContents == newContents {
                        let params = ["newInfo": newContents,"oldInfo": originalContents,"type": typeContents]
                        self.commitAction(index: index,params: params)
                    }else {
                        showToast(view: self.view, txt: "两次输入不一致")
                        return
                    }

                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (_) in}
        
        alert.addTextField { (originalContents) in
            originalContents.clearButtonMode = .always
            if index == 2 {originalContents.placeholder = "请输入原手机号";originalContents.keyboardType = .numberPad}
            else if index == 3 {originalContents.placeholder = "请输入原邮箱"}
            else if index == 4 {originalContents.placeholder = "请输入原QQ号"}
            else if index == 5 {originalContents.placeholder = "请输入原微信号"}
        }
        
        alert.addTextField { (newContents) in
            if index == 2 {newContents.placeholder = "请输入新手机号";newContents.keyboardType = .numberPad}
            else if index == 3 {newContents.placeholder = "请输入新邮箱"}
            else if index == 4 {newContents.placeholder = "请输入新QQ号"}
            else if index == 5 {newContents.placeholder = "请输入新微信号"}
        }
        
        alert.addTextField { (confirmContents) in
            if index == 2 {confirmContents.placeholder = "请确认新手机号";confirmContents.keyboardType = .numberPad}
            else if index == 3 {confirmContents.placeholder = "请确认新邮箱"}
            else if index == 4 {confirmContents.placeholder = "请确认新QQ号"}
            else if index == 5 {confirmContents.placeholder = "请确认新微信号"}
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true) {}
    }
    
    private func commitAction(index: Int,params: Dictionary<String, Any>) {
        
//        let tag = 10000
//        let username = self.mainTableView.viewWithTag(0 + tag) as! UITextField
//        let phone = self.mainTableView.viewWithTag(1 + tag) as! UITextField
//        let realName = self.mainTableView.viewWithTag(2 + tag) as! UITextField
//        let email = self.mainTableView.viewWithTag(3 + tag) as! UITextField
//        let QQ = self.mainTableView.viewWithTag(4 + tag) as! UITextField
//        let wechat = self.mainTableView.viewWithTag(5 + tag) as! UITextField

//        let params = ["newInfo": "17510354028","oldInfo": "15910354088","type": "phone"]
        request(frontDialog: true,method: .post, loadTextStr:"修改中...",url:API_UpdateUSER_INFO,params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        if resultJson.isEmpty {
                            showToast(view: self.view, txt: convertString(string: "获取数据失败"))
                        }else{
                            showToast(view: self.view, txt: resultJson)
                        }
                        return
                    }
                    if let result = LoginOutWrapper.deserialize(from: resultJson){
                        if result.success{
                            if !isEmptyString(str: result.accessToken){
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                            }
                            showToast(view: self.view, txt: "修改成功")
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取数据失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    override func loadNetRequestWithViewSkeleton(animate: Bool) {
        super.loadNetRequestWithViewSkeleton(animate: true)
        LennyNetworkRequest.obtainUserinfo(){
            (model) in
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
                return
            }
            self.model = model
            self.view.hideSkeleton()
            self.refreshTableViewData()
        }
    }
    
    override func refreshTableViewData() {
        mainTableView.reloadData()
    }
}

extension UserInfoController: UITableViewDelegate {
    
}

extension UserInfoController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    @objc private func editContents(button: UIButton) {
        let tag = button.tag - 20000
        switch tag {
        case 0,1:
            print("不能更改")
        case 2,3,4,5:
            showAlertController(index: tag)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if let cellP = cell {
            setViewBackgroundColorTransparent(view: cellP)
        }
        
        if cell == nil {
            guard let model = self.model else {return UITableViewCell()}
            guard let content = model.content else {return UITableViewCell()}
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            setupNoPictureAlphaBgView(view: cell)
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell?.textLabel?.textColor = UIColor.ccolor(with: 51, g: 51, b: 51)
            
            cell?.contentView.whc_AddBottomLine(0.5, color: UIColor.ccolor(with: 224, g: 224, b: 224))
            let textField = UITextField()
            cell?.contentView.addSubview(textField)
            textField.whc_CenterY(0).whc_Left(120).whc_Right(20).whc_Top(5).whc_Bottom(5)
            textField.borderStyle = .none
            textField.tag = indexPath.row + 10000
            textField.isUserInteractionEnabled = false
            
            let editButton = UIButton.init()
            editButton.isHidden = false
            cell?.contentView.addSubview(editButton)
            editButton.setBackgroundImage(UIImage(named: "fast_money_normal_bg"), for: .normal)
//            editButton.layer.borderWidth = 1
//            editButton.layer.borderColor = UIColor.gray.cgColor
            editButton.setTitleColor(.black, for: .normal)
            editButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            editButton.setTitle("修改", for: .normal)
            editButton.tag = indexPath.row + 20000
            editButton.addTarget(self, action: #selector(self.editContents), for: .touchUpInside)
            editButton.whc_CenterY(0).whc_Right(10).whc_Top(8).whc_Bottom(8).whc_Width(45)
            
            switch indexPath.row {
            case 0:
                editButton.isHidden = true
                cell?.imageView?.image = UIImage.init(named: "usericon")
                cell?.textLabel?.text = "用户昵称: "
                textField.backgroundColor = .clear
                textField.text = (content.username)!
                break
            case 1:
                editButton.isHidden = true
                cell?.imageView?.image = UIImage.init(named: "realname")
                cell?.textLabel?.text = "真实姓名: "
                textField.text = (content.realName)!
                break
            case 2:
                cell?.imageView?.image = UIImage.init(named: "userphone")
                cell?.textLabel?.text = "用户手机: "
                textField.text = (content.phone)!
                break
            case 3:
                cell?.imageView?.image = UIImage.init(named: "email")
                cell?.textLabel?.text = "用户邮箱: "
                textField.text = (content.email)!
                break
            case 4:
                cell?.imageView?.image = UIImage.init(named: "QQ")
                cell?.textLabel?.text = "用户QQ: "
                textField.text = (content.qq)!
                break
            case 5:
                cell?.imageView?.image = UIImage.init(named: "wechat")
                cell?.textLabel?.text = "用户微信: "
                textField.text = (content.wechat)!
            default:
                break
            }
            
            
        }
        return cell!
    }
}
