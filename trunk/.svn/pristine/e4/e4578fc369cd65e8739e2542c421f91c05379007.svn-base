//
//  InboxController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class InboxController: LennyBasicViewController {

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViewBackgroundColorTransparent(view: self.view)
        setViews()
    }

    var model:ReceiveMessageModel?
    private var mainTableView: UITableView!
    
    override var hasNavigationBar: Bool {
        return false
    }
    private func setViews() {
        
        mainTableView = UITableView()
        setViewBackgroundColorTransparent(view: self.mainTableView)
        contentView.addSubview(mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
//        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func loadNetRequestWithViewSkeleton(animate: Bool) {
        LennyNetworkRequest.obtainMessageReceiveList { (model) in
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
                return
            }
            self.model = model
            self.refreshTableViewData()
        }
    }
    
    override func refreshTableViewData() {
        self.mainTableView.reloadData()
    }
}

extension InboxController: UITableViewDelegate {
    
}

extension InboxController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.model{
            guard let content = model.content else { return 0}
            guard let rows = content.rows else {return 0}
            return rows.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.model{
            guard let content = model.content else { return }
            guard let rows = content.rows else {return }
            let data = rows[indexPath.row]
            Tool.confirm(title: "消息内容", message: data.message, controller: self)
            //设置已读
            if data.status == 1{
                self.setRead(sid: Int64(data.id),rid:data.receiveMessageId)
            }
            
        }
    }
    
    @objc private func cellLongPress(recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.began {
            
            if let model = self.model{
                guard let content = model.content else { return }
                guard let rows = content.rows else {return }
                let point = recognizer.location(in: mainTableView)
                let indexPath = mainTableView.indexPathForRow(at: point)
                let data = rows[(indexPath?.row)!]
                
                
                let alertVC = UIAlertController(title: "确认删除消息 ？", message: data.message, preferredStyle: .alert)
                let ensureAction = UIAlertAction(title: "删除", style: .destructive) {_ in
                    self.deleteMessage(receiveMessageId: data.receiveMessageId)
                }
                
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertVC.addAction(ensureAction)
                alertVC.addAction(cancelAction)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    
    
    func setRead(sid:Int64,rid:Int64){
        LennyNetworkRequest.readMessage(sid:sid,rid:rid) { (model) in
            if model?.code == 0 && !(model?.success)!{
                loginWhenSessionInvalid(controller: self)
                return
            }
            self.loadNetRequestWithViewSkeleton(animate: true)
        }
    }
    
    func deleteMessage(receiveMessageId: Int64) {
        LennyNetworkRequest.deleteReceiveMessage(receiveMessageId: receiveMessageId) { (model) in
            if (model?.success)! {
                self.loadNetRequestWithViewSkeleton(animate: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = InboxTableViewCell.init(style: .default, reuseIdentifier: "cell")
        if let model = self.model{
            guard let content = model.content else { return cell}
            guard let rows = content.rows else {return cell}
            let data = rows[indexPath.row]
            cell.setlabel_MentionType(type:data.sendType)
            cell.seticon(status: data.status)
            cell.setlabel_Day(creatTime: data.createTime!)
            cell.setlabel_Title(title: data.title!)
        }
        
        let longProgressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(cellLongPress))
        cell.addGestureRecognizer(longProgressGesture)
        return cell
    }

}
