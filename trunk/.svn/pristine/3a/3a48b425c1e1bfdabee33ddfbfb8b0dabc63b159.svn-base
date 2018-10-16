//
//  NoticesPageController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/3/29.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class NoticesPageController: BaseController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    var notices:[NoticeBean] = []
    
    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        
        setupthemeBgView(view: self.view,alpha: 0)
        
        if #available(iOS 11, *){} else {self.automaticallyAdjustsScrollViewInsets = false}
        self.navigationItem.title = "网站公告"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        loadNoticeDatas()
        
    }
    
    func loadNoticeDatas(){
        self.request(frontDialog: true, method:.get, loadTextStr:"获取中", url:API_NEW_NOTICE,
                     callback: {(resultJson:String,resultStatus:Bool)->Void in
                        if !resultStatus {
                            if resultJson.isEmpty {
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }else{
                                showToast(view: self.view, txt: resultJson)
                            }
                            return
                        }
                        if let result = NoticeWraper.deserialize(from: resultJson){
                            if result.success{
                                YiboPreference.setToken(value: result.accessToken as AnyObject)
                                self.notices.removeAll()
                                self.notices = result.content
                                self.tableView.reloadData()
                            }else{
                                if !isEmptyString(str: result.msg){
                                    showToast(view: self.view, txt: result.msg)
                                }else{
                                    showToast(view: self.view, txt: convertString(string: "获取失败"))
                                }
                                if (result.code == 0) {
                                    loginWhenSessionInvalid(controller: self)
                                }
                            }
                        }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.notices.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notice") as? NoticeCell  else {
            fatalError("The dequeued cell is not an instance of NoticeCell.")
        }
        let data = self.notices[indexPath.row]
        if let title = data.title{
            cell.txt.text = title
        }
        return cell
    }
    
    func showNoticeDialog(title:String,content:String) -> Void {
        let qrAlert = PopupAlert.init(title: title, message: content, cancelButtonTitle: nil, sureButtonTitle: "好的")
        qrAlert.show()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        let data = self.notices[indexPath.row]
        if let content = data.content{
            showNoticeDialog(title: "公告消息", content: content)
        }
        
    }

}
