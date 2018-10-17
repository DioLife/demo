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
    var notices:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "最新公告"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.notices.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notice") as? NoticeCell  else {
            fatalError("The dequeued cell is not an instance of NoticeCell.")
        }
        let data = self.notices[indexPath.row]
        do{
            let attrStr = try NSAttributedString.init(data: data.description.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute:NSPlainTextDocumentType], documentAttributes: nil)
            cell.txt.attributedText = attrStr
        }catch{
            print(error)
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
        showNoticeDialog(title: "公告消息", content: data)
    }

}
