//
//  OutboxController.swift
//  SinglePages
//
//  Created by Lenny's Macbook Air on 2018/5/4.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit

class OutboxController: LennyBasicViewController {

    override func viewDidLoad() {
        self.shouldFrosted = false
        super.viewDidLoad()
        setViewBackgroundColorTransparent(view: self.view)
        setViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadNetRequestWithViewSkeleton(animate: true)
    }
    
    override var hasNavigationBar: Bool {
        return false
    }
    
    var model:SendMessageModel?
    private let mainTableView = UITableView()
    
    private func setViews() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        contentView.addSubview(mainTableView)
        setViewBackgroundColorTransparent(view: mainTableView)
        mainTableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        mainTableView.tableFooterView = UIView()
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.estimatedRowHeight = 56
        
    }

    
    
    fileprivate func  sectionHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.ccolor(with: 224, g: 224, b: 224)
        let label = UILabel()
        view.addSubview(label)
        label.whc_CenterY(0).whc_Left(20).whc_WidthAuto().whc_Height(10)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.ccolor(with: 136, g: 136, b: 136)
        label.text = "发送短信列表"
        
        let button = UIButton()
        view.addSubview(button)
        button.whc_CenterY(0).whc_Right(20).whc_Width(100).whc_Height(35)
        button.setTitle("发送站内短信", for: .normal)
        button.setImage(UIImage.init(named: "editing"), for: .normal)
        button.layoutStyle = .image_Text
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = UIColor.mainColor()
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonHandle), for: .touchUpInside)
        return view
    }
    
    @objc private func buttonHandle() {
        print((#file as NSString).lastPathComponent + "." + #function)
//        let nav = UINavigationController.init(rootViewController: SendMessageController())
//        self.present(nav, animated: true, completion: nil)
        //点击发送通知进行
        NotificationCenter.default.post(name: NSNotification.Name("lzd"), object: self, userInfo: ["post":"aaa"])
    }
    
    //最后移除通知
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadNetRequestWithViewSkeleton(animate: Bool) {
        LennyNetworkRequest.obtainMessageSendList { (model) in
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

extension OutboxController: UITableViewDelegate {
    
}

extension OutboxController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OutBoxTableViewCell.init(style: .default, reuseIdentifier: "cell")
        if let model = self.model{
            guard let content = model.content else { return cell}
            guard let rows = content.rows else {return cell}
            let data = rows[indexPath.row]
            cell.setlabel_Date(creatTime: data.createTime!)
            cell.setlabel_Type(receiveType: data.receiveType!)
            cell.setlabel_Receiver(receiver: data.receiveAccount!)
            cell.setlabel_ContentDesc(content: data.title!)
        }
        
        let longProgressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(cellLongPress))
        cell.addGestureRecognizer(longProgressGesture)
        return cell
    }
    
    func deleteMessage(receiveMessageId: Int64) {
        LennyNetworkRequest.deleteSentMessage(messageId: receiveMessageId) { (model) in
            if (model?.success)! {
                self.loadNetRequestWithViewSkeleton(animate: true)
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
                    self.deleteMessage(receiveMessageId: Int64(data.id))
                }
                
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertVC.addAction(ensureAction)
                alertVC.addAction(cancelAction)
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView()
    }
    
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
        }
    }
    
    
}
