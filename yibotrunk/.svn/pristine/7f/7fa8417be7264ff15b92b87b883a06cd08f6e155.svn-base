//
//  MessageCenterController.swift
//  YiboGameIos
//
//  Created by yibo-johnson on 2018/1/19.
//  Copyright © 2018年 com.lvwenhan. All rights reserved.
//

import UIKit

class MessageCenterController: BaseTableViewController {
    
    var page = 1
    let pageSize = 20
    var datas:[MessageData] = []
    
    let UNREAD_STATUS = 1;
    let READ_STATUS = 2;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的站内信"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBackClick))
        loadDatas(showDialog:true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.datas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mcCell") as? MessageCenterCell  else {
            fatalError("The dequeued cell is not an instance of MessageCenterCell.")
        }
        // Configure the cell...
        let data = self.datas[indexPath.row]
        cell.titleUI.text = data.title
        cell.contentUI.text = data.message
        if data.status == UNREAD_STATUS || data.status == 0{
            cell.statusUI.text = "未读"
            cell.statusUI.textColor = UIColor.red
            cell.titleUI.textColor = UIColor.black
            cell.contentUI.font = UIFont.boldSystemFont(ofSize: 14)
            cell.titleUI.font = UIFont.boldSystemFont(ofSize: 16)
            cell.contentUI.textColor = UIColor.black
        }else{
            cell.statusUI.text = "已读"
            cell.statusUI.textColor = UIColor.blue
            cell.titleUI.textColor = UIColor.lightGray
            cell.contentUI.font = UIFont.systemFont(ofSize: 14)
            cell.titleUI.font = UIFont.systemFont(ofSize: 16)
            cell.contentUI.textColor = UIColor.lightGray
        }
        cell.timeUI.text = timeStampToString(timeStamp: data.createTime)
        return cell
    }
    
    func showContentDialog(title:String,content:String) -> Void {
        let alertController = UIAlertController(title: title,
                                                message: content, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.datas[indexPath.row]
//        showContentDialog(title: data.title, content: data.message)
        showFuncdialog(data: data)
        //若是未读的消息，则请求后台设置成已读
        if data.status != 2{
            syncRead(id: data.id)
        }
    }
    
    func showFuncdialog(data:MessageData) -> Void {
        let alert = UIAlertController.init(title: "选择操作", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction.init(title: "查看", style: .default, handler: {(action:UIAlertAction) in
            self.showContentDialog(title: data.title, content: data.message)
        })
        let action2 = UIAlertAction.init(title: "删除", style: .default, handler: {(action:UIAlertAction) in
            self.deleteMessage(id: data.userMessageId)
        })
        alert.addAction(action1)
        alert.addAction(action2)
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    /**
     * 置已读
     */
    func syncRead(id:Int) -> Void {
        request(frontDialog: false,method: .post, url: SET_READ_URL,
                params:["id":id],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        showToast(view: self.view, txt: convertString(string: "设置已读失败"))
                        return
                    }
                    if let result = MessageResultWrapper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            print("set message status to read")
                            self.loadDatas(showDialog:false)
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "设置已读失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    /**
     * delete message
     */
    func deleteMessage(id:Int) -> Void {
        request(frontDialog: false,method: .post, url: DELETE_MESSAGE_URL,
                params:["id":id],
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        showToast(view: self.view, txt: convertString(string: "删除失败"))
                        return
                    }
                    if let result = MessageResultWrapper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            self.loadDatas(showDialog:false)
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "删除成功"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }
    
    func loadDatas(showDialog:Bool) -> Void {
        let params:Dictionary<String,AnyObject> = ["status":0 as AnyObject,"pageNumber":page as AnyObject,"pageSize":pageSize as AnyObject]
        request(frontDialog: showDialog, loadTextStr:"获取中...", url: MESSAGE_LIST_URL,
                params:params,
                callback: {(resultJson:String,resultStatus:Bool)->Void in
                    if !resultStatus {
                        showToast(view: self.view, txt: "获取失败")
                        return
                    }
                    if let result = MessageResultWrapper.deserialize(from: resultJson){
                        if result.success{
                            YiboPreference.setToken(value: result.accessToken as AnyObject)
                            if let content = result.content{
                                if let list = content.datas{
                                    self.datas.removeAll()
                                    self.datas = self.datas + list
                                    self.tableView.reloadData()
                                }
                            }
                        }else{
                            if !isEmptyString(str: result.msg){
                                showToast(view: self.view, txt: result.msg)
                            }else{
                                showToast(view: self.view, txt: convertString(string: "获取失败"))
                            }
                            if result.code == 0{
                                loginWhenSessionInvalid(controller: self)
                            }
                        }
                    }
        })
    }

}
